Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262726AbVCPSWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262726AbVCPSWM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 13:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262727AbVCPSWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 13:22:12 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:37787 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262726AbVCPSV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 13:21:59 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
From: Lee Revell <rlrevell@joe-job.com>
To: rostedt@goodmis.org
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0503160237410.11824@localhost.localdomain>
References: <Pine.LNX.4.58.0503111440190.22043@localhost.localdomain>
	 <1110574019.19093.23.camel@mindpipe> <1110578809.19661.2.camel@mindpipe>
	 <Pine.LNX.4.58.0503140214360.697@localhost.localdomain>
	 <Pine.LNX.4.58.0503140427560.697@localhost.localdomain>
	 <Pine.LNX.4.58.0503140509170.697@localhost.localdomain>
	 <Pine.LNX.4.58.0503141024530.697@localhost.localdomain>
	 <Pine.LNX.4.58.0503150641030.6456@localhost.localdomain>
	 <20050315120053.GA4686@elte.hu>
	 <Pine.LNX.4.58.0503150746110.6456@localhost.localdomain>
	 <20050315133540.GB4686@elte.hu>
	 <Pine.LNX.4.58.0503151150170.6456@localhost.localdomain>
	 <1110913778.17931.2.camel@mindpipe>
	 <Pine.LNX.4.58.0503160237410.11824@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 16 Mar 2005 13:21:58 -0500
Message-Id: <1110997318.21212.8.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-16 at 02:50 -0500, Steven Rostedt wrote:
> 
> On Tue, 15 Mar 2005, Lee Revell wrote:
> 
> > On Tue, 2005-03-15 at 13:05 -0500, Steven Rostedt wrote:
> > > Damn! The answer was right there in front of my eyes! Here's the cleanest
> > > solution. I forgot about wait_on_bit_lock.  I've converted all the locks
> > > to use this instead.  We probably need to get priority inheritence working
> > > on this too someday, but for now it's better than wasting memory or
> > > getting into deadlocks.
> > >
> >
> > I am still not clear on why this did not hit with earlier kernels +
> > PREEMPT_DESKTOP.  Were the bitlocks introduced recently?  Or was another
> > lock-break patch dropped?
> >
> 
> When did you start seeing this? This code has been there as far back as
> 2.6.7 (the earliest 2.6 kernel I still have laying around) and as far
> back as Ingo's realtime-preempt-2.6.9-mm1-U10. Maybe the tracing didn't
> start picking this up till later, or that you were just lucky that no
> contention was happening on that lock.

Sometime after the RT preempt patches were rebased to mainline.

I don't see how there could be contention as I am on a UP.

Lee


