Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750969AbVLEKgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbVLEKgZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 05:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbVLEKgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 05:36:25 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:24204 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750969AbVLEKgY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 05:36:24 -0500
Date: Mon, 5 Dec 2005 11:35:57 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: George Anzinger <george@mvista.com>
cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Darren Hart <dvhltc@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/13] Time: Reduced NTP Rework (part 2)
In-Reply-To: <4390E48E.4020005@mvista.com>
Message-ID: <Pine.LNX.4.61.0512051132460.1609@scrub.home>
References: <20051202032551.19357.51421.sendpatchset@cog.beaverton.ibm.com>
 <20051202032604.19357.59425.sendpatchset@cog.beaverton.ibm.com>
 <4390E48E.4020005@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2 Dec 2005, George Anzinger wrote:

> In a discusson aroung the leapsecond and how to disable it (some folks don't
> want the time jump) it came to light that, for the most part, this is unused
> code.  It requires that time be kept in UST to be useful and, from what I can
> tell, most folks keep time in their local timezone, thus, effectively,
> disableing the usage of the leapsecond correction (ntp figures this out and
> just says "no").  Possibly it is time to ask if we should keep this in the
> kernel at all.

I'm thinking about moving the leap second handling to a timer, with the 
new timer system it would be easy to set a timer for e.g. 23:59.59 and 
then set the time. This way it would be gone from the common path and it 
wouldn't matter that much anymore whether it's used or not.

bye, Roman
