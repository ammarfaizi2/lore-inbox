Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269623AbUINW6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269623AbUINW6L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 18:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268001AbUINWzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 18:55:50 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:11603 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269553AbUINWzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 18:55:16 -0400
Message-ID: <414776CE.5030302@yahoo.com.au>
Date: Wed, 15 Sep 2004 08:55:10 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: fix scheduling latencies for !PREEMPT kernels
References: <20040914104449.GA30790@elte.hu> <20040914105048.GA31238@elte.hu> <20040914105904.GB31370@elte.hu> <20040914110237.GC31370@elte.hu> <20040914110611.GA32077@elte.hu> <20040914112847.GA2804@elte.hu> <20040914114228.GD2804@elte.hu> <4146EA3E.4010804@yahoo.com.au> <20040914132225.GA9310@elte.hu> <4146F33C.9030504@yahoo.com.au> <20040914145457.GA13113@elte.hu>
In-Reply-To: <20040914145457.GA13113@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>Another thing, I don't mean this to sound like a rhetorical question,
>>but if we have a preemptible kernel, why is it a good idea to sprinkle
> 
>       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
>>cond_rescheds everywhere? Isn't this now the worst of both worlds? Why
>>would someone who really cares about latency not enable preempt?
> 
> 
> two things:
> 
> 1) none of the big distros enables CONFIG_PREEMPT in their kernels - not
> even SuSE. This is pretty telling.
> 
> 2) 10 new cond_resched()'s are not precisely 'sprinkle everywhere'.
> 

No, but I mean putting them right down into fastpaths like the vmscan
one, for example.

And if I remember correctly, you resorted to putting them into
might_sleep as well (but I haven't read the code for a while, maybe
you're now getting decent results without doing that).
