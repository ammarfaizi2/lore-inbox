Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276019AbRI1LwT>; Fri, 28 Sep 2001 07:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276018AbRI1LwJ>; Fri, 28 Sep 2001 07:52:09 -0400
Received: from [62.116.8.197] ([62.116.8.197]:54147 "HELO
	ghanima.endorphin.org") by vger.kernel.org with SMTP
	id <S276019AbRI1LwD>; Fri, 28 Sep 2001 07:52:03 -0400
Date: Fri, 28 Sep 2001 13:52:22 +0200
From: clemens <therapy@endorphin.org>
To: David Grant <davidgrant79@hotmail.com>
Cc: Steven Joerger <steven@spock.2y.net>, linux-kernel@vger.kernel.org
Subject: Re: ide drive problem?
Message-ID: <20010928135222.A2722@ghanima.endorphin.org>
In-Reply-To: <20010928041519.968EA4FA00@spock> <OE55yDnSI4nHp4PlNMu00004f47@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OE55yDnSI4nHp4PlNMu00004f47@hotmail.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David, Hi Steve

i get:

hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hde: dma_intr: error=0x84 { DriveStatusError BadCRC }

on:

Linux version 2.4.9-ac7 (root@ghanima) (gcc version 2.95.4 20010902 (Debian
prerelease)) #1 SMP Wed Sep 26 14:39:37 CEST 2001

HPT370: IDE controller on PCI bus 00 dev 98
PCI: Found IRQ 15 for device 00:13.0
HPT370: chipset revision 3
HPT370: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xe800-0xe807, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xe808-0xe80f, BIOS settings: hdg:pio, hdh:pio
hde: ST360021A, ATA DISK drive

even thou i have VT8363/8365 (=KT133) as north bridge, and VT82C686A as
southbridge, at least the south bridge could not be blamed for that, since
a. i don't even use it, hde is my hpt370 controller, and
b. it's the A revision and not the infamous 686B revision (see
http://www.viahardware.com/686bfaq.shtm for more infos on "the" 686B bug)

what kernel, harddisc do you both have?

clemens

p.s.: i don't know if "BadCRC" has anything to do with bad blocks, but
/sbin/badblocks doesn't even show a single bad block on my brand new seagate 
disc, so i guess, that's not the source of the troubles.

On Thu, Sep 27, 2001 at 10:44:53PM -0700, David Grant wrote:
> I think the standard response people would give you is that your IDE cable
> is too long, of bad quality, or you are using a 40-pin cable instead of an
> 80-pin cable (although I'm pretty sure that should have been detected, and
> DMA should automatically have not been used, but I heard at one point that
> the code which detected this on motherboards using the vt82c686b chip didn't
> really work in some cases).
> 
> That's the standard answer, but I used to get this messages on my machine as
> well (I think it was back when I was trying to use my VIA chipset with
> Redhat 7.1).  I don't seem to get them anymore though, but maybe that's just
> because I'm trying to install distros newer than Redhat 7.1.  That makes me
> think that I never had CRC errors, it was just some buggy VIA code.
> 
> I just get the dma timeout errors now with my VIA IDE controller.  I also
> get them with the Promise controller (sigh...).
> 
> David Grant
> 
> ----- Original Message -----
> From: "Steven Joerger" <steven@spock.2y.net>
> To: <linux-kernel@vger.kernel.org>
> Sent: Thursday, September 27, 2001 9:02 PM
> Subject: ide drive problem?
> 
> 
> > List,
> >
> > When I enable support for my chipset in the kernel (via kt133) I always
> get
> > these messages:
> >
> > hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> > hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> >
> > over and over and ....
> >
> > Any clues to whats going on?
> >
> > Thanks,
> > Steven Joerger
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
