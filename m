Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264289AbTGBSAf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 14:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264257AbTGBSAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 14:00:34 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:11137 "EHLO
	gatekeeper.slim") by vger.kernel.org with ESMTP id S264328AbTGBR57
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 13:57:59 -0400
Subject: Re: ata-scsi driver update
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <3F01F125.4060907@pobox.com>
References: <3F00CEDC.2010806@pobox.com>
	 <1057086391.3444.3.camel@paragon.slim>  <3F01E030.9060201@pobox.com>
	 <1057089782.3274.1.camel@paragon.slim>  <3F01F125.4060907@pobox.com>
Content-Type: text/plain
Message-Id: <1057169057.3261.7.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-1) 
Date: 02 Jul 2003 20:04:17 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok it looks good:

ata_piix version 0.91
PCI: Enabling device 00:1f.1 (0005 -> 0007)
PCI: Setting latency timer of device 00:1f.1 to 64
PCI: Setting latency timer of device 00:1f.2 to 64
ata1: PATA max UDMA/33 cmd 0x1F0 ctl 0x3F6 bmdma 0xFC00 irq 14
ata1: unhandled bus state 0
ata1: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3469 86:3c01 87:4003
88:203f
ata1: dev 0 ATA, max UDMA/100, 234441648 sectors
ata1: dev 0 configured for UDMA/33
ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0xFC08 irq 15
ata2: unhandled bus state 0
ata2: dev 0 cfg 49:0f00 82:0218 83:4000 84:4000 85:0218 86:0000 87:4000
88:041f
ata2: dev 0 ATAPI, max UDMA/66
ata2: dev 0 configured for UDMA/33
ata3: SATA max UDMA/133 cmd 0xEFE0 ctl 0xEFAE bmdma 0xEF90 irq 18
ata4: SATA max UDMA/133 cmd 0xEFA0 ctl 0xEFAA bmdma 0xEF98 irq 18
ata3: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003
88:207f
ata3: dev 0 ATA, max UDMA/133, 234441648 sectors
ata3: dev 0 configured for UDMA/133
ata4: thread exiting
scsi0 : ata_piix
scsi1 : ata_piix
scsi2 : ata_piix
scsi3 : ata_piix
  Vendor: ATA       Model: WDC WD1200JB-00E  Rev: 0.60
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3120026AS       Rev: 0.60
  Type:   Direct-Access                      ANSI SCSI revision: 05
libata version 0.60 loaded.
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi2, channel 0, id 0, lun 0
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
Partition check:
 sda: sda1 sda2 sda3 sda4 < sda5 >
SCSI device sdb: 234441648 512-byte hdwr sectors (120034 MB)
 sdb: sdb1 sdb2

Only my DVD-ROM doesn't show here. It should be on scsi1 (or is ATAPI
support not in yet?) What also shows is that ata1 is not being
configured for maximum possible speed. Ata1 should be set to UDMA/100.
The SATA drive is configured properly though.

Cheers,

Jurgen

