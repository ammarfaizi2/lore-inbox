Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317755AbSHHSry>; Thu, 8 Aug 2002 14:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317785AbSHHSry>; Thu, 8 Aug 2002 14:47:54 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:65288
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317755AbSHHSrx>; Thu, 8 Aug 2002 14:47:53 -0400
Date: Thu, 8 Aug 2002 11:43:20 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: Nick Orlov <nick.orlov@mail.ru>, B.Zolnierkiewicz@elka.pw.edu.pl,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org, davidsen@tmr.com
Subject: Re: Part 2: Re: [PATCH] pdc20265 problem.
In-Reply-To: <172AF2F5BB8@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.10.10208081138500.25573-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Aug 2002, Petr Vandrovec wrote:

> On  8 Aug 02 at 10:41, Andre Hedrick wrote:
> 
> > ide0 at 0xdfe0-0xdfe7,0xdfae on irq 31
> > ide1 at 0xdfa0-0xdfa7,0xdfaa on irq 31
> > ide2 at 0x1f0-0x1f7,0x3f6 on irq 14
> 
> This is definitely bug. It should assigned ide0 to the port
> in legacy mode, as far as I can tell.

Again you have no experience in the logic!

This boots with Promise first because of BIOS Logic with INT19 hooks.
IE, that which I referenced in the documents that I know you did not read
but come back and state it has nothing to do with the issues.

> > PIIX4: IDE controller on PCI bus 00 dev 39
> > PIIX4: device not capable of full native PCI mode
> > PIIX4: device disabled (BIOS)
> > PIIX4: device disabled (BIOS)
> > hda: DupliDisk IDE RAID-1 Adapter( 1.19), ATA DISK drive
> > hdc: QUANTUM FIREBALLP KA13.6, ATA DISK drive
> > ide2: ports already in use, skipping probe
> > ide0 at 0xd800-0xd807,0xdc02 on irq 18
> > ide1 at 0xe400-0xe407,0xe802 on irq 18
> 
> You have disabled PIIX4 here, so ide0/1 were not reserved. I assume

ASS U ME that is the word!

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
HPT366: onboard version of chipset, pin1=1 pin2=2
HPT366: IDE controller on PCI bus 00 dev 98
PCI: Enabling device 00:13.0 (0005 -> 0007)
HPT366: chipset revision 1
HPT366: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:pio
HPT366: IDE controller on PCI bus 00 dev 99
HPT366: chipset revision 1
HPT366: not 100% native mode: will probe irqs later
    ide1: BM-DMA at 0xec00-0xec07, BIOS settings: hdc:DMA, hdd:pio
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xf000-0xf007, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xf008-0xf00f, BIOS settings: hdg:pio, hdh:pio
hda: DupliDisk IDE RAID-1 Adapter( 1.19), ATA DISK drive
hdc: QUANTUM FIREBALLP KA13.6, ATA DISK drive
ide0 at 0xd800-0xd807,0xdc02 on irq 18
ide1 at 0xe400-0xe407,0xe802 on irq 18

What do you need me to attach a device?

The FSCKING BIOS did this, because there is an option to boot UDMA66
first.

> that if you enable PIIX4, it will use legacy ports, and will become
> ide0/1.
>                                             Petr Vandrovec
>                                             
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Electrons wasted :-/

