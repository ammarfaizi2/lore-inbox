Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278099AbRKJQsp>; Sat, 10 Nov 2001 11:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277722AbRKJQsf>; Sat, 10 Nov 2001 11:48:35 -0500
Received: from unicef.org.yu ([194.247.200.148]:32019 "EHLO unicef.org.yu")
	by vger.kernel.org with ESMTP id <S278099AbRKJQsT>;
	Sat, 10 Nov 2001 11:48:19 -0500
Date: Sat, 10 Nov 2001 17:47:15 +0100 (CET)
From: Davidovac Zoran <zdavid@unicef.org.yu>
To: Torrey Hoffman <torrey.hoffman@myrio.com>
cc: "'Matthias Schniedermeyer'" <ms@citd.de>,
        Erik Andersen <andersen@codepoet.org>,
        Rik van Riel <riel@conectiva.com.br>, Ben Israel <ben@genesis-one.com>,
        <linux-kernel@vger.kernel.org>
Subject: RE: Disk Performance
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211CABE@mail0.myrio.com>
Message-ID: <Pine.LNX.4.33.0111101746020.11836-100000@unicef.org.yu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

try
hdparm -d1 /dev/hda
hdparm -d1 /dev/hdb
and test them now
On Fri, 9 Nov 2001, Torrey Hoffman wrote:

> Erik Andersen wrote:
>
> >The Promise controller has two identical 46.1GB IBM-DTLA-307045 7200
> >rpm hard drives on it.  The controller is capable of ATA100.  The hard
> >drives are capable of ATA100.  And yet even with CONFIG_IDEDMA_AUTO
> >set, these drives both come up running 3.39 MB/s.
>
> Interesting...
>
> You've got the PDC20267 chipset, I have two cards with the PDC20268
> chipset (Ultra TX2/100) and they both work fine - although the BIOS
> setting shows as PIO, the kernel correctly enables UDMA-100 for the
> Maxtor drives attached to them for me (CONFIG_IDEDMA_AUTO is on.)
>
> And, I have an identical IBM drive on my motherboard (VIA) controller
> and it comes up fine too, so it isn't the hard drive....
>
>
> Linux rivendell.arnor.net 2.4.14-pre6 #2 SMP Wed Oct 31 21:29:03 PST 2001
> i686 unknown
> ...
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> VP_IDE: IDE controller on PCI bus 00 dev 39
> VP_IDE: chipset revision 16
> VP_IDE: not 100% native mode: will probe irqs later
> VP_IDE: VIA vt82c596b (rev 23) IDE UDMA66 controller on pci00:07.1
>     ide0: BM-DMA at 0x9000-0x9007, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0x9008-0x900f, BIOS settings: hdc:DMA, hdd:DMA
> PDC20268: IDE controller on PCI bus 00 dev 90
> PDC20268: chipset revision 2
> PDC20268: not 100% native mode: will probe irqs later
> PDC20268: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER
> Mode.
>     ide2: BM-DMA at 0xac00-0xac07, BIOS settings: hde:pio, hdf:pio
>     ide3: BM-DMA at 0xac08-0xac0f, BIOS settings: hdg:pio, hdh:pio
> PDC20268: IDE controller on PCI bus 00 dev 98
> PDC20268: chipset revision 1
> PDC20268: not 100% native mode: will probe irqs later
> PDC20268: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER
> Mode.
>     ide4: BM-DMA at 0xc000-0xc007, BIOS settings: hdi:pio, hdj:pio
>     ide5: BM-DMA at 0xc008-0xc00f, BIOS settings: hdk:pio, hdl:pio
> hda: IBM-DTLA-307045, ATA DISK drive
> hdc: PLEXTOR CD-R PX-W1210A, ATAPI CD/DVD-ROM drive
> hdd: TOSHIBA DVD-ROM SD-M1402, ATAPI CD/DVD-ROM drive
> hde: Maxtor 4W060H4, ATA DISK drive
> hdg: Maxtor 4W060H4, ATA DISK drive
> hdi: Maxtor 4W060H4, ATA DISK drive
> hdk: Maxtor 4W060H4, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> ide2 at 0x9c00-0x9c07,0xa002 on irq 18
> ide3 at 0xa400-0xa407,0xa802 on irq 18
> ide4 at 0xb000-0xb007,0xb402 on irq 19
> ide5 at 0xb800-0xb807,0xbc02 on irq 19
> hda: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=5606/255/63, UDMA(66)
> hde: 117347328 sectors (60082 MB) w/2048KiB Cache, CHS=116416/16/63,
> UDMA(100)
> hdg: 117347328 sectors (60082 MB) w/2048KiB Cache, CHS=116416/16/63,
> UDMA(100)
> hdi: 117347328 sectors (60082 MB) w/2048KiB Cache, CHS=116416/16/63,
> UDMA(100)
> hdk: 117347328 sectors (60082 MB) w/2048KiB Cache, CHS=116416/16/63,
> UDMA(100)
> ...
>
> Torrey Hoffman
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

