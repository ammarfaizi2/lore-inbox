Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbWE2TDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbWE2TDK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 15:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWE2TDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 15:03:09 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:40457 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751190AbWE2TDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 15:03:08 -0400
Date: Mon, 29 May 2006 21:03:07 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Chris Wedgwood <cw@f00f.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] i386: don't consider regparm EXPERIMENTAL anymore
Message-ID: <20060529190306.GD3955@stusta.de>
References: <20060520025353.GE9486@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060520025353.GE9486@taniwha.stupidest.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2006 at 07:53:53PM -0700, Chris Wedgwood wrote:
>   [This might be a tad premature given recent tail-call fixups?]
> 
> ---
> 
> Drop EXPERIMENTAL status from REGPARM as a lot of people seem to use
> it and it seems to be pretty stable these days.
> 
> 
> Signed-off-by: Chris Wedgwood <cw@f00f.org>
> 
> diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
> index 5b1a7d4..2b8657d 100644
> --- a/arch/i386/Kconfig
> +++ b/arch/i386/Kconfig
> @@ -660,8 +660,7 @@ config BOOT_IOREMAP
>  	default y
>  
>  config REGPARM
> -	bool "Use register arguments (EXPERIMENTAL)"
> -	depends on EXPERIMENTAL
> +	bool "Use register arguments"
>  	default n
>  	help
>  	Compile the kernel with -mregparm=3. This uses a different ABI

You should make such patches against -mm (or at least against a current 
Linus' tree).

The dependency on EXPERIMENTAL was removed more than two months ago in 
Linus' tree (and at the same time the default was changed to "y").

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

