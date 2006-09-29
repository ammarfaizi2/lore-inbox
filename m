Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbWI2QFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbWI2QFo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 12:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbWI2QFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 12:05:44 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:23827 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932305AbWI2QFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 12:05:42 -0400
Date: Fri, 29 Sep 2006 18:05:21 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       76306.1226@compuserve.com, ebiederm@xmission.com
Subject: Re: [PATCH] fix EMBEDDED + SYSCTL menu
Message-ID: <20060929160521.GF3469@stusta.de>
References: <20060928204251.a20470c5.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060928204251.a20470c5.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2006 at 08:42:51PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> SYSCTL should still depend on EMBEDDED.  This unbreaks the
> EMBEDDED menu (from the recent SYSCTL_SYCALL menu option patch).
> 
> Fix typos in new SYSCTL_SYSCALL menu.
> 
> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> ---
>  init/Kconfig |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)
> 
> --- linux-2618-g10.orig/init/Kconfig
> +++ linux-2618-g10/init/Kconfig
> @@ -257,6 +257,9 @@ config CC_OPTIMIZE_FOR_SIZE
>  
>  	  If unsure, say N.
>  
> +config SYSCTL
> +	bool
> +
>  menuconfig EMBEDDED
>  	bool "Configure standard kernel features (for small systems)"
>  	help
> @@ -272,11 +275,8 @@ config UID16
>  	help
>  	  This enables the legacy 16-bit UID syscall wrappers.
>  
> -config SYSCTL
> -	bool
> -

ACK

>  config SYSCTL_SYSCALL
> -	bool "Sysctl syscall support"
> +	bool "Sysctl syscall support" if EMBEDDED
>  	default n
>  	select SYSCTL
>  	---help---
>...

You could achieve the same by removing the option...

Simply move SYSCTL_SYSCALL to the same place you are moving SYSCTL to 
without fiddling with the dependencies.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

