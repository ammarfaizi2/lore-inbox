Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S157683AbPLaEmP>; Thu, 30 Dec 1999 23:42:15 -0500
Received: by vger.rutgers.edu id <S157111AbPLaEmG>; Thu, 30 Dec 1999 23:42:06 -0500
Received: from nas02-198.34.thefree.net ([195.34.198.34]:1048 "HELO hyperspace") by vger.rutgers.edu with SMTP id <S157211AbPLaElt>; Thu, 30 Dec 1999 23:41:49 -0500
Date: Fri, 31 Dec 1999 04:31:51 +0000 (GMT)
From: Alex Holden <alex@linuxhacker.org>
To: linux-kernel@vger.rutgers.edu
Cc: linux-embedded@waste.org
Subject: Announce: initrd-tftp 0.2
Message-ID: <Pine.LNX.4.04.9912310404420.548-100000@hyperspace.linuxhacker.org>
X-Subliminal-Message: Use Linux!
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

* Please CC: me in replies as I'm not on linux-kernel currently *

I've just finished implementing and testing gzipped image support for
initrd-tftp, as well as fixing a few bugs (including telling you nicely 
when the image is too large for the ramdisk), and adding the capability to
specify what tftp server to use and file to download on the kernel command
line. It's even fairly well documented! ;)

You can download the patch (still against 2.2.13) from:
ftp://ftp.linuxhacker.org/pub/kernel/initrd-tftp/initrd-tftp-0.2.patch.gz
Please let me know of any problems you encounter.

The only things remaining to do are to clean a couple of things up to make
it play nicely in the case where you want to compile it in but not load an
initrd, and seperating the last of CONFIG_BLK_DEV_INITRD out from
CONFIG_BLK_DEV_INITRD_TFTP (ie. you shouldn't need the old floppy disk
loader and memory area loader (where the boot loader loads the ramdisk
into a memory area for you) if you're getting the initrd via tftp).

--------------- Linux- the choice of a GNU generation. --------------
: Alex Holden (M1CJD)- Caver, Programmer, Land Rover nut, Radio Ham :
-------------------- http://www.linuxhacker.org/ --------------------







-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
