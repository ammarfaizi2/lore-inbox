Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267270AbTAPVZA>; Thu, 16 Jan 2003 16:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267278AbTAPVZA>; Thu, 16 Jan 2003 16:25:00 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:47553 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S267270AbTAPVY7>;
	Thu, 16 Jan 2003 16:24:59 -0500
Date: Thu, 16 Jan 2003 21:33:32 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Jim Houston <jim.houston@attbi.com>
Cc: linux-kernel@vger.kernel.org,
       high-res-timers-discourse@lists.sourceforge.net, jim.houston@ccur.com
Subject: Re: [PATCH] improved boot time TSC synchronization
Message-ID: <20030116213332.GA14040@bjl1.asuk.net>
References: <200301161644.h0GGitX02052@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301161644.h0GGitX02052@linux.local>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Houston wrote:
> + *	t0 ---\
> + *             ---\
> + *		   --->
> + *			tm
> + *		   /---
> + *	       /---
> + *	t1 <---
> + *
> + *
> + * The goal is to adjust the slave's TSC such that tm falls exactly half-way
> + * between t0 and t1.

It looks like not only can you synchronise with a certain accuracy,
you can determine an upper bound on that accuracy (assuming the
underlying CPU clocks are locked).

Maybe that figure could be put into /proc/cpuinfo?

As well as being an interesting value, it may be useful for programs
to know the effective accuracy of `rdtsc'.

-- Jamie
