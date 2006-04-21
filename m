Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbWDUMCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWDUMCv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 08:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932068AbWDUMCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 08:02:49 -0400
Received: from mail.gmx.de ([213.165.64.20]:15820 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932065AbWDUMCs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 08:02:48 -0400
X-Authenticated: #14349625
Subject: Re: [ckrm-tech] Re: [RFC][PATCH 3/9] CPU controller - Adds
	timeslice scaling
From: Mike Galbraith <efault@gmx.de>
To: Naoaki MAEDA <maeda.naoaki@gmail.com>
Cc: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
In-Reply-To: <9fe69740604210450h798eded8nff1ef8b98c0f151@mail.gmail.com>
References: <20060421022727.13598.15397.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
	 <20060421022742.13598.7230.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
	 <1145607449.10016.47.camel@homer> <44489E27.2090108@jp.fujitsu.com>
	 <9fe69740604210450h798eded8nff1ef8b98c0f151@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 21 Apr 2006 14:03:49 +0200
Message-Id: <1145621030.7614.44.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-21 at 20:50 +0900, Naoaki MAEDA wrote:

> It was not good explanation. Let me restate that.
> The effect of shortening timeslice is to let the task be expired soon
> by shortening
> its remainder timeclice, so it still works even if the task consome very small
> timeslice at one time. However, expired TASK_INTERACTIVE tasks will be requeued
> to the active for a while by the scheduler, so shortening timeslice
> doesn't work well for
> TASK_INTERACTIVE tasks.

Yeah, understood.  This shortening of timeslice I think is generally
bad, (hmm...) though in an environment where preemption is rampant, this
shortening of slice should lead to a throughput gain for low ranking
_interdependent_ tasks.  Is that what you're trying to accomplish?  To
reduce latency at the bottom in the face of preemption from above?

	-Mike

