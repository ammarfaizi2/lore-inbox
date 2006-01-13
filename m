Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422830AbWAMTHf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422830AbWAMTHf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 14:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422829AbWAMTHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 14:07:34 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:62717 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1422830AbWAMTHc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:07:32 -0500
Subject: Re: Dual core Athlons and unsynced TSCs
From: Sven-Thorsten Dietrich <sven@mvista.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: thockin@hockin.org, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1137178855.15108.42.camel@mindpipe>
References: <1137104260.2370.85.camel@mindpipe>
	 <20060113180620.GA14382@hockin.org> <1137175117.15108.18.camel@mindpipe>
	 <20060113181631.GA15366@hockin.org> <1137175792.15108.26.camel@mindpipe>
	 <20060113185533.GA18301@hockin.org>
	 <1137178574.2536.13.camel@localhost.localdomain>
	 <1137178855.15108.42.camel@mindpipe>
Content-Type: text/plain
Organization: MontaVista Software, Inc.
Date: Fri, 13 Jan 2006 11:07:28 -0800
Message-Id: <1137179248.2536.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-13 at 14:00 -0500, Lee Revell wrote:
> On Fri, 2006-01-13 at 10:56 -0800, Sven-Thorsten Dietrich wrote:
> > On Fri, 2006-01-13 at 10:55 -0800, thockin@hockin.org wrote:
> > > On Fri, Jan 13, 2006 at 01:09:51PM -0500, Lee Revell wrote:
> > > > > Some apps/users need higher resolution and lower overhead that only rdtsc
> > > > > can offer currently.
> > > > 
> > > > But obviously if the TSC gives wildly inaccurate results, it cannot be
> > > > used no matter how low the overhead.
> > > 
> > > unless we can re-sync the TSCs often enough that apps don't notice.
> > > 
> > 
> > You'd have to quantify that somehow, in terms of the max drift rate
> > (ppm), and the max resolution available (< tsc frequency).  
> > 
> > Either that, or track an offset, and use one TSC as truth, and update
> > the correction factor for the other TSCs as often as needed, maybe?
> > 
> > This is kind of analogous to the "drift" NTP calculates against a
> > free-running oscillator. 
> > 
> > So you'd be pushing that functionality deeper into the OS-core.
> > 
> > Dave Mills had that "hardpps" stuff in there for a while, it might be a
> > starting point.
> > 
> > Just some thoughts for now... 
> > 
> 
> It kind of makes you wonder what in the heck AMD were thinking, whether
> they realized that this design decision would cause so many problems at
> the OS level (it's broken at least Linux and Solaris).  Maybe Windows
> keeps time in a way that was unaffected by this?
> 

Last time I looked at Windows, we had to create an RT task to
interpolate between jiffies, b/c Windows was only keeping time at the
10 / 16 (smp) ms resolution. (to get NTP to run)

That was 6 years ago. 

I haven't looked back since, and may I turn to salt or stone if I ever
do.

> Lee
> 
-- 
***********************************
Sven-Thorsten Dietrich
Real-Time Software Architect
MontaVista Software, Inc.
1237 East Arques Ave.
Sunnyvale, CA 94085

Phone: 408.992.4515
Fax: 408.328.9204

http://www.mvista.com
Platform To Innovate
*********************************** 

