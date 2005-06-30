Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263112AbVF3XIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263112AbVF3XIW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 19:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263109AbVF3XIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 19:08:22 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:56284 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263117AbVF3XH7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 19:07:59 -0400
Date: Thu, 30 Jun 2005 16:08:09 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Bill Huey <bhuey@lnxw.com>, Kristian Benoit <kbenoit@opersys.com>,
       linux-kernel@vger.kernel.org, andrea@suse.de, tglx@linutronix.de,
       karim@opersys.com, pmarques@grupopie.com, bruce@andrew.cmu.edu,
       nickpiggin@yahoo.com.au, ak@muc.de, sdietrich@mvista.com,
       dwalker@mvista.com, hch@infradead.org, akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT and I-PIPE: the numbers, take 3
Message-ID: <20050630230809.GB1298@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <42C320C4.9000302@opersys.com> <20050629225734.GA23793@nietzsche.lynx.com> <20050629235422.GI1299@us.ibm.com> <20050630070709.GA26239@elte.hu> <20050630154304.GA1298@us.ibm.com> <20050630161726.GA11185@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050630161726.GA11185@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2005 at 06:17:26PM +0200, Ingo Molnar wrote:
> 
> * Paul E. McKenney <paulmck@us.ibm.com> wrote:
> 
> > > another point is that this test is measuring the overhead of PREEMPT_RT, 
> > > without measuring the benefit of the cost: RT-task scheduling latencies.  
> > > We know since the rtirq patch (to which i-pipe is quite similar) that we 
> > > can achieve good irq-service latencies via relatively simple means, but 
> > > that's not what PREEMPT_RT attempts to do. (PREEMPT_RT necessarily has 
> > > to have good irq-response times too, but much of the focus went to the 
> > > other aspects of RT task scheduling.)
> > 
> > Agreed, a PREEMPT_RT-to-IPIPE comparison will never be an 
> > apples-to-apples comparison.  Raw data will never be a substitute for 
> > careful thought, right?  ;-)
> 
> well, it could still be tested, since it's so easy: the dohell script is 
> already doing all of that as it runs rtc_wakeup - which runs a 
> SCHED_FIFO task and carefully measures wakeup latencies. If it is used 
> with 1024 Hz (the default) and it can be used in every test without 
> impacting the system load in any noticeable way.

OK, I think that I finally understand what you are getting at -- and I
agree that it would be interesting to get latency measurements during the
actual lmbench runs.  However, if I understand correctly, you would want
roughly 1,000,000 latency measurements per lmbench run segment, which,
at 1024 Hz, would mean that each segment would take about 20 minutes.
A single lmbench run would then take many hours.

Is this really what you are getting at, or are you instead thinking
in terms of a single maximum-latency measurement covering the entire
lmbench run?

						Thanx, Paul
