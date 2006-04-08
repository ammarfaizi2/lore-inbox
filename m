Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964970AbWDHOm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964970AbWDHOm2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 10:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964971AbWDHOm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 10:42:28 -0400
Received: from [4.79.56.4] ([4.79.56.4]:50064 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S964970AbWDHOm2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 10:42:28 -0400
Subject: Re: [PATCH] Kconfig.debug: Set DEBUG_MUTEX to off by default
From: Arjan van de Ven <arjan@infradead.org>
To: tim.c.chen@linux.intel.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1144429008.25886.17.camel@localhost.localdomain>
References: <1144429008.25886.17.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 08 Apr 2006 16:42:27 +0200
Message-Id: <1144507347.2989.2.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-07 at 09:56 -0700, Tim Chen wrote:
> Hi,
> 
> DEBUG_MUTEX flag is on by default in current kernel configuration.
>  
> During performance testing, we saw mutex debug functions like
> mutex_debug_check_no_locks_freed (called by kfree()) is expensive as it
> goes through a global list of memory areas with mutex lock and do the
> checking.  For benchmarks such as Volanomark and Hackbench, we have seen
> more than 40% drop in performance on some platforms.  We suggest to set
> DEBUG_MUTEX off by default.  Or at least do that later when we feel that
> the mutex changes in the current code have stabilized.
> 
> Tim Chen
> 
> Signed-off-by: Tim Chen <tim.c.chen@intel.com>
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -101,7 +101,7 @@ config DEBUG_PREEMPT
>  
>  config DEBUG_MUTEXES
>  	bool "Mutex debugging, deadlock detection"
> -	default y
> +	default n

don't do default n, just remove the line instead ;)


