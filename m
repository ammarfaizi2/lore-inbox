Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265659AbUBPOaw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 09:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265667AbUBPOaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 09:30:52 -0500
Received: from mail011.syd.optusnet.com.au ([211.29.132.65]:49810 "EHLO
	mail011.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265659AbUBPOat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 09:30:49 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [BENCHMARK] 2.6.3-rc2 v 2.6.3-rc3-mm1 kernbench
Date: Tue, 17 Feb 2004 01:30:24 +1100
User-Agent: KMail/1.6
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200402170000.00524.kernel@kolivas.org> <4030C38A.4050909@cyberone.com.au>
In-Reply-To: <4030C38A.4050909@cyberone.com.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402170130.24070.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Feb 2004 00:20, Nick Piggin wrote:
> Con Kolivas wrote:
> >-----BEGIN PGP SIGNED MESSAGE-----
> >Hash: SHA1
> >
> >Here's some nice evidence of the sched domains' patch value:
> >kernbench 0.20 running on an X440 8x1.5Ghz P4HT (2 node)
> >
> >Time is in seconds. Lower is better (fixed font table)
> >
> >Summary:
> >Kernel:		2.6.3-rc2	2.6.3-rc3-mm1
> >Half(-j8)	120.8		113.0
> >Optimal(-j64)	81.6		79.3
> >Max(-j)		82.9		80.3
> >
> >
> >shorter summary:
> >2.6.3-rc3-mm1 kicks butt
>
> Thanks Con,
> Results look pretty good. The half-load context switches are
> increased - that is probably a result of active balancing.
> And speaking of active balancing, it is not yet working across
> nodes with the configuration you're on.
>
> To get some idea of our worst case SMT performance (-j8), would
> it be possible to do -j8 and -j64 runs with HT turned off?

sure.

results.2.6.3-rc3-mm1 + SMT:
Average Half Load Run:
Elapsed Time 113.008
User Time 742.786
System Time 90.65
Percent CPU 738
Context Switches 28062.6
Sleeps 24571.8

Average Optimum Load Run:
Elapsed Time 79.278
User Time 1007.69
System Time 107.388
Percent CPU 1407
Context Switches 33355
Sleeps 32720


2.6.3-rc3-mm1 no SMT:
Average Half Load Run:
Elapsed Time 133.51
User Time 799.268
System Time 92.784
Percent CPU 669
Context Switches 19340.8
Sleeps 24427.4

Average Optimum Load Run:
Elapsed Time 81.486
User Time 1006.37
System Time 106.952
Percent CPU 1366.8
Context Switches 33939
Sleeps 32453.4


Con
