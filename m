Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292669AbSBZSef>; Tue, 26 Feb 2002 13:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292659AbSBZScu>; Tue, 26 Feb 2002 13:32:50 -0500
Received: from chaos.analogic.com ([204.178.40.224]:15243 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S292420AbSBZScT>; Tue, 26 Feb 2002 13:32:19 -0500
Date: Tue, 26 Feb 2002 13:34:27 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Mike Fedyk <mfedyk@matchmail.com>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: ext3 and undeletion
In-Reply-To: <20020226171634.GL4393@matchmail.com>
Message-ID: <Pine.LNX.3.95.1020226130051.4315A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2002, Mike Fedyk wrote:

> On Tue, Feb 26, 2002 at 06:07:49PM +0100, Martin Dalecki wrote:
[SNIPPED...]

> > >group) to get around the quota issue.
> > 
> > Welcome to my kill-file. This just shows that you don't even have basic
> > background.
> 
> Thank you.
> 
> Now, if I'm talking out of my ass, can someone sane say so?
> 
> It would only call chown/chgrp on the files *inside* the undelete dir, and
> user,group,etc would have to be accounted for in another way.  Am I going in
> the wrong direction?
> 
> Mike

No SUID, no nothing special to accomplish the following:

johnson[1]$ pwd
/home/users/johnson

johnson[2]$ rm -r *

johnson[3]$ ls -la
total 8
drwxr-xr-x   2 rjohnson guru         4096 Feb 26 13:03 .
drwxr-xr-x  54 root     root         4096 Feb 26 13:04 ..

