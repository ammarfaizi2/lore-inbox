Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbTKTTr6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 14:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbTKTTr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 14:47:58 -0500
Received: from dp.samba.org ([66.70.73.150]:1675 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261957AbTKTTr4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 14:47:56 -0500
Date: Fri, 21 Nov 2003 06:46:44 +1100
From: Anton Blanchard <anton@samba.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: john stultz <johnstul@us.ibm.com>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: high res timestamps and SMP
Message-ID: <20031120194644.GA11889@krispykreme>
References: <3FBBF148.20203@nortelnetworks.com> <1069297341.23568.130.camel@cog.beaverton.ibm.com> <16316.38292.729957.491201@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16316.38292.729957.491201@alkaid.it.uu.se>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> Last time I checked, all 32-bit PowerPC chips ran that clock at 1/4
> of the bus clock speed.

It depends on the chip, on recent ppc64 boxes its 1/8 of the processor
clock speed.

> That may be adequate for time-of-day and I/O delays and such, but
> it's worthless for timestamps or performance measurements.

Can you show me the application that depends on timestamps being that
accurate?

Running the multiplier at a set fraction of the processor speed
is a good idea I think. Go look at any large x86 box (and possibly ia64
box) and you will find the timebases are not synced. Even our biggest
box has the timebase synced, its easy to do when the timebase is running
at a reasonable rate.

In a trade off between unsynced timebases and timebase running at a
fraction of the cpu speed, ill take the latter :) (Ask the x86 guys what
a pain unsynced timebases are)

Anton
