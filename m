Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267361AbUHPCpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267361AbUHPCpE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 22:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267363AbUHPCpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 22:45:04 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:14503 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267361AbUHPCov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 22:44:51 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P0
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040816024314.GA8960@elte.hu>
References: <20040809104649.GA13299@elte.hu>
	 <20040810132654.GA28915@elte.hu> <20040812235116.GA27838@elte.hu>
	 <1092382825.3450.19.camel@mindpipe> <20040813104817.GI8135@elte.hu>
	 <1092432929.3450.78.camel@mindpipe> <20040814072009.GA6535@elte.hu>
	 <20040815115649.GA26259@elte.hu> <20040816022554.16c3c84a@mango.fruits.de>
	 <1092622121.867.109.camel@krustophenia.net> <20040816024314.GA8960@elte.hu>
Content-Type: text/plain
Message-Id: <1092624336.867.121.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 15 Aug 2004 22:45:37 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-15 at 22:43, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > http://krustophenia.net/testresults.php?dataset=2.6.8.1-P0
> 
> nice. (What is the difference between the left-hand and the right-hand
> graphs - why is the right-hand side one 'wider'?)
> 

The right hand graph is logarithmically scaled on the y axis (set
logscale y in gnuplot).  Some of the latencies are rare enough to not
show up at all on the linear scale, like the peak in the 400s.

> > The peaks on this graph should correspond directly to the length of
> > the non-preemptible critical section reported by Ingo's latency
> > tracer.  I think the large peak around 580-600usecs is caused by the
> > extract_entropy issue (which can be hit by regular processes and
> > ksoftirqd), and the large peak around 80-100 by the XFree86 unmap_vmas
> > issue, as the times match and these are by far the most common
> > reported in latency_trace.
> 
> just to check this theory, could you make __check_and_rekey() an empty
> function? This should still produce a working random driver, albeit at
> much reduced entropy. If these latencies have a relationship to the
> mlockall() issue then this change should have an effect.
> 

Sure, will try this next.

Lee

