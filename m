Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267112AbSLDWLR>; Wed, 4 Dec 2002 17:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267119AbSLDWLR>; Wed, 4 Dec 2002 17:11:17 -0500
Received: from conure.mail.pas.earthlink.net ([207.217.120.54]:61694 "EHLO
	conure.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S267112AbSLDWLP>; Wed, 4 Dec 2002 17:11:15 -0500
Date: Wed, 4 Dec 2002 15:11:36 -0800 (PST)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Art Haas <ahaas@airmail.net>
cc: <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] C99 initializer fix for drivers/video/vfb.c
In-Reply-To: <20021204202408.GF9551@debian>
Message-ID: <Pine.LNX.4.33.0212041511150.1533-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Its fixed in my latest work which shoudl be coming very soon as you can
see by the emails :-)


MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@users.sf.net] 	                ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

On Wed, 4 Dec 2002, Art Haas wrote:

> Hi.
>
> This patch fixes a half-conversion to C99 initializers - the '='
> characters were dropped. The patch is against 2.5.50.
>
> Art Haas
>
> --- linux-2.5.50/drivers/video/vfb.c.old	2002-12-04 13:25:50.000000000 -0600
> +++ linux-2.5.50/drivers/video/vfb.c	2002-12-04 13:25:00.000000000 -0600
> @@ -96,17 +96,17 @@
>  		    struct vm_area_struct *vma);
>
>  static struct fb_ops vfb_ops = {
> -	.fb_set_var	gen_set_var,
> -	.fb_get_cmap	gen_set_cmap,
> -	.fb_set_cmap	gen_set_cmap,
> -	.fb_check_var	vfb_check_var,
> -	.fb_set_par	vfb_set_par,
> -	.fb_setcolreg	vfb_setcolreg,
> -	.fb_pan_display	vfb_pan_display,
> -	.fb_fillrect	cfb_fillrect,
> -	.fb_copyarea	cfb_copyarea,
> -	.fb_imageblit	cfb_imageblit,
> -	.fb_mmap	vfb_mmap,
> +	.fb_set_var	= gen_set_var,
> +	.fb_get_cmap	= gen_set_cmap,
> +	.fb_set_cmap	= gen_set_cmap,
> +	.fb_check_var	= vfb_check_var,
> +	.fb_set_par	= vfb_set_par,
> +	.fb_setcolreg	= vfb_setcolreg,
> +	.fb_pan_display	= vfb_pan_display,
> +	.fb_fillrect	= cfb_fillrect,
> +	.fb_copyarea	= cfb_copyarea,
> +	.fb_imageblit	= cfb_imageblit,
> +	.fb_mmap	= vfb_mmap,
>  };
>
>      /*
> --
> They that can give up essential liberty to obtain a little temporary safety
> deserve neither liberty nor safety.
>  -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

