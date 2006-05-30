Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbWE3OpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbWE3OpW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 10:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbWE3OpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 10:45:21 -0400
Received: from moci.net4u.de ([217.7.64.195]:54201 "EHLO moci.net4u.de")
	by vger.kernel.org with ESMTP id S932297AbWE3OpV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 10:45:21 -0400
From: Ernst Herzberg <earny@net4u.de>
Reply-To: earny@net4u.de
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] alpha: generic hweight (Re: ALPHA 2.6.17-rc5 compile error)
Date: Tue, 30 May 2006 16:45:16 +0200
User-Agent: KMail/1.9.1
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, akpm <akpm@osdl.org>,
       rth@twiddle.net, mita@miraclelinux.com
References: <200605291848.58756.list-lkml@net4u.de> <20060529164822.c16cfe43.rdunlap@xenotime.net>
In-Reply-To: <20060529164822.c16cfe43.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605301645.17251.earny@net4u.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 May 2006 01:48, Randy.Dunlap wrote:

> > lib/lib.a(bitmap.o): In function `__bitmap_weight':
> > : undefined reference to `hweight64'
> >
>
> Please try the patch below.
>
> From: Randy Dunlap <rdunlap@xenotime.net>
>
> According to include/asm-alpha/bitops.h, only ALPHA_EV67 has
> hardware hweight support, so ALPHA_EV6 needs to use GENERIC_HWEIGHT.
>
> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> ---
>  arch/alpha/Kconfig |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
>
> --- linux-2617-rc5.orig/arch/alpha/Kconfig
> +++ linux-2617-rc5/arch/alpha/Kconfig
> @@ -453,7 +453,7 @@ config ALPHA_IRONGATE
>
>  config GENERIC_HWEIGHT
>  	bool
> -	default y if !ALPHA_EV6 && !ALPHA_EV67
> +	default y if !ALPHA_EV67
>
>  config ALPHA_AVANTI
>  	bool

Compiles now. But does not boot (AIC7XXX related problem).

Will capture boot messages now.

Thanks

Earny
