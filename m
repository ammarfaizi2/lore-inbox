Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271489AbTGQPSI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 11:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271491AbTGQPSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 11:18:07 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:7575 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S271489AbTGQPSA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 11:18:00 -0400
Date: Thu, 17 Jul 2003 17:32:38 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Fix IDE initialization when we don't probe for interrupts.
In-Reply-To: <1057793279.7137.0.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.GSO.4.21.0307171730020.10372-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Jul 2003, Alan Cox wrote:
> On Mer, 2003-07-09 at 23:08, Jeff Garzik wrote:
> > > +		 * Disable device irq if we don't need to
> > > +		 * probe for it. Otherwise we'll get spurious
> > > +		 * interrupts during the identify-phase that
> > > +		 * the irq handler isn't expecting.
> > > +		 */
> > > +		hwif->OUTB(drive->ctl|2, IDE_CONTROL_REG);
> > 
> > 
> > Yeah, my driver does probing with interrupts disabled, too.
> > I'm curious where interrupts are re-enabled, though?
> 
> In the command write. BTW note that there are a few devices
> out there that dont honour the nIEN stuff.

Indeed. E.g. some old Western Digital Caviars.

I remember these giving me a bad time on Amiga. Apparently the problem didn't
show up on PC, since (in those days) IDE didn't share its interrupt with some
other device, unlike on Amiga.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

