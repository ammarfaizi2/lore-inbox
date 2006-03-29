Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbWC2Xlo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbWC2Xlo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 18:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbWC2Xlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 18:41:44 -0500
Received: from fmr19.intel.com ([134.134.136.18]:25313 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751280AbWC2Xln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 18:41:43 -0500
Message-ID: <442B14A5.4040606@linux.intel.com>
Date: Wed, 29 Mar 2006 15:13:41 -0800
From: Tim Chen <tim.c.chen@linux.intel.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: smpnice try to wakeup modification
References: <4429F5AC.4000103@linux.intel.com> <442B0F10.9000606@bigpond.net.au>
In-Reply-To: <442B0F10.9000606@bigpond.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Tim Chen wrote:
>> Peter,
>>
>> If there is no load on this_cpu, (i.e. tl_per_task is 0), we will 
>> fail the  "tl + target_load(cpu, idx) <= tl_per_task" check.
>
> This isn't the case.  If this_cpu is idle tl_per_task will be set to 
> SCHED_LOAD_SCALE (see implementation of cpu_avg_load_per_task()) and 
> that expression should succeed unless the value returned by 
> target_load(cpu, idx) is bigger than SCHED_LOAD_SCALE.  This is 
> exactly the same as would have happened with the original code.
>
> (BTW cpu_avg_load_per_task()'s original implementation would have had 
> the effect you describe but it was modified when it was realized that 
> it would break the code in a lot of places (not just here).  The 
> thinking now is that if there isn't enough data available to calculate 
> the average load per task for a run queue then the correct value to 
> use is the theoretical average i.e. SCHED_LOAD_SCALE.)
>
Ah, I was looking at the original smpnice patch.  Thanks for clarifying.

Tim

