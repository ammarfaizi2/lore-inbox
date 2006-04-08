Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751397AbWDHHyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbWDHHyl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 03:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbWDHHyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 03:54:41 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:21678
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S1751397AbWDHHyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 03:54:40 -0400
Date: Sat, 8 Apr 2006 00:54:30 -0700
To: Ingo Molnar <mingo@elte.hu>
Cc: Darren Hart <darren@dvhart.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       "Stultz, John" <johnstul@us.ibm.com>,
       Peter Williams <pwil3058@bigpond.net.au>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: RT task scheduling
Message-ID: <20060408075430.GA19403@gnuppy.monkey.org>
References: <200604052025.05679.darren@dvhart.com> <20060407091946.GA28421@elte.hu> <20060407103926.GC11706@gnuppy.monkey.org> <200604070756.21625.darren@dvhart.com> <20060407210633.GA15971@gnuppy.monkey.org> <20060408071657.GA11660@elte.hu> <20060408072530.GA14364@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060408072530.GA14364@elte.hu>
User-Agent: Mutt/1.5.11+cvs20060126
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 08, 2006 at 09:25:30AM +0200, Ingo Molnar wrote:
> > to the contrary, the "RT overload" code in the -rt tree does strict, 
> > system-wide RT priority scheduling. That's the whole point of it.
> 
> so after this "clarification of terminology" i hope you are in picture 
> now, so could you please explain to me what you meant by:

> > > You should consider for a moment to allow for the binding of a 
> > > thread to a CPU to determine the behavior of a SCHED_FIFO class task 
> > > instead of creating a new run category. [...]
> 
> to me it still makes no sense, and much of the followups were based on 
> this. Or were you simply confused about what the scheduling code in -rt 
> does precisely? Did that get clarified now?

The last time I looked at it I thought it did something pretty simplistic
in that it just dumped any RT thread to another CPU but didn't do it in
a strict manner with regard to priority. Maybe that's changed or else I
didn't pay attention to it that as carefully as I thought.

As far as CPU binding goes, I'm wanting a method of getting around the
latency of the rt overload logic in certain cases at the expense of
rebalancing. That's what I ment by it.

bill

