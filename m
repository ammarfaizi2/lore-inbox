Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131183AbRCGUdd>; Wed, 7 Mar 2001 15:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131196AbRCGUdX>; Wed, 7 Mar 2001 15:33:23 -0500
Received: from balu.sch.bme.hu ([152.66.224.40]:40348 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S131183AbRCGUdI>;
	Wed, 7 Mar 2001 15:33:08 -0500
Date: Wed, 7 Mar 2001 21:32:23 +0100 (MET)
From: Pozsar Balazs <pozsy@sch.bme.hu>
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: can't read DVD (under 2.4.[12] & 2.2.17)
In-Reply-To: <20010307210848.E4653@suse.de>
Message-ID: <Pine.GSO.4.30.0103072128180.6575-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Details: (dmesg)

Linux version 2.4.2-3mdk (jgarzik@no.mandrakesoft.com) (gcc version
egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 Tue Feb 27 02:14:17
CET 2001
...
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:pio, hdd:DMA
HPT370: IDE controller on PCI bus 00 dev 70
PCI: Found IRQ 11 for device 00:0e.0
HPT370: chipset revision 3
HPT370: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xec00-0xec07, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xec08-0xec0f, BIOS settings: hdg:DMA, hdh:pio
hdd: Pioneer DVD-ROM ATAPIModel DVD-105S 012, ATAPI CD/DVD-ROM drive
hdg: QUANTUM FIREBALLlct20 20, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
ide3 at 0xe400-0xe407,0xe802 on irq 11
hdg: 39876480 sectors (20417 MB) w/418KiB Cache, CHS=39560/16/63,
UDMA(100)
hdd: ATAPI 40X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hdg: hdg1 hdg2 hdg3 hdg4
...



When I run "dvdinfo /dev/hdd" I get:
Disc is encrypted.
Layer 0[3]
 Book Version:   0
 Book Type:      13
 Min Rate:       0
 Disc Size:      0
 Layer Type:     0
 Track Path:     1
 Num Layers:     2
 Track Density:  0
 Linear Density: 0
 BCA:            1
 Start Sector    0xd000
 End Sector      0xd000
 End Sector L0   0xd000
Layer 1[3]
 Book Version:   0
 Book Type:      13
 Min Rate:       0
 Disc Size:      0
 Layer Type:     0
 Track Path:     1
 Num Layers:     2
 Track Density:  0
 Linear Density: 0
 BCA:            1
 Start Sector    0xd000
 End Sector      0x1d000
 End Sector L0   0xd000
hdd: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdd: packet command error: error=0x50
ATAPI device hdd:
  Error: Illegal request -- (Sense key=0x05)
  Invalid field in command packet -- (asc=0x24, ascq=0x00)
  The failed "Send DVD Structure" packet command was:
  "ad 00 00 00 00 00 02 00 00 54 00 00 "
Could not read Physical layer 2
Copyright: CPST=1, RMI=0xfd


I also get this in syslog:

hdd: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdd: packet command error: error=0x50
ATAPI device hdd:
  Error: Illegal request -- (Sense key=0x05)
  Invalid field in command packet -- (asc=0x24, ascq=0x00)
  The failed "Send DVD Structure" packet command was:
  "ad 00 00 00 00 00 02 00 00 54 00 00 "


Tell me i can give you any more info.

Balazs Pozsar.



On Wed, 7 Mar 2001, Jens Axboe wrote:

> On Wed, Mar 07 2001, Pozsar Balazs wrote:
> >
> > hi all,
> >
> > Whatever I tried, I couldn't get my DVDs read. I get:
> >  sr0: CDROM (ioctl) reports ILLEGAL REQUEST.
> > or, I don't use ide-scsi, i get the ATAPI equivalent.
> > I have udf support compiled in, i have successfully authenticated the
> > disk(s), but lo luck.
> >
> > The drive is:
> >    Vendor: PIONEER   Model: DVD-ROM DVD-105   Rev: 1.22
> >
> > I tried 2.2.17, 2.4.1 & 2.4.2 (and a few different compiled versions of
> > them)
> >
> > What might be the problem?
>
> I don't know, you provide virtually no information. Use the ATAPI
> driver, and dump dmesg info when this happens. Then send that along.
>
>

