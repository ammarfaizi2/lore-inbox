Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262676AbUBZD0G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 22:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262698AbUBZDZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 22:25:08 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:6397 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S262676AbUBZDUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 22:20:00 -0500
Message-ID: <403D65D6.6050203@matchmail.com>
Date: Wed, 25 Feb 2004 19:19:50 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm3
References: <20040222172200.1d6bdfae.akpm@osdl.org>	<403BCE9E.7080607@matchmail.com> <20040224143025.36395730.akpm@osdl.org> <403D1347.8090801@matchmail.com> <403D468D.2090901@cyberone.com.au> <403D4CBE.9080805@matchmail.com> <403D5174.6050302@cyberone.com.au> <403D5B4C.3020309@matchmail.com> <403D5CB1.50409@cyberone.com.au> <403D5E79.5040508@matchmail.com> <403D6278.5010206@cyberone.com.au>
In-Reply-To: <403D6278.5010206@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> 
> 
> Mike Fedyk wrote:
> 
>> Nick Piggin wrote:
>>
>>>
>>>
>>> Mike Fedyk wrote:
>>>
>>>>
>>>> OK, I'll give that a try.
>>>>
>>>> Is the attached patch the latest version of your alternative patch 
>>>> instead of shrink_slab-for-all-zones.patch?
>>>>
>>>
>>> Yes that looks like it. I am actually starting to like this patch
>>> again 
>>
>>
>>
>> Didn't you like what you wrote in the first place ;)
>>
> 
> Hmm well no, it still reclaims slab too hard. I just forgot
> why I didn't like it :P

So, you think vm-shrink-slab-lowmem.patch shrinks slab too much, or 
Andrew's patch (IIRC, those comments were for Andrew's patch...)?

> 
>>> now that lowmem is being properly scanned as a result of
>>> highmem scanning.
>>
>>
>>
>> That's what zone-balancing-fix.patch does, right?
>>
> 
> Yes... but actually the kswapd path needs something similar.
> That would be the batching patch, but with a scanning value
> derived from the current size of the zone's lrus.
> 
> I'd just stick with 2.6.3 for now :)

Hmm, do you think I'd get more slab shrinking with 2.6.3 + 
zone-balancing-fix.patch?

Mike
