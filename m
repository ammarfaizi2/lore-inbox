Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbWEHHUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbWEHHUN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 03:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbWEHHUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 03:20:12 -0400
Received: from mga02.intel.com ([134.134.136.20]:13873 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932360AbWEHHUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 03:20:11 -0400
X-IronPort-AV: i="4.05,100,1146466800"; 
   d="scan'208"; a="32978701:sNHT39965338"
Subject: Re: [PATCH 2/10] make some arch depend routines accept cpumask
From: Shaohua Li <shaohua.li@intel.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>, Srivatsa Vaddagiri <vatsa@in.ibm.com>,
       Ashok Raj <ashok.raj@intel.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605072317150.2496@montezuma.fsmlabs.com>
References: <1147067142.2760.80.camel@sli10-desk.sh.intel.com>
	 <Pine.LNX.4.64.0605072317150.2496@montezuma.fsmlabs.com>
Content-Type: text/plain
Date: Mon, 08 May 2006 15:18:56 +0800
Message-Id: <1147072736.2760.95.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-05-07 at 23:17 -0700, Zwane Mwaikambo wrote:
> On Mon, 8 May 2006, Shaohua Li wrote:
> 
> > +int __cpuexit __cpu_disable(cpumask_t remove_mask)
> >  {
> >  	unsigned int cpu = smp_processor_id();
> >  	struct task_struct *p;
> >  	int ret;
> >  
> > +	BUG_ON(cpus_weight(remove_mask) != 1);
> >  	ret = mach_cpu_disable(cpu);
> 
> What is this extra argument actually used for?
Next patches will use it. Here we just want to make compilation work.

Thanks,
Shaohua
