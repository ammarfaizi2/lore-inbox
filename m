Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266091AbUAFHIj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 02:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266098AbUAFHIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 02:08:39 -0500
Received: from mail-09.iinet.net.au ([203.59.3.41]:45796 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S266091AbUAFHIh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 02:08:37 -0500
Message-ID: <3FFA5ED3.6040000@cyberone.com.au>
Date: Tue, 06 Jan 2004 18:08:03 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@fs.tum.de>
Subject: Re: 2.6.1-rc1-tiny2
References: <20040106054859.GA18208@waste.org> <3FFA56D6.6040808@cyberone.com.au> <20040106064607.GB18208@waste.org>
In-Reply-To: <20040106064607.GB18208@waste.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Matt Mackall wrote:

>On Tue, Jan 06, 2004 at 05:33:58PM +1100, Nick Piggin wrote:
>
>>
>>Matt Mackall wrote:
>>
>>
>>>This is the fourth release of the -tiny kernel tree. The aim of this
>>>tree is to collect patches that reduce kernel disk and memory
>>>footprint as well as tools for working on small systems. Target users
>>>are things like embedded systems, small or legacy desktop folks, and
>>>handhelds.
>>>
>>>
>>Have you considered Adrian Bunk's CPU selection rationalisation work?
>>
>
>Vaguely aware of it.
>

Basically, because the types of x86 cpus are only partially ordered,
and a the CPU selection somehow tries to follow the rule "this CPU or
higher", there ends up being a bit of stuff included which doesn't
need to be. Not sure what the savings add up to though...

>
>>The last argument I heard against it was that there is lower hanging
>>fruit for size reduction. You seem to have got a lot of that.
>>
>
>Yes, a fair amount. Btw, what's the size differential for piggin-sched
>vs mainline?
>

Very little, I think my sched.o is about 40 bytes bigger on UP. Its about
4K bigger for SMP, but thats with quite a bit of init stuff to set up the
sched domains. It also does HT scheduling, and some more of that could be
ifdefed I guess (its already 1-2K smaller than Ingo's shared runqueues).

If you're talking about my interactivity stuff, then that is very little
difference as well, maybe a few tens of bytes smaller. The scheduler is
pretty lean.


