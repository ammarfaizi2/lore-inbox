Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265553AbUBGAdX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 19:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265596AbUBGAdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 19:33:23 -0500
Received: from mail-07.iinet.net.au ([203.59.3.39]:29381 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265553AbUBGAdV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 19:33:21 -0500
Message-ID: <402431C5.3030205@cyberone.com.au>
Date: Sat, 07 Feb 2004 11:31:01 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Rick Lindsley <ricklind@us.ibm.com>, Anton Blanchard <anton@samba.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, dvhltc@us.ibm.com
Subject: Re: [PATCH] Load balancing problem in 2.6.2-mm1
References: <200402062311.i16NBdF14365@owlet.beaverton.ibm.com> <40242152.5030606@cyberone.com.au> <231480000.1076110387@flay> <4024261E.5070702@cyberone.com.au> <232690000.1076111266@flay> <40242D14.6070908@cyberone.com.au> <242810000.1076113505@flay>
In-Reply-To: <242810000.1076113505@flay>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Martin J. Bligh wrote:

>>>Not sure how true that turns out to be in practice ... probably depends
>>>heavily on both the workload (how heavily it's using the cache) and the
>>>chip (larger caches have proportionately more to lose).
>>>
>>>As we go forward in time, cache warmth gets increasingly important, as
>>>CPUs accelerate speeds quicker than memory. Cache sizes also get larger.
>>>I'd really like us to be conservative here - the unfairness thing is 
>>>really hard to hit anyway - you need a static number of processes that
>>>don't ever block on IO or anything.
>>>
>>Can we keep current behaviour default, and if arches want to
>>override it they can? And if someone one day does testing to
>>show it really isn't a good idea, then we can change the default.
>>
>
>Well, that should be a pretty easy test to do. I'll try it.
>
>

OK, use the revision of Rick's patch I posted, and don't use
CONFIG_SCHED_SMT because I think there is a problem with it.

Thanks
Nick

