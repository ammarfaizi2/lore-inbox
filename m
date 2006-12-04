Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966947AbWLDUgC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966947AbWLDUgC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 15:36:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966969AbWLDUgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 15:36:01 -0500
Received: from www17.your-server.de ([213.133.104.17]:3906 "EHLO
	www17.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966947AbWLDUgA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 15:36:00 -0500
Message-ID: <4574865A.6030508@m3y3r.de>
Date: Mon, 04 Dec 2006 21:34:34 +0100
From: Thomas Meyer <thomas@m3y3r.de>
User-Agent: Thunderbird 1.5.0.8 (X11/20061126)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ata_piix multithreaded device probes breaks detection of SCSI device
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: thomas@m3y3r.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

head: d916faace3efc0bf19fe9a615a1ab8fa1a24cd93

Here a sequential probe, that boots fine:
"
[cut]
ata_piix 0000:00:1f.1: version 2.00ac6
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1f.1 to 64
ata1: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x40C0 irq 14
ata2: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x40C8 irq 15
scsi0 : ata_piix
ata1.00: ATAPI, max UDMA/66
ata1.00: configured for UDMA/66
scsi1 : ata_piix
ATA: abnormal status 0x7F on port 0x177
scsi 0:0:0:0: CD-ROM            MATSHITA DVD-R   UJ-857   HAE4 PQ: 0 ANSI: 5
ata_piix 0000:00:1f.2: MAP [ P0 P2 XX XX ]
ata_piix 0000:00:1f.2: invalid MAP value 0

PCI: Enabling device 0000:00:1f.2 (0005 -> 0007)
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata3: SATA max UDMA/133 cmd 0x40D8 ctl 0x40F6 bmdma 0x4020 irq 19
ata4: SATA max UDMA/133 cmd 0x40D0 ctl 0x40F2 bmdma 0x4028 irq 19
scsi2 : ata_piix
ATA: abnormal status 0x7F on port 0x40DF
ATA: abnormal status 0x7F on port 0x40DF
ata3.01: ATA-7, max UDMA/133, 156301488 sectors: LBA48 NCQ (depth 0/32)
ata3.01: ata3: dev 1 multi count 16
ata3.01: configured for UDMA/133
scsi3 : ata_piix
ATA: abnormal status 0x7F on port 0x40D7
scsi 2:0:1:0: Direct-Access     ATA      ST98823AS        7.01 PQ: 0 ANSI: 5
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
  sda: sda1 sda4 sda5 sda6 sda7 sda8 sda9 sda10
sd 2:0:1:0: Attached scsi disk sda
PNP: No PS/2 controller found. Probing ports directly.
[cut]"

Here what i could catch from a multithreaded pci boot:

http://m3y3r.de/bilder/piix.jpg

with kind regards
Thomas
