Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261205AbSLHUtR>; Sun, 8 Dec 2002 15:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261302AbSLHUtR>; Sun, 8 Dec 2002 15:49:17 -0500
Received: from are.twiddle.net ([64.81.246.98]:60057 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S261205AbSLHUtQ>;
	Sun, 8 Dec 2002 15:49:16 -0500
Date: Sun, 8 Dec 2002 12:56:42 -0800
From: Richard Henderson <rth@twiddle.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Patrick Mochel <mochel@osdl.org>, Willy Tarreau <willy@w.ods.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
Subject: Re: /proc/pci deprecation?
Message-ID: <20021208125642.A22545@twiddle.net>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Patrick Mochel <mochel@osdl.org>, Willy Tarreau <willy@w.ods.org>,
	Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org,
	jgarzik@pobox.com
References: <Pine.LNX.4.33.0212072046260.8470-100000@localhost.localdomain> <Pine.LNX.4.44.0212072018480.1103-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0212072018480.1103-100000@home.transmeta.com>; from torvalds@transmeta.com on Sat, Dec 07, 2002 at 08:21:21PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 07, 2002 at 08:21:21PM -0800, Linus Torvalds wrote:
> >         Flags: bus master, medium devsel, latency 16, IRQ 19
> 
> Just out of interest, where _does_ it get the information? Does it try to
> do its own irq routing (bad!) or does it do it from /proc/bus/pci/devices?

It just reports what's in the PCI_INTERRUPT_LINE register.

At least on Alpha, we wrote into this register during pci
configuration, so the value matches what's in /proc/interrupts.
I guess I always assumed we did the same on x86, but I've
never checked.


r~
