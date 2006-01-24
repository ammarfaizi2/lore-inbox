Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030307AbWAXDuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030307AbWAXDuM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 22:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030317AbWAXDuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 22:50:12 -0500
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:5369 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1030307AbWAXDuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 22:50:10 -0500
Message-ID: <43D5A3F0.1000206@bigpond.net.au>
Date: Tue, 24 Jan 2006 14:50:08 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Bligh <mbligh@google.com>
CC: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Andy Whitcroft <apw@shadowen.org>
Subject: Re: -mm seems significanty slower than mainline on kernbench
References: <43C45BDC.1050402@google.com> <43C5BD8F.3000307@bigpond.net.au> <43C5BE4A.9030105@google.com> <200601121739.17886.kernel@kolivas.org> <43D52E6F.7040808@google.com> <43D5821A.7050001@bigpond.net.au>
In-Reply-To: <43D5821A.7050001@bigpond.net.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 24 Jan 2006 03:50:08 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Martin Bligh wrote:
> 
>>
>>> Thanks and looks like the results are in from 2.6.14-rc2-mm1 with the 
>>> patch backed out.
>>>
>>> Drumroll....
>>>
>>> http://test.kernel.org/perf/kernbench.moe.png
>>>
>>> The performance goes back to a range similar to 2.6.14-rc1-mm1 (see 
>>> 2.6.14-rc2-mm1 + 20328 in blue). Unfortunately this does implicate 
>>> this patch. Can we put it back into -mm only and allow Peter's 
>>> tweaks/fixes to go on top and have it tested some more before going 
>>> upstream?
>>
>>
>>
>> Hmm. Looks like we didn't get this as fixed up as I thought. Moe seems 
>> to be fixed (16x NUMA-Q), but elm3b132 is not (it's 4x, flat SMP ia32).
>> Look at the latest graphs ....
>>
>> Is it possible it only got fixed for NUMA boxes?
> 
> 
> It should be totally independent.
> 
> But anyhow, I can't see the problem.  The only numbers that I can see 
> for 2.6.16-rc1-mm[1|2] (which are the ones with the latest fix) on this 
> graph are approx. 101 which is much the same as the best of the rest. Or 
> have I missed something?

Oops.  I was looking at the graphs for Moe but 
<http://test.kernel.org/perf/dbench.elm3b132.png> doesn't appear to be 
demonstrating a problem either.  Given the fluctuation in the 2.6.16-rc1 
results (235, 234, 211, 228.5 and 237.5), the results for 2.6.16-rc1-mm1 
(229) and 2.6.16-mm2 (219) aren't significantly different.

Peter
PS I have a modification for kernbench that calculates and displays the 
standard deviations for the various averages if you're interested.  This 
would enable you to display 95% (say) confidence bars on the graphed 
results which in turn makes it easier to spot significant differences.
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
