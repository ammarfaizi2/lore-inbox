Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285216AbRLFVB1>; Thu, 6 Dec 2001 16:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285203AbRLFVBR>; Thu, 6 Dec 2001 16:01:17 -0500
Received: from mclean.mail.mindspring.net ([207.69.200.57]:57661 "EHLO
	mclean.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S285202AbRLFVAR>; Thu, 6 Dec 2001 16:00:17 -0500
Date: Thu, 06 Dec 2001 16:00:16 -0500
From: <joeja@mindspring.com>
To: Dave Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re: 2.4.x 2.5.x wishlist
Message-ID: <Springmail.105.1007672416.0.05638800@www.springmail.com>
X-Originating-IP: 4.20.162.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ABIT KT7A MB
zip 100 ide drive on /dev/hdd
52x Blaster cdrom on /dev/hdc
WD 6Gig HD on /dev/hdb
WD 30Gig HD on /dev/hda
Athlon 1.2Ghz 266Mhz fsb
512Meg RAM

I believe this is the via686 chipset but would have top grep dmesg for I am not sure if it is A or B. the website where I got it says B, but I think in dmesg I have seen A, along with a message via workaround bug

isa modem /dev/tty03
pci SB live
pci dec tulip network card
pci sym53c810 scsi card  && HP cd-rw
pci ieee1394 firewire card
agp GForce2 video card

ups on /dev/usb/ttyUSB0 using usb to serial converter

palm on com2 /dev/tty02

/dev/tty01 disabled MB only handles 2 com ports either built in or like my setup

I get messages like the following:

hdd lost interrupt (zip)

I also occasionally get hdc lost interrupt as well (cdrom) but have not seen them since I removed the zip drive

my hdb also had problems until I reformated ext2 it (loosing ALL data on it)  (TGFBU)

hda is ext3 (built into kernel)

I work with some large files, oftern megs in size sometimes gigs.

If I mount the drive and do large data transfers to it forget it.  30Megs cp hangs. sometimes just doing touch will hang it

kill -9 on the cp process does not do anything.

umount wont umount.

shutdown becomes a defunct process and it is rather interesting to be able to do ps -ef and see 10 shutdown processes in the process table.

The system is usually still usable but the logs and console get message about lot interrupt.

The maintainer knows and I tried the patch he had against 2.4.14 and it helped but did not fix the problem.

fdisk against the drive works just fine, but using it actually seems to not work.

moved the drive into another system and the drive works just fine under other OS

put another hard drive on hdd and the other drive seemed to work just fine with data transfer of 1Gig file to the drive / umount / mount etc

I don't think the power is overloaded as if it was I think I'd have kernel compile problems especially doing make -j 5 on UP with X running  as well as other progs.

Am now running 2.4.16 without the zip ini the system and all is okay except for the IEEE parport bug which breaks ecp/epp to my web cam.  However since it worked in 2.4.13 I found the line of code and just patched back that one line.  

parport is also VIA.. thus it must be a buggy chipset

Joe 

Dave Jones <davej@suse.de> wrote:
> On Wed, 5 Dec 2001 joeja@mindspring.com wrote:

> 2) The nasty VIA ide-floppy / iomega zip 100 drive bugs would get fixed
> as well as this prevents people from using their zip drives under Linux
> and forces them to use them under another OS.

Last I checked, mine worked fine. Details please?

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs


