Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271898AbTHMU5r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 16:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275553AbTHMU5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 16:57:47 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:45831 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S271898AbTHMU5q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 16:57:46 -0400
Date: Wed, 13 Aug 2003 16:49:23 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Andrew Theurer <habanero@us.ibm.com>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, Erich Focht <efocht@hpce.nec.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>, Andi Kleen <ak@muc.de>,
       torvalds@osdl.org
Subject: Re: [patch] scheduler fix for 1cpu/node case
In-Reply-To: <200307282124.28378.habanero@us.ibm.com>
Message-ID: <Pine.LNX.3.96.1030813163849.12417I-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jul 2003, Andrew Theurer wrote:

> Personally, I'd like to see all systems use NUMA sched, non NUMA systems being 
> a single node (no policy difference from non-numa sched), allowing us to 
> remove all NUMA ifdefs.  I think the code would be much more readable.

That sounds like a great idea, but I'm not sure it could be realized short
of a major rewrite. Look how hard Ingo and Con are working just to get a
single node doing a good job with interactive and throughput tradeoffs.

Once they get a good handle on identifying process behaviour, and I
believe they will, that information could be used in improving NUMA
performance, by sending not just 'a job" but "the right job" if it exists.
I'm sure there are still a few graduate theses possible on the topic!

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

