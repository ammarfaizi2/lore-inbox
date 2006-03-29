Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750849AbWC2Q5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbWC2Q5e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 11:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbWC2Q5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 11:57:33 -0500
Received: from vmailb.mclink.it ([195.110.128.107]:52234 "EHLO
	vmailb.mclink.it") by vger.kernel.org with ESMTP id S1750847AbWC2Q5d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 11:57:33 -0500
From: "Mauro Tassinari" <mtassinari@cmanet.it>
To: <jeff@garzik.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: libata/sata status on ich[?]
Date: Wed, 29 Mar 2006 18:57:12 +0200
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA//gP36uv0hG9NQDAJogAp8KAAAAQAAAAyTp2U2YnGEW3ub1INE9nAAEAAAAA@cmanet.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff, All,

our latest tests on previously reported ICH6 platforms show
2.6.16.git not reporting any device on 4th master port.
The same behaviour was previously observed with 2.6.16-mm2,
regardless the hd brand and type.


2.6.16.1

[... snip ...]

libata version 1.20 loaded.
ata_piix 0000:00:1f.2: version 1.05
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xAC00 ctl 0xA882 bmdma 0xA400 irq 19
ata2: SATA max UDMA/133 cmd 0xA800 ctl 0xA482 bmdma 0xA408 irq 19
ata1: dev 0 cfg 49:2f00 82:74eb 83:7fea 84:4023 85:74e9 86:3c02 87:4023
88:203f
ata1: dev 0 ATA-6, max UDMA/100, 321672960 sectors: LBA48
ata1: dev 0 configured for UDMA/100
scsi0 : ata_piix
ata2: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4673 85:7c69 86:3e21 87:4663
88:207f
ata2: dev 0 ATA-7, max UDMA/133, 320173056 sectors: LBA48
ata2: dev 0 configured for UDMA/133
scsi1 : ata_piix
  Vendor: ATA       Model: HDS722516VLSA80   Rev: V34O
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 6L160M0    Rev: BACE
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 321672960 512-byte hdwr sectors (164697 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 321672960 512-byte hdwr sectors (164697 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 320173056 512-byte hdwr sectors (163929 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 320173056 512-byte hdwr sectors (163929 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 sdb3 sdb4
sd 1:0:0:0: Attached scsi disk sdb

[... snip ...]

2.6.16-git16

[... snip ...]

libata version 1.20 loaded.
ata_piix 0000:00:1f.2: version 1.05
ata_piix 0000:00:1f.2: MAP [ P0 P1 P2 P3 ]
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xAC00 ctl 0xA882 bmdma 0xA400 irq 19
ata2: SATA max UDMA/133 cmd 0xA800 ctl 0xA482 bmdma 0xA408 irq 19
ata1: dev 0 cfg 49:2f00 82:74eb 83:7fea 84:4023 85:74e9 86:3c02 87:4023
88:203f
ata1: dev 0 ATA-6, max UDMA/100, 321672960 sectors: LBA48
ata1: dev 0 configured for UDMA/100
scsi0 : ata_piix
ata2: SATA port has no device.
scsi1 : ata_piix
  Vendor: ATA       Model: HDS722516VLSA80   Rev: V34O
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 321672960 512-byte hdwr sectors (164697 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 321672960 512-byte hdwr sectors (164697 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4
sd 0:0:0:0: Attached scsi disk sda

[... snip ...]

Will provide more info if needed.

Regards

Mauro Tassinari

