Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317980AbSHUHh7>; Wed, 21 Aug 2002 03:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317984AbSHUHh7>; Wed, 21 Aug 2002 03:37:59 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:38406
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317980AbSHUHh6>; Wed, 21 Aug 2002 03:37:58 -0400
Date: Wed, 21 Aug 2002 00:41:38 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Erik Andersen <andersen@codepoet.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre2-ac5 Promise PDC20269
In-Reply-To: <20020821031509.GA11920@codepoet.org>
Message-ID: <Pine.LNX.4.10.10208210040300.3867-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
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
hda: DupliDisk IDE RAID-1 Adapter( 1.19), ATA DISK drive
ide0 at 0xd800-0xd807,0xdc02 on irq 18
hdc: QUANTUM FIREBALLP KA13.6, ATA DISK drive
ide1 at 0xe400-0xe407,0xe802 on irq 18
ide2: ports already in use, skipping probe
hda: host protected area => 1
hda: setmax LBA 18041184, native  18039168
hda: 18039168 sectors (9236 MB) w/371KiB Cache, CHS=17896/16/63, UDMA(66)
hdc: host protected area => 1
hdc: 27068420 sectors (13859 MB) w/371KiB Cache, CHS=26853/16/63, UDMA(66)

You mean like the stoke check does ?

On Tue, 20 Aug 2002, Erik Andersen wrote:

> On Tue Aug 20, 2002 at 07:40:37PM -0700, Andre Hedrick wrote:
> > > hde reduced to Ultra33 mode.
> > > hde: host protected area => 1
> > > hde: 117266688 sectors (60041 MB) w/1820KiB Cache, CHS=116336/16/63, UDMA(133)
> 
> BTW that host protected area message is pretty silly. It gives
> the appearance that perhaps the BIOS has issued a SET MAX ADDRESS
> when in fact, all the message is doing is enumerating the drive's
> capabilities (duplicating what 'hdparm -I' does).  At the
> minimum, this message should be changed to something more like:
> 
>     printk("%s: host protected area supported: %s\n", 
> 	    drive->name, (flag==1)? "no" : "yes");
> 
> Personally, I think we should lose the message entirely.  If
> someone want to know what their drive can do, they can ask
> hdparm and get a full listing,
> 
>  -Erik
> 
> --
> Erik B. Andersen             http://codepoet-consulting.com/
> --This message was written using 73% post-consumer electrons--
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

