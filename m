Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263515AbTHZIdy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 04:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263284AbTHZIdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 04:33:53 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:16781 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263515AbTHZIcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 04:32:22 -0400
Date: Tue, 26 Aug 2003 10:31:32 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Tom Rini <trini@kernel.crashing.org>
cc: Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix the -test3 input config damages
In-Reply-To: <20030825180501.GD1075@ip68-0-152-218.tc.ph.cox.net>
Message-ID: <Pine.GSO.4.21.0308261030510.615-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Aug 2003, Tom Rini wrote:
> On Mon, Aug 25, 2003 at 06:13:32PM +0200, Geert Uytterhoeven wrote:
> > On Fri, 22 Aug 2003, Tom Rini wrote:
> > > --- 1.18/drivers/video/console/Kconfig	Wed Jul 16 10:39:32 2003
> > > +++ edited/drivers/video/console/Kconfig	Fri Aug 22 13:27:21 2003
> > > @@ -5,7 +5,7 @@
> > >  menu "Console display driver support"
> > >  
> > >  config VGA_CONSOLE
> > > -	bool "VGA text console" if EMBEDDED || !X86
> > > +	bool "VGA text console" if STANDARD && X86
> > >  	depends on !ARCH_ACORN && !ARCH_EBSA110 || !4xx && !8xx
> > >  	default y
> > >  	help
> > 
> > Ugh, this makes VGA_CONSOLE default to yes if X86 is not set, right? Don't you
> > want
> > 
> >     bool "VGA text console" if !STANDARD || X86

Oops, and I meant !X86, of course.

> > ?
> > 
> > Or do I need an update course on Kconfig syntax?
> 
> No, I think that's a logic error on my part.  What I intended was
> default to Y on (STANDARD && X86), otherwise ask.  So it should have
> been:
> bool "VGA text console" if !(STANDARD && X86)

OK, that's equivalent to what I had in mind :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

