Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267380AbUJRVG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267380AbUJRVG3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 17:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267374AbUJRVG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 17:06:29 -0400
Received: from mx1.elte.hu ([157.181.1.137]:43158 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267380AbUJRVFX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 17:05:23 -0400
Date: Mon, 18 Oct 2004 23:06:44 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Adam Heath <doogie@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U5
Message-ID: <20041018210644.GA14072@elte.hu>
References: <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <Pine.LNX.4.58.0410181249150.1218@gradall.private.brainfood.com> <20041018181826.GC2899@elte.hu> <Pine.LNX.4.58.0410181557190.1218@gradall.private.brainfood.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410181557190.1218@gradall.private.brainfood.com>
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


* Adam Heath <doogie@debian.org> wrote:

> On Mon, 18 Oct 2004, Ingo Molnar wrote:
> 
> > > However, after I reset the threshold to 50(and got a few small traces), I got
> > > this whopper.
> > >
> > > (XFree86/1129/CPU#0): new 4692 us maximum-latency critical section.
> > >  => started at timestamp 358506933: <call_console_drivers+0x76/0x140>
> > >  =>   ended at timestamp 358511625: <finish_task_switch+0x43/0xa0>
> > >  [<c0132480>] sub_preempt_count+0x60/0x90
> >
> > interesting - this could be a printk (trace) done in a critical section
> > though. What does /proc/latency_trace tell, is it full of console code
> > functions?
> 
> Too late, it's gone.  It'd be nice if there was some way to have
> history on that file.

well - if it's gone it's always replaced by a larger latency (if you use
the preempt_max_latency method), which in most cases is more interesting
than the one you wanted to save.

	Ingo
