Return-Path: <linux-kernel-owner+w=401wt.eu-S1750990AbXAPRy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbXAPRy6 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 12:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbXAPRy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 12:54:58 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:59064 "EHLO e3.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750990AbXAPRy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 12:54:56 -0500
Date: Tue, 16 Jan 2007 09:56:48 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: [mm PATCH 6/6] RCU: trivial fixes
Message-ID: <20070116175648.GH1776@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20070115191909.GA32238@in.ibm.com> <20070115193103.GG32238@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070115193103.GG32238@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 16, 2007 at 01:01:03AM +0530, Dipankar Sarma wrote:
> 
> Fix a few trivial things based on review comments.

Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

> Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>
> 
> ---
> 
> 
> 
> diff -puN kernel/rcupreempt.c~rcu-fix-trivials kernel/rcupreempt.c
> --- linux-2.6.20-rc3-mm1-rcu/kernel/rcupreempt.c~rcu-fix-trivials	2007-01-15 15:37:00.000000000 +0530
> +++ linux-2.6.20-rc3-mm1-rcu-dipankar/kernel/rcupreempt.c	2007-01-15 15:37:00.000000000 +0530
> @@ -156,7 +156,7 @@ void __rcu_read_lock(void)
>  		local_irq_save(oldirq);
> 
>  		/*
> -		 * Outermost nesting of rcu_read_lock(), so atomically
> +		 * Outermost nesting of rcu_read_lock(), so
>  		 * increment the current counter for the current CPU.
>  		 */
>  		idx = rcu_ctrlblk.completed & 0x1;
> @@ -169,7 +169,7 @@ void __rcu_read_lock(void)
>  		 * Now that the per-CPU counter has been incremented, we
>  		 * are protected.  We can therefore safely increment
>  		 * the nesting counter, relieving further NMIs of the
> -		 * need to do so.
> +		 * need to increment the per-CPU counter.
>  		 */
>  		current->rcu_read_lock_nesting = nesting + 1;
>  		barrier();
> 
> _
