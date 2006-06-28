Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751439AbWF1USY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbWF1USY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 16:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbWF1USV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 16:18:21 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:10917 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751439AbWF1USN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 16:18:13 -0400
Date: Wed, 28 Jun 2006 13:18:50 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] kernel/rcutorture.c: make code static
Message-ID: <20060628201850.GA2553@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060627015211.ce480da6.akpm@osdl.org> <20060628165445.GQ13915@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060628165445.GQ13915@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2006 at 06:54:45PM +0200, Adrian Bunk wrote:
> This patch makes needlessly global code static.

OK, ran a short test which passed on i386.  So we are set.

						Thanx, Paul

Acked-by: Paul E. McKenney <paulmck@us.ibm.com>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
>  kernel/rcutorture.c |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> --- linux-2.6.17-mm3-full/kernel/rcutorture.c.old	2006-06-27 17:59:20.000000000 +0200
> +++ linux-2.6.17-mm3-full/kernel/rcutorture.c	2006-06-27 18:01:00.000000000 +0200
> @@ -105,11 +105,11 @@
>  static DEFINE_PER_CPU(long [RCU_TORTURE_PIPE_LEN + 1], rcu_torture_batch) =
>  	{ 0 };
>  static atomic_t rcu_torture_wcount[RCU_TORTURE_PIPE_LEN + 1];
> -atomic_t n_rcu_torture_alloc;
> -atomic_t n_rcu_torture_alloc_fail;
> -atomic_t n_rcu_torture_free;
> -atomic_t n_rcu_torture_mberror;
> -atomic_t n_rcu_torture_error;
> +static atomic_t n_rcu_torture_alloc;
> +static atomic_t n_rcu_torture_alloc_fail;
> +static atomic_t n_rcu_torture_free;
> +static atomic_t n_rcu_torture_mberror;
> +static atomic_t n_rcu_torture_error;
>  
>  /*
>   * Allocate an element from the rcu_tortures pool.
> @@ -338,7 +338,7 @@
>  	}
>  }
>  
> -int srcu_torture_stats(char *page)
> +static int srcu_torture_stats(char *page)
>  {
>  	int cnt = 0;
>  	int cpu;
> @@ -567,7 +567,7 @@
>  /* Shuffle tasks such that we allow @rcu_idle_cpu to become idle. A special case
>   * is when @rcu_idle_cpu = -1, when we allow the tasks to run on all CPUs.
>   */
> -void rcu_torture_shuffle_tasks(void)
> +static void rcu_torture_shuffle_tasks(void)
>  {
>  	cpumask_t tmp_mask = CPU_MASK_ALL;
>  	int i;
> 
