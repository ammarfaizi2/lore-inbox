Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262262AbTE2OTj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 10:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbTE2OTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 10:19:38 -0400
Received: from bork.hampshire.edu ([206.153.194.35]:42981 "EHLO
	bork.hampshire.edu") by vger.kernel.org with ESMTP id S262262AbTE2OTh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 10:19:37 -0400
Date: Thu, 29 May 2003 10:32:56 -0400 (EDT)
From: "Wm. Josiah Erikson" <josiah@insanetechnology.com>
X-X-Sender: josiah@bork.hampshire.edu
To: linux-kernel@vger.kernel.org
Subject: siimage driver status
Message-ID: <Pine.LNX.4.44.0305291025550.11675-100000@bork.hampshire.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
	I have an Asus A7V8X Deluxe motherboard with a couple of WD Raptor 
hard drives that I'm trying to get to work with linux 2.4.21-rc6. The 
problem I'm having is that it's REALLY slow and crashy. The kernel reports 
this on bootup:

Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
NFORCE2: IDE controller at PCI slot 00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
AMD_IDE: Bios didn't set cable bits corectly. Enabling workaround.
ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
AMD_IDE: PCI device 10de:0065 (nVidia Corporation) (rev a2) UDMA100 
controller o
n pci00:09.0
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
SiI3112 Serial ATA: IDE controller at PCI slot 01:0b.0
SiI3112 Serial ATA: chipset revision 2
SiI3112 Serial ATA: not 100% native mode: will probe irqs later
    ide2: MMIO-DMA , BIOS settings: hde:pio, hdf:pio
    ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio
hda: SAMSUNG SP4002H, ATA DISK drive
blk: queue c02f6d40, I/O limit 4095Mb (mask 0xffffffff)
hdc: _NEC CD-RW NR-9300A, ATAPI CD/DVD-ROM drive
hdd: JLMS XJ-HD166S, ATAPI CD/DVD-ROM drive
hde: WDC WD360GD-00FNA0, ATA DISK drive
hdg: WDC WD360GD-00FNA0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xe0800080-0xe0800087,0xe080008a on irq 11
ide3 at 0xe08000c0-0xe08000c7,0xe08000ca on irq 11
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 78242976 sectors (40060 MB) w/2048KiB Cache, CHS=4870/255/63, 
UDMA(100)
hde: attached ide-disk driver.
hde: host protected area => 1
hde: 72303840 sectors (37020 MB) w/8192KiB Cache, CHS=4500/255/63
hdg: attached ide-disk driver.
hdg: host protected area => 1
hdg: 72303840 sectors (37020 MB) w/8192KiB Cache, CHS=4500/255/63
hdc: attached ide-scsi driver.
hdd: attached ide-scsi driver.
Partition check:
 hda: hda1 hda2 hda3
 hde: unknown partition table
 hdg: unknown partition table

The nforce2 ide controller works great, as does the drive on it. When I 
try to use either of the drives on the siimage controller, it brings 
everything else on my system to a temporary halt, and hdparm -t reports 
about 1.3MB/sec reads. This is a bummer, as I was hoping to RAID 0 them 
together and make them my boot drives :)

If I try and enable DMA, the machine instantly hardlocks.

I'm running debian sarge, if it matters.

Is there anything I should try, or is the siimage driver just still very 
early on in its development? I would be more than happy to beta- (or 
alpha) test code, or give developers access to my box if testbed platforms 
are needed. Whatever I can do to make it work :)

Thanks very much in advance
	-Josiah

Computer Guy
Hampshire College School of NS
Amherst, MA 01002

