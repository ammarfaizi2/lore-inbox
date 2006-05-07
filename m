Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbWEGMnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWEGMnS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 08:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbWEGMnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 08:43:18 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39690 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932139AbWEGMnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 08:43:18 -0400
Date: Sun, 7 May 2006 13:43:07 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Mike Galbraith <efault@gmx.de>, Andi Kleen <ak@suse.de>,
       Christopher Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org
Subject: Re: sched_clock() uses are broken
Message-ID: <20060507124307.GA20443@flint.arm.linux.org.uk>
Mail-Followup-To: Nick Piggin <nickpiggin@yahoo.com.au>,
	Mike Galbraith <efault@gmx.de>, Andi Kleen <ak@suse.de>,
	Christopher Friesen <cfriesen@nortel.com>,
	linux-kernel@vger.kernel.org
References: <20060502132953.GA30146@flint.arm.linux.org.uk> <p73slns5qda.fsf@bragg.suse.de> <44578EB9.8050402@nortel.com> <200605021859.18948.ak@suse.de> <445791D3.9060306@yahoo.com.au> <1146640155.7526.27.camel@homer> <445DE925.9010006@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <445DE925.9010006@yahoo.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 07, 2006 at 10:33:41PM +1000, Nick Piggin wrote:
> Mike Galbraith wrote:
> >On Wed, 2006-05-03 at 03:07 +1000, Nick Piggin wrote:
> >
> >>Other problem is that some people didn't RTFM and have started trying to
> >>use it for precise accounting :(
> >
> >
> >Are you talking about me perchance?  I don't really care about precision
> >_that_ much, though I certainly do want to tighten timeslice accounting.
> 
> No, sched_clock is fine to be used in CPU scheduling choices, which are
> heuristic anyway (although strictly speaking, even using it for timeslicing
> within a single CPU could cause slight unfairness).

Except maybe if it rolls over every 178 seconds, which is my original
point.  Maybe someone could comment on my initial patch sent 5 days
ago?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
