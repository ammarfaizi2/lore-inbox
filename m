Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317946AbSHUHHt>; Wed, 21 Aug 2002 03:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317947AbSHUHHt>; Wed, 21 Aug 2002 03:07:49 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:35334
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317946AbSHUHHs>; Wed, 21 Aug 2002 03:07:48 -0400
Date: Wed, 21 Aug 2002 00:10:38 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
       "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>,
       "'Padraig Brady'" <padraig.brady@corvil.com>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
       "Warner, Bill (IndSys, GEFanuc, VMIC)" <Bill.Warner@gefanuc.com>
Subject: Re: MMIO {Re: IDE-flash device and hard disk on same controller}
In-Reply-To: <Pine.LNX.4.10.10208202356390.3867-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.10.10208210009330.3867-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


More proof:
p6dnf:/proc # cat iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c8fff : Extension ROM
000f0000-000fffff : System ROM
00100000-1fffffff : System RAM
  00100000-002e44cb : Kernel code
  002e44cc-0039b59f : Kernel data
e080df00-e080df07 : ide0
e080df08-e080df0f : ide1
e080df10-e080df17 : ide0
e080df18-e080df1f : ide1
e080df80-e080df87 : ide0
e080df8a-e080df8a : ide0
e080dfc0-e080dfc7 : ide1
e080dfca-e080dfca : ide1
fd000000-fd3fffff : Number 9 Computer Company Imagine 128
fd400000-fd7fffff : Number 9 Computer Company Imagine 128
fe3e7e00-fe3e7eff : Lite-On Communications Inc LNE100TX
  fe3e7e00-fe3e7eff : tulip
fe3e7f00-fe3e7fff : CMD Technology Inc PCI0680
fe3f0000-fe3fffff : Number 9 Computer Company Imagine 128
fe400000-fe7fffff : Number 9 Computer Company Imagine 128
fe800000-febfffff : Number 9 Computer Company Imagine 128
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
fffe0000-ffffffff : reserved


On Tue, 20 Aug 2002, Andre Hedrick wrote:

> 
> Geert,
> 
> The proof.
> 
> 
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> SiI680: IDE controller on PCI bus 00 dev 90
> SiI680: chipset revision 1
> SiI680: not 100% native mode: will probe irqs later
> SiI680: BASE CLOCK == 133
>     ide0: MMIO-DMA at 0xe080df00-0xe080df07, BIOS settings: hda:pio, hdb:pio
>     ide1: MMIO-DMA at 0xe080df08-0xe080df0f, BIOS settings: hdc:pio, hdd:pio
> PIIX3: IDE controller on PCI bus 00 dev 39
> PIIX3: chipset revision 0
> PIIX3: not 100% native mode: will probe irqs later
>     ide2: BM-DMA at 0xffa0-0xffa7, BIOS settings: hde:DMA, hdf:DMA
>     ide3: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdg:pio, hdh:pio
> hda: Maxtor 4G160J8, ATA DISK drive
> hdb: Maxtor 4G160J8, ATA DISK drive
> hdc: Maxtor 4G160J8, ATA DISK drive
> hdd: Maxtor 4G160J8, ATA DISK drive
> hde: ATAPI 44X CDROM, ATAPI CD/DVD-ROM drive
> hdf: CREATIVEDVD5240E-1, ATAPI CD/DVD-ROM drive
> ide0 at 0xe080df80-0xe080df87,0xe080df8a on irq 9
> ide1 at 0xe080dfc0-0xe080dfc7,0xe080dfca on irq 9
> ide2 at 0x1f0-0x1f7,0x3f6 on irq 14

Andre Hedrick
LAD Storage Consulting Group

