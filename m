Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313443AbSC2OOG>; Fri, 29 Mar 2002 09:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313447AbSC2ON4>; Fri, 29 Mar 2002 09:13:56 -0500
Received: from chaos.analogic.com ([204.178.40.224]:3200 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S313420AbSC2ONm>; Fri, 29 Mar 2002 09:13:42 -0500
Date: Fri, 29 Mar 2002 09:13:38 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Padraig Brady <padraig@antefacto.com>
cc: Anton Altaparmakov <aia21@cus.cam.ac.uk>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: Re: ANN: NTFS 2.0.1 for kernel 2.5.7 released
In-Reply-To: <3CA4703C.8000900@antefacto.com>
Message-ID: <Pine.LNX.3.95.1020329085743.147A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Mar 2002, Padraig Brady wrote:

> Anton Altaparmakov wrote:
> > On Fri, 29 Mar 2002, Padraig Brady wrote:
> > 
> >>Is this a good default?
> > 
> > 
> > I don't see what's wrong with that. It follows the logic of least
> > surprise. In Windows all files are executable as there is no way to
> > distinguish executables from non-executables due to lack of executable
> > bit. NTFS on Linux has no way of telling the difference either and hence
> > it makes sense to allow execution of all files.
> > 
> > If you don't like it, use -o noexec,fmask=0111 and you will not have any
> > files being executable.
> > 
> > 
> >>IMHO you usually would not want to execute stuff off NTFS, and
> >>if you do you can always just explicitly invoke using wine like:
> >>`wine /ntfs/lookout.exe`
> > 
> > 
> > No you couldn't.
> > 
> 
> why not? wine should be changed to allow this if
> it is a limitation with it.
> 
> >>To have all files executable breaks stuff like:
> >>midnight commander (won't open executable files)
> > 
> > 
> > Ouch, that is plain stupid... mc should be fixed. I open executables all
> > the time and mc should automatically fire up a hexeditor.
> 
> Well by not opening I meant it tries to run them
> which is sensible really. I would guess any unix
> filemanager is going to have some issues with all
> files having executable bits set.
> 
> Isn't there some kludge for vfat where it marks
> *.{com,exe,bat} as executable?
> 

It used to be, under DOS, that ".COM" files were loaded and
"executed" even if they were text. Then, when the ".EXE" file
came out, it would be executed if the first two bytes were 'MZ' so
you could make a text file with the first two characters "MZ" and
save it as "CRASH.EXE" and that's what it would do. All ".BAT"
files were assumed to be interpreted by 'COMMAND.COM', the "shell",
as scripts. This means that you can make a ".BAT" file called
"COMMAND.BAT", with interesting results.

When FAT-32, NTFS, VFAT,  Windozes file-system(s) were developed
all bets are off. Long file-names are the result of a 'container-file'
concept and anything goes.

So the only way to guess at these file's execution capabilities
is to read the name --and it's a bad guess.

If the files are NOT set to 'executable' as read by Linux, then samba
will not work. For the files to be visible to WIN/Clients, they
must have all bits set. This 'feature' can be used to make DOS/Win
files temporarily off-limits to WIN/Clients (like during a backup).

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

