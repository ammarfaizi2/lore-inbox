Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261803AbVDAIrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbVDAIrR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 03:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbVDAIqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 03:46:19 -0500
Received: from witte.sonytel.be ([80.88.33.193]:18377 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261612AbVDAIqJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 03:46:09 -0500
Date: Fri, 1 Apr 2005 10:45:59 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix atyfb build on ppc
In-Reply-To: <200503311828.j2VISgPd028711@hera.kernel.org>
Message-ID: <Pine.LNX.4.62.0504011045030.6801@numbat.sonytel.be>
References: <200503311828.j2VISgPd028711@hera.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Mar 2005, Linux Kernel Mailing List wrote:

> ChangeSet 1.2305, 2005/03/31 08:49:44-08:00, benh@kernel.crashing.org
> 
> 	[PATCH] Fix atyfb build on ppc
> 	
> 	This patch fixes a build problem with atyfb on ppc.  It uses the stuff in
> 	macmodes.c, but doesn't trigger the build of it.  So if no other driver
> 	using macmodes is built, the link will fail.
> 	
> 	Signed-off-by: David Woodhouse <dwmw2@infradead.org>
> 	Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 	Signed-off-by: Andrew Morton <akpm@osdl.org>
> 	Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> 
> 
> 
>  Makefile |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> 
> diff -Nru a/drivers/video/Makefile b/drivers/video/Makefile
> --- a/drivers/video/Makefile	2005-03-31 10:28:55 -08:00
> +++ b/drivers/video/Makefile	2005-03-31 10:28:55 -08:00
> @@ -30,8 +30,8 @@
>  obj-$(CONFIG_FB_MATROX)		  += matrox/
>  obj-$(CONFIG_FB_RIVA)		  += riva/ vgastate.o
>  obj-$(CONFIG_FB_NVIDIA)		  += nvidia/
> -obj-$(CONFIG_FB_ATY)		  += aty/
> -obj-$(CONFIG_FB_ATY128)		  += aty/
> +obj-$(CONFIG_FB_ATY)		  += aty/ macmodes.o
> +obj-$(CONFIG_FB_ATY128)		  += aty/ macmodes.o
>  obj-$(CONFIG_FB_RADEON)		  += aty/
>  obj-$(CONFIG_FB_SIS)		  += sis/
>  obj-$(CONFIG_FB_KYRO)             += kyro/

Isn't this one obsoleted by `fbdev: Kconfig fix for macmodes and PPC', which
also went in?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
