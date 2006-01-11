Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750844AbWAKVmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbWAKVmO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 16:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbWAKVmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 16:42:14 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:11783 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750844AbWAKVmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 16:42:13 -0500
Date: Wed, 11 Jan 2006 22:42:12 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH -mm] mm/rmap.c: don't forget to include module.h
Message-ID: <20060111214212.GF29663@stusta.de>
References: <20060111042135.24faf878.akpm@osdl.org> <20060111165758.GH8686@mipter.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060111165758.GH8686@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 07:57:58PM +0300, Alexey Dobriyan wrote:
>   CC      mm/rmap.o
> mm/rmap.c:235: warning: type defaults to `int' in declaration of `EXPORT_SYMBOL'
> mm/rmap.c:235: warning: parameter names (without types) in function declaration
> mm/rmap.c:235: warning: data definition has no type or storage class
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  mm/rmap.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> --- linux-2.6.15-mm3/mm/rmap.c	2006-01-11 19:42:39.000000000 +0300
> +++ linux-2.6.15-mm3-rmap/mm/rmap.c	2006-01-11 19:48:12.000000000 +0300
> @@ -52,6 +52,9 @@
>  #include <linux/init.h>
>  #include <linux/rmap.h>
>  #include <linux/rcupdate.h>
> +#ifdef CONFIG_MIGRATION
> +#include <linux/module.h>
> +#endif
>...

There's no need for an #ifdef.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

