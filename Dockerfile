FROM mcr.microsoft.com/windows:10.0.19041.450
SHELL ["cmd", "/S", "/C"]
# Install git 
RUN powershell -Command Invoke-WebRequest 'https://github.com/git-for-windows/git/releases/download/v2.12.2.windows.2/MinGit-2.12.2.2-64-bit.zip' -OutFile MinGit.zip
RUN powershell -Command Expand-Archive c:\MinGit.zip -DestinationPath c:\MinGit; $env:PATH = $env:PATH + ';C:\MinGit\cmd\;C:\MinGit\cmd'; Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\' -Name Path -Value $env:PATH

# Install anaconda 
RUN powershell -Command Invoke-WebRequest -OutFile anaconda.exe -Uri https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe
RUN start /wait "" anaconda.exe /InstallationType=JustMe /RegisterPython=0 /S /D=%UserProfile%\anaconda3
# Run all anaconda commands here 
RUN call %UserProfile%\anaconda3\Scripts\activate.bat & call conda install h5py 

CMD ["powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]

