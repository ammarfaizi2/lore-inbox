Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265167AbUAORsN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 12:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265176AbUAORsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 12:48:13 -0500
Received: from 5.Red-80-32-157.pooles.rima-tde.net ([80.32.157.5]:15109 "EHLO
	smtp.newipnet.com") by vger.kernel.org with ESMTP id S265167AbUAORsL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 12:48:11 -0500
Message-ID: <200401151847570144.05F52854@192.168.128.16>
X-Mailer: Courier 3.50.00.09.1092 (http://www.rosecitysoftware.com) (P)
Date: Thu, 15 Jan 2004 18:47:57 +0100
From: "Carlos Velasco" <lkernel@newipnet.com>
To: linux-kernel@vger.kernel.org
Subject: iswraid calling modprobe when scsi statically compiled?
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm trying to use Intel Software Raid provided patch in:
http://marc.theaimsgroup.com/?l=linux-kernel&m=106972332715043&w=2

However, it seems to be calling modprobe although SCSI support is
statically configured in the kernel:

modules.conf:
alias block-major-8 sd_mod

.config (kernel):
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40

Booting:

<6>iswraid: Intel(tm) Software RAID driver Version 0.0.6
<3>kmod: failed to exec /sbin/modprobe -s -k block-major-8, errno = 2
       <-- ***
<7>iswraid: No raid array found
<6>SCSI subsystem driver Revision: 1.00
<7>libdata version 0.81 loaded.
<7>ata_piix version 0.95
<7>PCI: Setting latency timer of device 00:1f.2 to 64
<6>ata1: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 18
<6>ata2: SATA max UDMA/133 cmd 0xC800 ctl 0xC402 bmdma 0xD000 irq 18
<7>ata1: dev 0 cfg 49:2f00 82:7c69 83:7f09 84:4003 85:7c69 86:3e01
87:4003 88:407f
<6>ata1: dev 0 ATA, max UDMA/133, 160086528 sectors (lba48)
<6>ata1: dev 0 configured for UDMA/133
<7>ata2: dev 0 cfg 49:2f00 82:7c69 83:7f09 84:4003 85:7c69 86:3e01
87:4003 88:407f
<6>ata2: dev 0 ATA, max UDMA/133, 160086528 sectors (lba48)
<6>ata2: dev 0 configured for UDMA/133
<6>scsi0 : ata_piix
<6>scsi1 : ata_piix
...

It can't succed because I'm booting without modprobe at all (Intel RAID
card is the only one controller).
Any help would be apreciated.

Regards,
Carlos Velasco


