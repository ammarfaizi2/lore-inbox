Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129245AbRDGRtr>; Sat, 7 Apr 2001 13:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129464AbRDGRt3>; Sat, 7 Apr 2001 13:49:29 -0400
Received: from zeus.kernel.org ([209.10.41.242]:37849 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129346AbRDGRtO>;
	Sat, 7 Apr 2001 13:49:14 -0400
Date: Sat, 07 Apr 2001 13:36:11 -0400
From: "David St.Clair" <dstclair@cs.wcu.edu>
Subject: UDMA(66) drive coming up as UDMA(33)?
To: linux-kernel@vger.kernel.org
Message-id: <986664971.1224.4.camel@bugeyes.wcu.edu>
MIME-version: 1.0
X-Mailer: Evolution/0.10+cvs.2001.04.06.08.06 (Preview Release)
Content-type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to get my hard drive to use UDMA/66.  I'm thinking the cable
is not being detected.  When the HPT366 bios is set to UDMA 4; using
hdparm -t, I get a transfer rate of 19.51 MB/s. When the HPT366 bios is
set to PIO 4 the transfer rate is the same. Is this normal for a UDMA/66
drive? What makes me think something is wrong is that the log says

"ide2: BM-DMA at 0xbc00-0xbc07, BIOS settings: hde:pio" <-- PIO? 

and

"hde: 27067824 sectors (13859 MB) w/371KiB Cache, CHS=26853/16/63,
UDMA(33)" <--- UDMA(33)? shouldn't it be UDMA(66)?

Any ideas what might be wrong? Possible bug?


Hardware:
Abit BE6 Motherboard with HPT366 controller
Quantum Fireball KA 13.6 UDMA/66 HD
80 pin connector
Linux Partition is on /dev/hde2

Software:
Redhat 7.0
Kernel 2.4.3 (non-modified)

Use multi-mode by default = Y
CMD640 chipset bugfix/support = Y
RZ1000 chipset bugfix/support = Y
Generic PCI IDE chipset support = Y
Shareing PCI IDE interrupts support = Y
Generic PCI bus-master DMA support = Y
Use PCI DMA by default when available = Y
HPT366 chipset support = Y
Intel PIIXn chipsets support = Y
PIIXn Tuning support = Y
IGNORE word93 Validation BITS = Y



My Log:

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
automount[415]: starting automounter version 3.1.6, path = /misc,
maptype = file, mapname = /etc/auto.misc
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100%% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
HPT366: onboard version of chipset, pin1=1 pin2=2
HPT366: IDE controller on PCI bus 00 dev 98
PCI: Found IRQ 11 for device 00:13.0
PCI: The same IRQ used for device 00:0b.0
PCI: The same IRQ used for device 00:13.1
HPT366: chipset revision 1
HPT366: not 100%% native mode: will probe irqs later
    ide2: BM-DMA at 0xbc00-0xbc07, BIOS settings: hde:pio, hdf:pio
HPT366: IDE controller on PCI bus 00 dev 99
PCI: Found IRQ 11 for device 00:13.1
PCI: The same IRQ used for device 00:0b.0
PCI: The same IRQ used for device 00:13.0
HPT366: chipset revision 1
Initializing random number generator:  succeeded
HPT366: not 100%% native mode: will probe irqs later
     ide3: BM-DMA at 0xc800-0xc807, BIOS settings: hdg:pio, hdh:pio
hdc: Pioneer DVD-ROM ATAPIModel DVD-113 0114, ATAPI CD/DVD-ROM drive
hdd: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
hde: QUANTUM FIREBALLP KA13.6, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xb400-0xb407,0xb802 on irq 11
hde: 27067824 sectors (13859 MB) w/371KiB Cache, CHS=26853/16/63,
UDMA(33)
hdc: ATAPI DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
hdd: 98304kB, 96/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm



Thank you,

David St.Clair
dstclair@cs.wcu.edu


