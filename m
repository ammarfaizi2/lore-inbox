Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311092AbSCMUjO>; Wed, 13 Mar 2002 15:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311352AbSCMUjC>; Wed, 13 Mar 2002 15:39:02 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:46729 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S311092AbSCMUi4>; Wed, 13 Mar 2002 15:38:56 -0500
Date: Wed, 13 Mar 2002 15:38:49 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200203132038.g2DKcn520680@devserv.devel.redhat.com>
To: Erich Focht <efocht@ess.nec.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Node affine NUMA scheduler
In-Reply-To: <mailman.1016050377.26216.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.1016050377.26216.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> diff -urN 2.4.17-ia64-kdbv2.1-K3+/kernel/fork.c 2.4.17-ia64-kdbv2.1-k3z-nod9/kernel/fork.c
> --- 2.4.17-ia64-kdbv2.1-K3+/kernel/fork.c	Mon Mar  4 11:39:18 2002
> +++ 2.4.17-ia64-kdbv2.1-k3z-nod9/kernel/fork.c	Thu Mar  7 13:50:42 2002
> @@ -640,10 +640,6 @@
>  	{
>  		int i;
>  
> -		if (likely(p->cpus_allowed & (1UL<<smp_processor_id())))
> -			p->cpu = smp_processor_id();
> -		else
> -			p->cpu = __ffs(p->cpus_allowed);
>  		/* ?? should we just memset this ?? */
>  		for(i = 0; i < smp_num_cpus; i++)
>  			p->per_cpu_utime[cpu_logical_map(i)] =

OK, I am glad that we kinda converge on something common here
with ia-64 people.

-- Pete
