Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbVLaEyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbVLaEyR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 23:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbVLaEyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 23:54:17 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:32733 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751303AbVLaEyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 23:54:17 -0500
Subject: Re: [patch] latency tracer, 2.6.15-rc7
From: Lee Revell <rlrevell@joe-job.com>
To: paulmck@us.ibm.com
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Dave Jones <davej@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Eric Dumazet <dada1@cosmosbay.com>,
       Dipankar Sarma <dipankar@in.ibm.com>
In-Reply-To: <20051231042902.GA3428@us.ibm.com>
References: <1135887072.6804.9.camel@mindpipe>
	 <1135887966.6804.11.camel@mindpipe> <20051229202848.GC29546@elte.hu>
	 <1135908980.4568.10.camel@mindpipe> <20051230080032.GA26152@elte.hu>
	 <1135990270.31111.46.camel@mindpipe>
	 <Pine.LNX.4.64.0512301701320.3249@g5.osdl.org>
	 <1135991732.31111.57.camel@mindpipe>
	 <Pine.LNX.4.64.0512301726190.3249@g5.osdl.org>
	 <1136001615.3050.5.camel@mindpipe>  <20051231042902.GA3428@us.ibm.com>
Content-Type: text/plain
Date: Fri, 30 Dec 2005 23:54:14 -0500
Message-Id: <1136004855.3050.8.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-30 at 20:29 -0800, Paul E. McKenney wrote:
> This should help in UP configurations, or in SMP configurations where
> all CPUs are doing call_rcu_bh() very frequently.  I would not expect
> it to help in cases where one of several CPUs is frequently executing
> call_rcu_bh(), but where the other CPUs are either CPU-bound in user
> space or are in a tickful idle state. 

This and net/decnet/dn_route.c are the only two uses of call_rcu_bh in
the kernel.  And this one does not seem to be invoked frequently, it
took ~48 hours to show up in the latency tracer.  Of course a server
workload might call it all the time.

Lee

