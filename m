Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267654AbUGWLmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267654AbUGWLmm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 07:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267655AbUGWLmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 07:42:42 -0400
Received: from mproxy.gmail.com ([216.239.56.253]:36403 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267654AbUGWLmk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 07:42:40 -0400
Message-ID: <4d8e3fd30407230442afe80c1@mail.gmail.com>
Date: Fri, 23 Jul 2004 13:42:37 +0200
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-I3
Cc: linux-kernel@vger.kernel.org, Rudo Thomas <rudo@matfyz.cz>,
       Matt Heler <lkml@lpbproductions.com>
In-Reply-To: <20040723110430.GA3787@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040722100657.GA14909@elte.hu> <20040722160055.GA4837@ss1000.ms.mff.cuni.cz> <20040722161941.GA23972@elte.hu> <20040722172428.GA5632@ss1000.ms.mff.cuni.cz> <20040722175457.GA5855@ss1000.ms.mff.cuni.cz> <20040722180142.GC30059@elte.hu> <20040722180821.GA377@elte.hu> <20040722181426.GA892@elte.hu> <20040723104246.GA2752@elte.hu> <4d8e3fd30407230358141e0e58@mail.gmail.com> <20040723110430.GA3787@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jul 2004 13:04:30 +0200, Ingo Molnar <mingo@elte.hu> wrote:
> 
> * Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
> 
> > > i've uploaded the -I3 voluntary-preempt patch:
> > >
> > >  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc2-I3
> > >
> > > it mainly fixes an ext3 livelock that could result in long delays during
> > > heavy commit traffic.
> >
> > Hello Ingo, do you have any measurement of the improvement available ?
> 
> it's a bug in the patch, not really a latency fix. When this (rare)
> condition under heavy write traffic occurs then kjournald would loop for
> many seconds (or tens of seconds) in __journal_clean_checkpoint_list(),
> effectively hanging the system. The system is still preemptible but the
> user cannot do much with it. Note that this condition is not present in
> the vanilla kernel, it got introduced by earlier versions of
> voluntary-preempt.

Hi Ingo,
thanks for the clarification.

What about performance of vanilla vs voluntary-preempt-2.6.8-rc2-I3 ?
Do you have numbers available ? Can we, somehow, support you ?

Ciao,
                Paolo
