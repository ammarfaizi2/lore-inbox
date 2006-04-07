Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbWDGClV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbWDGClV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 22:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbWDGClU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 22:41:20 -0400
Received: from mail.tmr.com ([64.65.253.246]:45491 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S932294AbWDGClU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 22:41:20 -0400
Message-ID: <4435D2CE.9080708@tmr.com>
Date: Thu, 06 Apr 2006 22:47:42 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Boldi <a1426z@gawab.com>
CC: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org,
       linux-smp@vger.kernel.org, Mike Galbraith <efault@gmx.de>
Subject: Re: [RFC] sched.c : procfs tunables
References: <200603311723.49049.a1426z@gawab.com> <200604031459.43105.a1426z@gawab.com> <200604032221.32461.kernel@kolivas.org> <200604041627.19903.a1426z@gawab.com>
In-Reply-To: <200604041627.19903.a1426z@gawab.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:

>Con Kolivas wrote:
>  
>
>>On Monday 03 April 2006 21:59, Al Boldi wrote:
>>    
>>
>>>Con Kolivas wrote:
>>>      
>>>
>>>>None of the current "tunables" have easily understandable heuristics.
>>>>Even those that appear to be obvious, like timselice, are not. While
>>>>exporting tunables is not a bad idea, exporting tunables that noone
>>>>understands is not really helpful.
>>>>        
>>>>
>>>Couldn't this be fixed with an autotuning module based on cpu/mem/ctxt
>>>performance?
>>>      
>>>
>>You're assuming there is some meaningful relationship between changes in
>>cpu/mem/ctxt performance and these tunables, which isn't the case.
>>Furthermore if this was the case, noone understands it, can predict it or
>>know how to tune it. Just saying "autotune it" doesn't really tell us how
>>exactly the change those tunables in relation to the other variables.
>>Since Mike and I understand them reasonably well I think we'd both agree
>>that there is no meaningful association.
>>    
>>
>
>After playing w/ these tunables it occurred to me that they are really only 
>deadline limits, w/ a direct relation to cpu/mem/ctxt perf.
>
>i.e timeslice=1 on i386sx means something other than timeslice=1 on amd64
>
>It follows that w/o autotuning, the static default values have to be selected 
>to allow for a large underlying perf range w/ a preference for the high 
>range.  This is also the reason why 2.6 feels really crummy on low perf 
>ranges.
>  
>
Actually the lower HZ has something to do with that, and tuning 
swappiness can also help a lot.

>Autotuning the default values would allow to tighten this range specific to 
>the hw used, thus allowing for a smoother desktop experience.
>
-- 

bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

