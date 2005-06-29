Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262742AbVF2Xzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262742AbVF2Xzy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 19:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262744AbVF2Xzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 19:55:53 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:224 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262742AbVF2XyC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 19:54:02 -0400
Date: Wed, 29 Jun 2005 16:54:22 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Bill Huey <bhuey@lnxw.com>
Cc: Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       andrea@suse.de, tglx@linutronix.de, karim@opersys.com, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT and I-PIPE: the numbers, take 3
Message-ID: <20050629235422.GI1299@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <42C320C4.9000302@opersys.com> <20050629225734.GA23793@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050629225734.GA23793@nietzsche.lynx.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2005 at 03:57:34PM -0700, Bill Huey wrote:
> On Wed, Jun 29, 2005 at 06:29:24PM -0400, Kristian Benoit wrote:
> > Overall analysis:
> ...
> > We had not intended to redo a 3rd run so early, but we're happy we did
> > given the doubts expressed by some on the LKML. And as we suspected, these
> > new results very much corroborate what we had found earlier. As such, our
> > conclusions remain mostly unchanged:
> 
> Did you compile your host Linux kernel with CONFIG_SMP in place ? That's
> critical since a UP kernel removes both spinlock and blocking locks in
> critical paths makes micro benchmarks sort of invalid.
> 
> The benchmark is sort of confusing two things and merging them into one.
> Both the latency statistic and kernel performance must be kept seperate.
> The overall kernel performance is a more complicate issue that has to be
> analysize differently using a more complicated methodology. That because
> an RTOS use of PREEMPT_RT is going to be under a different circumstance
> than that of a pure dual kernel set up of some sort. The functionalities
> aren't the same.
> 
> I suggest that you compile the dual kernel with SMP turned on and try it
> again, otherwise it's not really testing the overhead of any of the locking
> for either the PREEMPT_RT or dual kernel set ups. That's really the only
> outstanding statistic that I've noticed in that benchmark.

If you were suggesting this to be run on an SMP system, I would agree
with you.  I, too, would very much like to see these results run on a
2-CPU or 4-CPU system, although I am most certainly -not- asking Kristian
and Karim to do this work -- it is very much someone else's turn in the
barrel, I would say!

However, on a UP system, I have to agree with Kristian's choice of
configuration.  An embedded system developer running on a UP system would
naturally use a UP Linux kernel build, so it makes sense to benchmark
a UP kernel on a UP system.

						Thanx, Paul
