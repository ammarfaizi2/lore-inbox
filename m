Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbULIOd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbULIOd4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 09:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbULIOd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 09:33:56 -0500
Received: from bgm-24-94-57-164.stny.rr.com ([24.94.57.164]:27817 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261474AbULIOdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 09:33:52 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-12
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>,
       Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>,
       "K.R. Foley" <kr@cybsft.com>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>, emann@mrv.com,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
In-Reply-To: <20041209131317.GA31573@elte.hu>
References: <20041124101626.GA31788@elte.hu>
	 <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu>
	 <20041207141123.GA12025@elte.hu>
	 <1102526018.25841.308.camel@localhost.localdomain>
	 <32950.192.168.1.5.1102529664.squirrel@192.168.1.5>
	 <1102532625.25841.327.camel@localhost.localdomain>
	 <32788.192.168.1.5.1102541960.squirrel@192.168.1.5>
	 <1102543904.25841.356.camel@localhost.localdomain>
	 <20041209093211.GC14516@elte.hu>  <20041209131317.GA31573@elte.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Kihon Technologies
Date: Thu, 09 Dec 2004 09:33:49 -0500
Message-Id: <1102602829.25841.393.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-09 at 14:13 +0100, Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > SLAB draining was an oversight - it's mainly called when there is VM
> > pressure (which is not a stricly necessary feature, so i disabled it),
> > but i forgot about the module-unload case where it's a correctness
> > feature. Your patch is a good starting point, i'll try to fix it on
> > SMP too.
> 
> here's the full patch against a recent tree, or download the -32-12
> patch from the usual place:
> 
>     http://redhat.com/~mingo/realtime-preempt/

Ingo,

I just tried out your changes with both my sillycaches test as well as
my real modules that had the original problems. They both work fine.

I'll ever reboot my main machine now (SMP) and run your kernel there
too, and see how it works.

Thanks,

-- Steve

