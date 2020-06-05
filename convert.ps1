function ConvertTo-Png
{
    [cmdletbinding()]
    param([Parameter(Mandatory=$true, ValueFromPipeline = $true)] $Path)

    process{
        if ($Path -is [string])
        {$Path = get-childitem $Path}

        If (!(test-path './bin'))
        {New-Item -ItemType Directory -Path './bin'}

        $Path | ForEach-Object {
            $image = [System.Drawing.Image]::FromFile($($_.FullName));
            $Output = [IO.Path]::Combine($_.Directory, 'bin', $_.Name);
            $FilePath = [IO.Path]::ChangeExtension($Output, '.png');
            $image.Save($FilePath, [System.Drawing.Imaging.ImageFormat]::Png);
            $image.Dispose();
        }
    }

}

Set-Location .\bmp

Get-ChildItem *.bmp | ConvertTo-Png
cd..
