Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933629AbWKQOpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933629AbWKQOpy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 09:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933631AbWKQOpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 09:45:54 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:55424 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S933629AbWKQOpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 09:45:53 -0500
Date: Fri, 17 Nov 2006 14:45:49 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
cc: lkml <linux-kernel@vger.kernel.org>, pazke@donpac.ru, akpm <akpm@osdl.org>
Subject: Re: [PATCH] visws: sgivwfb is module needs exports
In-Reply-To: <20061116213038.84cc25b5.randy.dunlap@oracle.com>
Message-ID: <Pine.LNX.4.64.0611171444150.10830@pentafluge.infradead.org>
References: <20061116213038.84cc25b5.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Acked-by: James Simmons <jsimmons@infradead.org>

On Thu, 16 Nov 2006, Randy Dunlap wrote:

> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> With CONFIG_FB_SGIVW=m:
> WARNING: "sgivwfb_mem_size" [drivers/video/sgivwfb.ko] undefined!
> WARNING: "sgivwfb_mem_phys" [drivers/video/sgivwfb.ko] undefined!
> 
> (or don't allow FB_SGIVW=m in Kconfig)
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> ---
>  arch/i386/mach-visws/setup.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> --- linux-2619-rc6.orig/arch/i386/mach-visws/setup.c
> +++ linux-2619-rc6/arch/i386/mach-visws/setup.c
> @@ -6,6 +6,7 @@
>  #include <linux/smp.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
> +#include <linux/module.h>
>  
>  #include <asm/fixmap.h>
>  #include <asm/arch_hooks.h>
> @@ -142,6 +143,8 @@ void __init time_init_hook(void)
>  
>  unsigned long sgivwfb_mem_phys;
>  unsigned long sgivwfb_mem_size;
> +EXPORT_SYMBOL(sgivwfb_mem_phys);
> +EXPORT_SYMBOL(sgivwfb_mem_size);
>  
>  long long mem_size __initdata = 0;
>  
> 
> 
> ---
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
