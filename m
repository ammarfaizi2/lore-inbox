Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131731AbRACWZ2>; Wed, 3 Jan 2001 17:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129226AbRACWZS>; Wed, 3 Jan 2001 17:25:18 -0500
Received: from hood.tvd.be ([195.162.196.21]:38196 "EHLO hood.tvd.be")
	by vger.kernel.org with ESMTP id <S131731AbRACWZH>;
	Wed, 3 Jan 2001 17:25:07 -0500
Date: Wed, 3 Jan 2001 23:24:34 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: Tom Rini <trini@kernel.crashing.org>, linux-fbdev@vuser.vu.union.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [linux-fbdev] [PATCH] matroxfb as a module (PPC)
In-Reply-To: <118A418518B3@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.05.10101032321530.611-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2001, Petr Vandrovec wrote:
> On  3 Jan 01 at 10:54, Tom Rini wrote:
> > I agree this sounds good.  I just think it's too late to do it now. :)
> > 
> > The vmode/cmode/vesa number stuff should stick around in 2.4 (it's too late
> > now to remove it) but documented as obsolete, and removed in 2.5.
> 
> I personally prefer 'video=matrox:vesa:0x105' over 
> 'video=matrox:1024x768-8', as with matroxfb you can modify this mode with
> 'left', 'right', 'fv', 'fh'... options, and without these parameters it is 
> unusable on fixed sync monitors (f.e. 'sync' is vital to specify 
> sync-on-green feature).
> 
> If someone will create modedb, which will allow specifying all parameters
> of fb_var_screeninfo, I'll remove this parsing code from matroxfb. But 
> without it I think that 'vesa' will survive forever... And as I can test
> only vga16fb and matroxfb, I'm not probably right one to do this.

Just add these options to the fb_find_mode() parser in modedb.c, and they'll
work on all fbdev drivers that use modedb. There's no reason to duplicate that
code in each fbdev.

Since matroxfb has the richest set of features (even more than atyfb ;-),
you're actually in the right position to do this :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
