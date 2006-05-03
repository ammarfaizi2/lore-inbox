Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965122AbWECHIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965122AbWECHIq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 03:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965124AbWECHIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 03:08:46 -0400
Received: from mail.gmx.de ([213.165.64.20]:48596 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965123AbWECHIp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 03:08:45 -0400
X-Authenticated: #14349625
Subject: Re: sched_clock() uses are broken
From: Mike Galbraith <efault@gmx.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andi Kleen <ak@suse.de>, Christopher Friesen <cfriesen@nortel.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <445791D3.9060306@yahoo.com.au>
References: <20060502132953.GA30146@flint.arm.linux.org.uk>
	 <p73slns5qda.fsf@bragg.suse.de> <44578EB9.8050402@nortel.com>
	 <200605021859.18948.ak@suse.de>  <445791D3.9060306@yahoo.com.au>
Content-Type: text/plain
Date: Wed, 03 May 2006 09:09:15 +0200
Message-Id: <1146640155.7526.27.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-03 at 03:07 +1000, Nick Piggin wrote:
> Other problem is that some people didn't RTFM and have started trying to
> use it for precise accounting :(

Are you talking about me perchance?  I don't really care about precision
_that_ much, though I certainly do want to tighten timeslice accounting.

Given that most people are going to end up using the pm_timer anyway, I
don't see the point of even having a sched_clock().  If it's jiffy
resolution, it's useless.  If it's wildly inaccurate (as it is in the
SMP case, monotonicity issues aside) it's more than useless.

	-Mike

