Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264660AbUHQJ4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264660AbUHQJ4M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 05:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264701AbUHQJ4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 05:56:12 -0400
Received: from ozlabs.org ([203.10.76.45]:17315 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264660AbUHQJ4F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 05:56:05 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Tim Bird <tim.bird@am.sony.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Cc: Adam Kropelin <akropel1@rochester.rr.com>
Subject: Re: [PATCH] - trivial comment fixups in init/main.c 
In-reply-to: Your message of "Tue, 13 Jul 2004 11:39:00 MST."
             <40F42C44.5010603@am.sony.com> 
Date: Tue, 17 Aug 2004 19:53:51 +1000
Message-Id: <20040817095601.4E7F22BEC3@ozlabs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <40F42C44.5010603@am.sony.com> you write:
> This patch has some trivial comment fixups for init/main.c, to bring
> the comments into consistency with the coding style of the kernel.

Personally, I prefer my comments quiet and unobtrusive, and I think
you'll find Linus' code tends to be the same.

Not to start a flame war, but since I started using a colorizing
editor for code, I found there was no need to waste vertical space
with large banners.  (This in my mind justifies the X project's entire
existence).

Sorry,
Rusty.

> diff -u -X /home/tbird/dontdiff -ruN linux-2.6.7.orig/init/main.c patch5/init/main.c
> --- linux-2.6.7.orig/init/main.c	2004-06-15 22:19:01.000000000 -0700
> +++ patch5/init/main.c	2004-07-12 12:34:55.000000000 -0700
> @@ -238,8 +264,10 @@
>   __setup("debug", debug_kernel);
>   __setup("quiet", quiet_kernel);
> 
> -/* Unknown boot options get handed to init, unless they look like
> -   failed parameters */
> +/*
> + * Unknown boot options get handed to init, unless they look like
> + * failed parameters
> + */
>   static int __init unknown_bootoption(char *param, char *val)
>   {
>   	/* Change NUL term back to "=", to make "param" the whole string. */
> @@ -250,8 +278,10 @@
>   	if (obsolete_checksetup(param))
>   		return 0;
> 
> -	/* Preemptive maintenance for "why didn't my mispelled command
> -           line work?" */
> +	/*
> +	 * Preemptive maintenance for "why didn't my mispelled command
> +	 * line work?"
> +	 */
>   	if (strchr(param, '.') && (!val || strchr(param, '.') < val)) {
>   		printk(KERN_ERR "Unknown boot option `%s': ignoring\n", param);
>   		return 0;
> @@ -289,7 +319,8 @@
>   	unsigned int i;
> 
>   	execute_command = str;
> -	/* In case LILO is going to boot us with default command line,
> +	/*
> +	 * In case LILO is going to boot us with default command line,
>   	 * it prepends "auto" before the whole cmdline which makes
>   	 * the shell think it should execute a script with such name.
>   	 * So we ignore all arguments entered _before_ init=... [MJ]
> @@ -483,9 +514,9 @@
>   	check_bugs();
> 
>   	/*
> -	 *	We count on the initial thread going ok
> -	 *	Like idlers init is an unlocked kernel thread, which will
> -	 *	make syscalls (and thus be locked).
> +	 * We count on the initial thread going ok
> +	 * Like idlers init is an unlocked kernel thread, which will
> +	 * make syscalls (and thus be locked).
>   	 */
>   	init_idle(current, smp_processor_id());
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
