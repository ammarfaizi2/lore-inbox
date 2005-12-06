Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbVLFKf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbVLFKf1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 05:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbVLFKf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 05:35:26 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:1431 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932132AbVLFKf0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 05:35:26 -0500
Date: Tue, 6 Dec 2005 11:35:04 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Darren Hart <dvhltc@us.ibm.com>, Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/13] Time: Reduced NTP Rework (part 2)
In-Reply-To: <20051206072708.GA25129@elte.hu>
Message-ID: <Pine.LNX.4.61.0512061130410.1609@scrub.home>
References: <4390E48E.4020005@mvista.com>
 <4395475C.21877.29399CFE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
 <20051206072708.GA25129@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 6 Dec 2005, Ingo Molnar wrote:

> > > I'm thinking about moving the leap second handling to a timer, with the 
> > > new timer system it would be easy to set a timer for e.g. 23:59.59 and 
> > > then set the time. This way it would be gone from the common path and it 
> > > wouldn't matter that much anymore whether it's used or not.
> > 
> > Will the timer solution guarantee consistent and exact updates?
> 
> it would still be dependent on system-load situations.

Interrupt-load, actually.

> It's an 
> interesting idea to use a timer for that, but there is no strict 
> synchronization between "get time of day" and "timer execution", so any 
> timer-based leap-second handling would be fundamentally asynchronous. I 
> dont think we want that, leap second handling should be a synchronous 
> property of 'time'.

I'm not really sure what you're talking about. Could you please elaborate 
on "fundamentally asynchronous" and "synchronous property of 'time'"?

bye, Roman
