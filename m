Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263413AbUC3B14 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 20:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263425AbUC3B1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 20:27:55 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:49646 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263413AbUC3B1x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 20:27:53 -0500
Message-Id: <200403300126.i2U1QUV06881@owlet.beaverton.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>,
       jun.nakajima@intel.com, piggin@cyberone.com.au,
       linux-kernel@vger.kernel.org, akpm@osdl.org, kernel@kolivas.org,
       rusty@rustcorp.com.au, anton@samba.org, lse-tech@lists.sourceforge.net,
       mbligh@aracnet.com
Subject: Re: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3 
In-reply-to: Your message of "Tue, 30 Mar 2004 10:01:44 +1000."
             <4068B8E8.2030407@yahoo.com.au> 
Date: Mon, 29 Mar 2004 17:26:30 -0800
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    This looks very cool. Very comprehensive. Have you got any
    plans to intergrate it with sched_domains (so for example,
    you can see stats for each domain)?

Yes -- ideally we can add some stats to domains too, so we can tell
(for example) how often it is adjusting rebalance intervals, or how many
processes are moved as a result of each domain's policy, etc.  Every time
I add another counter I cringe a bit, because we don't want to impose
overhead in the scheduler.  But so far,  using per-cpu data, utilizing
runqueue locking when it's in use, and accepting minor inaccuracies that
may result from the remaining cases, seems to be yielding a pretty good
picture of things without imposing a measurable load.

If you want to start using it yourself, I'm open to feedback.  I have patches
for major releases at

    http://oss.software.ibm.com/linux/patches/?patch_id=730

and a host of smaller releases (like rc2-mm5) at eaglet:

    http://eaglet.rain.com/rick/linux/schedstat/

If you're feeling *really* lucky I have a handful of useful but often
ungeneralized tools I can share,  like the the ones that made that web
page.

Rick
