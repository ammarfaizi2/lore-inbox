Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262594AbTDESji (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 13:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbTDESji (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 13:39:38 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:29203 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262594AbTDESjc (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 5 Apr 2003 13:39:32 -0500
Date: Sat, 5 Apr 2003 19:51:02 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
cc: linux-kernel@vger.kernel.org, <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] C99 Initialisers for drivers/video
In-Reply-To: <Pine.LNX.4.51.0304051607310.32140@dns.toxicfilms.tv>
Message-ID: <Pine.LNX.4.44.0304051950290.6322-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have the patch in the fbdev BK tree. I shoudl be finished later today 
with my final changes.


> Hello,
> 
> here is a set of C99 initialisers to 2.5 drivers/video files.
> 
>  retz3fb.c       |   16 +++++++-------
>  riva/fbdev.c    |   58 ++++++++++++++++++++++++++--------------------------
>  sis/sis_accel.c |   48 +++++++++++++++++++++----------------------
>  sis/sis_main.c  |   18 ++++++++--------
>  sis/sis_main.h  |   62 ++++++++++++++++++++++++++++----------------------------
>  5 files changed, 101 insertions(+), 101 deletions(-)
> 
> Regards,
> Maciej Soltysiak
> 
> diff -ru linux-2.5.66.orig/drivers/video/retz3fb.c linux-2.5.66/drivers/video/retz3fb.c
> --- linux-2.5.66.orig/drivers/video/retz3fb.c	2003-03-05 04:29:34.000000000 +0100
> +++ linux-2.5.66/drivers/video/retz3fb.c	2003-04-05 15:41:03.000000000 +0200
> @@ -1589,13 +1589,13 @@
> 
> 
>  static struct display_switch fbcon_retz3_8 = {
> -    setup:		fbcon_cfb8_setup,
> -    bmove:		retz3_8_bmove,
> -    clear:		retz3_8_clear,
> -    putc:		retz3_putc,
> -    putcs:		retz3_putcs,
> -    revc:		retz3_revc,
> -    clear_margins:	retz3_clear_margins,
> -    fontwidthmask:	FONTWIDTH(8)
> +    .setup		= fbcon_cfb8_setup,
> +    .bmove		= retz3_8_bmove,
> +    .clear		= retz3_8_clear,
> +    .putc		= retz3_putc,
> +    .putcs		= retz3_putcs,
> +    .revc		= retz3_revc,
> +    .clear_margins	= retz3_clear_margins,
> +    .fontwidthmask	= FONTWIDTH(8)
>  };
>  #endif
> diff -ru linux-2.5.66.orig/drivers/video/riva/fbdev.c linux-2.5.66/drivers/video/riva/fbdev.c
> --- linux-2.5.66.orig/drivers/video/riva/fbdev.c	2003-04-02 19:12:16.000000000 +0200
> +++ linux-2.5.66/drivers/video/riva/fbdev.c	2003-04-05 15:42:52.000000000 +0200
> @@ -297,34 +297,34 @@
>  #endif
> 
>  static struct fb_fix_screeninfo rivafb_fix = {
> -	id:		"nVidia",
> -	type:		FB_TYPE_PACKED_PIXELS,
> -	xpanstep:	1,
> -	ypanstep:	1,
> +	.id		= "nVidia",
> +	.type		= FB_TYPE_PACKED_PIXELS,
> +	.xpanstep	= 1,
> +	.ypanstep	= 1,
>  };
> 
>  static struct fb_var_screeninfo rivafb_default_var = {
> -	xres:		640,
> -	yres:		480,
> -	xres_virtual:	640,
> -	yres_virtual:	480,
> -	bits_per_pixel:	8,
> -	red:		{0, 8, 0},
> -	green:		{0, 8, 0},
> -	blue:		{0, 8, 0},
> -	transp:		{0, 0, 0},
> -	activate:	FB_ACTIVATE_NOW,
> -	height:		-1,
> -	width:		-1,
> -	accel_flags:	FB_ACCELF_TEXT,
> -	pixclock:	39721,
> -	left_margin:	40,
> -	right_margin:	24,
> -	upper_margin:	32,
> -	lower_margin:	11,
> -	hsync_len:	96,
> -	vsync_len:	2,
> -	vmode:		FB_VMODE_NONINTERLACED
> +	.xres		= 640,
> +	.yres		= 480,
> +	.xres_virtual	= 640,
> +	.yres_virtual	= 480,
> +	.bits_per_pixel	= 8,
> +	.red		= {0, 8, 0},
> +	.green		= {0, 8, 0},
> +	.blue		= {0, 8, 0},
> +	.transp		= {0, 0, 0},
> +	.activate	= FB_ACTIVATE_NOW,
> +	.height		= -1,
> +	.width		= -1,
> +	.accel_flags	= FB_ACCELF_TEXT,
> +	.pixclock	= 39721,
> +	.left_margin	= 40,
> +	.right_margin	= 24,
> +	.upper_margin	= 32,
> +	.lower_margin	= 11,
> +	.hsync_len	= 96,
> +	.vsync_len	= 2,
> +	.vmode		= FB_VMODE_NONINTERLACED
>  };
> 
>  /* from GGI */
> @@ -1984,10 +1984,10 @@
>  #endif /* !MODULE */
> 
>  static struct pci_driver rivafb_driver = {
> -	name:		"rivafb",
> -	id_table:	rivafb_pci_tbl,
> -	probe:		rivafb_probe,
> -	remove:		__exit_p(rivafb_remove),
> +	.name		= "rivafb",
> +	.id_table	= rivafb_pci_tbl,
> +	.probe		= rivafb_probe,
> +	.remove		= __exit_p(rivafb_remove),
>  };
> 
> 
> diff -ru linux-2.5.66.orig/drivers/video/sis/sis_accel.c linux-2.5.66/drivers/video/sis/sis_accel.c
> --- linux-2.5.66.orig/drivers/video/sis/sis_accel.c	2003-04-02 19:12:16.000000000 +0200
> +++ linux-2.5.66/drivers/video/sis/sis_accel.c	2003-04-05 15:55:07.000000000 +0200
> @@ -591,38 +591,38 @@
> 
>  #ifdef FBCON_HAS_CFB8
>  struct display_switch fbcon_sis8 = {
> -	setup:			fbcon_cfb8_setup,
> -	bmove:			fbcon_sis_bmove,
> -	clear:			fbcon_sis_clear8,
> -	putc:			fbcon_cfb8_putc,
> -	putcs:			fbcon_cfb8_putcs,
> -	revc:			fbcon_cfb8_revc,
> -	clear_margins:		fbcon_cfb8_clear_margins,
> -	fontwidthmask:		FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
> +	.setup			= fbcon_cfb8_setup,
> +	.bmove			= fbcon_sis_bmove,
> +	.clear			= fbcon_sis_clear8,
> +	.putc			= fbcon_cfb8_putc,
> +	.putcs			= fbcon_cfb8_putcs,
> +	.revc			= fbcon_cfb8_revc,
> +	.clear_margins		= fbcon_cfb8_clear_margins,
> +	.fontwidthmask		= FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
>  };
>  #endif
>  #ifdef FBCON_HAS_CFB16
>  struct display_switch fbcon_sis16 = {
> -	setup:			fbcon_cfb16_setup,
> -	bmove:			fbcon_sis_bmove,
> -	clear:			fbcon_sis_clear16,
> -	putc:			fbcon_cfb16_putc,
> -	putcs:			fbcon_cfb16_putcs,
> -	revc:			fbcon_sis_revc,
> -	clear_margins:		fbcon_cfb16_clear_margins,
> -	fontwidthmask:		FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
> +	.setup			= fbcon_cfb16_setup,
> +	.bmove			= fbcon_sis_bmove,
> +	.clear			= fbcon_sis_clear16,
> +	.putc			= fbcon_cfb16_putc,
> +	.putcs			= fbcon_cfb16_putcs,
> +	.revc			= fbcon_sis_revc,
> +	.clear_margins		= fbcon_cfb16_clear_margins,
> +	.fontwidthmask		= FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
>  };
>  #endif
>  #ifdef FBCON_HAS_CFB32
>  struct display_switch fbcon_sis32 = {
> -	setup:			fbcon_cfb32_setup,
> -	bmove:			fbcon_sis_bmove,
> -	clear:			fbcon_sis_clear32,
> -	putc:			fbcon_cfb32_putc,
> -	putcs:			fbcon_cfb32_putcs,
> -	revc:			fbcon_sis_revc,
> -	clear_margins:		fbcon_cfb32_clear_margins,
> -	fontwidthmask:		FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
> +	.setup			= fbcon_cfb32_setup,
> +	.bmove			= fbcon_sis_bmove,
> +	.clear			= fbcon_sis_clear32,
> +	.putc			= fbcon_cfb32_putc,
> +	.putcs			= fbcon_cfb32_putcs,
> +	.revc			= fbcon_sis_revc,
> +	.clear_margins		= fbcon_cfb32_clear_margins,
> +	.fontwidthmask		= FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
>  };
>  #endif
> 
> diff -ru linux-2.5.66.orig/drivers/video/sis/sis_main.c linux-2.5.66/drivers/video/sis/sis_main.c
> --- linux-2.5.66.orig/drivers/video/sis/sis_main.c	2003-04-02 19:12:17.000000000 +0200
> +++ linux-2.5.66/drivers/video/sis/sis_main.c	2003-04-05 15:57:26.000000000 +0200
> @@ -2045,17 +2045,17 @@
> 
>  #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
>  static struct fb_ops sisfb_ops = {
> -	owner:		THIS_MODULE,
> -	fb_get_fix:	sisfb_get_fix,
> -	fb_get_var:	sisfb_get_var,
> -	fb_set_var:	sisfb_set_var,
> -	fb_get_cmap:	sisfb_get_cmap,
> -	fb_set_cmap:	sisfb_set_cmap,
> +	.owner		= THIS_MODULE,
> +	.fb_get_fix	= sisfb_get_fix,
> +	.fb_get_var	= sisfb_get_var,
> +	.fb_set_var	= sisfb_set_var,
> +	.fb_get_cmap	= sisfb_get_cmap,
> +	.fb_set_cmap	= sisfb_set_cmap,
>  #ifdef SISFB_PAN
> -        fb_pan_display:	sisfb_pan_display,
> +        .fb_pan_display	= sisfb_pan_display,
>  #endif
> -	fb_ioctl:	sisfb_ioctl,
> -	fb_mmap:	sisfb_mmap,
> +	.fb_ioctl	= sisfb_ioctl,
> +	.fb_mmap	= sisfb_mmap,
>  };
>  #endif
> 
> diff -ru linux-2.5.66.orig/drivers/video/sis/sis_main.h linux-2.5.66/drivers/video/sis/sis_main.h
> --- linux-2.5.66.orig/drivers/video/sis/sis_main.h	2003-04-02 19:12:17.000000000 +0200
> +++ linux-2.5.66/drivers/video/sis/sis_main.h	2003-04-05 16:00:19.000000000 +0200
> @@ -286,43 +286,43 @@
>  static int    video_type = FB_TYPE_PACKED_PIXELS;
> 
>  static struct fb_var_screeninfo default_var = {
> -	xres:           0,
> -	yres:           0,
> -	xres_virtual:   0,
> -	yres_virtual:   0,
> -	xoffset:        0,
> -	yoffset:        0,
> -	bits_per_pixel: 0,
> -	grayscale:      0,
> -	red:            {0, 8, 0},
> -	green:          {0, 8, 0},
> -	blue:           {0, 8, 0},
> -	transp:         {0, 0, 0},
> -	nonstd:         0,
> -	activate:       FB_ACTIVATE_NOW,
> -	height:         -1,
> -	width:          -1,
> -	accel_flags:    0,
> -	pixclock:       0,
> -	left_margin:    0,
> -	right_margin:   0,
> -	upper_margin:   0,
> -	lower_margin:   0,
> -	hsync_len:      0,
> -	vsync_len:      0,
> -	sync:           0,
> -	vmode:          FB_VMODE_NONINTERLACED,
> +	.xres		= 0,
> +	.yres		= 0,
> +	.xres_virtual	= 0,
> +	.yres_virtual	= 0,
> +	.xoffset	= 0,
> +	.yoffset	= 0,
> +	.bits_per_pixel	= 0,
> +	.grayscale	= 0,
> +	.red		= {0, 8, 0},
> +	.green		= {0, 8, 0},
> +	.blue		= {0, 8, 0},
> +	.transp		= {0, 0, 0},
> +	.nonstd		= 0,
> +	.activate	= FB_ACTIVATE_NOW,
> +	.height		= -1,
> +	.width		= -1,
> +	.accel_flags	= 0,
> +	.pixclock	= 0,
> +	.left_margin	= 0,
> +	.right_margin	= 0,
> +	.upper_margin	= 0,
> +	.lower_margin	= 0,
> +	.hsync_len	= 0,
> +	.vsync_len	= 0,
> +	.sync		= 0,
> +	.vmode		= FB_VMODE_NONINTERLACED,
>  #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
> -	reserved:       {0, 0, 0, 0, 0, 0}
> +	.reserved	= {0, 0, 0, 0, 0, 0}
>  #endif
>  };
> 
>  #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
>  static struct fb_fix_screeninfo sisfb_fix = {
> -	id:		"SiS",
> -	type:		FB_TYPE_PACKED_PIXELS,
> -	xpanstep:	1,
> -	ypanstep:	1,
> +	.id		= "SiS",
> +	.type		= FB_TYPE_PACKED_PIXELS,
> +	.xpanstep	= 1,
> +	.ypanstep	= 1,
>  };
>  static char myid[20];
>  static u32 pseudo_palette[17];
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

