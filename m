Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261823AbVAMXnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbVAMXnG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 18:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbVAMXjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 18:39:51 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:19460 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261765AbVAMX37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 18:29:59 -0500
Date: Fri, 14 Jan 2005 00:29:43 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Luca Falavigna <dktrkranz@gmail.com>
Cc: dri-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Compile bug in Direct Rendering Manager (kernel 2.6.11-rc1)
Message-ID: <20050113232943.GO29578@stusta.de>
References: <41E6525E.6030200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E6525E.6030200@gmail.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 11:50:06AM +0100, Luca Falavigna wrote:
> 
> While compiling kernel 2.6.11-rc1, make exits with a lot of errors concerning
> Direct Rendering Manager. Here is some info I've grabbed:
> 
> [...]
> CC [M]  drivers/char/drm/gamma_drv.o
> drivers/char/drm/gamma_drv.c:39:22: drm_auth.h: No such file or directory
>...
> make[3]: *** [drivers/char/drm/gamma_drv.o] Error 1
>...
> [...]
> CONFIG_DRM=m
> CONFIG_DRM_TDFX=m
> CONFIG_DRM_GAMMA=m
>...

The more interestion options would have been:
CONFIG_EXPERIMENTAL=y
# CONFIG_CLEAN_COMPILE is not set
CONFIG_BROKEN=y

If you answer "yes" to

  "Prompt for development and/or incomplete code/drivers"

and "no" to

  "Select only drivers expected to compile cleanly"

it souldn't be a big surprise if a driver doesn't compile.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

