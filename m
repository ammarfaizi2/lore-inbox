Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261667AbULFVnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbULFVnj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 16:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbULFVni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 16:43:38 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:15375 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261668AbULFVl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 16:41:26 -0500
Date: Mon, 6 Dec 2004 22:41:23 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Riina Kikas <riinak@ut.ee>
Cc: linux-kernel@vger.kernel.org, mroos@ut.ee
Subject: Re: [PATCH 2.6] clean-up: fixes "shadows global" warning
Message-ID: <20041206214123.GL7250@stusta.de>
References: <Pine.SOC.4.61.0412062251140.21075@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOC.4.61.0412062251140.21075@math.ut.ee>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2004 at 10:52:58PM +0200, Riina Kikas wrote:
> This patch fixes warning "declaration of `errno' shadows a global 
> declaration"
> occuring on line 102
> 
> Signed-off-by: Riina Kikas <Riina.Kikas@mail.ee>
> 
> --- a/include/linux/nfsd/export.h	2004-08-14 10:55:33.000000000 +0000
> +++ b/include/linux/nfsd/export.h	2004-10-31 19:01:15.000000000 +0000
> @@ -99,7 +99,7 @@
>  int			exp_rootfh(struct auth_domain *,
>  					char *path, struct knfsd_fh *, int 
>  					maxsize);
>  int			exp_pseudoroot(struct auth_domain *, struct svc_fh 
>  *fhp, struct cache_req *creq);
> -int			nfserrno(int errno);
> +int			nfserrno(int errno_l);
> 
>  extern void expkey_put(struct cache_head *item, struct cache_detail *cd);
>  extern void svc_export_put(struct cache_head *item, struct cache_detail 
>  *cd);

It doesn't make much sense to change the name in the prototype in the 
header file but not in the actual file.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

