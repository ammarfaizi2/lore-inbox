Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276042AbRI1NJi>; Fri, 28 Sep 2001 09:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276044AbRI1NJ3>; Fri, 28 Sep 2001 09:09:29 -0400
Received: from vega.digitel2002.hu ([213.163.0.181]:64705 "EHLO
	vega.digitel2002.hu") by vger.kernel.org with ESMTP
	id <S276042AbRI1NJS>; Fri, 28 Sep 2001 09:09:18 -0400
Date: Fri, 28 Sep 2001 15:09:36 +0200
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: clemens <therapy@endorphin.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide drive problem?
Message-ID: <20010928150936.B12586@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
In-Reply-To: <20010928041519.968EA4FA00@spock> <OE55yDnSI4nHp4PlNMu00004f47@hotmail.com> <20010928135222.A2722@ghanima.endorphin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <20010928135222.A2722@ghanima.endorphin.org>
User-Agent: Mutt/1.3.22i
X-Operating-System: vega Linux 2.4.10-grsecurity-1.8 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2001 at 01:52:22PM +0200, clemens wrote:
> Hi David, Hi Steve
> 
> i get:
> 
> hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hde: dma_intr: error=0x84 { DriveStatusError BadCRC }

Hmmm, I get this message as well about once a day (though it seems it
could not cause any damage ... yet ...)
But I have got non-highpoint-equipped KT133 motherboard with ATA33
disk.

Note, that this hw config DID NOT WORK with 2.2.x kernel at all (waiting
for interrupt or something similar message)

> on:
> 
> Linux version 2.4.9-ac7 (root@ghanima) (gcc version 2.95.4 20010902 (Debian
> prerelease)) #1 SMP Wed Sep 26 14:39:37 CEST 2001
> 
> HPT370: IDE controller on PCI bus 00 dev 98
> PCI: Found IRQ 15 for device 00:13.0
> HPT370: chipset revision 3
> HPT370: not 100% native mode: will probe irqs later
>     ide2: BM-DMA at 0xe800-0xe807, BIOS settings: hde:DMA, hdf:pio
>     ide3: BM-DMA at 0xe808-0xe80f, BIOS settings: hdg:pio, hdh:pio
> hde: ST360021A, ATA DISK drive
> 
> even thou i have VT8363/8365 (=KT133) as north bridge, and VT82C686A as
> southbridge, at least the south bridge could not be blamed for that, since
> a. i don't even use it, hde is my hpt370 controller, and
> b. it's the A revision and not the infamous 686B revision (see
> http://www.viahardware.com/686bfaq.shtm for more infos on "the" 686B bug)
> 
> what kernel, harddisc do you both have?
> 
> clemens
> 
> p.s.: i don't know if "BadCRC" has anything to do with bad blocks, but
> /sbin/badblocks doesn't even show a single bad block on my brand new seagate 
> disc, so i guess, that's not the source of the troubles.
> 
> On Thu, Sep 27, 2001 at 10:44:53PM -0700, David Grant wrote:
> > I think the standard response people would give you is that your IDE cable
> > is too long, of bad quality, or you are using a 40-pin cable instead of an
> > 80-pin cable (although I'm pretty sure that should have been detected, and
> > DMA should automatically have not been used, but I heard at one point that
> > the code which detected this on motherboards using the vt82c686b chip didn't
> > really work in some cases).
> > 
> > That's the standard answer, but I used to get this messages on my machine as
> > well (I think it was back when I was trying to use my VIA chipset with
> > Redhat 7.1).  I don't seem to get them anymore though, but maybe that's just
> > because I'm trying to install distros newer than Redhat 7.1.  That makes me
> > think that I never had CRC errors, it was just some buggy VIA code.
> > 
> > I just get the dma timeout errors now with my VIA IDE controller.  I also
> > get them with the Promise controller (sigh...).
> > 
> > David Grant
> > 
> > ----- Original Message -----
> > From: "Steven Joerger" <steven@spock.2y.net>
> > To: <linux-kernel@vger.kernel.org>
> > Sent: Thursday, September 27, 2001 9:02 PM
> > Subject: ide drive problem?
> > 
> > 
> > > List,
> > >
> > > When I enable support for my chipset in the kernel (via kt133) I always
> > get
> > > these messages:
> > >
> > > hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> > > hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> > >
> > > over and over and ....
> > >
> > > Any clues to whats going on?
