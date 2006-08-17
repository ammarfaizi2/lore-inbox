Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbWHQV6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbWHQV6l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 17:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbWHQV6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 17:58:41 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:2473 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932376AbWHQV6k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 17:58:40 -0400
Subject: Re: Linux time code
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       linux-kernel@vger.kernel.org, Udo van den Heuvel <udovdh@xs4all.nl>
In-Reply-To: <Pine.LNX.4.64.0608171334030.6761@scrub.home>
References: <44E32B23.16949.BBB1EC4@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
	 <1155758034.5513.69.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0608171334030.6761@scrub.home>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 14:58:37 -0700
Message-Id: <1155851917.31755.125.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 13:43 +0200, Roman Zippel wrote:
> On Wed, 16 Aug 2006, john stultz wrote:
> > > For example there is a POSIX-like sys_clock_gettime() intended to 
> > > server the end-user directly, but there's no counterpart do_clock_gettime() to 
> > > server any in-kernel needs. 
> > 
> > Hmmm.. ktime_get(), ktime_get_ts() and ktime_get_real(), provide this
> > info. Is there something missing here?
> 
> What is missing is the abiltity to map a clock to a posix clock, so that 
> you would have CLOCK_REALTIME/CLOCK_MONOTONIC as NTP controlled clocks and 
> other CLOCK_* as the raw clock.

Is there a use case for this (wanting non-NTP corrected time on a system
running NTPd) you have in mind?

I'm not strictly opposed to this idea, but since it exposes a new
interface to userland it needs to be carefully thought out and well
understood.

thanks
-john

