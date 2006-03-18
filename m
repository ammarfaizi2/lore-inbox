Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751580AbWCRMy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580AbWCRMy1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 07:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbWCRMy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 07:54:26 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:29909 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750720AbWCRMy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 07:54:26 -0500
Date: Sat, 18 Mar 2006 05:54:25 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       John Stultz <johnstul@us.ibm.com>, Lee Revell <rlrevell@joe-job.com>,
       Martin Ridgeway <mridge@users.sourceforge.net>
Subject: Re: 2.6.16-rc6-rt7
Message-ID: <20060318125425.GA32662@smtp.west.cox.net>
References: <20060316095607.GA28571@elte.hu> <20060317233636.GB26253@smtp.west.cox.net> <1142678240.17279.76.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142678240.17279.76.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2006 at 11:37:19AM +0100, Thomas Gleixner wrote:
> On Fri, 2006-03-17 at 16:36 -0700, Tom Rini wrote:
> > On Thu, Mar 16, 2006 at 10:56:08AM +0100, Ingo Molnar wrote:
> > 
> > > i have released the 2.6.16-rc6-rt7 tree, which can be downloaded from 
> > > the usual place:
> > > 
> > >    http://redhat.com/~mingo/realtime-preempt/
> > 
> > I was wondering, is it normal for the nanosleep02 and alarm02 LTP tests
> > to fail?  For sometime I've seen these tests fail from time to time with
> > the -RT patch but not the regular kernel.
> 
> The nanosleep02 failure is incorrect due to rounding errors in the test
> code.
[snip]
> This never happens on vanilla, as the nanosleep is rounded to the next
> jiffie. -rt has high resolution timers which are delivered accurate, so
> the rounding errors of the testcode surface.

Thanks!  Any ideas about the alarm02 test?

-- 
Tom Rini
http://gate.crashing.org/~trini/
