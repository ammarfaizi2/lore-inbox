Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbWEHEho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbWEHEho (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 00:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbWEHEho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 00:37:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:6037 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932288AbWEHEhn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 00:37:43 -0400
X-Authenticated: #14349625
Subject: Re: sched_clock() uses are broken
From: Mike Galbraith <efault@gmx.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andi Kleen <ak@suse.de>, Christopher Friesen <cfriesen@nortel.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <1147061696.8544.12.camel@homer>
References: <20060502132953.GA30146@flint.arm.linux.org.uk>
	 <p73slns5qda.fsf@bragg.suse.de> <44578EB9.8050402@nortel.com>
	 <200605021859.18948.ak@suse.de>  <445791D3.9060306@yahoo.com.au>
	 <1146640155.7526.27.camel@homer>  <445DE925.9010006@yahoo.com.au>
	 <1147023122.13315.16.camel@homer>  <1147061696.8544.12.camel@homer>
Content-Type: text/plain
Date: Mon, 08 May 2006 06:37:43 +0200
Message-Id: <1147063063.8809.7.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-08 at 06:15 +0200, Mike Galbraith wrote:
> On Sun, 2006-05-07 at 19:32 +0200, Mike Galbraith wrote:
> > On Sun, 2006-05-07 at 22:33 +1000, Nick Piggin wrote:
> > > Mike Galbraith wrote:
> > > > On Wed, 2006-05-03 at 03:07 +1000, Nick Piggin wrote:
> > > > 
> > > >>Other problem is that some people didn't RTFM and have started trying to
> > > >>use it for precise accounting :(
> > > > 
> > > > 
> > > > Are you talking about me perchance?  I don't really care about precision
> > > > _that_ much, though I certainly do want to tighten timeslice accounting.
> > > 
> > > No, sched_clock is fine to be used in CPU scheduling choices, which are
> > > heuristic anyway (although strictly speaking, even using it for timeslicing
> > > within a single CPU could cause slight unfairness).
> > > 
> > > I'm talking about the update_cpu_clock() / task_struct->sched_time stuff.
> > 
> > Oh.  I kinda sorta agree.
> 

Sorry for yet another reply, but running the old starvation testcase
that caused sched_clock() to be born in the first place tickled my
funny-bone.  With that running and hitting 300k context switches...

now: 2100508962835 tick: 2100508972067 stamp: 2100508961220 total: 2906
now: 2101531243883 tick: 2101531251877 stamp: 2101531238543 total: 2924
now: 2102695422392 tick: 2102695431699 stamp: 2102695418265 total: 2940

Accounting?  Not :)

	-Mike

