Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317363AbSIBUnm>; Mon, 2 Sep 2002 16:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318460AbSIBUnm>; Mon, 2 Sep 2002 16:43:42 -0400
Received: from pop.gmx.de ([213.165.64.20]:43675 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S317363AbSIBUnl>;
	Mon, 2 Sep 2002 16:43:41 -0400
Subject: lost lines in header files for the 2.5.3x kernel beta releases
From: Jimmy Jazz <Jimmy.Jazz@gmx.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 02 Sep 2002 22:48:04 +0200
Message-Id: <1030999685.20021.15.camel@andromede>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i'm using Mandrake 8.2 and i have tried to compile the last kernel.

I found that some lines were missing in the 2.5.32 and 2.5.33 kernel
headers files.

[root@andromede linux]# diff -w ./include/linux/fb.h.ori
./include/linux/fb.h
318a319,325
>     /* get non settable parameters */
>     int (*fb_get_fix)(struct fb_fix_screeninfo *fix, int con,
> 		                      struct fb_info *info);
>     /* get settable parameters */
>     int (*fb_get_var)(struct fb_var_screeninfo *var, int con,
> 			                          struct fb_info *info);
> 

----------[root@andromede linux]#  diff -w ./include/video/fbcon.h.ori
./include/video/fbcon.h
44a45,67
> #ifdef CONFIG_FBCON_SPLASHSCREEN
> struct splash_data {
> 	int	splash_state;			/* show splash? */
> 	int	splash_color;			/* transparent color */
> 	int	splash_fg_color;		/* foreground color */
> 	int	splash_width;			/* width of image */
> 	int	splash_height;			/* height of image */
> 	int	splash_text_xo;			/* text area origin */
> 	int	splash_text_yo;
> 	int	splash_text_wi;			/* text area size */ 
> 	int	splash_text_he;
> 	int	splash_penguin_xo;		/* penguin area origin */
> 	int	splash_penguin_yo;
> 	int	splash_penguin_wi;		/* penguin area size */
> 	int	splash_penguin_he;
> 	int	splash_penguin_r;		/* penguin bg color */
> 	int	splash_penguin_g;
> 	int	splash_penguin_b;
> 	int	splash_no_penguin;		/* don't display him */
> 	char	splash_jpeg[1];			/* jpeg */
> };
> #endif
> 
57a81,88
>     char *screen_base;              /* pointer to top of virtual
screen */    
>                                     /* (virtual address) */
>     int visual;
>     int type;                       /* see FB_TYPE_* */
>     int type_aux;                   /* Interleave for interleaved
Planes */
>     u_short ypanstep;               /* zero if no hardware ypan */
>     u_short ywrapstep;              /* zero if no hardware ywrap */
>     u_long line_length;             /* length of a line in bytes */
69a101
> 
88a121,124
> 
> #ifdef CONFIG_FBCON_SPLASHSCREEN
>     struct splash_data *splash_data;
> #endif
--------------------------------------------------------------------
The 2.5.33 kernel code still doesn't compile. I'm stuck in irtty.c ;)

Regards,

gs



