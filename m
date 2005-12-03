Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbVLCAfw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbVLCAfw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 19:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbVLCAfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 19:35:52 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:23276 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751130AbVLCAfw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 19:35:52 -0500
Subject: Re: [PATCH 2/13] Time: Reduced NTP Rework (part 2)
From: john stultz <johnstul@us.ibm.com>
To: george@mvista.com
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Darren Hart <dvhltc@us.ibm.com>, Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <4390E48E.4020005@mvista.com>
References: <20051202032551.19357.51421.sendpatchset@cog.beaverton.ibm.com>
	 <20051202032604.19357.59425.sendpatchset@cog.beaverton.ibm.com>
	 <4390E48E.4020005@mvista.com>
Content-Type: text/plain
Date: Fri, 02 Dec 2005 16:35:44 -0800
Message-Id: <1133570144.7605.32.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-02 at 16:19 -0800, George Anzinger wrote:
> john stultz wrote:
> > All,
> > 	Here is the second of two patches which try to minimize my ntp rework
> > patches.
> > 	
> > This patch further changes the interrupt time NTP code, breaking out the
> > leapsecond processing and introduces an accessor to a shifted ppm
> 
> In a discusson aroung the leapsecond and how to disable it (some folks 
> don't want the time jump) it came to light that, for the most part, 
> this is unused code.  It requires that time be kept in UST to be 
> useful and, from what I can tell, most folks keep time in their local 
> timezone, thus, effectively, disableing the usage of the leapsecond 
> correction (ntp figures this out and just says "no").  Possibly it is 
> time to ask if we should keep this in the kernel at all.

Well, I'm trying explicitly to not change the kernel's current NTP
behavior. Instead I'm trying to allow the current NTP behavior to apply
to a continuous clocksource to avoid interpolation error and other
problems with irregular timer interrupts.

Although Its an interesting point, and I'm not opposed to discussing it,
its just not really relevant to the patch. So you might want to start a
new thread.

Also, I think the debate has been brought up a number of times on
comp.protocols.time.ntp, so you might want to check there first.

thanks
-john

