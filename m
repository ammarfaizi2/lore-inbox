Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290763AbSBLFCe>; Tue, 12 Feb 2002 00:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290767AbSBLFCZ>; Tue, 12 Feb 2002 00:02:25 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:39608 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S290763AbSBLFCU>;
	Tue, 12 Feb 2002 00:02:20 -0500
Date: Tue, 12 Feb 2002 10:28:52 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] per-cpu areas
Message-ID: <20020212102852.I32236@in.ibm.com>
In-Reply-To: <E17wsrr-0007bD-00@wagner.rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E17wsrr-0007bD-00@wagner.rustcorp.com.au>; from rusty@rustcorp.com.au on Thu, Oct 03, 2002 at 09:25:23AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +static void __init setup_per_cpu_areas(void)
> +{
> +	unsigned long size, i;
> +	char *ptr;
> +	/* Created by linker magic */
> +	extern char __per_cpu_start[], __per_cpu_end[];
> +
> +	/* Copy section for each CPU (we discard the original) */
> +	size = ALIGN(__per_cpu_end - __per_cpu_start, SMP_CACHE_BYTES);
> +	ptr = alloc_bootmem(size * NR_CPUS);

Would it be possible to free up NR_CPUS - smp_num_cpus worth of memory 
after smp_init? .... 

Regards,
Kiran

-- 
Ravikiran G Thirumalai <kiran@in.ibm.com>
Linux Technology Center, IBM Software Labs,
Bangalore.
