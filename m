Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135947AbRD0JlR>; Fri, 27 Apr 2001 05:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135940AbRD0JlH>; Fri, 27 Apr 2001 05:41:07 -0400
Received: from lenin.dabney.caltech.edu ([131.215.82.3]:45837 "EHLO
	lenin.dabney.caltech.edu") by vger.kernel.org with ESMTP
	id <S135994AbRD0Jkw>; Fri, 27 Apr 2001 05:40:52 -0400
Date: Fri, 27 Apr 2001 02:40:50 -0700 (PDT)
From: jason <jason@lacan.dabney.caltech.edu>
To: linux-kernel@vger.kernel.org
Subject: kernel panic with 2.4.x and reiserfs
Message-ID: <Pine.LNX.4.10.10104270104010.7570-100000@lacan.dabney.caltech.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

As the subject would imply, I've been having problems with 2.4.x. I have
my root partition (/dev/hda1) as reiserfs and also have another harddrive
with a reiserfs partition (/dev/hdc1). Several programs write (e.g. save
files to) /dev/hdc1, and I also store files there. Under 2.4.2, whenever
manually copying files from hda1 to hdc1, I would get a kernel panic, the
kernel would dump the contentx of the registers onto any consoles open at
that moment, and then the machine would freeze. Upon rebooting, the
machine would work flawlessly until I tried to repeat the same procedure.
Curiously enough, this did not happen under 2.4.1 (I would sometimes
reboot under 2.4.1, do my copying, then reboot back under 2.4.2). I'm
fairly sure that I checked that this did not happen under 2.4.3.
  Tonight,however, I tried to copy from hda1 to hdc1 and had several
problems. The first 2 times I did it, I received segfaults. The third
time, the process hung. I changed from X to the console to kill it. After
doing this, the keyboard would not communicate with X, meaning that all I
could do was move the mouse, or change back to the console. After changing
back to the console again, the kernel panicked, dumped the registers, and
crashed. Upon reboot, the kernel panicked when reiserfs was called (in
init). Upon a 2nd reboot (and all non-floppy boots since then), I receive
"Error 17" from GRUB and the computer hangs.
  My apologies that I can't provide a log, but I can't access the
computer. I've tried rebooting with a rescue disk, and I get a message
when reiserfs is called that contains the following messages (among
others):

reiserfs_read_super: can't find reiserfs filesystem on dev 03:01
Invalid session # or type of track
Kernel panic: VFS: Unable to mount root fs on 03:01

  In case it's any help, I'm running Debian "sid" under kernel 2.4.3. hda
is a Western Digital WD400 (UDMA 100) while hdc is a Maxtor 36.5 GB. I
have a 900 Mhz Athlon on an Abit KT7A, the latter containing the South
Bridge VIA VT82C686B and a North Bridge VIA VT8363A.
  Any info on how I could possibly retrieve data from my disk (hda) would
be greatly appreciated...


Thanks
Jason Frantz

