Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272251AbTHNKHq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 06:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272253AbTHNKHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 06:07:45 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:55781 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S272251AbTHNKHo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 06:07:44 -0400
Date: Thu, 14 Aug 2003 12:05:28 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Matthew Wilcox <willy@debian.org>, Russell King <rmk@arm.linux.org.uk>,
       Greg KH <greg@kroah.com>, "David S. Miller" <davem@redhat.com>,
       rddunlap@osdl.org, davej@redhat.com,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: C99 Initialisers
In-Reply-To: <3F3A9FA1.8000708@pobox.com>
Message-ID: <Pine.GSO.4.21.0308141202410.12289-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Aug 2003, Jeff Garzik wrote:
> > On Wed, Aug 13, 2003 at 03:44:44PM -0400, Jeff Garzik wrote:
> >>enums are easy  putting direct references would be annoying, but I also 
> >>argue it's potentially broken and wrong to store and export that 
> >>information publicly anyway.  The use of enums instead of pointers is 
> >>practically required because there is a many-to-one relationship of ids 
> >>to board information structs.
> > 
> > The hard part is that it's actually many-to-many.  The same card can have
> > multiple drivers.  one driver can support many cards.
> 
> pci_device_tables are (and must be) at per-driver granularity.  Sure the 
> same card can have multiple drivers, but that doesn't really matter in 
> this context, simply because I/we cannot break that per-driver 
> granularity.  Any solution must maintain per-driver granularity.

Aren't there any `hidden multi-function in single-function' PCI devices out
there? E.g. cards with a serial and a parallel port?

At least for the Zorro bus, these exist. E.g. the Ariadne card contains both
Ethernet and 2 parallel ports, so the Ariadne Ethernet driver and the (still to
be written) Ariadne parallel port driver are both drivers for the same Zorro
device.

Gr{oetje,eeting}s,

						Geert

P.S. Yes, according to the IBM slides at LKS, m68k is dead ;-)
--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

