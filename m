Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317603AbSHCQdh>; Sat, 3 Aug 2002 12:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317604AbSHCQdh>; Sat, 3 Aug 2002 12:33:37 -0400
Received: from mta03-svc.ntlworld.com ([62.253.162.43]:7571 "EHLO
	mta03-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S317603AbSHCQdg>; Sat, 3 Aug 2002 12:33:36 -0400
From: <alien.ant@ntlworld.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19 IDE Partition Check issue
Date: Sat, 3 Aug 2002 16:37:08 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20020803163708.GHUY23840.mta03-svc.ntlworld.com@[10.137.100.63]>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I attempted to upgrade from 2.4.18 to 2.4.19 today but one of machines repeatedly hangs at the "Partition check" on the IDE drives.

The machine is a Compaq Proliant 800 Pentium III SMP box with a Highpoint 370 IDE controller. I attempted several reboots with the check continually failing. Rebooting back to 2.4.18 removed the problem.

Searching the archive I note several other people have had this problem with 2.4.19-pre kernels but, as yet, there seems to be no resolution?

Thanks,

Steve.


2.4.19
------
Aug  3 16:04:23 shaun kernel: HPT370: IDE controller on PCI bus 01 dev 38
Aug  3 16:04:23 shaun kernel: HPT370: chipset revision 3
Aug  3 16:04:23 shaun kernel: HPT370: not 100%% native mode: will probe irqs lat er
Aug  3 16:04:23 shaun kernel: HPT370: using 33MHz PCI clock
Aug  3 16:04:23 shaun kernel:     ide2: BM-DMA at 0x4000-0x4007, BIOS settings: hde:DMA, hdf:DMA
Aug  3 16:04:23 shaun kernel:     ide3: BM-DMA at 0x4008-0x400f, BIOS settings: hdg:pio, hdh:pio
Aug  3 16:04:23 shaun kernel: hda: CD-ROM CDU701-Q, ATAPI CD/DVD-ROM drive
Aug  3 16:04:23 shaun kernel: hde: Maxtor 53073U6, ATA DISK drive
Aug  3 16:04:23 shaun kernel: hdf: IBM-DTLA-307045, ATA DISK drive
Aug  3 16:04:23 shaun kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Aug  3 16:04:23 shaun kernel: ide2 at 0x4400-0x4407,0x4412 on irq 23
Aug  3 16:04:23 shaun kernel: hde: 60030432 sectors (30736 MB) w/2048KiB Cache,CHS=59554/16/63, UDMA(66)
Aug  3 16:04:23 shaun kernel: hdf: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63, UDMA(44)
Aug  3 16:04:23 shaun kernel: hda: ATAPI 14X CD-ROM drive, 128kB Cache
Aug  3 16:04:23 shaun kernel: Uniform CD-ROM driver Revision: 3.12
Aug  3 16:04:23 shaun kernel: Partition check:
Aug  3 16:04:23 shaun kernel:  hde: hde1 < hde5 >
Aug  3 16:04:23 shaun kernel:  hdf:hdf: status timeout: status=0xff {Busy }
Aug  3 16:04:23 shaun kernel: hde: DMA disabled
Aug  3 16:04:23 shaun kernel: hdf: DMA disabled
Aug  3 16:04:23 shaun kernel: hdf: drive not ready for command
Aug  3 16:04:23 shaun kernel: ide2: reset: success
Aug  3 16:04:23 shaun kernel:  hdf1 < hdf5 >


2.4.18
------
Aug  3 16:14:46 shaun kernel: HPT370: IDE controller on PCI bus 01 dev
38
Aug  3 16:14:46 shaun kernel: HPT370: chipset revision 3
Aug  3 16:14:46 shaun kernel: HPT370: not 100%% native mode: will probe irqs later
Aug  3 16:14:46 shaun kernel:     ide2: BM-DMA at 0x4000-0x4007, BIOS settings:hde:DMA, hdf:DMA
Aug  3 16:14:46 shaun kernel:     ide3: BM-DMA at 0x4008-0x400f, BIOS settings:hdg:pio, hdh:pio
Aug  3 16:14:46 shaun kernel: hda: CD-ROM CDU701-Q, ATAPI CD/DVD-ROM drive
Aug  3 16:14:46 shaun kernel: hde: Maxtor 53073U6, ATA DISK drive
Aug  3 16:14:46 shaun kernel: hdf: IBM-DTLA-307045, ATA DISK drive
Aug  3 16:14:46 shaun kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Aug  3 16:14:46 shaun kernel: ide2 at 0x4400-0x4407,0x4412 on irq 23
Aug  3 16:14:46 shaun kernel: hde: 60030432 sectors (30736 MB) w/2048KiB Cache,CHS=59554/16/63, UDMA(66)
Aug  3 16:14:46 shaun kernel: hdf: 90069840 sectors (46116 MB) w/1916KiB Cache,CHS=89355/16/63, UDMA(44)
Aug  3 16:14:46 shaun kernel: hda: ATAPI 14X CD-ROM drive, 128kB Cache
Aug  3 16:14:46 shaun kernel: Uniform CD-ROM driver Revision: 3.12
Aug  3 16:14:46 shaun kernel: Partition check:
Aug  3 16:14:46 shaun kernel:  hde: hde1 < hde5 >
Aug  3 16:14:46 shaun kernel:  hdf: hdf1 < hdf5 >

