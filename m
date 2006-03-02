Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750852AbWCBWXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbWCBWXp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 17:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbWCBWXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 17:23:45 -0500
Received: from omta02ps.mx.bigpond.com ([144.140.83.154]:32204 "EHLO
	omta02ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750838AbWCBWXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 17:23:44 -0500
Message-ID: <4407706D.90604@bigpond.net.au>
Date: Fri, 03 Mar 2006 09:23:41 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       John Hawkes <hawkes@sgi.com>, Ingo Molnar <mingo@elte.hu>,
       npiggin@suse.de, "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: 2.6.16-rc5-mm1 -- strange load balancing problems
References: <20060228042439.43e6ef41.akpm@osdl.org> <4406C881.3060400@bigpond.net.au>
In-Reply-To: <4406C881.3060400@bigpond.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Thu, 2 Mar 2006 22:23:42 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> I'm seeing some strange load balancing problems with this kernel.  I 
> don't think that they're due to the smpnice patches as I've applied them 
> on a standard 2.6.15-rc5 kernel and the problem doesn't happen there.
> 
> The problem is (as I say) quite strange and (for me) very reproducible. 
>  I have two programs (aspin and gsmiley) which I use to produce CPU hard 
> spinners for testing purposes.  What I'm finding is that when I start 
> several copies of aspin load balancing goes as expected but when I 
> launch several copies of gsmiley they all go to the one CPU and stick 
> there like glue.  (The most obvious difference between the two programs 
> is that aspin is just a command line tool while gsmiley is an X windows 
> program that spins a simley face and reports its own assessment of the 
> percentage of CPU it's getting.)  The machine that I've seen this 
> problem is a hyper threading Pentium 4 and I suspect that it may be due 
> to the SCHED_MC changes which overlap SCHED_SMT a bit.
> 
> I'm trying to test this on a non hyper threading machine but the machine 
> has crashed (different kernel) while doing the build.  I'll resume this 
> effort tomorrow but I thought that I should report the problem so that 
> others could comment.
> 
> Peter
> PS SCHED_MC was configured in but I'll try it without tomorrow and 
> report the results.

Configuring SCHED_MC to "no" causes this problem to go away.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
