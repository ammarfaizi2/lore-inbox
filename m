Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314548AbSHRMb6>; Sun, 18 Aug 2002 08:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314602AbSHRMb6>; Sun, 18 Aug 2002 08:31:58 -0400
Received: from ivimey.org ([194.106.52.201]:26940 "EHLO gatemaster.ivimey.org")
	by vger.kernel.org with ESMTP id <S314548AbSHRMb5>;
	Sun, 18 Aug 2002 08:31:57 -0400
Date: Sun, 18 Aug 2002 13:33:31 +0100 (BST)
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
X-X-Sender: ruthc@sharra.ivimey.org
To: Larry McVoy <lm@bitmover.com>
cc: Matti Aarnio <matti.aarnio@zmailer.org>, Dax Kelson <dax@gurulabs.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Does Solaris really scale this well?
In-Reply-To: <20020817175517.A31128@work.bitmover.com>
Message-ID: <Pine.LNX.4.44.0208181228330.13351-100000@sharra.ivimey.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Aug 2002, Larry McVoy wrote:

>On Sun, Aug 18, 2002 at 12:03:24AM +0100, Ruth Ivimey-Cook wrote:
>> >> "When you take a 99-way UltraSPARC III machine and add a 100th processor, 
>> >> you get 94 percent linear scalability. You can't get 94 percent linear 
>> >> scalability on your first Intel chip. It's very, very hard to do, and they 
>> >> have not done it."
>> 
>> I've seen scientific reports of scalability that good in non-shared memory
>> computers (mostly in transputer arrays) where (with a scalable algorithm)
>> unless you got >90% you were doing something wrong.  However, if you insist on
>> sharing main memory, I still don't believe you can get anywhere near that...
>> IMO 30% is doing very well once past the first few CPUs.
>
>Please reconsider your opinion.  Both Sun and SGI scale past 100 CPUs on
>reasonable workloads in shared memory.  Where "reasonable" != easy to do.

Larry,

I wasn't disputing that Sun could have say 100 cpus in a box, but that the
100th shared-memory CPU didias much work as the first. That said, I _am_ out
of date on the performance of the Sun machines; what kind of measured
performance effeciency do you get with them?

A google search turned up:
    http://www.icg.tu-graz.ac.at/goller/publication/pers/node6.html (1997)
in which the author says:

  Utilizing more than half of all processors is commonly agreed to be an
acceptable efficiency for parallel applications. In all three diagrams, the
efficiency never drops below this 50%-level in the area of interest

-- well, I would disagree about the implied "any parallel app", but it does
seem to be true of many SMP systems...

In the following paper, the authors benchmarked IBM, Cray and SGI
supercomputers: http://citeseer.nj.nec.com/kang99benchmarking.html (1999)

If you look at pages numbered 53 & 54, you will see graphs of time vs num
processors that are a very long way from linear, indeed in one case time
increased as cum cpus increased.

It is also instructive to note that in many cases, the peak processor power is 
obtained by multiplying individual peak power by the number of processors, 
with no notice taken of the costs of synchronisation, memory access or 
communication. Consequently, many new owners of supercomputers are very 
disappointed with their new 'baby' when they find it's not nearly as powerful 
as they had been told.

Regards,

Ruth

-- 
Ruth Ivimey-Cook
Software engineer and technical writer.



