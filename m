Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317211AbSF1NCt>; Fri, 28 Jun 2002 09:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317212AbSF1NCs>; Fri, 28 Jun 2002 09:02:48 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:16596 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S317211AbSF1NCr>;
	Fri, 28 Jun 2002 09:02:47 -0400
Date: Fri, 28 Jun 2002 15:03:42 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Denis Oliver Kropp <dok@directfb.org>
cc: James Simmons <jsimmons@transvirtual.com>,
       Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.5.21] CyberPro 32bit support and other fixes
In-Reply-To: <20020615105547.GA22186@skunk.convergence.de>
Message-ID: <Pine.GSO.4.21.0206281502560.14426-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jun 2002, Denis Oliver Kropp wrote:
> Quoting James Simmons (jsimmons@transvirtual.com):
> > 
> > > Why is the pseudo palette used anyway?
> > 
> > Its a fast way for the console to grab the proper console index color to
> > draw to the framebuffer. Otherwise we have to regenerate the color all the
> > time. Plus it is always endian code for us :-)
> 
> I didn't mean the array of colors for the console, but the usage of
> the hardware palette for modes != 8 bit.
> 
> > > There's no speed benefit and
> > > applications running in true/direct color would look wrong.
> > 
> > For userland no but for the kernel we do have a benifiet.
> 
> There's no speed benefit if you write "index|index|index" into the
> framebuffer instead of "red|green|blue".

But it does allow to change the console palette without the need to redraw the
screen, just like for VGA text mode.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

