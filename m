Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265805AbUIOAfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265805AbUIOAfa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 20:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265977AbUIOAfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 20:35:30 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:17060 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S265805AbUIOAfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 20:35:14 -0400
Subject: Re: [patch] sched: fix scheduling latencies for !PREEMPT kernels
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040914145457.GA13113@elte.hu>
References: <20040914104449.GA30790@elte.hu>
	 <20040914105048.GA31238@elte.hu> <20040914105904.GB31370@elte.hu>
	 <20040914110237.GC31370@elte.hu> <20040914110611.GA32077@elte.hu>
	 <20040914112847.GA2804@elte.hu> <20040914114228.GD2804@elte.hu>
	 <4146EA3E.4010804@yahoo.com.au> <20040914132225.GA9310@elte.hu>
	 <4146F33C.9030504@yahoo.com.au>  <20040914145457.GA13113@elte.hu>
Content-Type: text/plain
Message-Id: <1095208515.2406.43.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 14 Sep 2004 20:35:15 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-14 at 10:54, Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> > Another thing, I don't mean this to sound like a rhetorical question,
> > but if we have a preemptible kernel, why is it a good idea to sprinkle
>       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > cond_rescheds everywhere? Isn't this now the worst of both worlds? Why
> > would someone who really cares about latency not enable preempt?
> 
> two things:
> 
> 1) none of the big distros enables CONFIG_PREEMPT in their kernels - not
> even SuSE. This is pretty telling.
> 

I am not sure this means preemption is a bad idea, it just means there's
no point in enabling CONFIG_PREEMPT with the current kernel because it's
not enough of an improvement to make a difference for low latency
applications.

Lee

