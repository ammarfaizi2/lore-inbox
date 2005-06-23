Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262933AbVFXAET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262933AbVFXAET (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 20:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262881AbVFXACa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 20:02:30 -0400
Received: from bizon.gios.gov.pl ([212.244.124.8]:9415 "EHLO bizon.gios.gov.pl")
	by vger.kernel.org with ESMTP id S262936AbVFXAAd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 20:00:33 -0400
Date: Fri, 24 Jun 2005 01:47:35 +0200 (CEST)
From: Krzysztof Oledzki <olel@ans.pl>
X-X-Sender: olel@bizon.gios.gov.pl
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: SATA speed. Should be 150 or 133?
Message-ID: <Pine.LNX.4.62.0506240135340.29382@bizon.gios.gov.pl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-187430788-789118242-1119570455=:29382"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---187430788-789118242-1119570455=:29382
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hello,

Is it normal that each time kernel reports UDMA/133 instead of UDMA/150=20
for sata? I noticed this on both ICH5 and ICH6 (AHCI).

* 2.6.12 with ICH5:
libata version 1.11 loaded.
ata_piix version 1.03
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 193
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xCCB8 ctl 0xCCB2 bmdma 0xCC80 irq 193
ata2: SATA max UDMA/133 cmd 0xCCA0 ctl 0xCC9A bmdma 0xCC88 irq 193
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 86:3801 87:4003 88:=
207f
ata1: dev 0 ATA, max UDMA/133, 156250000 sectors:
ata1: dev 0 configured for UDMA/133
scsi0 : ata_piix
ata2: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 86:3801 87:4003 88:=
207f
ata2: dev 0 ATA, max UDMA/133, 156250000 sectors:
ata2: dev 0 configured for UDMA/133
scsi1 : ata_piix
   Vendor: ATA       Model: Maxtor 6Y080M0    Rev: YAR5
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: Maxtor 6Y080M0    Rev: YAR5
   Type:   Direct-Access                      ANSI SCSI revision: 05

* 2.6.12 with ICH6:
libata version 1.11 loaded.
ahci version 1.00
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 217
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ahci(0000:00:1f.2) AHCI 0001.0000 32 slots 4 ports 1.5 Gbps 0xf impl SATA m=
ode
ahci(0000:00:1f.2) flags: 64bit ncq pm led slum part
ata1: SATA max UDMA/133 cmd 0xE0802100 ctl 0x0 bmdma 0x0 irq 217
ata2: SATA max UDMA/133 cmd 0xE0802180 ctl 0x0 bmdma 0x0 irq 217
ata3: SATA max UDMA/133 cmd 0xE0802200 ctl 0x0 bmdma 0x0 irq 217
ata4: SATA max UDMA/133 cmd 0xE0802280 ctl 0x0 bmdma 0x0 irq 217
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:=
007f
ata1: dev 0 ATA, max UDMA/133, 156301488 sectors: lba48
ata1: dev 0 configured for UDMA/133
scsi0 : ahci
ata2: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:=
007f
ata2: dev 0 ATA, max UDMA/133, 156301488 sectors: lba48
ata2: dev 0 configured for UDMA/133
scsi1 : ahci
ata3: no device found (phy stat 00000000)
scsi2 : ahci
ata4: no device found (phy stat 00000000)
scsi3 : ahci
   Vendor: ATA       Model: ST380817AS        Rev: 3.42
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: ST380817AS        Rev: 3.42
   Type:   Direct-Access                      ANSI SCSI revision: 05


Best regards,


 =09=09=09Krzysztof Ol=EAdzki


PS: Thank you for updating the libata-dev/passthru repository and creating=
=20
the 2.6.12-git4-passthru1 patch. :)
---187430788-789118242-1119570455=:29382--
