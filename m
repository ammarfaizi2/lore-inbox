Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283085AbRK2Hx0>; Thu, 29 Nov 2001 02:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283086AbRK2HxR>; Thu, 29 Nov 2001 02:53:17 -0500
Received: from mail.sonytel.be ([193.74.243.200]:14512 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S283085AbRK2HxK>;
	Thu, 29 Nov 2001 02:53:10 -0500
Date: Thu, 29 Nov 2001 08:52:56 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Simmons <jsimmons@transvirtual.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [PATCH] Hooks for new fbdev api
In-Reply-To: <Pine.LNX.4.10.10111281036200.11130-100000@www.transvirtual.com>
Message-ID: <Pine.GSO.4.21.0111290851320.6747-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Nov 2001, James Simmons wrote:
> +struct fb_copyarea {
> +	__u32 sx;	/* screen-relative */
> +	__u32 sy;
> +	__u32 width;
> +	__u32 height;
> +	__u32 dx;
> +	__u32 dy;
> +};
> +
> +struct fb_fillrect {
> +	__u32 x1;	/* screen-relative */
> +	__u32 y1;

Why call them x1 and y1 here?

> +	__u32 width;
> +	__u32 height;
> +	__u32 color;
> +	__u32 rop;
> +};
> +
> +struct fb_image {
> +	__u32 width;	/* Size of image */
> +	__u32 height;
> +	__u16 x;	/* Where to place image */
> +	__u16 y;

And x and y here?

I'd vote for either x/y or dx/dy (destinatation x/y).

> +	__u32 fg_color;	/* Only used when a mono bitmap */
> +	__u32 bg_color;
> +	__u8  depth;	/* Dpeth of the image */
                           Depth
> +	char  *data;	/* Pointer to image data */
> +};
> +

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

