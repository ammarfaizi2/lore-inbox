Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311572AbSCXF3r>; Sun, 24 Mar 2002 00:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311574AbSCXF3h>; Sun, 24 Mar 2002 00:29:37 -0500
Received: from [206.58.238.200] ([206.58.238.200]:64386 "EHLO
	portland.puremagic.com") by vger.kernel.org with ESMTP
	id <S311572AbSCXF31>; Sun, 24 Mar 2002 00:29:27 -0500
Date: Sat, 23 Mar 2002 21:29:19 -0800 (PST)
From: Brad Roberts <braddr@puremagic.com>
To: <linux-kernel@vger.kernel.org>
Subject: partition detection failure between 2.4.19-pre2 and pre3
Message-ID: <Pine.LNX.4.33.0203232054210.27124-100000@portland.puremagic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(not on the list, I read it via a list archive due to traffic, so please
cc me on all replies)

Starting with 2.4.19-pre3 (and continuing for -pre4 and every post-pre2 ac
kernel I've tried) bootup hangs during partition detection:

2.4.19-pre2 output:

<snip>
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20265: IDE controller on PCI bus 00 dev 30
PCI: Found IRQ 5 for device 00:06.0
PCI: Sharing IRQ 5 with 00:10.0
PCI: Sharing IRQ 5 with 00:11.2
PCI: Sharing IRQ 5 with 00:11.3
PCI: Sharing IRQ 5 with 00:11.4
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0xb400-0xb407, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xb408-0xb40f, BIOS settings: hdg:DMA, hdh:pio
VP_IDE: IDE controller on PCI bus 00 dev 89
PCI: Found IRQ 11 for device 00:11.1
PCI: Sharing IRQ 11 with 01:00.0
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci00:11.1
    ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 98196H8, ATA DISK drive
hdc: 52X CD-ROM, ATAPI CD/DVD-ROM drive
hde: Maxtor 4D060H3, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xd800-0xd807,0xd402 on irq 5
hda: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=9964/255/63, UDMA(100)
hde: 120069936 sectors (61476 MB) w/2048KiB Cache, CHS=119117/16/63, UDMA(100)
hdc: ATAPI 52X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 < hda5 > hda3 hda4
 hde: hde1
<snip>


The pre-3 output stops right after:

Partition check:
 hda: hda1 hda2 < hda5 > hda3 hda4
 hde:


Ie, it never detects any partitions on hde.  The motherboard is an
A7V266-E asus motherboard.

Suggestions?  I started looking through the changes between pre2 and pre3,
but the ide subsystem got overhauled reasonably thoroughly in pre3.

Thanks,
Brad

