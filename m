Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292281AbSCDJUY>; Mon, 4 Mar 2002 04:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292289AbSCDJUF>; Mon, 4 Mar 2002 04:20:05 -0500
Received: from mail.sonytel.be ([193.74.243.200]:47834 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S292281AbSCDJTu>;
	Mon, 4 Mar 2002 04:19:50 -0500
Date: Mon, 4 Mar 2002 10:19:22 +0100 (MET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: James Simmons <jsimmons@transvirtual.com>
cc: Dave Jones <davej@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] [PATCH] hitfb ported to new api.
In-Reply-To: <Pine.LNX.4.10.10203020939140.28753-100000@www.transvirtual.com>
Message-ID: <Pine.GSO.4.21.0203041015440.29240-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Mar 2002, James Simmons wrote:
> +static struct fb_var_screeninfo hitfb_var __initdata = {
> +	0, 0, 0, 0, 0, 0, 0, 0,
> +	{0, 0, 0}, {0, 0, 0}, {0, 0, 0}, {0, 0, 0},
> +	0, FB_ACTIVATE_NOW, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0,
> +	0, FB_VMODE_NONINTERLACED
>  };

> +static struct fb_fix_screeninfo hitfb_fix __initdata = {
> +	"Hitachi HD64461",(unsigned long) NULL, 0, FB_TYPE_PACKED_PIXELS,
> +	0, FB_VISUAL_TRUECOLOR, 0, 0, 0, 0, (unsigned long) NULL, 0, 
> +	FB_ACCEL_NONE
>  };

Suggestion: use the new-style struct initialization. It's less error-prone, and
you can get rid of the 0/NULL values.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

