Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265736AbTCFPR2>; Thu, 6 Mar 2003 10:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265857AbTCFPR1>; Thu, 6 Mar 2003 10:17:27 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:28680 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S265736AbTCFPR0>; Thu, 6 Mar 2003 10:17:26 -0500
Date: Thu, 6 Mar 2003 15:27:54 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Ben Collins <bcollins@debian.org>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix compilation of atyfb
In-Reply-To: <Pine.GSO.4.21.0303061106390.28248-100000@vervain.sonytel.be>
Message-ID: <Pine.LNX.4.44.0303061527270.4540-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I will be passing in the new fbdev code. I think it is time. It has this 
fix as well as others.

On Thu, 6 Mar 2003, Geert Uytterhoeven wrote:

> On Wed, 5 Mar 2003, Ben Collins wrote:
> > I needed this patch in order for mach64 fb support to be compiled.
> > 
> > --- linux-2.5.64.orig/drivers/video/Makefile	2003-03-05 08:49:48.000000000 -0500
> > +++ linux-2.5.64/drivers/video/Makefile	2003-03-05 08:59:41.000000000 -0500
> > @@ -57,7 +57,7 @@
> >  obj-$(CONFIG_FB_MATROX)		  += matrox/
> >  obj-$(CONFIG_FB_RIVA)		  += riva/ cfbimgblt.o vgastate.o 
> >  obj-$(CONFIG_FB_SIS)		  += sis/
> > -obj-$(CONFIG_FB_ATY)		  += aty/ cfbimgblt.o cfbfillrect.o cfbimgblt.o
> > +obj-$(CONFIG_FB_ATY)		  += aty/ cfbimgblt.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
> >  obj-$(CONFIG_FB_I810)             += i810/ cfbfillrect.o cfbcopyarea.o \
> >  	                             cfbimgblt.o vgastate.o
> 
> While you're at it, better remove the duplicate cfbimgblt.o too:
> 
> --- linux-2.5.64/drivers/video/Makefile	Wed Mar  5 10:07:24 2003
> +++ linux-m68k-2.5.64/drivers/video/Makefile	Wed Mar  5 11:57:44 2003
> @@ -57,7 +57,7 @@
>  obj-$(CONFIG_FB_MATROX)		  += matrox/
>  obj-$(CONFIG_FB_RIVA)		  += riva/ cfbimgblt.o vgastate.o 
>  obj-$(CONFIG_FB_SIS)		  += sis/
> -obj-$(CONFIG_FB_ATY)		  += aty/ cfbimgblt.o cfbfillrect.o cfbimgblt.o
> +obj-$(CONFIG_FB_ATY)		  += aty/ cfbfillrect.o cfbcopyarea.o cfbimgblt.o
>  obj-$(CONFIG_FB_I810)             += i810/ cfbfillrect.o cfbcopyarea.o \
>  	                             cfbimgblt.o vgastate.o
>  
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

