Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263201AbVFXHik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263201AbVFXHik (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 03:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263206AbVFXHij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 03:38:39 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:50693 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263201AbVFXHg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 03:36:27 -0400
Date: Fri, 24 Jun 2005 09:36:24 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Christian Hesse <mail@earthworm.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kernel .patches support
Message-ID: <20050624073624.GB26545@stusta.de>
References: <200506232358.34897.mail@earthworm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506232358.34897.mail@earthworm.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2005 at 11:58:27PM +0200, Christian Hesse wrote:
> Hi everybody,
> 
> every time I apply a patch to my kernel tree I (or my scripts) make an
> 
> echo $PATCHNAME $PATCHVERSION >> .patches
> 
> This patch makes the file accessible via /proc/patches.gz. I think this can be 
> handy if you want to know what patches you (or your distributor) applied to 
> your running kernel...
>...
> Let me know what you think.

To be honest, I'm not a fan of it.

If e.g. looking at a Debian kernel source that has 289 different patches 
with names like tty-locking-fixes7 applied, you'll see that this often 
won't give you much valuable information.

You'd need an uniform naming convention for patches across 
distributions, and I don't think such things are worth the effort.

> Regards,
> Christian

> --- linux-2.6.12+/include/linux/patches.h	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.12+-patches/include/linux/patches.h	2005-06-23 23:10:15.278685000 +0200
> @@ -0,0 +1,6 @@
> +#ifndef _LINUX_PATCHES_H
> +#define _LINUX_PATCHES_H
> +
> +#include <linux/autoconf.h>
> +
> +#endif
>...

What do you need this file for?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

