Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265264AbUBAK5Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 05:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265267AbUBAK5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 05:57:24 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:13696 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S265264AbUBAK5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 05:57:22 -0500
Date: Sun, 1 Feb 2004 11:06:14 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200402011106.i11B6E7F000557@81-2-122-30.bradfords.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
       Timothy Miller <miller@techsource.com>
Cc: John Bradford <john@grabjohn.com>, chakkerz@optusnet.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.58.0402011123010.20933@waterleaf.sonytel.be>
References: <4017F2C0.4020001@techsource.com>
 <200401291211.05461.chakkerz@optusnet.com.au>
 <40193136.4070607@techsource.com>
 <200401291629.i0TGTN7S001406@81-2-122-30.bradfords.org.uk>
 <40193A67.7080308@techsource.com>
 <200401291718.i0THIgbb001691@81-2-122-30.bradfords.org.uk>
 <4019472D.70604@techsource.com>
 <200401291855.i0TItHoU001867@81-2-122-30.bradfords.org.uk>
 <40195AE0.2010006@techsource.com>
 <Pine.GSO.4.58.0402011123010.20933@waterleaf.sonytel.be>
Subject: Re: [OT] Crazy idea:  Design open-source graphics chip
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Geert Uytterhoeven <geert@linux-m68k.org>:
> On Thu, 29 Jan 2004, Timothy Miller wrote:
> > Ok, so, how about this idea:
> >
> > - Small Xilinx FPGA, 16M of RAM, and a DAC on a board.
> > - AGP 2X
> > - Up to 2048x2048 resolution at 8, 16, and 32 bpp.
> > - Acceleration ONLY for solid fills and bitblts on-screen.
> 
> Sounds OK to me.
> 
> > Given that so little is accelerated, there is no point in putting more
> > than the viewable framebuffer on the card, hense the 16 megs.  It would
> > probably actually HURT performance to cache pixmaps on the card.
> >
> >
> > Oh, there's one thing I forgot.  It would have to support VGA.  There is
> > a VGA core on opencores.org that we could use, but its logic area would
> > probably push up the FPGA cost so that the board was in the $100 range.
> >   Probably more.
> 
> Why support legacy VGA? It makes things more complex and expensive, and doesn't
> give us much, especially for a SoC.

It makes the card usable in a standard machine before the kernel has
booted.  I don't care about that at all from a technical viewpoint, as
there are better ways to deal with it, (re-write the system BIOS to
use the framebuffer for the BIOS configuration, for example), but I
can see that there may be a marketing reason for including VGA - more
people are likely to buy the card.  Whether this is significant
depends on the market we try to sell it in, and whether cost per unit
would be increased by the extra complexity, or decreased by the higher
volume of production possible if more units are going to be sold.

A cheap cludge would be an optional second GPU on the card just to do
the required VGA modes, with an analogue video pass-through.  That
would make the VGA cards more expensive than a single GPU which
incorporated VGA, but add almost nothing in cost or complexity terms
to the non-VGA cards.

John.
