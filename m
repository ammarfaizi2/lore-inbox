Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263451AbTCUIAV>; Fri, 21 Mar 2003 03:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263498AbTCUIAV>; Fri, 21 Mar 2003 03:00:21 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:51953 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S263451AbTCUIAT>;
	Fri, 21 Mar 2003 03:00:19 -0500
Message-ID: <3E7AC906.2020303@mvista.com>
Date: Fri, 21 Mar 2003 00:10:46 -0800
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortelnetworks.com>
CC: Joel Becker <Joel.Becker@oracle.com>, john stultz <johnstul@us.ibm.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Clock monotonic  a suggestion
References: <3E7A59CD.8040700@mvista.com> <20030321025045.GX2835@ca-server1.us.oracle.com> <3E7AA8CD.8070708@nortelnetworks.com>
In-Reply-To: <3E7AA8CD.8070708@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> Joel Becker wrote:
> 
>>     The issue for CLOCK_MONOTONIC isn't one of resolution.  The
>> issue is one of accuracy.  If the monotonic clock is ever allowed to
>> have an offset or a fudge factor, it is broken.  Asking the monotonic
>> clock for time must always, without fail, return the exact, accurate
>> time since boot (or whatever sentinal time) in the the units monotonic
>> clock is using.
> 
> 
> I thought that strictly speaking monotonic just meant that it never went 
> backwards.

That is implied by the name.  What the standard says is that it is a 
clock that is not settable and that its units are seconds and 
nanoseconds.  The standard does not say anything about returning the 
same time (which, of course is legal and possible given that the 
standard allows the resolution to be as large as 20 ms).

What I am trying to call attention to is that, if we don't base the 
clock on the NTP corrected time, the notion of a second used by 
CLOCK_MONOTONIC will not be the same as that used by CLOCK_REALTIME. 
I think this is a bad thing...

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

