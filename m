Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286369AbRLJUBQ>; Mon, 10 Dec 2001 15:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286371AbRLJUBG>; Mon, 10 Dec 2001 15:01:06 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S286369AbRLJUAw>;
	Mon, 10 Dec 2001 15:00:52 -0500
Message-ID: <3C15146D.BA780B43@mandrakesoft.com>
Date: Mon, 10 Dec 2001 15:00:45 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.13-12mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Paul P Komkoff Jr <i@stingr.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MTU vlan-related patch for tulip (2.4.x)
In-Reply-To: <20011210225759.B11450@stingr.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul P Komkoff Jr wrote:
> diff -urN linux-2.4.9-ac10-novlan/drivers/net/tulip/tulip.h linux-2.4.9-ac10/drivers/net/tulip/tulip.h
> --- linux-2.4.9-ac10-novlan/drivers/net/tulip/tulip.h   Wed Jun 20 22:19:02 2001
> +++ linux-2.4.9-ac10/drivers/net/tulip/tulip.h  Mon Sep 10 18:42:27 2001
> @@ -264,7 +264,7 @@
> 
>  #define MEDIA_MASK     31
> 
> -#define PKT_BUF_SZ             1536    /* Size of each temporary Rx buffer. */
> +#define PKT_BUF_SZ             1540    /* Size of each temporary Rx buffer. */
> 
>  #define TULIP_MIN_CACHE_LINE   8       /* in units of 32-bit words */
> 
> diff -urN linux-2.4.9-ac10-novlan/drivers/net/tulip/tulip_core.c linux-2.4.9-ac10/drivers/net/tulip/tulip_core.c
> --- linux-2.4.9-ac10-novlan/drivers/net/tulip/tulip_core.c      Mon Sep 10 18:50:47 2001
> +++ linux-2.4.9-ac10/drivers/net/tulip/tulip_core.c     Mon Sep 10 18:39:59 2001
> @@ -59,7 +59,7 @@
>  #if defined(__alpha__) || defined(__arm__) || defined(__hppa__) \
>         || defined(__sparc_) || defined(__ia64__) \
>         || defined(__sh__) || defined(__mips__)
> -static int rx_copybreak = 1518;
> +static int rx_copybreak = 1522;
>  #else
>  static int rx_copybreak = 100;
>  #endif

I haven't added it to mainline because of these two patches...   I want
to fully analyze their affects before potentially shifting allocation
patterns particularly.

	Jeff



-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
