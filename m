Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWEGNzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWEGNzu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 09:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbWEGNzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 09:55:50 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:21009 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932168AbWEGNzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 09:55:50 -0400
Date: Sun, 7 May 2006 14:55:40 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Mike Galbraith <efault@gmx.de>, Andi Kleen <ak@suse.de>,
       Christopher Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org
Subject: Re: sched_clock() uses are broken
Message-ID: <20060507135540.GD20443@flint.arm.linux.org.uk>
Mail-Followup-To: Nick Piggin <nickpiggin@yahoo.com.au>,
	Mike Galbraith <efault@gmx.de>, Andi Kleen <ak@suse.de>,
	Christopher Friesen <cfriesen@nortel.com>,
	linux-kernel@vger.kernel.org
References: <44578EB9.8050402@nortel.com> <200605021859.18948.ak@suse.de> <445791D3.9060306@yahoo.com.au> <1146640155.7526.27.camel@homer> <445DE925.9010006@yahoo.com.au> <20060507124307.GA20443@flint.arm.linux.org.uk> <445DEE70.10807@yahoo.com.au> <445DEF6D.1050902@yahoo.com.au> <20060507131825.GC20443@flint.arm.linux.org.uk> <445DF667.309@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <445DF667.309@yahoo.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 07, 2006 at 11:30:15PM +1000, Nick Piggin wrote:
> Russell King wrote:
> >On Sun, May 07, 2006 at 11:00:29PM +1000, Nick Piggin wrote:
> >
> >>Nick Piggin wrote:
> >>
> >>
> >>>I stand by my first reply to your comment WRT the API.
> >>
> >>Actually, on rereading, it seems like I was a bit confused about
> >>your proposal. I don't think you specified anyway the units
> >>returned by your new sched_clock(). So it is identical to my
> >>"corrected" interface :\
> >
> >
> >Okay, so that presumably means we have to either stick with what we
> >currently have, or go the whole hog and re-implement the sched_clock()
> >support?
> >
> >IOW, my patch on 2nd May isn't of any use as it currently stands?
> 
> IMO it would probably be best to try to re implement it in one go.
> It shouldn't have spread too far out of kernel/sched.c, and the arch
> code should mostly be implementable in terms of their sched_clock().
> Mundane but not difficult.
> 
> Making arch code actually try to do the right thing may require a
> bit more thinking, to handle both the variable time counter issue
> and your time counter wrap problem. That wouldn't be your problem
> though, outside arch/arm/

Also, any comments on update_cpu_clock() and current_sched_time() both
appearing to be buggy, or am I barking up the wrong tree with those?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
