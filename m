Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266403AbUA2V1l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 16:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266451AbUA2V1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 16:27:41 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2176 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S266403AbUA2V1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 16:27:37 -0500
Date: Thu, 29 Jan 2004 21:36:27 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200401292136.i0TLaR76000250@81-2-122-30.bradfords.org.uk>
To: Timothy Miller <miller@techsource.com>
Cc: chakkerz@optusnet.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <40195AE0.2010006@techsource.com>
References: <4017F2C0.4020001@techsource.com>
 <200401291211.05461.chakkerz@optusnet.com.au>
 <40193136.4070607@techsource.com>
 <200401291629.i0TGTN7S001406@81-2-122-30.bradfords.org.uk>
 <40193A67.7080308@techsource.com>
 <200401291718.i0THIgbb001691@81-2-122-30.bradfords.org.uk>
 <4019472D.70604@techsource.com>
 <200401291855.i0TItHoU001867@81-2-122-30.bradfords.org.uk>
 <40195AE0.2010006@techsource.com>
Subject: Re: [OT] Crazy idea:  Design open-source graphics chip
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It's a simple framebuffer, possibly with line drawing, and box filling
> > capabilities.  Nevertheless, it could be used as a general purpose X
> > display, for spreadsheets, simple to moderate wordprocessing,
> > (I.E. probably not DTP-like applications), status displays for various
> > systems, etc.
> > 
> > So, it does have real world uses.
> 
> But wouldn't it be painfully slow?

[snip]

> Have you ever used a graphics card in VESA mode?  Dragging a window 
> around the screen and watching it repaint can be a very unenjoyable 
> thing to watch.  From what you've described, this is the sort of thing 
> you'd get.

OK, maybe it would be too slow for practical desktop use.

> > So, we can either do something interesting with the above, or sit
> > around discussing how expensive it is to make a graphics card.
> > 
> > At least it provides a way for us to create the first generation of
> > open graphics hardware cheaply, and experiment with various ideas.
> > 
> > Besides, this is just the first stage - once we have the graphics
> > card, we can move on to other things like the 9-track tape drive
> > discussed on LKML a while ago:
> 
> 
> Ok, so, how about this idea:
> 
> - Small Xilinx FPGA, 16M of RAM, and a DAC on a board.
> - AGP 2X
> - Up to 2048x2048 resolution at 8, 16, and 32 bpp.
> - Acceleration ONLY for solid fills and bitblts on-screen.
> 
> Given that so little is accelerated, there is no point in putting more 
> than the viewable framebuffer on the card, hense the 16 megs.  It would 
> probably actually HURT performance to cache pixmaps on the card.

If we put 4 or more on each board, it could be useful for betting
shops, stock markets, shop window displays, and other applications
where you need to control a dozen or more screens, which basically
contain textual information, but where 80x25 text mode just isn't
enough.  I.E. you might want the odd pie chart or different sized text
or something.

> Oh, there's one thing I forgot.  It would have to support VGA.

Maybe not, the primary market for this, (I.E. what makes it cost
effective to produce, and therefore available for developers to use as
their primary display), could be users who want to control many
displays, and who would have a standard VGA card for the primary
monitor.  (Yeah, it would be kind of ironic if 99% of our amasing new
graphics cards ended up in mahines with another card as the primary
display, but then again, if it makes the open hardware available for
developers to experiment with at a reasonable cost, it would be worth
doing).

So, what about a PCI card with four or eight 16MB framebuffers, and
the basic acceleration and other specs you described above.  Is that
at least slightly feasible, do you think?

John.
