Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272325AbTHOX1M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 19:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272329AbTHOX1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 19:27:11 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:2023 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S272325AbTHOX1J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 19:27:09 -0400
Subject: Re: PIT, TSC and power management [was: Re: 2.6.0-test3 "loosing
	ticks"]
From: john stultz <johnstul@us.ibm.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Charles Lepple <clepple@ghz.cc>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030815231249.GE19707@mail.jlokier.co.uk>
References: <20030813014735.GA225@timothyparkinson.com>
	 <1060793667.10731.1437.camel@cog.beaverton.ibm.com>
	 <20030814171703.GA10889@mail.jlokier.co.uk>
	 <1060882084.10732.1588.camel@cog.beaverton.ibm.com>
	 <3F3C272E.7060702@ghz.cc>
	 <1060969733.10731.1604.camel@cog.beaverton.ibm.com>
	 <20030815231249.GE19707@mail.jlokier.co.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1060989910.10732.1617.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 15 Aug 2003 16:25:10 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-08-15 at 16:12, Jamie Lokier wrote:
> john stultz wrote:
> > Well, depending on how ntp is compiled, it could use stime, rather then
> > settimeofday. This causes ntp to set the time on average .5 seconds off
> > the desired time. Since .5 is outside the .128 sec slew boundary, ntp 
> > will do another step adjustment which has the same poor accuracy. This
> > results in ntp just hopping back and forth around the desired time. 
> 
> On my more-or-less Red Hat 9 system, it would be quite surprising if
> the ntpd which works with 2.4 suddenly stopped working...

Yea, I don't think this is the issue. RH9 doesn't have this problem. I
was just explaining why I asked if ntpdate -b <server> set the time
properly on his box.

Really I think the amd76x_pm module is cause, as it seems to changes the
cpu frequency and I'm suspecting it doesn't use the cpu_freq notifiers.
I'd be quite interested to see if the issue still appears when you're
not running that module. 

thanks
-john




