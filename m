Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262644AbSITN40>; Fri, 20 Sep 2002 09:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262645AbSITN40>; Fri, 20 Sep 2002 09:56:26 -0400
Received: from mailgate.imerge.co.uk ([195.217.208.100]:1528 "EHLO
	imgserv04.imerge-bh.co.uk") by vger.kernel.org with ESMTP
	id <S262644AbSITN4Z>; Fri, 20 Sep 2002 09:56:25 -0400
Message-ID: <C0D45ABB3F45D5118BBC00508BC292DB9D4208@imgserv04>
From: James Finnie <jf1@IMERGE.co.uk>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: IDE Hard disk geometry problem in 2.4.19 / 2.4.20pre7
Date: Fri, 20 Sep 2002 15:04:02 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a large number of IDE hard disks here where I work.  Since moving to
2.4.19 from 2.4.17, several of these disks have stopped working, resulting
in a kernel panic after the drive has declared itself to have 0 cylinders!
All the disks that have broken are the following:

Seagate 80GB U6 ST380020ACE with Firmware version 4.65

We have lots of these same drives, with FW v 3.34, that all work fine.  I do
not have a single drive with the 4.65 firmware working.  

My problem is that these drives used to work fine, with 2.4.17.  They are
not obsolete hardware, I think they are all less than 6 months old.

I have seen this on CS5530 with the standard kernel PCI IDE, and on SIS630
with the SIS Kernel IDE driver.  

Setting ide=nodma makes no difference.

Here is an excerpt from the kernel console booting:


....
hda: ST380020ACE, ATA DISK drive
....
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04  { DriveStatusError }
hda: setmax_ext LBA 1, native 0
hda: 0 sectors (0 MB) w/2048KiB Cache, CHS 0/255/63, (U)DMA
....
hda2: bad access: block=2, count=2
end_request: I/O error, dev 03:02 (hda), sector 2
EXT3-fs: unable to read superblock
hda2: bad access: block=2, count=2
end_request: I/O error, dev 03:02 (hda), sector 2
EXT3-fs: unable to read superblock
Kernel panic: VFS: Unable to mount root fs on 03:02


Is this a result of all the new IDE stuff that went in in 2.4.19???

Cheers for any help,


James Finnie
Imerge Ltd.










~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
Imerge Limited                          Tel :- +44 (0)1954 783600 
Unit 6 Bar Hill Business Park           Fax :- +44 (0)1954 783601 
Saxon Way                               Web :- http://www.imerge.co.uk 
Bar Hill 
Cambridge 
CB3 8SL 
United Kingdom 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 


