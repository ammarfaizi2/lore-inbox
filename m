Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279032AbRJ2GRA>; Mon, 29 Oct 2001 01:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279034AbRJ2GQt>; Mon, 29 Oct 2001 01:16:49 -0500
Received: from mail108.mail.bellsouth.net ([205.152.58.48]:52210 "EHLO
	imf08bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S279032AbRJ2GQg>; Mon, 29 Oct 2001 01:16:36 -0500
Message-ID: <3BDCF46B.53D04CE3@mandrakesoft.com>
Date: Mon, 29 Oct 2001 01:17:15 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.org
Subject: Re: [patch] 2.4.13 remove unused warnings on module tables
In-Reply-To: <3030.1004321561@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> @@ -11,6 +11,7 @@
>  #include <linux/spinlock.h>
>  #include <linux/list.h>
> 
> +#ifndef CONFIG_KBUILD_2_5
>  #ifdef __GENKSYMS__
>  #  define _set_ver(sym) sym
>  #  undef  MODVERSIONS
> @@ -21,6 +22,7 @@
>  #   include <linux/modversions.h>
>  # endif
>  #endif /* __GENKSYMS__ */
> +#endif /* CONFIG_KBUILD_2_5 */
> 
>  #include <asm/atomic.h>
> 
> @@ -257,8 +259,6 @@ static const unsigned long __module_##gt

I don't think we need this part of the patch.

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

