Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261955AbVBSVpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261955AbVBSVpn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 16:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbVBSVpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 16:45:43 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:22282 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261955AbVBSVp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 16:45:29 -0500
Date: Sat, 19 Feb 2005 22:45:24 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: updated list of unused kernel exports posted
Message-ID: <20050219214524.GF4337@stusta.de>
References: <1108847674.6304.158.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108847674.6304.158.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 19, 2005 at 10:14:33PM +0100, Arjan van de Ven wrote:

>...
> The following symbols are added to this list since the last posted list;
> some of these will be of the "emerging functionality" type, others will
> be now-redundant and should be investigated for removal; after all each
> exported symbol uses easily over a hundred bytes of unswappable kernel
> memory for every linux user out there.
> 
> +++ unused.new  2005-02-19 21:27:59.556557390 +0100
> +alloc_chrdev_region

Used on s390:
drivers/s390/char/vmlogrdr.c
drivers/s390/char/tape_char.c

>...
> +backlight_device_register
> +backlight_device_unregister

Used on the Sharp Zaurus:
drivers/video/backlight/corgi_bl.c

>...
> +cpufreq_get

Used on ARM:
drivers/pcmcia/sa11xx_base.c

But ist seems to be wrong that it gets exported twice on ARM.

>...
> +nr_free_pages

In -mm, it's used by reiser4.

> +nr_pagecache

Used on s390:
arch/s390/appldata/appldata_mem.c

>...
> +pccard_static_ops

Used on ARM and m32r:
drivers/pcmcia/m32r_pcc.c
drivers/pcmcia/soc_common.c
drivers/pcmcia/m32r_cfc.c
drivers/pcmcia/hd64465_ss.c

>...
> +platform_get_irq_byname

Used on ppc:
drivers/net/gianfar.c

> +platform_get_resource_byname

Used on ARM, m32r and ppc:
drivers/net/smc91x.c

>...
> +totalram_pages

In -mm, it's used by reiser4.

>...
> +try_acquire_console_sem

It's used in -mm:
drivers/video/aty/radeon_pm.c

>...
> +wait_for_completion_interruptible
>...
> +wait_for_completion_timeout

Both are used in -mm:
drivers/i2c/i2c-core.c

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

