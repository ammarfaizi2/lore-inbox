Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135892AbRASAwy>; Thu, 18 Jan 2001 19:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136133AbRASAwo>; Thu, 18 Jan 2001 19:52:44 -0500
Received: from gateway.sequent.com ([192.148.1.10]:61350 "EHLO
	gateway.sequent.com") by vger.kernel.org with ESMTP
	id <S135892AbRASAwe>; Thu, 18 Jan 2001 19:52:34 -0500
Date: Thu, 18 Jan 2001 16:52:25 -0800
From: Mike Kravetz <mkravetz@sequent.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: multi-queue scheduler update
Message-ID: <20010118165225.E8637@w-mikek.des.sequent.com>
In-Reply-To: <20010118155311.B8637@w-mikek.des.sequent.com> <20010119012616.D32087@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010119012616.D32087@athlon.random>; from andrea@suse.de on Fri, Jan 19, 2001 at 01:26:16AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 19, 2001 at 01:26:16AM +0100, Andrea Arcangeli wrote:
> On Thu, Jan 18, 2001 at 03:53:11PM -0800, Mike Kravetz wrote:
> > Here are some very preliminary numbers from sched_test_yield
> > (which was previously posted to this (lse-tech) list by Bill
> > Hartner).  Tests were run on a system with 8 700 MHz Pentium
> > III processors.
> > 
> >                            microseconds/yield
> > # threads      2.2.16-22           2.4        2.4-multi-queue
> > ------------   ---------         --------     ---------------
> > 16               18.740            4.603         1.455
> 
> I remeber the O(1) scheduler from Davide Libenzi was beating the mainline O(N)
> scheduler with over 7 tasks in the runqueue (actually I'm not sure if the
> number was 7 but certainly it was under 10). So if you also use a O(1)
> scheduler too as I guess (since you have a chance to run fast on the lots of
> tasks running case) the most interesting thing is how you score with 2/4/8
> tasks in the runqueue (I think the tests on the O(1) scheduler patch was done
> at max on a 2-way SMP btw). (the argument for which Davide's patch wasn't
> included is that most machines have less than 4/5 tasks in the runqueue at the
> same time)
> 
> Andrea

Thanks for the suggestion.  The only reason I hesitated to test with
a small number of threads is because I was under the assumption that
this particular benchmark may have problems if the number of threads
was less than the number of processors.  I'll give the tests a try
with a smaller number of threads.  I'm also open to suggestions for
what benchmarks/test methods I could use for scheduler testing.  If
you remember what people have used in the past, please let me know.

-- 
Mike Kravetz                                 mkravetz@sequent.com
IBM Linux Technology Center
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
