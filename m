Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUCAJIg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 04:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbUCAJId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 04:08:33 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:19422 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S261169AbUCAJFg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 04:05:36 -0500
Message-ID: <4042FCBC.7000809@matchmail.com>
Date: Mon, 01 Mar 2004 01:05:00 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: MM VM patches was: 2.6.3-mm4
References: <20040225185536.57b56716.akpm@osdl.org> <4042F38B.8020307@matchmail.com> <4042F7E6.1050904@cyberone.com.au>
In-Reply-To: <4042F7E6.1050904@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> 
> 
> Mike Fedyk wrote:
> 
>> Andrew Morton wrote:
>>
>>> shrink_slab-for-all-zones.patch
>>>   vm: scan slab in response to highmem scanning
>>>
>>> zone-balancing-fix.patch
>>>   vmscan: zone balancing fix
>>
>>
>>
>> On 2.6.3 + [1] + nfsd-lofft.patch running on a 1GB ram file server.   
>> I have noticed two related issues.
>>
>> First, under 2.6.3 it averages about 90MB[2] anon memory, and 30MB 
>> with the -mm4 vm (the rest is in swap cache).  This could balance out 
>> on the normal non-idle week-day load though...
>>
>> Second the -mm4 vm, there is a lot more swapping[3] going on during 
>> the daily updatedb, and backup runs that are performed on this machine.
>> I'd have to call this second issue a regression, but I want to run it 
>> a couple more days to see if it gets any better (unless you agree of 
>> course).
>>
> 
> There are a few things backed out now in 2.6.4-rc1-mm1, and quite a
> few other changes. I hope we can trouble you to test 2.6.4-rc1-mm1?

Yes, I saw that, but since I wasn't using the new code, I chose to keep 
it in the "-mm4" thread. :-D

I'll backport it to 2.6.3 if it doesn't patch with "-F3"...

> Tell me, do you have highmem enabled on this system? If so, swapping

Yes, to get that extra 128MB ram. :)

> might be explained by the batching patch. With it, a small highmem
> zone could possibly place quite a lot more pressure on a large
> ZONE_NORMAL.
> 
> 2.6.4-rc1-mm1 sould do much better here.

OK, I'll give that one a shot Monday or Tuesday night.

So, I'll merge up 2.6.3 + "vm of rc1-mm1" and tell you guys what I see.

Are the graphs helpful at all?

Mike
