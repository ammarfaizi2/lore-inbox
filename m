Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135899AbRASA0J>; Thu, 18 Jan 2001 19:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132678AbRASAZ7>; Thu, 18 Jan 2001 19:25:59 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:54650 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S135899AbRASAZs>; Thu, 18 Jan 2001 19:25:48 -0500
Date: Fri, 19 Jan 2001 01:26:16 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Mike Kravetz <mkravetz@sequent.com>
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: multi-queue scheduler update
Message-ID: <20010119012616.D32087@athlon.random>
In-Reply-To: <20010118155311.B8637@w-mikek.des.sequent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010118155311.B8637@w-mikek.des.sequent.com>; from mkravetz@sequent.com on Thu, Jan 18, 2001 at 03:53:11PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2001 at 03:53:11PM -0800, Mike Kravetz wrote:
> Here are some very preliminary numbers from sched_test_yield
> (which was previously posted to this (lse-tech) list by Bill
> Hartner).  Tests were run on a system with 8 700 MHz Pentium
> III processors.
> 
>                            microseconds/yield
> # threads      2.2.16-22           2.4        2.4-multi-queue
> ------------   ---------         --------     ---------------
> 16               18.740            4.603         1.455

I remeber the O(1) scheduler from Davide Libenzi was beating the mainline O(N)
scheduler with over 7 tasks in the runqueue (actually I'm not sure if the
number was 7 but certainly it was under 10). So if you also use a O(1)
scheduler too as I guess (since you have a chance to run fast on the lots of
tasks running case) the most interesting thing is how you score with 2/4/8
tasks in the runqueue (I think the tests on the O(1) scheduler patch was done
at max on a 2-way SMP btw). (the argument for which Davide's patch wasn't
included is that most machines have less than 4/5 tasks in the runqueue at the
same time)

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
