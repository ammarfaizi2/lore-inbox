Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274749AbSITD5J>; Thu, 19 Sep 2002 23:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274852AbSITD5J>; Thu, 19 Sep 2002 23:57:09 -0400
Received: from franka.aracnet.com ([216.99.193.44]:48293 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S274749AbSITD5I>; Thu, 19 Sep 2002 23:57:08 -0400
Date: Thu, 19 Sep 2002 21:00:09 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [BUG] x86_udelay_tsc not honoring notsc
Message-ID: <466275568.1032469207@[10.10.2.3]>
In-Reply-To: <20020920035258.GR28202@holomorphy.com>
References: <20020920035258.GR28202@holomorphy.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Does this help (on top of John's TSC patch in rollup 0)?
> 
> Nope. But I believe I found the root cause: it apparently takes
> long enough to kick all the cpus the NMI oopser goes off during
> one of the many long ints-off sections in the bootstrap phase. My
> burning question now is why this only showed up in 2.5.36. Somehow
> I mistook a rather blatant (c.f. SIGEMT) NMI oops for TSD %cr4 #GP.
> 
> I'm going to guess the NMI oopser was not eager enough to trip
> beforehand and recent changes repaired that. Is this close?
> 
> If so, it's probably not worth mucking around with the bootstrap
> sequence to deal with something this minor. It's not like it can
> be mistaken for having hung, as console output is very consistent.
> Maybe we should give NUMA-Q a couple of minutes instead of 5s?

Nah, just recode the boot sequence to make them all boot in 
parallel ;-)

M.

