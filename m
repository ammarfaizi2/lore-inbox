Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964951AbWDDBaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964951AbWDDBaB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 21:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964933AbWDDBaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 21:30:01 -0400
Received: from omta03sl.mx.bigpond.com ([144.140.92.155]:4532 "EHLO
	omta03sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S964951AbWDDBaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 21:30:00 -0400
Message-ID: <4431CC12.8060707@bigpond.net.au>
Date: Tue, 04 Apr 2006 11:29:54 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux-kernel@vger.kernel.org, Al Boldi <a1426z@gawab.com>
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.3.1 for  2.6.16-rc5
References: <200604031459.51542.a1426z@gawab.com> <200604040929.48198.kernel@kolivas.org> <4431B756.3080101@bigpond.net.au> <200604041012.04591.kernel@kolivas.org>
In-Reply-To: <200604041012.04591.kernel@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 4 Apr 2006 01:29:54 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Tuesday 04 April 2006 10:01, Peter Williams wrote:
>> Con Kolivas wrote:
>>> On Tuesday 04 April 2006 09:04, Peter Williams wrote:
>>>> Al Boldi wrote:
>>>>> Also, different schedulers per cpu could be rather useful.
>>>>> Peter Williams wrote:
>>>> I think that would be dangerous.  However, different schedulers per
>>>> cpuset might make sense but it involve a fair bit of work.
>>> I'm curious. How do you think different schedulers per cpu would be
>>> useful?
>> I don't but I think they MIGHT make sense for cpusets e.g. one set with
>> a scheduler targeted at interactive tasks and another targeted at server
>> tasks.  NB the emphasis on might.
> 
> I am curious as to Al's answer since he asked for the feature.

OK.

> It would be 
> easy for me to modify the staircase cpu scheduler to allow the interactive 
> and compute modes be set on a per-cpu basis if that was desired.  For that to
> be helpful of course you'd have to manually set affinity for the tasks or 
> logins you wanted to run on each cpu(s).

Yes, I agree that it would not be a good idea for CPUs that are sharing 
(via load balancing) the same set of tasks to have different schedulers 
or policy which is why I suggested only doing it at the cpuset level.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
