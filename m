Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267962AbRGVLkD>; Sun, 22 Jul 2001 07:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267964AbRGVLjx>; Sun, 22 Jul 2001 07:39:53 -0400
Received: from finch-post-10.mail.demon.net ([194.217.242.38]:15379 "EHLO
	finch-post-10.mail.demon.net") by vger.kernel.org with ESMTP
	id <S267962AbRGVLjl>; Sun, 22 Jul 2001 07:39:41 -0400
Date: Sun, 22 Jul 2001 12:39:44 +0100
From: "Robert J.Dunlop" <rjd@xyzzy.clara.co.uk>
To: Igmar Palsenberg <i.palsenberg@jdimedia.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New PCI device
Message-ID: <20010722123944.A21182@xyzzy.clara.co.uk>
In-Reply-To: <Pine.LNX.4.33.0107211732080.28026-100000@jdi.jdimedia.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0107211732080.28026-100000@jdi.jdimedia.nl>; from i.palsenberg@jdimedia.nl on Sat, Jul 21, 2001 at 05:27:45PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sat, Jul 21,  Igmar Palsenberg wrote:
> 
> Hi,
> 
> I've got a new toy in my computer :
> 
> 02:09.0 Network controller: Unknown device 1638:1100 (rev 02)
>         Subsystem: Unknown device 1638:1100
>         Flags: medium devsel, IRQ 9
>         I/O ports at d800 [disabled] [size=128]
>         Memory at d5800000 (32-bit, non-prefetchable) [disabled] [size=4K]
>         I/O ports at d400 [disabled] [size=64]
> 
> Device itself says :
> 
> WL11000P
> It's a PCMCIA bridge, with one big IC : Manufacturer : PLX , type PCI9052

The PLX PCI9052 is a generic bridge chip used by a lot of manufactures for
many different cards.  What the card does is determined by other chips on
the board not the PCI interface. We use the PLX PCI9052 to build multiport
intelligent synchronous comms cards that are reported as "Communication
controller". The PLX chip does not determine the type of device.

> No idea why the PCI type ID says it's a network controller, it certainly
> isn't. The whole package is sold as a Dynalink wireless LAN L11H, a PCI
> PCICIA controller with one slot and a PCMCIA card based on a PrismII
> chipset.

Well the manufacturer ID 0x1638 belongs to Eumitcom Technology Inc and
their website (http://www.eumitcom.com/) shows the WL11000P combo to be a
IEEE 802.11b compliant wireless card. That's my definition of a Network
controller.

> I'm gonna plug the PCMCIA card in my notebook, see what it doesn. It it
> does work, the problem is the PCMCIA card bot been supported. Else I'v got
> a big problem :)

They say they have Linux support but no indication of which version. Don't
see drivers in the standard kernel so I guess they must be supplying it
as a patch. See http://www.eumitcom.com/html/wlan3.htm for download.

HTH
-- 
        Bob Dunlop                      FarSite Communications
        rjd@xyzzy.clara.co.uk           bob.dunlop@farsite.co.uk
        www.xyzzy.clara.co.uk           www.farsite.co.uk
