Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWDOXGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWDOXGm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 19:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbWDOXGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 19:06:42 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:62992 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932161AbWDOXGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 19:06:42 -0400
Date: Sun, 16 Apr 2006 01:06:40 +0200
From: Adrian Bunk <bunk@stusta.de>
To: "Martin J. Bligh" <mbligh@google.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Default CONFIG_DEBUG_MUTEXES to n
Message-ID: <20060415230640.GP15022@stusta.de>
References: <44417792.2070900@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44417792.2070900@google.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 15, 2006 at 03:45:38PM -0700, Martin J. Bligh wrote:
> CONFIG_DEBUG_MUTEXES has a significant performant impact (reduced perf
> of reaim by 50% on ia32 NUMA boxes). It should not be on by default.
> 
> Signed-off-by: Martin J. Bligh <mbligh@google.com>
> 
> 

> diff -aurpN -X /home/mbligh/.diff.exclude linux-2.6.17-rc1/lib/Kconfig.debug 2.6.17-rc1_no_mutex_dbg/lib/Kconfig.debug
> --- linux-2.6.17-rc1/lib/Kconfig.debug	2006-04-15 15:28:54.000000000 -0700
> +++ 2.6.17-rc1_no_mutex_dbg/lib/Kconfig.debug	2006-04-15 15:44:14.000000000 -0700
> @@ -101,7 +101,7 @@ config DEBUG_PREEMPT
>  
>  config DEBUG_MUTEXES
>  	bool "Mutex debugging, deadlock detection"
> -	default y
> +	default n
>...
>  config DEBUG_SPINLOCK
>  	bool "Spinlock debugging"
> +	default n
>...

"default n" has no effect and can be removed.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

