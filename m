Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133047AbRASQIA>; Fri, 19 Jan 2001 11:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135245AbRASQHu>; Fri, 19 Jan 2001 11:07:50 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:20190 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S133047AbRASQHk>; Fri, 19 Jan 2001 11:07:40 -0500
Date: Fri, 19 Jan 2001 08:06:37 -0800 (PST)
From: David Lang <dlang@diginsite.com>
To: Mike Kravetz <mkravetz@sequent.com>
cc: Andrea Arcangeli <andrea@suse.de>, <lse-tech@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: multi-queue scheduler update
In-Reply-To: <20010118165225.E8637@w-mikek.des.sequent.com>
Message-ID: <Pine.LNX.4.31.0101190805450.25863-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

another thing that would be interesting is what is the overhead on UP or
small (2-4 way) SMP machines

David Lang

On Thu, 18 Jan 2001, Mike Kravetz wrote:

> Date: Thu, 18 Jan 2001 16:52:25 -0800
> From: Mike Kravetz <mkravetz@sequent.com>
> To: Andrea Arcangeli <andrea@suse.de>
> Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
> Subject: Re: [Lse-tech] Re: multi-queue scheduler update
>
> On Fri, Jan 19, 2001 at 01:26:16AM +0100, Andrea Arcangeli wrote:
> > On Thu, Jan 18, 2001 at 03:53:11PM -0800, Mike Kravetz wrote:
> > > Here are some very preliminary numbers from sched_test_yield
> > > (which was previously posted to this (lse-tech) list by Bill
> > > Hartner).  Tests were run on a system with 8 700 MHz Pentium
> > > III processors.
> > >
> > >                            microseconds/yield
> > > # threads      2.2.16-22           2.4        2.4-multi-queue
> > > ------------   ---------         --------     ---------------
> > > 16               18.740            4.603         1.455
> >
> > I remeber the O(1) scheduler from Davide Libenzi was beating the mainline O(N)
> > scheduler with over 7 tasks in the runqueue (actually I'm not sure if the
> > number was 7 but certainly it was under 10). So if you also use a O(1)
> > scheduler too as I guess (since you have a chance to run fast on the lots of
> > tasks running case) the most interesting thing is how you score with 2/4/8
> > tasks in the runqueue (I think the tests on the O(1) scheduler patch was done
> > at max on a 2-way SMP btw). (the argument for which Davide's patch wasn't
> > included is that most machines have less than 4/5 tasks in the runqueue at the
> > same time)
> >
> > Andrea
>
> Thanks for the suggestion.  The only reason I hesitated to test with
> a small number of threads is because I was under the assumption that
> this particular benchmark may have problems if the number of threads
> was less than the number of processors.  I'll give the tests a try
> with a smaller number of threads.  I'm also open to suggestions for
> what benchmarks/test methods I could use for scheduler testing.  If
> you remember what people have used in the past, please let me know.
>
> --
> Mike Kravetz                                 mkravetz@sequent.com
> IBM Linux Technology Center
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
