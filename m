Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269658AbUJGC0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269658AbUJGC0s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 22:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269659AbUJGC0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 22:26:48 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:43449 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269658AbUJGC0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 22:26:46 -0400
Message-ID: <4164A962.1010906@yahoo.com.au>
Date: Thu, 07 Oct 2004 12:26:42 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
CC: "'Andrew Morton'" <akpm@osdl.org>, mingo@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: Default cache_hot_time value back to 10ms
References: <200410062313.i96NDo609923@unix-os.sc.intel.com>
In-Reply-To: <200410062313.i96NDo609923@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Kenneth W wrote:
> Andrew Morton wrote on Wednesday, October 06, 2004 1:43 PM
> 
>>"Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
>>
>>> Secondly, let me ask the question again from the first mail thread:  this value
>>> *WAS* 10 ms for a long time, before the domain scheduler.  What's so special
>>> about domain scheduler that all the sudden this parameter get changed to 2.5?
>>
>>So why on earth was it switched from 10 to 2.5 in the first place?
>>
>>Please resend the final patch.
> 
> 
> 
> Here is a patch that revert default cache_hot_time value back to the equivalence
> of pre-domain scheduler, which determins task's cache affinity via architecture
> defined variable cache_decay_ticks.
> 
> This is a mere request that we go back to what *was* before, *NOT* as a new
> scheduler tweak (Whatever tweak done for domain scheduler broke traditional/
> industry recognized workload).
> 

OK... Well Andrew as I said I'd be happy for this to go in. I'd be *extra*
happy if Judith ran a few of those dbt thingy tests which had been sensitive
to idle time. Can you ask her about that? or should I?

> As a side note, I'd like to get involved on future scheduler tuning experiments,
> we have fair amount of benchmark environments where we can validate things across
> various kind of workload, i.e., db, java, cpu, etc.  Thanks.
> 

That would be very welcome indeed. We have a big backlog of scheduler things
to go in after 2.6.9 is released (although not many of them change the runtime
behaviour IIRC). After that, I have some experimental performance work that
could use wider testing. After *that*, the multiprocessor scheduler will in a
state where 2.6 shouldn't need much more work, so we can concentrate on just
tuning the dials.
