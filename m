Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265534AbUEZMQC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265534AbUEZMQC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 08:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265529AbUEZMQC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 08:16:02 -0400
Received: from smtp016.mail.yahoo.com ([216.136.174.113]:39809 "HELO
	smtp016.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265534AbUEZMOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 08:14:42 -0400
Message-ID: <40B48A2E.4030909@yahoo.com.au>
Date: Wed, 26 May 2004 22:14:38 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Buddy Lumpkin <b.lumpkin@comcast.net>
CC: "'William Lee Irwin III'" <wli@holomorphy.com>, orders@nodivisions.com,
       linux-kernel@vger.kernel.org
Subject: Re: why swap at all?
References: <S265489AbUEZLfK/20040526113510Z+1673@vger.kernel.org>
In-Reply-To: <S265489AbUEZLfK/20040526113510Z+1673@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Buddy Lumpkin wrote:
> 
> 
> -----Original Message-----
> From: William Lee Irwin III [mailto:wli@holomorphy.com] 
> Sent: Wednesday, May 26, 2004 2:09 AM
> To: Buddy Lumpkin
> Cc: orders@nodivisions.com; linux-kernel@vger.kernel.org
> Subject: Re: why swap at all?
> 
> On Wed, May 26, 2004 at 01:30:09AM -0700, Buddy Lumpkin wrote:
> 
>>As for your short, two sentence comment below, let me save you the energy
> 
> of
> 
>>insinuations and translate your message the way I read it: 
>>-------------------------------------------------------------------------
>>I don't recognize your name, therefore you can't possibly have a valuable
>>opinion on the direction VM system development should go. I doubt you have
>>an actual performance problem to share, but if you do, please share it and
>>go away so that we can work on solving the problem.
>>--------------------------------------------------------------------------
>>My response:
>>Get over yourself.
> 
> 
>>What the Hell? I have enough bugs I'm paid to fix that I'm not going to
>>tolerate harassment for requesting that claims that the kernel behaves
>>pathologically in some scenario be cast as comprehensible bugreports.
>>It's also worth noting that paying customers don't respond so uncouthly.
> 
> 
> 
>>-- wli
> 
> 
> If you follow the thread, you will see no claim from me that there is
> anything wrong with the kernel. I simply stated that the priority of VM
> system development should focus on physical memory, and that physical memory
> access should not suffer as a result of some tradeoff that improves the
> performance of the VM system when free physical memory is low and there is
> heavy use of the swap device.
> 

You also went on to say:
 > This of course doesn't address the VM paging storms that happen due to large
 > amounts of file system writes. Once the pagecache fills up, dirty pages must
 > be evicted from the pagecache so that new pages can be added to the
 > pagecache.

By and large, Linux doesn't reclaim dirty pages from the pagecache,
and it should not have paging storms due to large amounts of file
system writes.

If you had a workload where it does, we would be interested to see
it. I pointed out to you that this is what Bill was asking you to
file a detailed report about.

> I can't speak whether or not a case like this currently exists, but I know
> optimizing swap performance is a very complicated yet captivating subject
> that has consumed many a posts on this list. People have tried to optimize
> every part of the VM before, so I was just calling out what I believe to be
> a very reasonable and practical goal and put a little bit of substance
> around why I think it's practical.
> 

Actually, during the 2.5 development cycle, swapping performance
got fairly neglected to the point where we were performing twice
as bad as 2.4 for most things. I (and others) recently improved
this because real people doing real things were complaining.

[snip rant]

> 
> I can picture where this is going. Here is an interview between you and a
> popular Linux magazine in two years:
> 
> 
> Linux Magazine: You have contributed to linux for quite some time, correct?
> 
> William: Oh yes, it is my hobby and occupation. I love my work.
> 
> Linux Magazine: You have done all these wonderful things!
> 
> William: Thanks, I am very proud of that
> 
> Linux Magazine: Why did you make such and such decision that backfired?
> 
> William: I don't have to answer that, I don't owe you anything and your not
> a paying customer.
> 
> Give me a break.
> 

What?? Give *you* a break? From a fictional interview you concocted?

Give me a break.
