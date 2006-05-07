Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbWEGRwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWEGRwM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 13:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbWEGRwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 13:52:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:21143 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932208AbWEGRwL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 13:52:11 -0400
X-Authenticated: #14349625
Subject: Re: sched_clock() uses are broken
From: Mike Galbraith <efault@gmx.de>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@suse.de>,
       Christopher Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060507165356.GA32453@flint.arm.linux.org.uk>
References: <44578EB9.8050402@nortel.com> <200605021859.18948.ak@suse.de>
	 <445791D3.9060306@yahoo.com.au> <1146640155.7526.27.camel@homer>
	 <445DE925.9010006@yahoo.com.au>
	 <20060507124307.GA20443@flint.arm.linux.org.uk>
	 <445DEE70.10807@yahoo.com.au> <445DEF6D.1050902@yahoo.com.au>
	 <20060507131825.GC20443@flint.arm.linux.org.uk> <445DF667.309@yahoo.com.au>
	 <20060507165356.GA32453@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Sun, 07 May 2006 19:52:11 +0200
Message-Id: <1147024331.13315.34.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-05-07 at 17:53 +0100, Russell King wrote:
> On Sun, May 07, 2006 at 11:30:15PM +1000, Nick Piggin wrote:
> > Russell King wrote:
> > >On Sun, May 07, 2006 at 11:00:29PM +1000, Nick Piggin wrote:
> > >
> > >>Nick Piggin wrote:
> > >>
> > >>
> > >>>I stand by my first reply to your comment WRT the API.
> > >>
> > >>Actually, on rereading, it seems like I was a bit confused about
> > >>your proposal. I don't think you specified anyway the units
> > >>returned by your new sched_clock(). So it is identical to my
> > >>"corrected" interface :\
> > >
> > >
> > >Okay, so that presumably means we have to either stick with what we
> > >currently have, or go the whole hog and re-implement the sched_clock()
> > >support?
> > >
> > >IOW, my patch on 2nd May isn't of any use as it currently stands?
> > 
> > IMO it would probably be best to try to re implement it in one go.
> > It shouldn't have spread too far out of kernel/sched.c, and the arch
> > code should mostly be implementable in terms of their sched_clock().
> > Mundane but not difficult.
> 
> Having looked at this several times over the last couple of days, I've
> come to the conclusion that I'm not the right person to fix this problem.
> I've tried several methods of converting the code, but every time I
> remain unconvinced that the changes are provably correct as far as not
> missing something, so I end up throwing the changes away and starting
> again.
> 
> Yes, I admit defeat.

Ah, you feel my pain.  I look forward to the continuous nanosecond clock
that the time guys are currently talking about, and will hopefully _not_
decide is not needed.

	-Mike

