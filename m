Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267339AbTAQA0H>; Thu, 16 Jan 2003 19:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267340AbTAQA0H>; Thu, 16 Jan 2003 19:26:07 -0500
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:2697 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S267339AbTAQA0A>; Thu, 16 Jan 2003 19:26:00 -0500
Message-ID: <3E274FB1.EF85F6E0@attbi.com>
Date: Thu, 16 Jan 2003 19:34:57 -0500
From: Jim Houston <jim.houston@attbi.com>
Reply-To: jim.houston@attbi.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
CC: linux-kernel@vger.kernel.org,
       high-res-timers-discourse@lists.sourceforge.net, jim.houston@ccur.com
Subject: Re: [PATCH] improved boot time TSC synchronization
References: <200301161644.h0GGitX02052@linux.local> <20030116213332.GA14040@bjl1.asuk.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> 
> It looks like not only can you synchronise with a certain accuracy,
> you can determine an upper bound on that accuracy (assuming the
> underlying CPU clocks are locked).
> 
> Maybe that figure could be put into /proc/cpuinfo?
> 
> As well as being an interesting value, it may be useful for programs
> to know the effective accuracy of `rdtsc'.
> 
> -- Jamie

Hi Jamie,

Yeah, I'd be glad to add the round-trip time to cpuinfo.  I see
this as a bogomips like metric.  It tells you how quickly you 
can move cache lines from chip to chip.

The patch currently prints the round-trip time and the max_delta.
On a Quad P4 Xeon, I got round-trip times in the 0.7 microsecond
range which is disappointing. The max_delta was almost always
zero cycles meaning that the feedback loop thinks that the TSC values
are perfectly synchronized.

Jim Houston - Concurrent Computer Corp.
