Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318059AbSIEUv0>; Thu, 5 Sep 2002 16:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318115AbSIEUv0>; Thu, 5 Sep 2002 16:51:26 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:20999
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S318059AbSIEUvZ>; Thu, 5 Sep 2002 16:51:25 -0400
Date: Thu, 5 Sep 2002 13:55:29 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: "T. Ryan Halwachs" <halwachs@cats.ucsc.edu>
cc: kernel mailing list <linux-kernel@vger.kernel.org>,
       ataraid mailing list <ataraid-list@redhat.com>
Subject: Re: CMD649: siig 'Ultra ATA-100 pci' secondary channel mapped as
 ide1?
In-Reply-To: <1031248988.4320.156.camel@p700m700>
Message-ID: <Pine.LNX.4.10.10209051353580.8071-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 Sep 2002, T. Ryan Halwachs wrote:

> Is this a feature of CMD649? What if I want to use the second channel on my MOBO?
>  
> > Sep  2 23:49:12 array kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31 
> > Sep  2 23:49:12 array kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> > Sep  2 23:49:12 array kernel: PIIX4: IDE controller on PCI bus 00 dev 39 
> > Sep  2 23:49:12 array kernel: PIIX4: chipset revision 1
> > Sep  2 23:49:13 array kernel: PIIX4: not 100%% native mode: will probe irqs later
> > Sep  2 23:49:13 array kernel:     ide0: BM-DMA at 0x14a0-0x14a7, BIOS settings: hda:DMA, hdb:pio

Argh, this needs to skip groups.

It is totally odd that it wrapped back early.

Will look into it.


