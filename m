Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129115AbRBWTCD>; Fri, 23 Feb 2001 14:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131734AbRBWTBy>; Fri, 23 Feb 2001 14:01:54 -0500
Received: from raven.toyota.com ([63.87.74.200]:4368 "EHLO raven.toyota.com")
	by vger.kernel.org with ESMTP id <S129115AbRBWTBo>;
	Fri, 23 Feb 2001 14:01:44 -0500
Message-ID: <3A96B395.5124FFC1@toyota.com>
Date: Fri, 23 Feb 2001 11:01:41 -0800
From: J Sloan <jjs@toyota.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steve <sjthorne@ozemail.com.au>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 3c509 + sb16 bug
In-Reply-To: <20010224043350.A14635@ozemail.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perhaps it's cold comfort, but I found long ago that
3c509 and SB don't mix too well, at least in Linux.

ISA devices are somewhat dumb, switching one
of the cards for a PCI version does the trick here.

SB128, SBlive work fine, or you might want to go
to a 10/100 pci ethernet card.

Just my $.02

jjs

Steve wrote:

> The evidence really speaks for itself:
>
> firstly, I have been running a 2.2.18 kernel system, with a 3c509b and a
> soundblaster 16 (and sundry other hardware).
>
> The soundblaster 16 is on 0x220, irq 5. Its a soundblaster 16 (vibra 16b, '94)
> The 3c509 is pnp and detects under 2.2.18 as the following:
> eth0: 3c509 at 0x300 tag 1, 10baseT port, address  00 a0 24 75 b7 28, IRQ 10.
>
> Both cards work perfectly, and autodetect without any arguments.
>
> Now:
>
> Here are the interesting bits of the boot of the 2.4.x kernel:
>
> PCI: PCI BIOS revision 2.10 entry at 0xfb4f0,
> last bus=1
> PCI: Using configuration type 1
> PCI: Probing PCI hardware
> Unknown bridge resource 0: assuming transparent
> Unknown bridge resource 1: assuming transparent
> Unknown bridge resource 2: assuming transparent
> PCI: Using IRQ router ALI [10b9/1533] at 00:07.0
> isapnp: Scanning for Pnp cards...
> isapnp: Card '3Com 3C509B EtherLink III'
> isapnp: 1 Plug & Play card detected total
>
> eth0: 3c509 at 0x220, 10baseT port, address  00 20 24 75 b7 28, IRQ 5.
> 3c509.c:1.16 (2.2) 2/3/98 becker@cesdis.gsfc.nasa.gov.
>
> Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
> sb: No ISAPnP cards found, trying standard ones...
> sb: I/O, IRQ, and DMA are mandatory
>
> NB: PCI stuff was interesting, but I'm not sure if its connected to this
> situation.
>
> After bootup, at a random time interval between 10 seconds and 5 minutes the
> following error spams the screen:
> eth0: infinite loop in interrupt, status 2001
>
> I can only conclude that the kernel has mistaken an ethernet card for a
> sound card.
>
> for convience, here is an lspci:
> 00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1541 (rev 04)
> 00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5243 (rev 04)
> 00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge
> [Aladdin IV] (rev c3)
> 00:08.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2064W [Millennium]
> (rev 01)
> 00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c2)
>
> Stephen Thorne
>
>   ------------------------------------------------------------------------
>    Part 1.2Type: application/pgp-signature

