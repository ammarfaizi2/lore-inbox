Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270090AbRHGF6R>; Tue, 7 Aug 2001 01:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270091AbRHGF6G>; Tue, 7 Aug 2001 01:58:06 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:22033 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S270090AbRHGF5x>; Tue, 7 Aug 2001 01:57:53 -0400
From: Andrzej Krzysztofowicz <kufel!ankry@green.mif.pg.gda.pl>
Message-Id: <200108062346.BAA09011@kufel.dom>
Subject: Re: How does "alias ethX drivername" in modules.conf work?
To: kufel!MemAlpha.CX!rhw@green.mif.pg.gda.pl (Riley Williams)
Date: Tue, 7 Aug 2001 01:46:25 +0200 (CEST)
Cc: kufel!alumni.brown.edu!Thomas.Duffy.99@green.mif.pg.gda.pl (Thomas
	Duffy),
        kufel!vger.kernel.org!linux-kernel@green.mif.pg.gda.pl (Linux Kernel)
In-Reply-To: <Pine.LNX.4.33.0108062304060.2845-200000@infradead.org> from "Riley Williams" at sie 06, 2001 11:56:07 
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  >> One of my systems has SIX ethernet cards, these being three ISA
>  >> and two PCI NE2000 clones and a DEC Tulip. Here's the relevant
>  >> section of modules.conf on the system in question:
> 
>  >>  Q> alias eth0 ne
>  >>  Q> options eth0 io=0x340
>  >>  Q> alias eth1 ne
>  >>  Q> options eth1 io=0x320
>  >>  Q> alias eth2 ne
>  >>  Q> options eth2 io=0x2c0
>  >>  Q> alias eth3 ne2k-pci
>  >>  Q> alias eth4 ne2k-pci
>  >>  Q> alias eth5 tulip
> 
> 
> However, if the cards are controlled by different drivers, you can
> influence the order they are detected in by your choice of entries in
> modules.conf - in the example above, the ISA cards are always eth0,
                                                         ^^^^^^
> eth1 and eth2, the NE2k-pci cards are always eth3 and eth4, and the
> tulip card is always eth5, simply because that's what the said file
> says.

Not always. You are wrong here, I'm afraid:

Lets assume that eth0-eth3 are not initialized at boot time and your init
scripts attempt to initialize eth4 ...

To avoid such problems one probably should add a lot of pre-install parameters
in modules.conf.

Andrzej