> > Sep  2 23:49:13 array kernel: PDC20267: IDE controller on PCI bus 00 dev 68
> > Sep  2 23:49:13 array kernel: PCI: Sharing IRQ 11 with 00:11.0
> > Sep  2 23:49:14 array kernel: PDC20267: chipset revision 2
> > Sep  2 23:49:14 array kernel: PDC20267: not 100%% native mode: will probe irqs later
> > Sep  2 23:49:14 array kernel: PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
> > Sep  2 23:49:15 array kernel:     ide2: BM-DMA at 0x1400-0x1407, BIOS settings: hde:DMA, hdf:pio
> > Sep  2 23:49:15 array kernel:     ide3: BM-DMA at 0x1408-0x140f, BIOS settings: hdg:DMA, hdh:pio
> > Sep  2 23:49:15 array kernel: PDC20267: IDE controller on PCI bus 00 dev 70
> > Sep  2 23:49:15 array kernel: PCI: Found IRQ 10 for device 00:0e.0
> > Sep  2 23:49:15 array kernel: PDC20267: chipset revision 2
> > Sep  2 23:49:16 array kernel: PDC20267: not 100%% native mode: will probe irqs later
> > Sep  2 23:49:16 array kernel: PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
> > Sep  2 23:49:16 array kernel:     ide4: BM-DMA at 0x1440-0x1447, BIOS settings: hdi:DMA, hdj:pio
> > Sep  2 23:49:16 array kernel:     ide5: BM-DMA at 0x1448-0x144f, BIOS settings: hdk:DMA, hdl:pio
> > Sep  2 23:49:16 array kernel: CMD649: IDE controller on PCI bus 00 dev 80
> > Sep  2 23:49:17 array kernel: PCI: Found IRQ 9 for device 00:10.0
> > Sep  2 23:49:17 array kernel: PCI: Sharing IRQ 9 with 00:07.2
> > Sep  2 23:49:17 array kernel: CMD649: chipset revision 2
> > Sep  2 23:49:17 array kernel: CMD649: not 100%% native mode: will probe irqs later				      *
> 														    *
> > Sep  2 23:49:17 array kernel:     ide1: BM-DMA at 0x14b0-0x14b7, BIOS settings: hdc:pio, hdd:pio                * * * * * * * * *
> 														    * 
> > Sep  2 23:49:17 array kernel:     ide6: BM-DMA at 0x14b8-0x14bf, BIOS settings: hdm:pio, hdn:pio		      *
> > Sep  2 23:49:17 array kernel: hda: QUANTUM FIREBALL_TM3840A, ATA DISK drive
> > Sep  2 23:49:17 array kernel: hdc: WDC WD1200BB-00CAA1, ATA DISK drive
> > Sep  2 23:49:17 array kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx 
> > Sep  2 23:49:17 array kernel: hde: WDC WD1200AB-00CBA1, ATA DISK drive
> > Sep  2 23:49:17 array kernel: hdg: WDC WD1200AB-00CBA1, ATA DISK drive
> > Sep  2 23:49:17 array kernel: hdi: WDC WD1200AB-00CBA1, ATA DISK drive
> > Sep  2 23:49:17 array kernel: hdk: IC35L120AVVA07-0, ATA DISK drive
> > Sep  2 23:49:17 array kernel: hdm: WDC WD1200AB-00CBA1, ATA DISK drive
> > Sep  2 23:49:17 array kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> > Sep  2 23:49:17 array kernel: ide1 at 0x1800-0x1807,0x14f6 on irq 9
> > Sep  2 23:49:18 array kernel: ide2 at 0x14d0-0x14d7,0x14c6 on irq 11
> > Sep  2 23:49:18 array kernel: ide3 at 0x14c8-0x14cf,0x14c2 on irq 11
> > Sep  2 23:49:18 array kernel: ide4 at 0x14e8-0x14ef,0x14de on irq 10
> > Sep  2 23:49:18 array kernel: ide5 at 0x14e0-0x14e7,0x14da on irq 10
> > Sep  2 23:49:18 array kernel: ide6 at 0x14f8-0x14ff,0x14f2 on irq 9
> > Sep  2 23:49:18 array kernel: hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> > Sep  2 23:49:18 array kernel: hda: task_no_data_intr: error=0x04 { DriveStatusError }
> > Sep  2 23:49:18 array kernel: hda: 7539840 sectors (3860 MB) w/76KiB Cache, CHS=935/128/63, DMA
> > Sep  2 23:49:18 array kernel: hdc: host protected area => 1
> > Sep  2 23:49:18 array kernel: hdc: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=232581/16/63, UDMA(100)
> > Sep  2 23:49:18 array kernel: hde: host protected area => 1
> > Sep  2 23:49:18 array kernel: hde: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=232581/16/63, UDMA(100)
> > Sep  2 23:49:18 array kernel: hdg: host protected area => 1
> > Sep  2 23:49:18 array kernel: hdg: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=232581/16/63, UDMA(100)
> > Sep  2 23:49:18 array kernel: hdi: host protected area => 1
> > Sep  2 23:49:18 array kernel: hdi: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=232581/16/63, UDMA(100)
> > Sep  2 23:49:18 array kernel: hdk: host protected area => 1
> > Sep  2 23:49:18 array kernel: hdk: 241254720 sectors (123522 MB) w/1863KiB Cache, CHS=239340/16/63, UDMA(100)
> > Sep  2 23:49:18 array kernel: hdm: host protected area => 1
> > Sep  2 23:49:18 array kernel: hdm: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=232581/16/63, UDMA(100)
> > Sep  2 23:49:18 array kernel: Partition check:
> > Sep  2 23:49:18 array kernel:  hda: [PTBL] [469/255/63] hda1 hda2
> > Sep  2 23:49:18 array kernel:  hdc: hdc1
> > Sep  2 23:49:18 array kernel:  hde: hde1
> > Sep  2 23:49:19 array kernel:  hdg: hdg1
> > Sep  2 23:49:19 array kernel:  hdi: hdi1
> > Sep  2 23:49:19 array kernel:  hdk: hdk1
> > Sep  2 23:49:19 array kernel:  hdm: hdm1
> 

Andre Hedrick
LAD Storage Consulting Group

