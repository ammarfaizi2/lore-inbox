Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129944AbQLER4H>; Tue, 5 Dec 2000 12:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129563AbQLERz6>; Tue, 5 Dec 2000 12:55:58 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:44040
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129881AbQLERzp>; Tue, 5 Dec 2000 12:55:45 -0500
Date: Tue, 5 Dec 2000 09:24:55 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: "Robert B. Easter" <reaster@comptechnews.com>
cc: Daniel Sangenberg <daniel@datanova.se>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.17 + ide patches + 61gb ibm disc = problem
In-Reply-To: <00120512253218.00289@comptechnews>
Message-ID: <Pine.LNX.4.10.10012050923110.18591-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2000, Robert B. Easter wrote:

> > Uniform Multi-Platform E-IDE driver Revision: 6.30
> > ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> > PIIX4: IDE controller on PCI bus 00 dev 21
> > PIIX4: chipset revision 1
> > PIIX4: not 100% native mode: will probe irqs later
> >      ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:pio, hdb:DMA
> >      ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:DMA
> > hdb: IBM-DTLA-307060, ATA DISK drive
> > hdd: IBM-DTLA-307060, ATA DISK drive
> > ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> > ide1 at 0x170-0x177,0x376 on irq 15
> > hdb: IBM-DTLA-307060, 58644MB w/1916kB Cache, CHS=7476/255/63, UDMA(33)
> > hdd: IBM-DTLA-307060, 58644MB w/1916kB Cache, CHS=119150/16/63, UDMA(33)

You have the classic BIOS issue it only works half way.
pass the geometries to fix one side of the other.

> > hdd1 [events: 00000001](write) hdd1's sb offset: 60051456
> > hdb1 [events: 00000001](write) hdb1's sb offset: 60050816
> >
> 
> 
> I don't understand why you have set them to be slaves when they are the only 
> drives on the ports.  Shouldn't you be setting the jumpers on both drives 
> into the Single Drive (default) settings?  I always thought the Master and 
> Slave positions are to be used only when connecting two drives on one port.
> 
> hda and hdc should be the devices.

This is true, what are you running in this bizzare mode?

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
