Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262272AbTC1Hth>; Fri, 28 Mar 2003 02:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262284AbTC1Hth>; Fri, 28 Mar 2003 02:49:37 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:29161 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S262272AbTC1Htg>;
	Fri, 28 Mar 2003 02:49:36 -0500
Date: Fri, 28 Mar 2003 09:00:26 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Simmons <jsimmons@infradead.org>
cc: Antonino Daplas <adaplas@pol.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] Framebuffer fixes.
In-Reply-To: <Pine.LNX.4.44.0303280443170.11648-100000@phoenix.infradead.org>
Message-ID: <Pine.GSO.4.21.0303280857240.7286-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Mar 2003, James Simmons wrote:
> > > > > Shouldn't these be info->var.bits_per_pixel instead of fb_logo.depth?
> > > > 
> > > > Yes, fb_logo.depth == info->var.bits_per_pixel.
> > > 
> > > Euh, now I get confused... Do you mean
> > > `Yes, it should be replaced by info->var.bits_per_pixel' or
> > > `No, logo.depth is always equal to info->var.bits_per_pixel'?
> > 
> > :)  Sorry about that. I meant:
> > 
> > 
> > `No, fb_logo.depth is always equal to info->var.bits_per_pixel'
> 
> No this is no longer true. For example last night I displayed the 16 color 
> logo perfectly fine on a 16 bpp display!!!! The mono display still has 
> bugs tho. The new logo tries to pick the best image to display. Say for 
> example we have two video cards. One running VESA fbdev at 16 bpp and a 
> another at vga 4 planar via vga16fb. This way we can have the both the 16 
> color and 224 color logo compiled in.  The correct logo will be displayed 
> then on the correct display. Now say we only have a mono display but all 

Didn't it always work like that? You got the 16 color logo on vga16fb and the
224 color logo on displays with more than 256 colors (except for directcolor).

> the cards support 8 bpp or better. That logo still gets displayed.
                                     ^^^^
Which logo do you mean with `that'? On a monochrome display, it should be the
monochrome logo.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

