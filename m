Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263212AbVAFXX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263212AbVAFXX4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 18:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263214AbVAFXU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 18:20:26 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:51615 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S263207AbVAFXQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 18:16:36 -0500
Message-Id: <200501062316.j06NFP900855@www.watkins-home.com>
From: "Guy" <bugzilla@watkins-home.com>
To: "'Mike Hardy'" <mhardy@h3c.com>, "'Jesper Juhl'" <juhl-lkml@dif.dk>
Cc: "'Andrew Walrond'" <andrew@walrond.org>, <linux-raid@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
Subject: RE: No swap can be dangerous (was Re: swap on RAID (was Re: swp - Re: ext3 journal on software raid))
Date: Thu, 6 Jan 2005 18:15:18 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <41DDC25C.2040404@h3c.com>
Thread-Index: AcT0Q7r33D0WvEF1RPWnO9m4fh9ruQAAacOw
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I MUST/SHOULD have swap space....
Maybe I will create a RAM disk and use it for swap!  :)  :)  :)

Guy

-----Original Message-----
From: linux-raid-owner@vger.kernel.org
[mailto:linux-raid-owner@vger.kernel.org] On Behalf Of Mike Hardy
Sent: Thursday, January 06, 2005 5:58 PM
To: Jesper Juhl
Cc: Andrew Walrond; linux-raid@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: No swap can be dangerous (was Re: swap on RAID (was Re: swp -
Re: ext3 journal on software raid))



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
>>If I recollect a recent thread on LKML correctly, your 'no inherent need
for 
>>swap' might be wrong.
>>
>>I think the gist was this: the kernel can sometimes needs to move bits of 
>>memory in order to free up dma-able ram, or lowmem. If I recall correctly,

>>the kernel can only do this move via swap, even if there is stacks of free

>>(non-dmaable or highmem) memory.
>>
>>I distinctly remember the moral of the thread being "Always mount some
swap, 
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
-
To unsubscribe from this list: send the line "unsubscribe linux-raid" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