johnson[4]$ ls -laR /home/users/lost+found/rjohnson
total 5428
drwxr-xr-x  17 rjohnson guru         4096 Feb 13 16:54 .
drwxrwxrwx  21 root     root         4096 Feb 26 05:34 ..
-rw-r--r--   1 rjohnson guru            6 Oct 15  1998 .XF86_S3
-rw-------   1 rjohnson guru            0 Aug 10  1998 .Xauthority
-rw-r--r--   1 rjohnson guru         1557 Dec 31  1997 .acrorc
-rw-r--r--   1 rjohnson guru          273 May 13  1998 .addressbook
-rw-r--r--   1 rjohnson guru         2684 May 13  1998 .addressbook.lu
-rw-r--r--   1 rjohnson guru            0 Feb 13 16:54 .bash_history
-rwxr-xr-x   1 rjohnson guru          343 May 17  1999 .bashrc
-rw-r--r--   1 rjohnson guru         2938 Sep 26  1994 .emacs
-rw-r--r--   1 rjohnson guru           47 Aug  5  1996 .forward.SAVED
-rw-r--r--   1 rjohnson guru           92 Feb 26  1997 .gopherrc
-rw-r--r--   1 rjohnson guru          130 Nov  2  1998 .ispell_english
-rw-r--r--   1 rjohnson guru          164 Sep 26  1994 .kermrc
-rw-r--r--   1 rjohnson guru           34 Sep 26  1994 .less
-rw-r--r--   1 rjohnson guru          114 Sep 26  1994 .lessrc
-rw-r--r--   1 rjohnson guru            8 Feb 12  1999 .mosaic-cc-2.7b5
-rw-r--r--   1 rjohnson guru         1349 Feb 12  1999 .mosaic-hot.html
-rw-r--r--   1 rjohnson guru         1413 Feb 12  1999 .mosaic-hot.html.backup
-rw-r--r--   1 rjohnson guru          282 Oct 20  1995 .mosaic-hotlist-default
-rw-r--r--   1 rjohnson guru          854 Aug 22  1996 .mosaic-hotlist-default.html
drwx------   2 rjohnson guru         4096 Jan 27  1997 .mosaic-personal-annotations
-rw-r--r--   1 rjohnson guru         1718 Feb 12  1999 .mosaic-x-history
-rw-r--r--   1 rjohnson guru        39706 Feb 12  1999 .mosaic-x-history.backup
-rw-r--r--   1 rjohnson guru            5 Feb 12  1999 .mosaicpid
-rw-r--r--   1 rjohnson guru          204 Oct 10  1995 .mymail
-rw-r--r--   1 rjohnson guru         9236 Dec 30  1999 .pine-debug1
-rw-r--r--   1 rjohnson guru         8978 Feb 19  1999 .pine-debug2
-rw-r--r--   1 rjohnson guru         8978 Feb 19  1999 .pine-debug3
-rw-r--r--   1 rjohnson guru         9237 Feb 19  1999 .pine-debug4
-rw-r--r--   1 rjohnson guru        10682 Dec 30  1999 .pinerc
-rw-r--r--   1 rjohnson guru           90 Jul 15  1995 .plan
-rw-r--r--   1 rjohnson guru          625 Oct 15  1998 .procmailrc
-rw-r--r--   1 rjohnson guru           17 Dec  6  1994 .profile
-rw-r--r--   1 rjohnson guru          454 Jul 15  1995 .project
-rw-r--r--   1 rjohnson guru           35 May 16  1995 .rhosts
drwxr-xr-x   2 rjohnson guru         4096 Jan 26  1997 .seyon
-rw-r--r--   1 rjohnson guru          209 Feb 13 16:54 .signature
-rw-r--r--   1 rjohnson guru          532 Nov 19  1996 .signature.SAVED
-rw-r--r--   1 rjohnson guru          275 Sep 10  1997 .signature.bak
-rw-r--r--   1 rjohnson guru           50 Feb 19  1999 .sversionrc
drwx------   2 rjohnson guru         4096 Jan 26  1997 .term
-rw-r--r--   2 rjohnson guru        12288 Sep 11  1996 .vacation.dir
-rw-r--r--   1 rjohnson guru          247 Sep 11  1996 .vacation.msg
-rw-r--r--   2 rjohnson guru        12288 Sep 11  1996 .vacation.pag
-rwxr-xr-x   1 rjohnson guru          443 Sep  4  1997 .xinitrc
-rw-r--r--   1 rjohnson guru         1117 Sep  2  1998 BOMBER.CREW
-rw-r--r--   1 rjohnson guru         7697 Jul 27  1998 BusLogic.html
-rw-r--r--   1 rjohnson guru           21 Apr 17  1998 CHECK.KERNEL
-rw-r--r--   1 rjohnson guru         6519 Mar 30  1998 Computers
-rw-r--r--   1 rjohnson guru          442 Sep 28  1998 DELAY.PATCH
-rw-r--r--   1 rjohnson guru         4349 Nov  2  1998 Flying_saucers
-rw-r--r--   1 rjohnson guru         4349 Mar 17  1998 Flying_saucers.bak
-rw-r--r--   1 rjohnson guru          576 May 15  1998 IRQ.PATCH
-rw-r--r--   1 rjohnson guru           69 Apr 24  1998 ME.TXT
-rwxr-xr-x   1 rjohnson guru          131 Aug  3  1998 MIT
drwx--x--x   2 rjohnson guru         4096 Oct 21  1998 Mail
-rw-r--r--   1 rjohnson guru          135 Jul 11  1998 PATENT
-rw-r--r--   1 rjohnson guru          625 Jun  3  1998 _procmail
drwxr-xr-x   2 rjohnson guru         4096 Dec  1  1998 asm
-rwxr-xr-x   1 rjohnson guru         1358 Sep 16  1997 backup
-rw-r--r--   1 rjohnson guru       230454 Jun  5  1998 baldie.bmp
drwxr-xr-x   3 rjohnson guru         4096 Jun  1  1998 bomb
-rwxr-xr-x   1 rjohnson guru         2993 Oct  9 16:06 c.c
drwxr-xr-x   2 rjohnson guru         4096 Sep 28  1998 callback
-rw-r--r--   1 rjohnson guru        12900 May 18  1998 chaos.txt
-rwxr-xr-x   1 rjohnson guru        57276 Dec  9  1997 chkdev.c
-rw-r--r--   1 rjohnson guru         5276 Nov 17  1998 cpu.speed
-rw-r--r--   1 rjohnson guru          895 Sep 29  1998 delay.c
-rw-r--r--   1 rjohnson guru          964 Sep 30  1998 delay.patch
-rwxr-xr-x   1 rjohnson guru         5414 Mar  9  1998 diskio
-rw-r--r--   1 rjohnson guru         3364 Nov 22  1998 evil.IDE
-rwxr-xr-x   1 rjohnson guru         5061 Nov 11  1998 fastchk.asm
-rw-r--r--   1 rjohnson guru          957 Oct 31  1997 firewall.sh
-rwxr-xr-x   1 rjohnson guru         4717 Oct  1 15:09 fpu
-rw-r--r--   1 rjohnson guru          499 Oct 30  1997 fpu.c
-rw-r--r--   1 rjohnson guru       257507 Jan 28 08:47 friday.ps
-rw-r--r--   1 rjohnson guru         5363 Aug 20  1997 ftp.txt
-rwxr-xr-x   1 rjohnson guru          345 Sep 15  1998 get_bomb
-rwxr-xr-x   1 rjohnson guru       219539 Dec  6  1994 gwm
drwxr-xr-x   2 rjohnson guru         4096 Nov 14  1997 homepage
-rwxr-xr-x   1 rjohnson guru           84 Jan 28  1998 hostfile
-rw-r--r--   1 rjohnson guru        86994 Jan 28  1998 hosts.tmp
-rwxr-xr-x   1 rjohnson guru        22261 Sep 10  1998 iiclink.asm
-rw-r--r--   1 rjohnson guru         1522 May 25  1998 info.bak
-rw-r--r--   1 rjohnson guru          392 Aug 17  1998 ioapic-2.1.115-A
-rw-r--r--   1 rjohnson guru        30547 May 14  1998 irq.c
drwxr-xr-x   2 rjohnson guru         4096 Jan 26  1997 jboot
-rw-r--r--   1 rjohnson guru          675 Nov 29  1995 jboot-1.13.lsm
-rw-r--r--   1 rjohnson guru         8263 Oct  4  1998 jitter.c
-rwxr-xr-x   1 rjohnson guru           79 Jun 26  1998 keepalive.sh
-rw-r--r--   1 rjohnson guru        24348 Dec 10  1997 latierra.c
-rw-r--r--   1 rjohnson guru          267 Aug 11  1997 lawsuit
drwxr-xr-x   2 rjohnson guru         4096 Mar 19  1997 logs
-rwxr-xr-x   1 rjohnson guru         5904 Nov  9  1998 lookups
-rw-r--r--   1 rjohnson guru         1533 Nov  9  1998 lookups.c
-rw-r--r--   1 rjohnson guru      1339467 Aug 31  1998 ls-lR
-rw-r--r--   1 rjohnson guru      1239040 Jul 28  1998 m4-1.4.tar
drwx------   2 rjohnson guru         4096 Oct  5  1999 mail
-rwxr-xr-x   1 rjohnson guru       411945 Nov 14  1997 main
-rwxr-xr-x   1 rjohnson guru          469 Dec 16  1996 make_bfloppy
-rwxr-xr-x   1 rjohnson guru          474 Sep 16  1996 make_boot
-rwxr-xr-x   1 rjohnson guru          460 Jun 19  1998 make_floppy
-rw-r--r--   1 rjohnson guru         1175 Mar 20  1998 mem.c
-rw-r--r--   1 rjohnson guru         5835 Nov  9  1998 messages
-rwxr-xr-x   1 rjohnson guru           36 Sep 12  1996 modem
-rw-r--r--   1 rjohnson guru        28084 Oct  3  1998 mptable.c
-rw-r--r--   1 rjohnson guru         5715 Aug 22  1996 mwmrc
-rwxr-xr-x   1 rjohnson guru         1312 Jan 28  1997 new_backup
-rw-r--r--   1 rjohnson guru         2343 Apr 21  1998 operating.systems
-rwxr-xr-x   1 rjohnson guru          718 Jan  2  1996 plot
drwxr-xr-x   3 rjohnson guru         4096 Jan 26  1997 pppdc
drwxr-xr-x   2 rjohnson guru         4096 Jan 26  1997 ptools
-rw-r--r--   1 rjohnson guru         3955 Jun 18  1998 reboot.c
-rwxr-xr-x   1 rjohnson guru          214 Nov  6  1997 restore
-rwxr-xr-x   1 rjohnson guru         2185 Jan  6  1997 rights.h
-rwxr-xr-x   1 rjohnson guru         7293 Dec 26  1996 showserv
-rw-r--r--   1 rjohnson guru         1765 Aug 13  2001 smile.sh
drwxr-xr-x  19 rjohnson guru         4096 Apr 17  1998 test
-rw-r--r--   1 rjohnson guru       788903 Jul 22  1998 test.cdcolor
-rwxr-xr-x   1 rjohnson guru         5019 May 25  1998 timer
-rw-r--r--   1 rjohnson guru         1247 Oct  3  1998 timer.c
drwxr-xr-x  10 rjohnson guru         4096 Nov 18  1998 tools
-rw-r--r--   1 rjohnson guru          471 Oct  9 16:09 typescript
-rw-r--r--   1 rjohnson guru          426 Jun 24  1998 udelay.patch
-rwxr-xr-x   1 rjohnson guru         4137 Dec  5  1996 unix2world
-rwxr-xr-x   1 rjohnson guru          171 Jan 27  1998 update_host
-rwxr-xr-x   1 rjohnson guru        84707 Jul 10  1998 utility.asm
-rwxr-xr-x   1 rjohnson guru        16819 Sep 25  1998 vl12ct.asm
-rwxr-xr-x   1 rjohnson guru         3845 Dec  5  1996 world2unix
-rwxr-xr-x   1 rjohnson guru         8141 Oct  9 16:08 xxx


All the deleted files, with the correct path(s), are now in the
top directory file the file-system ../lost+found directory. They
are still owned by the original user, still subject to the same
quota. The disk space can't run out because you have simply moved
files that didn't exceed the disk space before they were moved.

All one needs is a compile-time switch to enable the following:

If the lost+found directory is writable by the current user, blindly
create any paths that may already exist, using the ../lost+found/~ 
directory as the root, and rename() the file you think you are
unlink()ing unless the file exists in /tmp, or is a sym-link,
special file, pipe, socket or device.

To enable such a function (after modifing the C library), just make
lost+found world-writable. The permissions of its contents remain
unchanged as does the owner. If the owner didn't want others in
the universe to read his resume.txt, or porno.jpg, they still can't
read it and they can't overwrite it.

The sysadmin deletes the contents (probably via crond), every time it
has been backed up. 

There are lots of advantages to this scheme. The most notable being
that it is transparent to normal users.  Database programs that do
a lot of deleting temporary files that don't exist in /tmp, need to
be have their default directory on a file-system with lost+found
not world writable.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

        111,111,111 * 111,111,111 = 12,345,678,987,654,321

