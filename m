Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261903AbVFVKGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbVFVKGd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 06:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262967AbVFVKC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 06:02:58 -0400
Received: from witte.sonytel.be ([80.88.33.193]:35296 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262828AbVFVJ63 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 05:58:29 -0400
Date: Wed, 22 Jun 2005 11:57:58 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jurriaan <thunder7@xs4all.nl>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [PATCH] New framebuffer fonts + updated 12x22 font available
In-Reply-To: <200506220308.j5M380Ru002576@hera.kernel.org>
Message-ID: <Pine.LNX.4.62.0506221156540.16901@numbat.sonytel.be>
References: <200506220308.j5M380Ru002576@hera.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2005, Linux Kernel Mailing List wrote:
> [PATCH] New framebuffer fonts + updated 12x22 font available
> 
> Improve the fonts for use with the framebuffer.
> 
> I've added all the characters marked 'FIXME' in the sun12x22 font and
> created a 10x18 font (based on the sun12x22 font) and a 7x14 font (based
> on the vga8x16 font).
> 
> This patch is non-intrusive, no options are enabled by default so most
                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> users won't notice a thing.

But ...

> --- a/drivers/video/console/Kconfig
> +++ b/drivers/video/console/Kconfig
> @@ -153,6 +153,15 @@ config FONT_6x11
>  	  Small console font with Macintosh-style high-half glyphs.  Some Mac
>  	  framebuffer drivers don't support this one at all.
>  
> +config FONT_7x14
> +	bool "console 7x14 font (not supported by all drivers)" if FONTS
> +	depends on FRAMEBUFFER_CONSOLE
> +	default y if !SPARC32 && !SPARC64 && !FONTS
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Sorry I didn't nocice during the original review...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
