Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbWEHGR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbWEHGR5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 02:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbWEHGR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 02:17:57 -0400
Received: from S010600138f6abc78.vc.shawcable.net ([24.85.144.67]:8383 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S932334AbWEHGR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 02:17:56 -0400
Date: Sun, 7 May 2006 23:17:49 -0700 (PDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Shaohua Li <shaohua.li@intel.com>
cc: lkml <linux-kernel@vger.kernel.org>, Srivatsa Vaddagiri <vatsa@in.ibm.com>,
       Ashok Raj <ashok.raj@intel.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/10] make some arch depend routines accept cpumask
In-Reply-To: <1147067142.2760.80.camel@sli10-desk.sh.intel.com>
Message-ID: <Pine.LNX.4.64.0605072317150.2496@montezuma.fsmlabs.com>
References: <1147067142.2760.80.camel@sli10-desk.sh.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 May 2006, Shaohua Li wrote:

> +int __cpuexit __cpu_disable(cpumask_t remove_mask)
>  {
>  	unsigned int cpu = smp_processor_id();
>  	struct task_struct *p;
>  	int ret;
>  
> +	BUG_ON(cpus_weight(remove_mask) != 1);
>  	ret = mach_cpu_disable(cpu);

What is this extra argument actually used for?

