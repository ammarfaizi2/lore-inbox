Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318564AbSGZUPH>; Fri, 26 Jul 2002 16:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318569AbSGZUOz>; Fri, 26 Jul 2002 16:14:55 -0400
Received: from www.transvirtual.com ([206.14.214.140]:29715 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S318564AbSGZUMw>; Fri, 26 Jul 2002 16:12:52 -0400
Date: Fri, 26 Jul 2002 13:15:54 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Keith Owens <kaos@ocs.com.au>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.5.28 Correct drivers/video aty build inconsistency
In-Reply-To: <8505.1027656817@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.44.0207261315390.15282-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fixed. Thanks.

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'\_   _/`\
 \___)=(___/

On Fri, 26 Jul 2002, Keith Owens wrote:

> Detected by kbuild 2.5.
>
> pp_makefile4:
> Warning: drivers/video/cfbimgblt.o is a sub-object and it appears on select().
>          This is an ambiguous combination and is not recommended.
>
> CONFIG_FB_NEOMAGIC=m, CONFIG_FB_ATY=y builds cfbimgblt as a module then
> links it into vmlinux via atyfb.
>
> Index: 28.1/drivers/video/aty/Makefile
> --- 28.1/drivers/video/aty/Makefile Fri, 26 Jul 2002 10:10:31 +1000 kaos (linux-2.5/u/b/12_Makefile 1.3 444)
> +++ 28.1(w)/drivers/video/aty/Makefile Fri, 26 Jul 2002 14:07:55 +1000 kaos (linux-2.5/u/b/12_Makefile 1.3 444)
> @@ -3,7 +3,7 @@ export-objs    :=  atyfb_base.o mach64_a
>
>  obj-$(CONFIG_FB_ATY) += atyfb.o
>
> -atyfb-y				:= atyfb_base.o mach64_accel.o ../cfbimgblt.o
> +atyfb-y				:= atyfb_base.o mach64_accel.o
>  atyfb-$(CONFIG_FB_ATY_GX)	+= mach64_gx.o
>  atyfb-$(CONFIG_FB_ATY_CT)	+= mach64_ct.o mach64_cursor.o
>  atyfb-objs			:= $(atyfb-y)
> Index: 28.1/drivers/video/Makefile
> --- 28.1/drivers/video/Makefile Fri, 26 Jul 2002 10:10:31 +1000 kaos (linux-2.5/x/b/16_Makefile 1.12 444)
> +++ 28.1(w)/drivers/video/Makefile Fri, 26 Jul 2002 14:08:51 +1000 kaos (linux-2.5/x/b/16_Makefile 1.12 444)
> @@ -89,7 +89,7 @@ obj-$(CONFIG_FB_TX3912)           += tx3
>  obj-$(CONFIG_FB_MATROX)		  += matrox/
>  obj-$(CONFIG_FB_RIVA)		  += riva/
>  obj-$(CONFIG_FB_SIS)		  += sis/
> -obj-$(CONFIG_FB_ATY)		  += aty/
> +obj-$(CONFIG_FB_ATY)		  += aty/ cfbimgblt.o
>
>  obj-$(CONFIG_FB_SUN3)             += sun3fb.o
>  obj-$(CONFIG_FB_BWTWO)            += bwtwofb.o
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

