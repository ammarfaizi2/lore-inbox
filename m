Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266115AbSLISIm>; Mon, 9 Dec 2002 13:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266116AbSLISIm>; Mon, 9 Dec 2002 13:08:42 -0500
Received: from havoc.daloft.com ([64.213.145.173]:21974 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S266115AbSLISIl>;
	Mon, 9 Dec 2002 13:08:41 -0500
Date: Mon, 9 Dec 2002 13:16:18 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Richard Henderson <rth@twiddle.net>,
       Patrick Mochel <mochel@osdl.org>, Willy Tarreau <willy@w.ods.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: /proc/pci deprecation?
Message-ID: <20021209181618.GE17495@gtf.org>
References: <1039458577.10470.49.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0212090958140.10925-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212090958140.10925-100000@home.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2002 at 10:11:39AM -0800, Linus Torvalds wrote:
> 
> On 9 Dec 2002, Alan Cox wrote:
> >
> > Tested and verified. If I leave it alone non apic mode works. To use
> > APIC mode I have to write the new IRQ value into that register. I've
> > shoved that into the driver for now, since its a demented chip specific
> > horror.
> 
> That's definitely where it should be - the behaviour of the
> PCI_INTERRUPT_LINE register is clearly chip-specific, so it should be in
> the chip-specific drivers..
> 
> It's a kind of strange behaviour, though. What chip is this? It sounds
> kind of convenient, but as far as I can tell it can only work for those
> kinds of PCI devices that are on the same chip as the irq controller..

As a reminder of ancient times, one of the reasons I wanted to do
per-PCI-device interrupt routing was due to the older incarnation of
these chips, the Via 686 a/b southbridges.  They have a similar method
of routing interrupts, where writing to PCI_INTERRUPT_LINE directly
makes internal chip magic occur.  So you are correct WRT
"only work ... on the same chip as the irq controller"

	Jeff



