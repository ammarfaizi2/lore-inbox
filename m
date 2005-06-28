Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261811AbVF1AXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261811AbVF1AXh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 20:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbVF1AXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 20:23:37 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:4770 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261811AbVF1AX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 20:23:28 -0400
Message-ID: <42C09877.90800@yahoo.com.au>
Date: Tue, 28 Jun 2005 10:23:19 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Markus_T=F6rnqvist?= <mjt@nysv.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Hans Reiser <reiser@namesys.com>,
       David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506231924.j5NJOvLA031008@laptop11.inf.utfsm.cl> <42BB31E9.50805@slaphack.com> <1119570225.18655.75.camel@localhost.localdomain> <42BB5E1A.70903@namesys.com> <1119609680.17066.81.camel@localhost.localdomain> <20050627091808.GC11013@nysv.org> <42BFCAE7.6070708@yahoo.com.au> <20050627125555.GE11013@nysv.org>
In-Reply-To: <20050627125555.GE11013@nysv.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Törnqvist wrote:
> On Mon, Jun 27, 2005 at 07:46:15PM +1000, Nick Piggin wrote:
> 
>>The scheduler is being improved for better behaviour on complex
>>topologies like multi core + NUMA and multi level NUMA systems.
>>If Con's work had gone in first, then conversely these improvements
>>would have had to wait.
> 
> 
> Or be merged in later.
> 

It _was_ merged later. Con was talking about Andrew's -mm tree.

> The problem is, why do the interfaces have to live so much that
> examples like this come to my ears (or eyes ;) all the time?
> 

The scheduler interfaces are probably among the most stable
in the kernel. Con was talking about internal implementation.

> I hate to say this without digging out any URLs, but one friend
> of mine says he has a very hard time doing any networking code
> because it's too labile. Maybe that's being embettered for something
> else too?
> 

It seems there are plenty of people who can do networking code
just fine.

> Or the other friend who curses that the networking code is just
> crap and basically has to rewrite the code to get it working.
> Yes, I've tried to get these guys to submit their code, but they
> argue back that no one wants to see it.
> 

I get the feeling your friend is making up some tall tales if he
says he rewrote the networking code to be much better than it is
now. But I can guarantee him that if he has it will be of great
interest to the network developers.

> 
>>>There's also my all-time favorite, http://lkml.org/lkml/2005/3/14/4
>>
>>What's wrong with that? The slowdown is due to the workload
>>becoming disk bound. The reasons are still not entirely clear,
>>but I don't think it is a recent (ie. 2.6) regression (or even
>>a regression at all IIRC).
> 
> 
> It's not that easy.
> 
> So let's say the scheduler slowdown is a temporary situation to
> adapt it to multicore+NUMA.
> I assume that's what you mean, by having the kernels on par
> with 2.6.10 and the above paragraph.

I'm pretty sure it isn't a scheduler slowdown, but rather the
system is getting disk bound. I think the reporter has
performance back to 2.6.10 levels - it is actually something I
still have to follow up on, but it is difficult because the
reporter isn't able to share his code, although he's otherwise
very helpful.

> 
> Why on earth did the slowdown ever get merged and we have to wait
> for it to be on par with some older version?
> 

If slowdowns do get merged, it is generally because they either
haven't been reported until being merged or they make an accepted
tradeoff. Not that they haven't been tested.

Let's just get this straight, no amount of QA other than releasing
a kernel and asking people to use it is going to find all the bugs
that will be encountered.

> 
> Please do correct me if I'm wrong :)
> 

I mostly agree with you apart from your specific examples I think
we could do things better, and most of us have made some big blunders,
However there is just no way that bringing any of that up will help
Reiser4 being merged.

Send instant messages to your online friends http://au.messenger.yahoo.com 
