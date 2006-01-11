Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030699AbWAKDNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030699AbWAKDNa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 22:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030710AbWAKDNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 22:13:30 -0500
Received: from smtp-out.google.com ([216.239.45.12]:12059 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1030699AbWAKDNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 22:13:30 -0500
Message-ID: <43C477AD.4090308@google.com>
Date: Tue, 10 Jan 2006 19:12:45 -0800
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Peter Williams <pwil3058@bigpond.net.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: -mm seems significanty slower than mainline on kernbench
References: <43C45BDC.1050402@google.com> <200601111249.05881.kernel@kolivas.org> <43C46F99.1000902@bigpond.net.au> <200601111407.05738.kernel@kolivas.org>
In-Reply-To: <200601111407.05738.kernel@kolivas.org>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Wed, 11 Jan 2006 01:38 pm, Peter Williams wrote:
> 
>>Con Kolivas wrote:
>> > I guess we need to check whether reversing this patch helps.
>>
>>It would be interesting to see if it does.
>>
>>If it does we probably have to wear the cost (and try to reduce it) as
>>without this change smp nice support is fairly ineffective due to the
>>fact that it moves exactly the same tasks as would be moved without it.
>>  At the most it changes the frequency at which load balancing occurs.
> 
> 
> I disagree. I think the current implementation changes the balancing according 
> to nice much more effectively than previously where by their very nature, low 
> priority tasks were balanced more frequently and ended up getting their own 
> cpu. No it does not provide firm 'nice' handling that we can achieve on UP 
> configurations but it is also free in throughput terms and miles better than 
> without it. I would like to see your more robust (and nicer code) solution 
> incorporated but I also want to see it cost us as little as possible. We 
> haven't confirmed anything just yet...

Whether it turns out to be that or not ... 10% is a BIG frigging hit to 
take doing something basic like kernel compilation. Hell, 1% is a big 
hit to take, given the lengths we go to to buy that sort of benefit.

M.
