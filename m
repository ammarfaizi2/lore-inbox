Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbVDCRjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbVDCRjQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 13:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbVDCRjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 13:39:16 -0400
Received: from smtpout.mac.com ([17.250.248.73]:64980 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261238AbVDCRjM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 13:39:12 -0400
In-Reply-To: <424E81CC.6000600@gmail.com>
References: <424E81CC.6000600@gmail.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <a127bbd121b274b7adb7e71b42979e4b@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kaos@ocs.com.au
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH] RCU in kernel/intermodule.c
Date: Sun, 3 Apr 2005 13:38:33 -0400
To: Luca Falavigna <dktrkranz@gmail.com>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 02, 2005, at 06:28, Luca Falavigna wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> - --- ./kernel/intermodule.c.orig	2005-04-01 19:25:26.000000000 +0000
> +++ ./kernel/intermodule.c	2005-04-02 02:46:22.000000000 +0000
> @@ -3,7 +3,7 @@
>  /* Written by Keith Owens <kaos@ocs.com.au> Oct 2000 */
>  #include <linux/module.h>
>  #include <linux/kmod.h>
> - -#include <linux/spinlock.h>

   ^ Ugh, mangled patch

> +#include <linux/rcupdate.h>
>  #include <linux/list.h>
>  #include <linux/slab.h>

Please don't sign patches with PGP, it mangles them and makes them
much harder to apply.

Also, the intermodule stuff is slated for removal, as soon as MTD and
such are fixed; the interface has been deprecated for a while.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


