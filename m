Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263991AbTA2VaF>; Wed, 29 Jan 2003 16:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264665AbTA2VaE>; Wed, 29 Jan 2003 16:30:04 -0500
Received: from 64-60-75-69.cust.telepacific.net ([64.60.75.69]:15889 "EHLO
	racerx.ixiacom.com") by vger.kernel.org with ESMTP
	id <S263991AbTA2VaE>; Wed, 29 Jan 2003 16:30:04 -0500
Message-ID: <3E384882.6020703@ixiacom.com>
Date: Wed, 29 Jan 2003 13:32:50 -0800
From: Dan Kegel <dkegel@ixiacom.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: debate on 700 threads vs asynchronous code
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Chin wrote:
 > Terje Eggestad <terje.eggestad@scali.com> wrote:
 >> Apart from the argument already given on other replies, you should
 >> keep in mind that you probably need to give priority to doing receive.
 >> THat include your clients, but if you don't you run into the risk of
 >> significantly limiting your bandwidth since the send queues around your
 >> system fill up.
 >>
 >> Try doing that with threads.
 >>
 >> Actually I would recommend the approach c)
 >>
 >> c)  Write an asynchronous system with only 2 or three threads where I
 >> manage the connections and keep the state of each connection in a data
 >> structure.
 >
> Today I do method (C)... but many people seem to say that, hey, pthreads does almost
> just that with a constant memory overhead of remembering the stack per blocking
> thread... so there is no time difference, just that pthreads consumes slightly more
> memory.  That is the issue I am trying to get my head around.

The best way to get your head around it is to
benchmark both approaches, and spend some time
refining your implementation of each so you
understand where the bottlenecks are.

> That particular question, no one has answered... in Linux, the scheduler will not go 
> around crazy trying to schedule prcosses that are all waiting on IO.  NOw the only 
> time I see a degrade in threads would be if all are runnable.... in that case a async
> scheme with two threads would let each task run to completion, not thrashing the
> kernel.  Is that correct to say?

There are lots of other issues, too.
Talk is cheap and fun, but only coding will give the real answer.
Go forth and code...

- Dan






