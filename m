Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751383AbWFFX7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbWFFX7l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 19:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWFFX7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 19:59:41 -0400
Received: from mail08.syd.optusnet.com.au ([211.29.132.189]:52914 "EHLO
	mail08.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751383AbWFFX7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 19:59:40 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [Patch] sched: mc/smt power savings sched policy
Date: Wed, 7 Jun 2006 09:59:08 +1000
User-Agent: KMail/1.9.3
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, nickpiggin@yahoo.com.au,
       mingo@elte.hu, pwil3058@bigpond.net.au, akpm@osdl.org
References: <20060606112521.A18026@unix-os.sc.intel.com>
In-Reply-To: <20060606112521.A18026@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606070959.09216.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 June 2006 04:25, Siddha, Suresh B wrote:
> Appended the patch. Can someone please test compile the powerpc change?
>
> thanks,
> suresh
> --
>
> sysfs entries 'sched_mc_power_savings' and 'sched_smt_power_savings' in
> /sys/devices/system/cpu/ control the MC/SMT power savings policy for
> the scheduler.
>
> Based on the values (1-enable, 0-disable) for these controls, sched groups
> cpu power will be determined for different domains. When power savings
> policy is enabled and under light load conditions, scheduler will minimize
> the physical packages/cpu cores carrying the load and thus conserving
> power(with a perf impact based on the workload characteristics... see OLS
> 2005 CMP kernel scheduler paper for more details..)

This MC code is a maze of #ifdefs within functions and getting harder to 
follow with each subsequent patch. Can we not deviate so much from kernel 
style?

-- 
-ck
