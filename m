Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269381AbUINPB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269381AbUINPB5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 11:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269021AbUINO6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 10:58:23 -0400
Received: from mx2.elte.hu ([157.181.151.9]:47237 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269029AbUINOxc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 10:53:32 -0400
Date: Tue, 14 Sep 2004 16:54:57 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: fix scheduling latencies for !PREEMPT kernels
Message-ID: <20040914145457.GA13113@elte.hu>
References: <20040914104449.GA30790@elte.hu> <20040914105048.GA31238@elte.hu> <20040914105904.GB31370@elte.hu> <20040914110237.GC31370@elte.hu> <20040914110611.GA32077@elte.hu> <20040914112847.GA2804@elte.hu> <20040914114228.GD2804@elte.hu> <4146EA3E.4010804@yahoo.com.au> <20040914132225.GA9310@elte.hu> <4146F33C.9030504@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4146F33C.9030504@yahoo.com.au>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Another thing, I don't mean this to sound like a rhetorical question,
> but if we have a preemptible kernel, why is it a good idea to sprinkle
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> cond_rescheds everywhere? Isn't this now the worst of both worlds? Why
> would someone who really cares about latency not enable preempt?

two things:

1) none of the big distros enables CONFIG_PREEMPT in their kernels - not
even SuSE. This is pretty telling.

2) 10 new cond_resched()'s are not precisely 'sprinkle everywhere'.

	Ingo
