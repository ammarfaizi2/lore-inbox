Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262896AbTCSC1A>; Tue, 18 Mar 2003 21:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262908AbTCSC1A>; Tue, 18 Mar 2003 21:27:00 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:1529 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S262896AbTCSC06>;
	Tue, 18 Mar 2003 21:26:58 -0500
Message-ID: <3E77D7DE.6090004@mvista.com>
Date: Tue, 18 Mar 2003 18:37:18 -0800
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: tim@physik3.uni-rostock.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix nanosleep() granularity bumps
References: <Pine.LNX.4.33.0303182123510.30255-100000@gans.physik3.uni-rostock.de>	<3E77D107.30406@mvista.com> <20030318203125.054b2704.akpm@digeo.com>
In-Reply-To: <20030318203125.054b2704.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> george anzinger <george@mvista.com> wrote:
> 
>>
>>
>>Here is a fix for the problem that eliminates the index from the 
>>structure.  The index ALWAYS depends on the current value of 
>>base->timer_jiffies in a rather simple way which is I exploit.  Either 
>>patch works, but this seems much simpler...
> 
> 
> Seems to be a nice change.  I think it would be better to get Tim's fix into
> Linus's tree and let your rationalisation bake for a while in -mm.
> 
> There is currently a mysterious timer lockup happening on power4 machines. 
> I'd like to keep these changes well-separated in time so we can get an
> understanding of what code changes correlate with changed behaviour.

Tell me more...
> 
> There are timer changes in Linus's post-2.5.65 tree and your patch generates
> zillions of rejects against everything.  Can you send me a diff against
> Linus's latest sometime?

Sure, possibly even tonight.

-g



> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

