Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267967AbRGVLtX>; Sun, 22 Jul 2001 07:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267968AbRGVLtO>; Sun, 22 Jul 2001 07:49:14 -0400
Received: from jdi.jdimedia.nl ([212.204.192.51]:25557 "EHLO jdi.jdimedia.nl")
	by vger.kernel.org with ESMTP id <S267967AbRGVLtD>;
	Sun, 22 Jul 2001 07:49:03 -0400
Date: Sun, 22 Jul 2001 13:48:40 +0200 (CEST)
From: Igmar Palsenberg <i.palsenberg@jdimedia.nl>
X-X-Sender: <igmar@jdi.jdimedia.nl>
To: "Robert J.Dunlop" <rjd@xyzzy.clara.co.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: New PCI device
In-Reply-To: <20010722123944.A21182@xyzzy.clara.co.uk>
Message-ID: <Pine.LNX.4.33.0107221342140.1363-100000@jdi.jdimedia.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sun, 22 Jul 2001, Robert J.Dunlop wrote:

> On Sat, Jul 21,  Igmar Palsenberg wrote:
> >
> > Hi,
> >
> > I've got a new toy in my computer :
> >
> > 02:09.0 Network controller: Unknown device 1638:1100 (rev 02)
> >         Subsystem: Unknown device 1638:1100
> >         Flags: medium devsel, IRQ 9
> >         I/O ports at d800 [disabled] [size=128]
> >         Memory at d5800000 (32-bit, non-prefetchable) [disabled] [size=4K]
> >         I/O ports at d400 [disabled] [size=64]
> >
> > Device itself says :
> >
> > WL11000P
> > It's a PCMCIA bridge, with one big IC : Manufacturer : PLX , type PCI9052
>
> The PLX PCI9052 is a generic bridge chip used by a lot of manufactures for
> many different cards.  What the card does is determined by other chips on
> the board not the PCI interface. We use the PLX PCI9052 to build multiport
> intelligent synchronous comms cards that are reported as "Communication
> controller". The PLX chip does not determine the type of device.

I've got hold of the datasheet. It's a generic PCI to ISA bridge indeed.

> > No idea why the PCI type ID says it's a network controller, it certainly
> > isn't. The whole package is sold as a Dynalink wireless LAN L11H, a PCI
> > PCICIA controller with one slot and a PCMCIA card based on a PrismII
> > chipset.
>
> Well the manufacturer ID 0x1638 belongs to Eumitcom Technology Inc and
> their website (http://www.eumitcom.com/) shows the WL11000P combo to be a
> IEEE 802.11b compliant wireless card. That's my definition of a Network
> controller.

I'm still thinking about what driver to create.. A driver that
emulates a PCMCIA controller is a knightmare, but so is an ethernet driver
for this setup.

The 2.4.x kernel has support for the wireless card itself, but in a PCMCIA
context. Creating a ethernet driver creates a lot of duplicate code.

> > I'm gonna plug the PCMCIA card in my notebook, see what it doesn. It it
> > does work, the problem is the PCMCIA card bot been supported. Else I'v got
> > a big problem :)
>
> They say they have Linux support but no indication of which version. Don't
> see drivers in the standard kernel so I guess they must be supplying it
> as a patch. See http://www.eumitcom.com/html/wlan3.htm for download.

I don't call it support. The drivers are ancient, pcmcia-cs on their site
is a 1.5 year old version, and the driver itself doesn't work. Making it
work would require a large amount of code change to their driver, so it's
better to start from scratch.

> HTH


	Igmar (who is confused about what to do)


-- 

Igmar Palsenberg
JDI Media Solutions

Boulevard Heuvelink 102
6828 KT Arnhem
The Netherlands

mailto: i.palsenberg@jdimedia.nl
PGP/GPG key : http://www.jdimedia.nl/formulier/pgp/igmar

