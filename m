Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131845AbQK2ScK>; Wed, 29 Nov 2000 13:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131830AbQK2ScA>; Wed, 29 Nov 2000 13:32:00 -0500
Received: from c1075343-a.spngfld1.il.home.com ([24.14.189.192]:47621 "EHLO
        bastion.yi.org") by vger.kernel.org with ESMTP id <S131127AbQK2Sbv>;
        Wed, 29 Nov 2000 13:31:51 -0500
Message-ID: <20001129130616.A4879@bastion.sprileet.net>
Date: Wed, 29 Nov 2000 13:06:16 -0600
From: --Damacus Porteng-- <kernel@bastion.yi.org>
To: LinuxKernel <linux-kernel@vger.kernel.org>
Subject: IDE-SCSI/HPT366 Problem
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LK Prodigies:

This problem is current on the Linux-2.4.0-test11 kernel.  Please tell me if
this has already been resolved - I am new to the list.

Here is my setup:
	Motherboard: Soyo 6BA+IV (built-in PIIX4 and HPT366 IDE controllers)
	CDRWs: Yamaha 4416S (SCSI) & Yamaha 8424E (EIDE)
	
	Kernel: 2.4.0test11 -- I must use 2.3.X or 2.4.X since my main drives
	are on the HPT366 channels.
	
	IDE: Using both HPT and PIIX chipsets.  Base system drives are on
	HPT366 channels.  / == /dev/hde.  Works fine.

	Software: cdrecord 1.8.1, cdrecord 1.9

Problem:
	The problem lies with using my EIDE CDRW - I set it up properly using
	IDE-SCSI.  I can use my mp3tocdda shell script to encode mp3s to CD
	(uses cdrecord as well) on the fly using either drive, however, when I
	use cdrecord to write a data CD, the system hard-locks, no kernel
	panic messages, and no Magic SysRQ keystroke works.  

	Quite odd that I could do the cdrecord for audio tracks, but not
	data..

	Anyhow, I moved the CDRW to the PIIX4 channels (and changed my lilo
	append line to make hda=scsi, instead of hdg=scsi) and now both the
	mp3tocdda script and cdrecord for data images works fine.  

	I'm thinking it's a problem with HPT366, since IDE-SCSI/PIIX4 worked
	fine with the setup, and cdrecord has always been a working package
	for me.

	Also, the HPT366 setup screen (VERY simple) shows the CDRW using MW
	DMA 2 and is unchangable thru the HPT366 BIOS.  Is there something
	I should be doing with hdparm on the CD device?


Thanks in advance,

Damacus Porteng

--
Damnit, Linus, I'm a network admin, not a kernel hacker!
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
