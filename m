Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbWDGJYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbWDGJYL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 05:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbWDGJYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 05:24:11 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:32176
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S932395AbWDGJYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 05:24:10 -0400
Date: Fri, 7 Apr 2006 02:23:59 -0700
To: Darren Hart <darren@dvhart.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>,
       "Stultz, John" <johnstul@us.ibm.com>,
       Peter Williams <pwil3058@bigpond.net.au>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: RT task scheduling
Message-ID: <20060407092359.GB11706@gnuppy.monkey.org>
References: <200604052025.05679.darren@dvhart.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604052025.05679.darren@dvhart.com>
User-Agent: Mutt/1.5.11+cvs20060126
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2006 at 08:25:04PM -0700, Darren Hart wrote:
> Part of the issue here is to define what we consider "correct behavior" for 
> SCHED_FIFO realtime tasks.  Do we (A) need to strive for "strict realtime 
> priority scheduling" where the NR_CPUS highest priority runnable SCHED_FIFO 
> tasks are _always_ running?  Or do we (B) take the best effort approach with 
> an upper limit RT priority imbalances, where an imbalance may occur (say at 
> wakeup or exit) but will be remedied within 1 tick.  The smpnice patches 
> improve load balancing, but don't provide (A).

I regret getting into this discussion late, but it should always be (A)
if you're building a kernel for strict RT usage. (B) is for a system that's
more general purpose. It's not a "one policy fits all" kind of problem.

The search costs of (A) could be be significant and may degrade system
performance. Optimizations for that case is for another discussion.

bill

