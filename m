Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268040AbUHQAGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268040AbUHQAGc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 20:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268029AbUHQAGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 20:06:32 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:10906 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268031AbUHQADx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 20:03:53 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P2
From: Lee Revell <rlrevell@joe-job.com>
To: Thomas Charbonnel <thomas@undata.org>
Cc: Ingo Molnar <mingo@elte.hu>, Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <1092665577.5362.12.camel@localhost>
References: <20040816023655.GA8746@elte.hu>
	 <1092624221.867.118.camel@krustophenia.net>
	 <20040816032806.GA11750@elte.hu> <20040816033623.GA12157@elte.hu>
	 <1092627691.867.150.camel@krustophenia.net>
	 <20040816034618.GA13063@elte.hu> <1092628493.810.3.camel@krustophenia.net>
	 <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost>
	 <20040816113131.GA30527@elte.hu>  <20040816120933.GA4211@elte.hu>
	 <1092662814.5082.2.camel@localhost>  <1092665577.5362.12.camel@localhost>
Content-Type: text/plain
Message-Id: <1092701086.13981.103.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 16 Aug 2004 20:04:47 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-16 at 10:12, Thomas Charbonnel wrote:
> I wrote :
> > Ingo Molnar wrote :
> > > here's -P2:
> > > 
> > >  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P2
> > > 
> > > Changes since -P1:
> > > 
> > >  - trace interrupted kernel code (via hardirqs, NMIs and pagefaults)
> > > 
> > >  - yet another shot at trying to fix the IO-APIC/USB issues.
> > > 
> > >  - mcount speedups - tracing should be faster
> > > 
> > > 	Ingo
> > 
> > Same do_IRQ problem with P2, trace is here :
> > http://www.undata.org/~thomas/swapper-P2.trace
> > 
> > Thomas
> > 
> 
> Ok, maybe that was a false positive. In fact the trace corresponds to
> some preempt violation occurring during the boot process :
> preemption latency trace v1.0
> -----------------------------
>  latency: 136095 us, entries: 4000 (14818)
>  process: swapper/1, uid: 0
>  nice: 0, policy: 0, rt_priority: 0

Yes, I get this one too.  Maybe the tracer should ignore such huge
values, as they seem to only happen during boot and there dosn't seem to
be a reason to fix them.

Lee


