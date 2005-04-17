Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261534AbVDQUo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbVDQUo4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 16:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbVDQUnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 16:43:07 -0400
Received: from waste.org ([216.27.176.166]:63374 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261527AbVDQUkv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 16:40:51 -0400
Date: Sun, 17 Apr 2005 13:40:34 -0700
From: Matt Mackall <mpm@selenic.com>
To: Adrian Bunk <bunk@stusta.de>, arjanv@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] drivers/char/random.c: #if 0 randomize_range
Message-ID: <20050417204034.GJ21897@waste.org>
References: <20050417201537.GO3625@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050417201537.GO3625@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 17, 2005 at 10:15:37PM +0200, Adrian Bunk wrote:
> This patch #if 0's the unused global function randomize_range.
>

This is presumably for future work in process randomization. Arjan,
what's the status of this bit?

> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
>  drivers/char/random.c  |    2 ++
>  include/linux/random.h |    1 -
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> --- linux-2.6.12-rc2-mm3-full/include/linux/random.h.old	2005-04-17 18:17:17.000000000 +0200
> +++ linux-2.6.12-rc2-mm3-full/include/linux/random.h	2005-04-17 18:17:23.000000000 +0200
> @@ -65,7 +65,6 @@
>  #endif
>  
>  unsigned int get_random_int(void);
> -unsigned long randomize_range(unsigned long start, unsigned long end, unsigned long len);
>  
>  #endif /* __KERNEL___ */
>  
> --- linux-2.6.12-rc2-mm3-full/drivers/char/random.c.old	2005-04-17 18:17:30.000000000 +0200
> +++ linux-2.6.12-rc2-mm3-full/drivers/char/random.c	2005-04-17 18:18:12.000000000 +0200
> @@ -1618,6 +1618,7 @@
>   * a <range> with size "len" starting at the return value is inside in the
>   * area defined by [start, end], but is otherwise randomized.
>   */
> +#if 0
>  unsigned long
>  randomize_range(unsigned long start, unsigned long end, unsigned long len)
>  {
> @@ -1627,3 +1628,4 @@
>  		return 0;
>  	return PAGE_ALIGN(get_random_int() % range + start);
>  }
> +#endif  /*  0  */

-- 
Mathematics is the supreme nostalgia of our time.
