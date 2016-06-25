########################################
# Japanese menu for Sublime Text 3 のファイル置き換えを自動化
########################################

# $args[0] = Login Profile

$fromPath = "C:\Users\" + $args[0] + "\AppData\Roaming\Sublime Text 3\Packages\Japanize"
# Write-Output $fromPath + "\*.jp"

if (!(Test-Path $fromPath))
{
  Write-Output 処理終了1
  return
}

# japanizeフォルダへ移動
cd $fromPath

$toPath = "C:\Users\" + $args[0] + "\AppData\Roaming\Sublime Text 3\Packages\Default"
if (!(Test-Path $toPath))
{
  $packagePath = "C:\Users\" + $args[0] + "\AppData\Roaming\Sublime Text 3\Packages"
  
  if (!(Test-Path $packagePath))
  {
    Write-Output 処理終了2
    return
  }
  
  # Defaultフォルダがなければ新規作成
  New-Item $toPath -ItemType Directory
}

# japanizeフォルダ→Defaultフォルダへ *.sublime-menu.jp を全てコピー
Copy-Item .\* ..\Default -Include *.jp

# japanizeフォルダ→Userフォルダへ Main.sublime-menu をコピー

# 既にファイルが存在する場合はリネーム
if (Test-Path ..\User\Main.sublime-menu)
{  
  Rename-Item ..\User\Main.sublime-menu Main.sublime-menu.org
}
Copy-Item .\Main.sublime-menu ..\User

# Defaultフォルダへコピーしたファイルにおいて、末尾の.jpを削除する
cd ..\Default
dir | Rename-Item -newname { $_.name -Replace '.sublime-menu.jp','.sublime-menu' } 
