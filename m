Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263742AbTLTALY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 19:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263702AbTLTALY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 19:11:24 -0500
Received: from maximus.kcore.de ([213.133.102.235]:10406 "EHLO
	maximus.kcore.de") by vger.kernel.org with ESMTP id S263742AbTLTALR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 19:11:17 -0500
From: Oliver Feiler <kiza@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: ide-scsi hangs in 2.4.23
Date: Sat, 20 Dec 2003 01:09:54 +0100
User-Agent: KMail/1.5
X-PGP-Key-Fingerprint: E9DD 32F1 FA8A 0945 6A74  07DE 3A98 9F65 561D 4FD2
X-PGP-Key: http://kiza.kcore.de/pgpkey
X-Species: Snow Leopard
X-Operating-System: Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312200109.55075.kiza@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

the following happens quite often on the first access of a CD (audio and 
data). Anyone know what it means? The process accessing the CD hangs for 
about 15 seconds or so, then the system freezes for 1-2 seconds and then 
everything works like a charm.

scsi : aborting command due to timeout : pid 28, scsi1, channel 0, id 0, lun 0 
Read Capacity 00 00 00 00 00 00 00 00 00 
hdc: irq timeout: status=0xd0 { Busy }
hdc: DMA disabled
hdc: ATAPI reset complete
hdc: irq timeout: status=0xd0 { Busy }
hdc: ATAPI reset complete
hdc: status error: status=0x51 { DriveReady SeekComplete Error }
hdc: status error: error=0x60
scsi1 channel 0 : resetting for second half of retries.
SCSI bus is being reset for host 1 channel 0.
ide-scsi: Strange, packet command initiated yet DRQ isn't asserted
ISO 9660 Extensions: Microsoft Joliet Level 1
ISOFS: changing to secondary root

The drive is an LG GCC-4120B DVD/CD-RW drive attached to a VIA vt8235 
controller, 2nd channel, single drive. Using ide-scsi emulation. The problem 
is harmless though. At least it hasn't caused any further problems.


IDE part of dmesg:
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1
    ide0: BM-DMA at 0xec00-0xec07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xec08-0xec0f, BIOS settings: hdc:DMA, hdd:pio
hda: WDC WD400EB-00CPF0, ATA DISK drive
hdb: IBM-DTLA-305030, ATA DISK drive
blk: queue c0343820, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c0343968, I/O limit 4095Mb (mask 0xffffffff)
hdc: HL-DT-ST RW/DVD GCC-4120B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=4865/255/63, UDMA(100)
hdb: attached ide-disk driver.
hdb: host protected area => 1
hdb: 60036480 sectors (30739 MB) w/380KiB Cache, CHS=3737/255/63, UDMA(100)
ide-cd: passing drive hdc to ide-scsi emulation.
hdc: attached ide-scsi driver.


-- 
Oliver Feiler  <kiza@(kcore.de|lionking.org|gmx[pro].net)>

