Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbVCHXcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbVCHXcG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 18:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbVCHXaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 18:30:22 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:35319 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262206AbVCHXXf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 18:23:35 -0500
Message-ID: <422E33F0.6020403@mvista.com>
Date: Tue, 08 Mar 2005 15:23:28 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Andrew Morton <akpm@osdl.org>, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clean up FIXME in do_timer_interrupt
References: <1109869828.2908.18.camel@mindpipe>	 <20050303164520.0c0900df.akpm@osdl.org> <1109899148.3630.5.camel@mindpipe>	 <42283857.9050007@mvista.com> <1109968985.6710.16.camel@mindpipe>	 <4228CBFB.3000602@mvista.com> <1110313644.4600.13.camel@mindpipe>
In-Reply-To: <1110313644.4600.13.camel@mindpipe>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Fri, 2005-03-04 at 12:58 -0800, George Anzinger wrote:
> 
>>Lee Revell wrote:
>>
>>>On Fri, 2005-03-04 at 02:28 -0800, George Anzinger wrote:
>>>The thing that brought this code to my attention is that with PREEMPT_RT
>>>this happens to be the longest non-preemptible code path in the kernel.
>>>On my 1.3 Ghz machine set_rtc_mmss takes about 50 usecs, combined with
>>>the rest of timer irq we end up disabling preemption for about 90 usecs.
>>>Unfortunately I don't have the trace anymore.
>>>
>>>Anyway the upshot is if we hung this off a timer it looks like we would
>>>improve the worst case latency with PREEMPT_RT by almost 50%.  Unless
>>>there is some reason it has to be done synchronously of course.
>>
>>Well, it does have to be done at the right WRT the second, but I suspect we can 
>>hit that as well with a timer as it is hit now.  Also, if we are _really_ off 
>>the mark, this can be defered till the next second.
>>
> 
> 
> Do you have a patch?

Not at the moment, but I will work one up.
> 
> Andrew merged my trivial patch to clean up the logic, but a real fix
> would be better.
> 
> Lee
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

