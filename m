Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261734AbUKPOYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbUKPOYs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 09:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbUKPOYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 09:24:32 -0500
Received: from krt.neobee.net ([80.74.175.2]:10910 "EHLO krt.neobee.net")
	by vger.kernel.org with ESMTP id S261985AbUKPOXB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 09:23:01 -0500
Message-Id: <200411161427.iAGERt46031185@krt.neobee.net>
Reply-To: <mile.davidovic@micronasnit.com>
From: "Mile Davidovic" <mile.davidovic@micronasnit.com>
To: <linux-kernel@vger.kernel.org>
Subject: ITERaid and atkbd
Date: Tue, 16 Nov 2004 15:23:30 +0100
Organization: MicronasNIT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Thread-Index: AcTL59g5iOMXQzHPQh6TdtK7H5/dvA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks

I have trouble with IT8212F raid controller (on Gigabyte boards also known
as GigaRaid) on FedoraCore 3.
There was some problem with building modules but after some fixing Makefile
I succeeded to build module. 

After loading module dmesg shows:
	Found Controller: IT8212 UDMA/ATA133 RAID Controller
	FindDevices: device 0 is IDE
	FindDevices: device 1 is IDE
	Channel[0] BM-DMA at 0xA400-0xA407
	Channel[1] BM-DMA at 0xA408-0xA40F
	scsi2 : ITE RAIDExpress133
	  Vendor: ITE       Model: IT8212F           Rev: 1.3
	  Type:   Direct-Access                      ANSI SCSI revision: 00
	SCSI device sdb: 488397166 512-byte hdwr sectors (250059 MB)
	sdb: asking for cache data failed
	sdb: assuming drive cache: write through
	 sdb: sdb1
	Attached scsi disk sdb at scsi2, channel 0, id 0, lun 0
	  Vendor: ITE       Model: IT8212F           Rev: 1.3
	  Type:   Direct-Access                      ANSI SCSI revision: 00
	SCSI device sdc: 488397166 512-byte hdwr sectors (250059 MB)
	sdc: asking for cache data failed
	sdc: assuming drive cache: write through
	 sdc:<4>atkbd.c: Unknown key pressed (translated set 2, code 0x0 on
isa0060/serio0).
	atkbd.c: Use 'setkeycodes 00 <keycode>' to make it known.
	atkbd.c: Unknown key pressed (translated set 2, code 0x0 on
isa0060/serio0).
	atkbd.c: Use 'setkeycodes 00 <keycode>' to make it known.
	 sdc1
	Attached scsi disk sdc at scsi2, channel 0, id 1, lun 0

[root@beowulf scsi]# mount /dev/sdb1 /mnt/
atkbd.c: Unknown key pressed (translated set 2, code 0x0 on isa0060/serio0).
atkbd.c: Use 'setkeycodes 00 <keycode>' to make it known.
...
atkbd.c: Unknown key pressed (translated set 2, code 0x0 on isa0060/serio0).
atkbd.c: Use 'setkeycodes 00 <keycode>' to make it known.
kjournald starting.  Commit interval 5 seconds
atkbd.c: Unknown key pressed (translated set 2, code 0x0 on isa0060/serio0).
atkbd.c: Use 'setkeycodes 00 <keycode>' to make it known.
EXT3 FS on sdb1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
atkbd.c: Unknown key pressed (translated set 2, code 0x0 on isa0060/serio0).
atkbd.c: Use 'setkeycodes 00 <keycode>' to make it known.

I found a lot of messages with this subject but I didn't found any final
answer.
I also tried to use iteraid driver from mm tree but situation is same.

Thanks in a advice
Best regards Mile


