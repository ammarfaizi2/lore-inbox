Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbVGXUjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVGXUjl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 16:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbVGXUjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 16:39:40 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:33292 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261254AbVGXUjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 16:39:40 -0400
Date: Sun, 24 Jul 2005 22:39:32 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Grant Coady <lkml@dodo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3 test: finding compile errors with make randconfig
Message-ID: <20050724203932.GX3160@stusta.de>
References: <f8b6e1h2t4tlto7ia8gs8aanpib68mhit6@4ax.com> <20050724091327.GQ3160@stusta.de> <glq7e1ttejp2sh7uuo6nil2vafljdprkpk@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <glq7e1ttejp2sh7uuo6nil2vafljdprkpk@4ax.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2005 at 05:42:58AM +1000, Grant Coady wrote:
> On Sun, 24 Jul 2005 11:13:27 +0200, Adrian Bunk <bunk@stusta.de> wrote:
> >
> >it's generally useful, but the target kernel should be the latest -mm
> >kernel. 
> 097-error:drivers/char/drm/drm_memory.h:163: error: redefinition of `drm_ioremap_nocache'
> 097-error:drivers/char/drm/drm_memory.h:163: error: `drm_ioremap_nocache' previously defined here
> 097-error:drivers/char/drm/drm_memory.h:174: error: redefinition of `drm_ioremapfree'
> 097-error:drivers/char/drm/drm_memory.h:174: error: `drm_ioremapfree' previously defined here

This requires the .config for debugging.

My first guess is that drm_memory.h requires a simple #ifdef to allow 
multiple inclusions.

> 098-error:drivers/usb/gadget/ether.c:2510: error: `STATUS_BYTECOUNT' undeclared (first use in this function)
> 098-error:drivers/usb/gadget/ether.c:2510: error: (Each undeclared identifier is reported only once
> 098-error:drivers/usb/gadget/ether.c:2510: error: for each function it appears in.)

Already fixed in 2.6.13-rc3.

> grant@sempro:/opt/linux/trial4$ grep error *-error |wc -l
> 2105
> 
> With > 2k (raw) errors in 97.something builds of 2.6.12.3, why go 
> looking for trouble in -mm?  
>...

You aren't running into problems that are already fixed (see your second 
example above).

> Grant.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

