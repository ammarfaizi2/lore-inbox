Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266108AbSLISDW>; Mon, 9 Dec 2002 13:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266112AbSLISDW>; Mon, 9 Dec 2002 13:03:22 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32526 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266108AbSLISDV>; Mon, 9 Dec 2002 13:03:21 -0500
Date: Mon, 9 Dec 2002 10:11:39 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Richard Henderson <rth@twiddle.net>, Patrick Mochel <mochel@osdl.org>,
       Willy Tarreau <willy@w.ods.org>, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <jgarzik@pobox.com>
Subject: Re: /proc/pci deprecation?
In-Reply-To: <1039458577.10470.49.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0212090958140.10925-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 9 Dec 2002, Alan Cox wrote:
>
> Tested and verified. If I leave it alone non apic mode works. To use
> APIC mode I have to write the new IRQ value into that register. I've
> shoved that into the driver for now, since its a demented chip specific
> horror.

That's definitely where it should be - the behaviour of the
PCI_INTERRUPT_LINE register is clearly chip-specific, so it should be in
the chip-specific drivers..

It's a kind of strange behaviour, though. What chip is this? It sounds
kind of convenient, but as far as I can tell it can only work for those
kinds of PCI devices that are on the same chip as the irq controller..

		Linus

