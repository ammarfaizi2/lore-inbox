Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbWA1XUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWA1XUX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 18:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWA1XUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 18:20:23 -0500
Received: from omta01ps.mx.bigpond.com ([144.140.82.153]:62407 "EHLO
	omta01ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750791AbWA1XUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 18:20:23 -0500
Message-ID: <43DBFC34.3010003@bigpond.net.au>
Date: Sun, 29 Jan 2006 10:20:20 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@google.com>
CC: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Andy Whitcroft <apw@shadowen.org>
Subject: Re: -mm seems significanty slower than mainline on kernbench
References: <43C45BDC.1050402@google.com> <43C5BD8F.3000307@bigpond.net.au> <43C5BE4A.9030105@google.com> <200601121739.17886.kernel@kolivas.org> <43D52E6F.7040808@google.com> <43D5821A.7050001@bigpond.net.au> <43D5A3F0.1000206@bigpond.net.au> <43D5AFF9.10608@google.com> <43D5C7AE.6040207@bigpond.net.au> <43D5CC4F.3000300@google.com>
In-Reply-To: <43D5CC4F.3000300@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sat, 28 Jan 2006 23:20:20 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> 
>>> Thanks, but I have that. What do you think those vertical bars on the 
>>> graph are for? ;-) They're deviation of 5 runs. I throw away the best 
>>> and worst first.
>>
>>
>>
>> Not very good scientific practice :-)
> 
> 
> 
> Bollocks to scientific practice ;-) It works, it produces very stable 
> results, has done for a few years now. Things like cron or sunspots can 
> kick in. Yes, yes, I did stats at University ... but the real world 
> doesn't work like that. The visuals in the graph speak for it.
> 
>>
>> Looking at the other 6 kernbench graphs, I see that it also occurs for 
>> elm3b70 but no others (including elm3b6 and elm3b67).  Are there any 
>> differences between the various elm3b systems that could explain this?
>>
> Yes. They're all completely different architectures - there's a brief 
> description at the top of the main page. elm3b67 should be ignored, nay 
> thrown out of the window. It's an unstable POS that randomly loses 
> processors. I've removed it from the pages.
> 
> elm3b70 is PPC64 (8 cpu)
> elm3b6 is x86_64.
> elm3b132 is a 4x SMP ia32 Pentium 3.
> moe is 16x NUMA-Q (ia32).
> gekko-lp1 is a 2x PPC blade.
> 
>>> Use the visuals in the graph .. it's very telling. -mm is *broken*.
>>> It may well not be the same issue as last time though, I shouldn't
>>> have jumped to that conclusion.
>>
>>
>>
>> It's very hard to understand how it could be an issue on a system that 
>> doesn't have a lot of abnormally niced (i.e. non zero) tasks that are 
>> fairly active as it's now mathematically equivalent to the original in 
>> the absence of such tasks.  Do these two systems have many such tasks 
>> running?
>>
>> Would it be possible to get a run with the following patches backed out:
>>
>> +sched-modified-nice-support-for-smp-load-balancing-fix.patch
>> +sched-modified-nice-support-for-smp-load-balancing-fix-fix.patch
> 
> 
> 
> Yup, that should prove or disprove it. It's probably something 
> completely un-scheduler-related ;-)
> 
> M.

Looking at the latest results for 2.6.16-rc1-mm3, it appears to me that 
this is no longer an issue.  Do you agree?

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
