Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313896AbSDINZb>; Tue, 9 Apr 2002 09:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313898AbSDINZa>; Tue, 9 Apr 2002 09:25:30 -0400
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:21970 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S313896AbSDINZ3>;
	Tue, 9 Apr 2002 09:25:29 -0400
Message-ID: <3CB2EBC7.4010207@acm.org>
Date: Tue, 09 Apr 2002 08:25:27 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rob Radez <rob@osinvestor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Further WatchDog Updates
In-Reply-To: <Pine.LNX.4.33.0204090645240.17511-100000@pita.lan>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Radez wrote:

>On Mon, 8 Apr 2002, Corey Minyard wrote:
>
>>Rob Radez wrote:
>>
>>>Ok, new version of watchdog updates is up at
>>>http://osinvestor.com/bigwatchdog-4.diff
>>>
>>Could the timeout be in milliseconds?  A lot of watchdogs have lower
>>resolution, and I have written applications that require a lower
>>resolution than a second.  Milliseconds is small enough to not cause
>>problems, but big enough to give a good range of time.
>>
>
>Not in 2.4, and I wonder if that might be too fine-grained for some
>drivers which have an upper limit of 255 seconds.  I also wonder if it
>would be considered ugly to extend WDIOC_SETOPTIONS to have a
>WDIOS_TIMEINMILLI bit.
>
>Regards,
>Rob Radez
>
Why is that too fine grained?  You would just set the values from 1000 
to 255000 instead of 1 to 255, and round up.

I have a board that sets the time value in wierd times (like 225ms, 
450ms, 900ms, 1800ms, 3600ms, etc.).  I wouldn't be against the 
WDIOS_TIMEINMILLI option, but milliseconds should be good enough for anyone.

-Corey


