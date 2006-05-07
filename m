Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbWEGRhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWEGRhP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 13:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbWEGRhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 13:37:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:60902 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932205AbWEGRhN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 13:37:13 -0400
X-Authenticated: #14349625
Subject: Re: sched_clock() uses are broken
From: Mike Galbraith <efault@gmx.de>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@suse.de>,
       Christopher Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060507124307.GA20443@flint.arm.linux.org.uk>
References: <20060502132953.GA30146@flint.arm.linux.org.uk>
	 <p73slns5qda.fsf@bragg.suse.de> <44578EB9.8050402@nortel.com>
	 <200605021859.18948.ak@suse.de> <445791D3.9060306@yahoo.com.au>
	 <1146640155.7526.27.camel@homer> <445DE925.9010006@yahoo.com.au>
	 <20060507124307.GA20443@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Sun, 07 May 2006 19:37:13 +0200
Message-Id: <1147023433.13315.22.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-05-07 at 13:43 +0100, Russell King wrote:
> On Sun, May 07, 2006 at 10:33:41PM +1000, Nick Piggin wrote:
> > Mike Galbraith wrote:
> > >On Wed, 2006-05-03 at 03:07 +1000, Nick Piggin wrote:
> > >
> > >>Other problem is that some people didn't RTFM and have started trying to
> > >>use it for precise accounting :(
> > >
> > >
> > >Are you talking about me perchance?  I don't really care about precision
> > >_that_ much, though I certainly do want to tighten timeslice accounting.
> > 
> > No, sched_clock is fine to be used in CPU scheduling choices, which are
> > heuristic anyway (although strictly speaking, even using it for timeslicing
> > within a single CPU could cause slight unfairness).
> 
> Except maybe if it rolls over every 178 seconds, which is my original
> point.  Maybe someone could comment on my initial patch sent 5 days
> ago?

Simply ignore the wrap... unless you have a scenario where the wrap
event itself is significant event.

	-Mike

