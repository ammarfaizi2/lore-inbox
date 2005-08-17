Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbVHQARf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbVHQARf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 20:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbVHQARe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 20:17:34 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:5316 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750769AbVHQARe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 20:17:34 -0400
Subject: Re: [RFC - 0/9] Generic timekeeping subsystem  (v. B5)
From: john stultz <johnstul@us.ibm.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, lkml <linux-kernel@vger.kernel.org>,
       George Anzinger <george@mvista.com>, frank@tuxrocks.com,
       Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
In-Reply-To: <Pine.LNX.4.62.0508161710580.9829@schroedinger.engr.sgi.com>
References: <1123723279.30963.267.camel@cog.beaverton.ibm.com>
	 <1123726394.32531.33.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508152115480.3728@scrub.home>
	 <1124151001.8630.87.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.62.0508161116270.7101@schroedinger.engr.sgi.com>
	 <1124236081.8630.110.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.62.0508161710580.9829@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Tue, 16 Aug 2005 17:17:29 -0700
Message-Id: <1124237849.8630.112.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-16 at 17:14 -0700, Christoph Lameter wrote:
> On Tue, 16 Aug 2005, john stultz wrote:
> 
> > This is basically what I do in my patch. I directly apply the NTP
> > adjustment to the timesource interval, and periodically increment the
> > NTP state machine by the timesource interval when we accumulate it.
> 
> Is there some way to tell the NTP code how much the time_interpolator time 
> deviates from xtime?
> 
> If the NTP code would use getnstimeofday or 
> do_gettimeofday then it would already get interpolated time.

That seems a bit backwards, no?

> The curious issue in the current arrangement is that the interpolator 
> knows much more accurately how much time has passed between interrupts 
> than the timer interrupt but it has no time to make that information 
> available to the NTP code.

That is why I'm suggesting time_interpolator users to move to my code
(when they're ready, of course :).

thanks
-john


