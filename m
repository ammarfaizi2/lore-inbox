Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVAFXDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVAFXDv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 18:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263070AbVAFXCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 18:02:05 -0500
Received: from ip-66-80-14-114.dsl.sca.megapath.net ([66.80.14.114]:3051 "EHLO
	h3c.com") by vger.kernel.org with ESMTP id S263060AbVAFW5k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 17:57:40 -0500
Message-ID: <41DDC25C.2040404@h3c.com>
Date: Thu, 06 Jan 2005 14:57:32 -0800
From: Mike Hardy <mhardy@h3c.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <juhl-lkml@dif.dk>
CC: Andrew Walrond <andrew@walrond.org>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: No swap can be dangerous (was Re: swap on RAID (was Re: swp -
 Re: ext3 journal on software raid))
References: <41DC9420.5030701@h3c.com> <20050106093811.GB99565@caffreys.strugglers.net> <41DD798F.8030902@h3c.com> <200501062208.39563.andrew@walrond.org> <Pine.LNX.4.61.0501062333260.3430@dragon.hygekrogen.localhost>
In-Reply-To: <Pine.LNX.4.61.0501062333260.3430@dragon.hygekrogen.localhost>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jesper Juhl wrote:
> On Thu, 6 Jan 2005, Andrew Walrond wrote:
> 
> 
>>On Thursday 06 January 2005 17:46, Mike Hardy wrote:
>>
>>>You are correct that I was getting at the zero swap argument - and I
>>>agree that it is vastly different from simply not expecting it. It is
>>>important to know that there is no inherent need for swap in the kernel
>>>though - it is simply used as more "memory" (albeit slower, and with
>>>some optimizations to work better with real memory) and if you don't
>>>need it, you don't need it.
>>>
>>
>>If I recollect a recent thread on LKML correctly, your 'no inherent need for 
>>swap' might be wrong.
>>
>>I think the gist was this: the kernel can sometimes needs to move bits of 
>>memory in order to free up dma-able ram, or lowmem. If I recall correctly, 
>>the kernel can only do this move via swap, even if there is stacks of free 
>>(non-dmaable or highmem) memory.
>>
>>I distinctly remember the moral of the thread being "Always mount some swap, 
>>if you can"
>>
>>This might have changed though, or I might have got it completely wrong. - 
>>I've cc'ed LKML incase somebody more knowledgeable can comment...
>>
> 
> 
> http://kerneltrap.org/node/view/3202
> 

Interesting - I was familiar with the original swappiness thread 
(http://kerneltrap.org/node/view/3000) but haven't seen anything since 
then (I mainly follow via kernel-traffic - enjoyable, but nowhere near 
real time). There's clearly been a bunch more discussion...

Not to rehash the performance arguments, but it appears from my read of 
the kernel trap page referenced above that the primary argument for swap 
is still the performance argument - I didn't see anything referencing 
swap being necessary to move DMAable ram or lowmem. Was that posted 
previously on linux-kernel but not on kerneltrap?

I'm still under the impression that "to swap or not" is a 
performance/policy/risk-management question, not a correctness question. 
If I'm wrong, I'd definitely like to know...

-Mike
