Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbWEGRcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbWEGRcE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 13:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWEGRcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 13:32:03 -0400
Received: from mail.gmx.de ([213.165.64.20]:14534 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932201AbWEGRcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 13:32:02 -0400
X-Authenticated: #14349625
Subject: Re: sched_clock() uses are broken
From: Mike Galbraith <efault@gmx.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andi Kleen <ak@suse.de>, Christopher Friesen <cfriesen@nortel.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <445DE925.9010006@yahoo.com.au>
References: <20060502132953.GA30146@flint.arm.linux.org.uk>
	 <p73slns5qda.fsf@bragg.suse.de> <44578EB9.8050402@nortel.com>
	 <200605021859.18948.ak@suse.de>  <445791D3.9060306@yahoo.com.au>
	 <1146640155.7526.27.camel@homer>  <445DE925.9010006@yahoo.com.au>
Content-Type: text/plain
Date: Sun, 07 May 2006 19:32:02 +0200
Message-Id: <1147023122.13315.16.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-05-07 at 22:33 +1000, Nick Piggin wrote:
> Mike Galbraith wrote:
> > On Wed, 2006-05-03 at 03:07 +1000, Nick Piggin wrote:
> > 
> >>Other problem is that some people didn't RTFM and have started trying to
> >>use it for precise accounting :(
> > 
> > 
> > Are you talking about me perchance?  I don't really care about precision
> > _that_ much, though I certainly do want to tighten timeslice accounting.
> 
> No, sched_clock is fine to be used in CPU scheduling choices, which are
> heuristic anyway (although strictly speaking, even using it for timeslicing
> within a single CPU could cause slight unfairness).
> 
> I'm talking about the update_cpu_clock() / task_struct->sched_time stuff.

Oh.  I kinda sorta agree. If the continuous nanosecond thing happens,
it'll make things _much_ easier.  I actually have exactly one testcase
that actually requires nanoseconds as things stand, and that one I've
worked around in the past.  The rest of my desire to increase accuracy
stems from instrumenting timeslice enforcement.  Statistical at best,
and truly sad at worst.

	-Mike

