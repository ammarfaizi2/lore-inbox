Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262483AbUCIXow (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 18:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262463AbUCIXot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 18:44:49 -0500
Received: from web14912.mail.yahoo.com ([216.136.225.248]:41760 "HELO
	web14912.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262285AbUCIXmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 18:42:24 -0500
Message-ID: <20040309234223.20649.qmail@web14912.mail.yahoo.com>
Date: Tue, 9 Mar 2004 15:42:23 -0800 (PST)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: libata and RAID
To: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My RAID setup broke with something I pulled in the last 24 hours on the 2.6
kernel. If I back off a version everything works fine.

I have an Intel i875P based motherboard with ICH5. Dell PE400SC. One RAID drive
is SATA other is IDE. dmesg shows the normal startup. My non-RAID SATA and IDE
parititions are working ok.

ata1: SATA max UDMA/133 cmd 0xFE00 ctl 0xFE12 bmdma 0xFEA0 irq 18
ata2: SATA max UDMA/133 cmd 0xFE20 ctl 0xFE32 bmdma 0xFEA8 irq 18
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:207f
ata1: dev 0 ATA, max UDMA/133, 156301488 sectors (lba48)
ata1: dev 0 configured for UDMA/133
scsi0 : ata_piix
ata2: port disabled. ignoring.
ata2: thread exiting
scsi1 : ata_piix
  Vendor: ATA       Model: ST380013AS        Rev: 1.01
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sda: drive cache: write through
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: raid1 personality registered as nr 3

but when raidstart runs it can't find /dev/md0.
I'm running udev for /dev so I check in /sys/block for md0 and see that it is
missing.
Missing /sys/block/md0 means no /dev/md0 will get created.

So what do I have to do to get /sys/block/md0 back?


=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Yahoo! Search - Find what you’re looking for faster
http://search.yahoo.com
