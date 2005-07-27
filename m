Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262015AbVG0Q7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbVG0Q7M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 12:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbVG0Q46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 12:56:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3528 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262015AbVG0Q4u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 12:56:50 -0400
Date: Wed, 27 Jul 2005 09:55:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Robert Love <rml@novell.com>
Cc: paulus@samba.org, linux-kernel@vger.kernel.org, ttb@tentacle.dhs.org
Subject: Re: [patch] inotify: ppc32 syscalls.
Message-Id: <20050727095539.602fcc4a.akpm@osdl.org>
In-Reply-To: <1122479106.21253.158.camel@betsy>
References: <1122479106.21253.158.camel@betsy>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love <rml@novell.com> wrote:
>
> Hey, Paulus,
> 
> Add inotify system call stubs to PPC32.
> 

ppc64 likes to keep its 32-bit-syscall table in sync with ppc32 so it'd be
best to do ppc64 while we're at it (both sys_call_table and
sys_call_table32)

> 
>  arch/ppc/kernel/misc.S   |    3 +++
>  include/asm-ppc/unistd.h |    5 ++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff -urN linux-2.6.13-rc3-git8/arch/ppc/kernel/misc.S linux/arch/ppc/kernel/misc.S
> --- linux-2.6.13-rc3-git8/arch/ppc/kernel/misc.S	2005-07-27 10:59:31.000000000 -0400
> +++ linux/arch/ppc/kernel/misc.S	2005-07-27 11:25:43.000000000 -0400
> @@ -1451,3 +1451,6 @@
>  	.long sys_waitid
>  	.long sys_ioprio_set
>  	.long sys_ioprio_get
> +	.long sys_inotify_init		/* 275 */
> +	.long sys_inotify_add_watch
> +	.long sys_inotify_rm_watch
> diff -urN linux-2.6.13-rc3-git8/include/asm-ppc/unistd.h linux/include/asm-ppc/unistd.h
> --- linux-2.6.13-rc3-git8/include/asm-ppc/unistd.h	2005-07-27 10:59:32.000000000 -0400
> +++ linux/include/asm-ppc/unistd.h	2005-07-27 11:25:26.000000000 -0400
> @@ -279,8 +279,11 @@
>  #define __NR_waitid		272
>  #define __NR_ioprio_set		273
>  #define __NR_ioprio_get		274
> +#define __NR_inotify_init	275
> +#define __NR_inotify_add_watch	276
> +#define __NR_inotify_rm_watch	277
>  
> -#define __NR_syscalls		275
> +#define __NR_syscalls		278
>  
>  #define __NR(n)	#n
>  
