Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262666AbUBZEJg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 23:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262669AbUBZEJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 23:09:36 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:34472 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S262666AbUBZEJF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 23:09:05 -0500
Message-ID: <403D7159.6060101@matchmail.com>
Date: Wed, 25 Feb 2004 20:08:57 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm3
References: <20040222172200.1d6bdfae.akpm@osdl.org>	<403BCE9E.7080607@matchmail.com> <20040224143025.36395730.akpm@osdl.org> <403D1347.8090801@matchmail.com> <403D468D.2090901@cyberone.com.au> <403D4CBE.9080805@matchmail.com> <403D5174.6050302@cyberone.com.au> <403D5B4C.3020309@matchmail.com> <403D5CB1.50409@cyberone.com.au> <403D5E79.5040508@matchmail.com> <403D6278.5010206@cyberone.com.au> <403D65D6.6050203@matchmail.com> <403D6816.1020000@cyberone.com.au>
In-Reply-To: <403D6816.1020000@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> 
> 
> Mike Fedyk wrote:
> 
>>
>> So, you think vm-shrink-slab-lowmem.patch shrinks slab too much, or 
>> Andrew's patch (IIRC, those comments were for Andrew's patch...)?
>>
> 
> Mine does.
> 

Won't Andrew's patch scan/shrink the slab more if there is more highmem 
than lowmem?

>>
>> Hmm, do you think I'd get more slab shrinking with 2.6.3 + 
>> zone-balancing-fix.patch?
>>
> 
> 
> Not really because you shouldn't be hitting the direct reclaim
> path. shrink_slab-for-all-zones.patch will help more though.

Sorry, I meant "shrink slab more than 2.6.3 with 2.6.3 + 
zone-balancing-fix.patch".

Since the zones are more balanced, there should be more lowmem scanning 
going on...
