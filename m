Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267243AbSKPHKG>; Sat, 16 Nov 2002 02:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267245AbSKPHKG>; Sat, 16 Nov 2002 02:10:06 -0500
Received: from takibi.datarithm.net ([64.81.244.37]:31542 "EHLO takibi.rmr")
	by vger.kernel.org with ESMTP id <S267243AbSKPHKE>;
	Sat, 16 Nov 2002 02:10:04 -0500
Date: Fri, 15 Nov 2002 23:16:34 -0800
From: Robert Read <rread@clusterfs.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, braam@clusterfs.com,
       intermezzo-discuss@lists.sourceforge.net,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-rc2
Message-ID: <20021115231634.B21156@datarithm.net>
Mail-Followup-To: Robert Read <rread@clusterfs.com>,
	Adrian Bunk <bunk@fs.tum.de>,
	Marcelo Tosatti <marcelo@conectiva.com.br>, braam@clusterfs.com,
	intermezzo-discuss@lists.sourceforge.net,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L.0211151309400.11268-100000@freak.distro.conectiva> <20021115230426.GC10408@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20021115230426.GC10408@fs.tum.de>; from bunk@fs.tum.de on Sat, Nov 16, 2002 at 12:04:26AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is obviously correct and has been applied to our
tree.  It would be great it was applied to 2.4.20-rc2.

robert

* Adrian Bunk (bunk@fs.tum.de) [021115 15:19]:
> I got the following error at the final linking of 2.4.20-rc2:
> 
> <--   snip  -->
> 
> ...
>         -o vmlinux
> fs/fs.o(.text+0x53bc3): In function `presto_free_cache':
> : undefined reference to `presto_dentry_slab'
> make: *** [vmlinux] Error 1
> 
> <--  snip  -->
> 
> 
> K S Sreeram <sreeram@tachyontech.net> proposed the following patch two
> weeks ago:
> 
> --- a/fs/intermezzo/dcache.c	Mon Oct 21 10:56:57 2002
> +++ b/fs/intermezzo/dcache.c	Mon Oct 21 10:56:57 2002
> @@ -48,7 +48,7 @@
>  
>  #include <linux/intermezzo_fs.h>
>  
> -static kmem_cache_t * presto_dentry_slab;
> +kmem_cache_t * presto_dentry_slab;
>  
>  /* called when a cache lookup succeeds */
>  static int presto_d_revalidate(struct dentry *de, int flag)
> 
> 
> 
> cu
> Adrian
> 
> -- 
> 
>        "Is there not promise of rain?" Ling Tan asked suddenly out
>         of the darkness. There had been need of rain for many days.
>        "Only a promise," Lao Er said.
>                                        Pearl S. Buck - Dragon Seed
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by: To learn the basics of securing 
> your web site with SSL, click here to get a FREE TRIAL of a Thawte 
> Server Certificate: http://www.gothawte.com/rd524.html
> _______________________________________________
> intermezzo-discuss mailing list
> intermezzo-discuss@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/intermezzo-discuss
