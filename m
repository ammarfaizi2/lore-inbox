Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261664AbULFVjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbULFVjK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 16:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbULFVjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 16:39:10 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:7183 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261664AbULFVjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 16:39:03 -0500
Date: Mon, 6 Dec 2004 22:38:59 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Riina Kikas <riinak@ut.ee>
Cc: linux-kernel@vger.kernel.org, mroos@ut.ee
Subject: Re: [PATCH 2.6] clean-up: fixes "shadows global", "unused parameter" warnings
Message-ID: <20041206213859.GK7250@stusta.de>
References: <Pine.SOC.4.61.0412062253040.21075@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOC.4.61.0412062253040.21075@math.ut.ee>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2004 at 10:55:11PM +0200, Riina Kikas wrote:
> This patch fixes warnings "declaration of `prefetch' shadows a global 
> declaration"
> (occuring on line 141) and "unused parameter `addr'" (occuring on line 136)
> 
> Signed-off-by: Riina Kikas <Riina.Kikas@mail.ee>
> 
> --- a/arch/i386/mm/fault.c	2004-12-02 21:30:30.000000000 +0000
> +++ b/arch/i386/mm/fault.c	2004-12-02 21:30:59.000000000 +0000
> @@ -133,12 +133,12 @@
>   * Sometimes AMD Athlon/Opteron CPUs report invalid exceptions on prefetch.
>   * Check that here and ignore it.
>   */
> -static int __is_prefetch(struct pt_regs *regs, unsigned long addr)
> +static int __is_prefetch(struct pt_regs *regs)
>...
>  static inline int is_prefetch(struct pt_regs *regs, unsigned long 

I wonder how this patch compiled for you considering that you didn't 
change the call to __is_prefetch in is_prefetch...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

