Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbVHXSA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbVHXSA2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 14:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbVHXSA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 14:00:28 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:1528 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751331AbVHXSA1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 14:00:27 -0400
Subject: Re: [RFC - 0/9] Generic timekeeping subsystem  (v. B5)
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Nishanth Aravamudan <nacc@us.ibm.com>, benh@kernel.crashing.org,
       Anton Blanchard <anton@samba.org>, frank@tuxrocks.com,
       George Anzinger <george@mvista.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0508240134050.3743@scrub.home>
References: <1123723279.30963.267.camel@cog.beaverton.ibm.com>
	 <1123726394.32531.33.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508152115480.3728@scrub.home>
	 <1124151001.8630.87.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508162337130.3728@scrub.home>
	 <1124241449.8630.137.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508182213100.3728@scrub.home>
	 <1124505151.22195.78.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508202204240.3728@scrub.home>
	 <1124737075.22195.114.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508230134210.3728@scrub.home>
	 <1124830262.20464.26.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508232321530.3728@scrub.home>
	 <1124838847.20617.11.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508240134050.3743@scrub.home>
Content-Type: text/plain
Date: Wed, 24 Aug 2005 11:00:22 -0700
Message-Id: <1124906422.20820.16.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-24 at 01:54 +0200, Roman Zippel wrote:
> Hi,
> 
> On Tue, 23 Aug 2005, john stultz wrote:
> 
> > I'm assuming gettimeofday()/clock_gettime() looks something like:
> >    xtime + (get_cycles()-last_update)*(mult+ntp_adj)>>shift
> 
> Where did you get the ntp_adj from? It's not in my example.
> gettimeofday() was in the previous mail: "xtime + (cycle_offset * mult +
> error) >> shift". The difference between system time and reference 
> time is really important. gettimeofday() returns the system time, NTP 
> controls the reference time and these two are synchronized regularly.
> I didn't see that anywhere in your example.

Ok, so then to clarify the above (as you mention gettimeofday uses
system_time), would your gettimeofday look something like:

gettiemofday():
	return (system_time + (cycle_offset * mult) + error)>> shift

?

thanks
-john

