Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWIUIYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWIUIYX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 04:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWIUIYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 04:24:22 -0400
Received: from sccrmhc12.comcast.net ([204.127.200.82]:1013 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750708AbWIUIYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 04:24:22 -0400
Date: Thu, 21 Sep 2006 01:24:54 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Daniel Walker <dwalker@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, rmk@arm.linux.org.uk,
       Kevin Hilman <khilman@mvista.com>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: Re: 2.6.18-rt1
Message-ID: <20060921082454.GA32756@plexity.net>
Reply-To: dsaxena@plexity.net
References: <20060920141907.GA30765@elte.hu> <1158774118.29177.13.camel@c-67-180-230-165.hsd1.ca.comcast.net> <20060920182553.GC1292@us.ibm.com> <200609201436.47042.gene.heskett@verizon.net> <20060920194650.GA21037@elte.hu> <20060921080435.GA29636@plexity.net> <20060921080456.GA32040@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060921080456.GA32040@elte.hu>
Organization: Plexity Networks
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 21 2006, at 10:04, Ingo Molnar was caught saying:
> 
> * Deepak Saxena <dsaxena@plexity.net> wrote:
> 
> > I am seeing an intermittent lock up on the ARM Versatile board during 
> > the ALSA driver init that only shows up with (PREEMPT_RT & 
> > !HIGH_RES_TIMERS & ARM_EABI) enabled. If HRT is disabled and EABI is 
> > enabled, the kernel works every time, and same with !RT & !HRT & EABI.  
> > I get no oops, just a complete lock up with no console output.
> 
> does enabling LOCKDEP give you any better info? (It might not make a 
> difference on the bootup that locks, but maybe you'll get a lockdep clue 
> about the problem in one of the successful bootups.)

This is with LOCKDEP enabled. I'll look at this more tommorrow but
I think next steps for me are printks to see if I can pinpoint the
issue and possibly looking at the assembly to see if there's an obvious
compiler issue.

~Deepak

-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

"An open heart has no possessions, only experiences" - Matt Bibbeau
