Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbUCRJmo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 04:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262471AbUCRJmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 04:42:43 -0500
Received: from witte.sonytel.be ([80.88.33.193]:6042 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262470AbUCRJmk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 04:42:40 -0500
Date: Thu, 18 Mar 2004 10:42:33 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jakub Bogusz <qboosh@pld-linux.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] [PATCH 2.6][RESEND] fbcon margins colour
 fix
In-Reply-To: <20040318093715.GB17838@gruby.cs.net.pl>
Message-ID: <Pine.GSO.4.58.0403181041230.10688@waterleaf.sonytel.be>
References: <20040317233135.GB3510@satan.blackhosts>
 <Pine.GSO.4.58.0403181020320.10688@waterleaf.sonytel.be>
 <20040318093715.GB17838@gruby.cs.net.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2004, Jakub Bogusz wrote:
> On Thu, Mar 18, 2004 at 10:21:31AM +0100, Geert Uytterhoeven wrote:
> > On Thu, 18 Mar 2004, Jakub Bogusz wrote:
> > > I sent it a few times to linux-kernel and at least one to
> > > linux-fbdev-devel, but haven't seen any comments - and this annoying
> > > changing margins colour seems to be still there in 2.6.4 (at least on
> > > tdfxfb).
> >
> > What happens on `reverse video' (i.e. black on white, like Sun) graphics cards?
> > In that case the overscan color is white.
>
> Uhm. What is palette entry for this white?

0, on pseudocolor displays. So probably it's OK.

> Or, more generally, how to find (palette colour number of) overscan
> colour for current console?
> Video erase character colour is not proper one as it may be different
> even from background colour at the moment of vt switch.

There's no standardized way for that. So it may depend on the driver. I know
ATI Mach64 has a special register for the overscan color, which is always set
to black, IIRC.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
