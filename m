Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbVHYSKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbVHYSKU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 14:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbVHYSKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 14:10:20 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:53679 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751387AbVHYSKS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 14:10:18 -0400
Subject: Re: [RFC - 0/9] Generic timekeeping subsystem  (v. B5)
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Nishanth Aravamudan <nacc@us.ibm.com>, benh@kernel.crashing.org,
       Anton Blanchard <anton@samba.org>, frank@tuxrocks.com,
       George Anzinger <george@mvista.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0508250102020.3743@scrub.home>
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
	 <1124906422.20820.16.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508242043220.3728@scrub.home>
	 <1124910953.20820.34.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508242142420.3743@scrub.home>
	 <1124923231.20820.87.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508250102020.3743@scrub.home>
Content-Type: text/plain
Date: Thu, 25 Aug 2005 11:08:52 -0700
Message-Id: <1124993333.20820.195.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-25 at 02:45 +0200, Roman Zippel wrote:
> Hi,
> 
> On Wed, 24 Aug 2005, john stultz wrote:
> 
> > Ok, well, I'm still at a loss for understanding how this avoids my
> > concern about time inconsistencies.
> 
> Let's take a simple example to demonstrate the difference between system 
> time and reference time.

[snip]

> 		17000		16974		8	-26
> 18		18000		17958		8	-42
> 19		19000		18942		8	-58
> 20		20000		19926		8	-74
> 
> let's assume we're late with the update by 10 cycles 
> (gettimeofday=19926+10*8=20006), so a change to the mult also requires a 
> adjustment of the system time:
> 
> 20+10		20000		19916		9	-84
> 
> so gettimeofday=19916+10*9=20006

Hey Roman, 
	Thanks for your patient persistence. The light bulb finally clicked on
for me last night. I'll start playing with the idea and get back to
you. 

thanks again,
-john

