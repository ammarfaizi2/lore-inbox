Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269073AbRG3S2V>; Mon, 30 Jul 2001 14:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269074AbRG3S2M>; Mon, 30 Jul 2001 14:28:12 -0400
Received: from tisch.mail.mindspring.net ([207.69.200.157]:40742 "EHLO
	tisch.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S269073AbRG3S1z>; Mon, 30 Jul 2001 14:27:55 -0400
From: joeja@mindspring.com
Date: Mon, 30 Jul 2001 14:16:15 -0400
To: linux-kernel@vger.kernel.org
Subject: athelon freeze IO/sluggishness 2.4.7 Emu10k weirdness
Message-ID: <Springmail.105.996516975.0.17269800@www.springmail.com>
X-Originating-IP: 4.20.162.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I have some large file that act as filesystems for the bochs emulator. These files are of sizes of about 400Meg to 1Gig file size. (several in between as well). They were created using the dd command (dd if=/dev/null of=filename bs=512 count=<some large number like 100>).

when I do a cp ./filename /storage/filename (or any other drive or partition or directory) the system slows down to a crawl, and I can see the system io just shoot up. WAY up to about 100% and the system in most cases becomes unusable.  

my system is an AMD Athelon Thunderbird 1.2Ghz (266fsb) , 512Megs of RAM 30 gig WD ATA 100 IDE hard drive (ABIT KT7A MB). 

now running 2.4.7 (same thing happened on 2.4.5 & 2.4.6) (Redhat 7.1) (compiled with egcs-1.1.2)

In my old Dual 233Mhz with 128Meg of RAM (2.2.x 2.0.x) I never had this type of slowdown. I used to copy file about 512Megs from cdrom to hd drive and visa versa.

Both machines run X / Gnome / Windowmaker and these actions are done in an xterm. I doubt that that has anything to do with it, but I hope this gives you the understanding that there are other large processes running.

It seems that if I do cp, rm, bzip or dd (not sure of any other commands at this time) with large files I have this waiting period where my system becomes unusable till the command is finished.  

Does this have anything to do with UP vs SMP?

Is this normal?  I'd think that with 1.2Ghz CPU I wouldn't have that kind of slowdown in the system.

Do I need to do something special to access the ata100 features of the drive? (like hdparm)

Joe
please cc me as I am not on this list.

  

