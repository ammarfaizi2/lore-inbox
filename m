Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269094AbTCBDBL>; Sat, 1 Mar 2003 22:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269099AbTCBDBK>; Sat, 1 Mar 2003 22:01:10 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:53006 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S269094AbTCBDBI>; Sat, 1 Mar 2003 22:01:08 -0500
Date: Sat, 1 Mar 2003 19:11:19 -0800
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Cc: Hugo Mills <hugo-lkml@carfax.org.uk>
Subject: Re: [PATCH] More spelling fixes: loose->lose
Message-ID: <20030302031119.GB30797@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org, Hugo Mills <hugo-lkml@carfax.org.uk>
References: <20030301202807.GA24998@carfax.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030301202807.GA24998@carfax.org.uk>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 01, 2003 at 08:28:07PM +0000, Hugo Mills wrote:
>    Loose, pronounced with a soft "s", as in the word "spelling", means
> badly-fitting or vague.

Actually it means "not tight" or unconstrained as in "loosen
the collar and check airflow before performing
mouth-to-mouth" or "let loose the dogs"

In actual usage loose and lose can be antonyms when
referring to priveleges.  "loose privs" vs "lose privs".

I found at least one case of correction that looked wrong so
i perused the lot, see comments.

> diff -ur linux-2.5.63-orig/arch/ia64/kernel/perfmon.c linux-2.5.63/arch/ia64/kernel/perfmon.c
> --- linux-2.5.63-orig/arch/ia64/kernel/perfmon.c	2003-03-01 16:19:41.000000000 +0000
> +++ linux-2.5.63/arch/ia64/kernel/perfmon.c	2003-03-01 19:55:03.000000000 +0000
> @@ -2995,7 +2995,7 @@
>  		 * interruptible). In this case, the PMU will be kept frozen and the process will 
>  		 * run to completion without monitoring enabled.
>  		 *
> -		 * Of course, we cannot loose notify process when self-monitoring.
> +		 * Of course, we cannot lose notify process when self-monitoring.

This might have been "loosely notify" but careful examination of the
context idicates it should be "lose notification process" or
"lose the notify process". 

> diff -ur linux-2.5.63-orig/drivers/scsi/atari_NCR5380.c linux-2.5.63/drivers/scsi/atari_NCR5380.c
> --- linux-2.5.63-orig/drivers/scsi/atari_NCR5380.c	2003-01-09 04:04:16.000000000 +0000
> +++ linux-2.5.63/drivers/scsi/atari_NCR5380.c	2003-03-01 20:05:24.000000000 +0000
> @@ -2953,7 +2953,7 @@
>       * on any queue, so they won't be retried ...
>       *
>       * Conclusion: either scsi.c disables timeout for all resetted commands

[OT] Past tense of the verb reset is reset, not resetted.

> -     * immediately, or we loose!  As of linux-2.0.20 it doesn't.
> +     * immediately, or we lose!  As of linux-2.0.20 it doesn't.
>       */
>  
>      /* After the reset, there are no more connected or disconnected commands

> diff -ur linux-2.5.63-orig/include/asm-mips/processor.h linux-2.5.63/include/asm-mips/processor.h
> --- linux-2.5.63-orig/include/asm-mips/processor.h	2003-01-09 04:03:50.000000000 +0000
> +++ linux-2.5.63/include/asm-mips/processor.h	2003-03-01 20:11:23.000000000 +0000
> @@ -228,7 +228,7 @@
>   * Do necessary setup to start up a newly executed thread.
>   */
>  #define start_thread(regs, new_pc, new_sp) do {				\
> -	/* New thread looses kernel privileges. */			\
> +	/* New thread loses kernel privileges. */			\

Good catch.  We don't want "New thread loosens kernel privileges."

>  	regs->cp0_status = (regs->cp0_status & ~(ST0_CU0|ST0_KSU)) | KU_USER;\
>  	regs->cp0_epc = new_pc;						\
>  	regs->regs[29] = new_sp;					\
> diff -ur linux-2.5.63-orig/include/asm-mips64/processor.h linux-2.5.63/include/asm-mips64/processor.h
> --- linux-2.5.63-orig/include/asm-mips64/processor.h	2003-01-09 04:04:14.000000000 +0000
> +++ linux-2.5.63/include/asm-mips64/processor.h	2003-03-01 20:10:46.000000000 +0000
> @@ -256,7 +256,7 @@
>  do {									\
>  	unsigned long __status;						\
>  									\
> -	/* New thread looses kernel privileges. */			\
> +	/* New thread loses kernel privileges. */			\
>  	__status = regs->cp0_status & ~(ST0_CU0|ST0_FR|ST0_KSU);	\
>  	__status |= KSU_USER;						\
>  	__status |= (current->thread.mflags & MF_32BIT) ? 0 : ST0_FR;	\

> diff -ur linux-2.5.63-orig/include/linux/securebits.h linux-2.5.63/include/linux/securebits.h
> --- linux-2.5.63-orig/include/linux/securebits.h	2003-01-09 04:03:56.000000000 +0000
> +++ linux-2.5.63/include/linux/securebits.h	2003-03-01 20:10:11.000000000 +0000
> @@ -14,7 +14,7 @@
>  #define SECURE_NOROOT            0
>  
>  /* When set, setuid to/from uid 0 does not trigger capability-"fixes"
> -   to be compatible with old programs relying on set*uid to loose
> +   to be compatible with old programs relying on set*uid to lose
>     privileges. When unset, setuid doesn't change privileges. */

Youch,  Meaning inversion.




-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
