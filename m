Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161120AbWG1Lpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161120AbWG1Lpx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 07:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932612AbWG1Lpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 07:45:52 -0400
Received: from smtp.ono.com ([62.42.230.12]:63349 "EHLO resmta03.ono.com")
	by vger.kernel.org with ESMTP id S1751079AbWG1Lpw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 07:45:52 -0400
Date: Fri, 28 Jul 2006 13:45:50 +0200
From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
To: "Linux-Kernel, " <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Subject: [2.6.18-rc2-mm1] libata ate one PATA channel
Message-ID: <20060728134550.030a0eb8@werewolf.auna.net>
X-Mailer: Sylpheed-Claws 2.3.1cvs86 (GTK+ 2.10.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi...

I've been out for more than a week. Just went to try -rc2-mm1 and
it ate one ide channel...

This was -rc1-mm2:
libata version 2.00 loaded.
ata_piix 0000:00:1f.1: version 2.00ac6
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1f.1 to 64
ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
scsi0 : ata_piix
ata1.00: ATAPI, max UDMA/33
ata1.01: ATAPI, max MWDMA0, CDB intr
ata1.00: configured for PIO3
ata1.01: configured for PIO3
  Vendor: HL-DT-ST  Model: DVDRAM GSA-4120B  Rev: A111
  Type:   CD-ROM                             ANSI SCSI revision: 05
  Vendor: IOMEGA    Model: ZIP 250           Rev: 51.G
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
scsi1 : ata_piix
ata2.00: ATA-6, max UDMA/100, 234441648 sectors: LBA48
ata2.00: ata2: dev 0 multi count 16
ata2.01: ATAPI, max UDMA/33
ata2.00: configured for UDMA/33
ata2.01: configured for UDMA/33
  Vendor: ATA       Model: ST3120022A        Rev: 3.06
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: TOSHIBA   Model: DVD-ROM SD-M1712  Rev: 1004
  Type:   CD-ROM                             ANSI SCSI revision: 05
ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata3: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 16
ata4: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD008 irq 16


This is -rc2-mm1, a PATA channel is missing...

libata version 2.00 loaded.
ata_piix 0000:00:1f.1: version 2.00ac6
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1f.1 to 64
ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
scsi0 : ata_piix
ata1.00: ATAPI, max UDMA/33 
ata1.01: ATAPI, max MWDMA0, CDB intr
ata1.00: configured for UDMA/33
ata1.01: configured for PIO3
  Vendor: HL-DT-ST  Model: DVDRAM GSA-4120B  Rev: A111 
  Type:   CD-ROM                             ANSI SCSI revision: 05
  Vendor: IOMEGA    Model: ZIP 250           Rev: 51.G 
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ] 
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata2: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 16
ata3: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD008 irq 16

Any idea ?
Any more info needed ?
TIA

--
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2007.0 (Cooker) for i586
Linux 2.6.17-jam04 (gcc 4.1.1 20060518 (prerelease)) #2 SMP PREEMPT Mon
