Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317176AbSHPIrz>; Fri, 16 Aug 2002 04:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317169AbSHPIry>; Fri, 16 Aug 2002 04:47:54 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:15860 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S317176AbSHPIrv>; Fri, 16 Aug 2002 04:47:51 -0400
Date: Fri, 16 Aug 2002 10:51:43 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
cc: Alan Cox <alan@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre2-ac3
In-Reply-To: <Pine.LNX.4.44.0208151649030.849-100000@chaos.physics.uiowa.edu>
Message-ID: <Pine.NEB.4.44.0208161051050.1351-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Aug 2002, Kai Germaschewski wrote:

> Well, so I had to dowload and compile gcc 2.95 and reproduce the
> problem... The following patch fixes it:
>
> diff -ur linux-2.4.20-pre2/drivers/isdn/hisax/hisax_debug.h linux-2.4.20-pre2.x/drivers/isdn/hisax/hisax_debug.h
> --- linux-2.4.20-pre2/drivers/isdn/hisax/hisax_debug.h	Thu Aug 15 16:48:25 2002
> +++ linux-2.4.20-pre2.x/drivers/isdn/hisax/hisax_debug.h	Thu Aug 15
> 16:48:04 2002
> @@ -28,7 +28,7 @@
>
>  #define DBG(level, format, arg...) do { \
>  if (level & __debug_variable) \
> -printk(KERN_DEBUG "%s: " format "\n" , __FUNCTION__, ## arg); \
> +printk(KERN_DEBUG "%s: " format "\n" , __FUNCTION__ , ## arg); \
>  } while (0)
>
>  #define DBG_PACKET(level,data,count) \

I can confirm that this patch fixes it.

Thanks
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

