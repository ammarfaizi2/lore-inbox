Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262125AbREQUaz>; Thu, 17 May 2001 16:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262121AbREQUap>; Thu, 17 May 2001 16:30:45 -0400
Received: from cs140085.pp.htv.fi ([213.243.140.85]:5893 "EHLO
	porkkala.cs140085.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S262117AbREQUag>; Thu, 17 May 2001 16:30:36 -0400
Message-ID: <3B043481.A394D98D@pp.htv.fi>
Date: Thu, 17 May 2001 23:28:49 +0300
From: Jussi Laako <jlaako@pp.htv.fi>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: VIA/PDC/Athlon
In-Reply-To: <E150QtB-0005aC-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> RH 2.4.2-2 and 2.4.4-ac9 are I believe the same driver exactly. 2.4.3 is 
> an ancient known not to work well driver

Ummm... Here's stripped dmesg of both kernels... Is this compiler thingie or
Athlon optimizations?
Notice also different detected PDC20265 BIOS settings! So 2.4.4-ac9 detects
those BIOS settings correctly and 2.4.2-2 doesn't. That's probably reason
why 2.4.2-2 works?

--- 8< ---

Linux version 2.4.4-ac9 (root@davinci) (gcc version 2.95.3 20010315
(release)) #1 Wed May 16 17:37:30 EEST 2001

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 21
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:04.1
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:DMA
PDC20265: IDE controller on PCI bus 00 dev 88
PCI: Found IRQ 10 for device 00:11.0
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0x7400-0x7407, BIOS settings: hde:DMA, hdf:DMA
    ide3: BM-DMA at 0x7408-0x740f, BIOS settings: hdg:DMA, hdh:DMA
hda: IBM-DTLA-307030, ATA DISK drive
hdb: SONY CDU4811, ATAPI CD/DVD-ROM drive
hde: IBM-DTLA-307030, ATA DISK drive
hdf: IBM-DTLA-307030, ATA DISK drive
hdg: IBM-DTLA-307030, ATA DISK drive
hdh: IBM-DTLA-307030, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2 at 0x8800-0x8807,0x8402 on irq 10
ide3 at 0x8000-0x8007,0x7802 on irq 10
hda: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=3737/255/63, UDMA(100)
hde: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=59560/16/63, UDMA(100)
hdf: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=59560/16/63, UDMA(100)
hdg: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=59560/16/63, UDMA(100)
hdh: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=59560/16/63, UDMA(100)
Partition check:
 hda:hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide0: reset: success
 hda1 hda2 hda3 hda4
 hde: hde1 hde2 hde3 hde4
 hdf: unknown partition table
 hdg: unknown partition table
 hdh: unknown partition table

--- 8< ---

Linux version 2.4.2-2 (root@porky.devel.redhat.com) (gcc version 2.96
20000731 (Red Hat Linux 7.1 2.96-79)) #1 Sun Apr 8 20:41:30 EDT 2001

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 21
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:04.1
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:DMA
PDC20265: IDE controller on PCI bus 00 dev 88
PCI: Found IRQ 10 for device 00:11.0
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0x7400-0x7407, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0x7408-0x740f, BIOS settings: hdg:pio, hdh:pio
hda: IBM-DTLA-307030, ATA DISK drive
hdb: SONY CDU4811, ATAPI CD/DVD-ROM drive
hde: IBM-DTLA-307030, ATA DISK drive
hdf: IBM-DTLA-307030, ATA DISK drive
hdg: IBM-DTLA-307030, ATA DISK drive
hdh: IBM-DTLA-307030, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2 at 0x8800-0x8807,0x8402 on irq 10
ide3 at 0x8000-0x8007,0x7802 on irq 10
hda: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=3737/255/63, UDMA(33)
hde: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=59560/16/63, UDMA(100)
hdf: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=59560/16/63, UDMA(100)
hdg: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=59560/16/63, UDMA(100)
hdh: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=59560/16/63, UDMA(100)
Partition check:
 hda: hda1 hda2 hda3 hda4
 hde: hde1 hde2 hde3 hde4
 hdf: unknown partition table
 hdg: unknown partition table
 hdh: unknown partition table

--- 8< ---

 - Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers
