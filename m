Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266341AbUIJIEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266341AbUIJIEp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 04:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267199AbUIJICO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 04:02:14 -0400
Received: from witte.sonytel.be ([80.88.33.193]:55487 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S266884AbUIJIBo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 04:01:44 -0400
Date: Fri, 10 Sep 2004 09:58:06 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: [Linux-fbdev-devel] [PATCH 7/7] fbdev: Add Tile Blitting support
In-Reply-To: <200409100534.56680.adaplas@hotpop.com>
Message-ID: <Pine.GSO.4.58.0409100957130.93@waterleaf.sonytel.be>
References: <200409100534.56680.adaplas@hotpop.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Sep 2004, Antonino A. Daplas wrote:
> --- linux-2.6.9-rc1-mm4-orig/drivers/video/Kconfig	2004-09-10 04:43:22.834414192 +0800
> +++ linux-2.6.9-rc1-mm4/drivers/video/Kconfig	2004-09-10 05:01:35.555295368 +0800
> @@ -49,6 +49,24 @@ config FB_MODE_HELPERS
>  	  your driver does not take advantage of this feature, choosing Y will
>  	  just increase the kernel size by about 5K.
>
> +config FB_TILEBLITTING
> +       bool "Enable Tile Blitting Support"
> +       depends on FB
> +       default n
> +       ---help---
> +         This enables tile blitting.  Tile blitting is a drawing technique
> +	 where the screen is divided into rectangular sections (tiles), whereas
> +	 the standard blitting divides the screen into pixels. Because the
> +	 default drawing element is a tile, drawing functions will be passed
> +	 parameters in terms of number of tiles instead of number of pixels.
> +	 For example, to draw a single character, instead of using bitmaps,
> +	 an index to an array of bitmaps will be used.  To clear or move a
> +	 rectangular section of a screen, the rectangle willbe described in
                                                        ^^^^^^
							will be
> +	 terms of number of tiles in the x- and y-axis.
> +
> +	 This is particularly important to one driver, the matroxfb.  If
                                                       ^^^^^^^^^^^^
						       matroxfb?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
