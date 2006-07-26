Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030377AbWGZEoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030377AbWGZEoY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 00:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030381AbWGZEoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 00:44:24 -0400
Received: from [213.184.169.84] ([213.184.169.84]:42505 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1030377AbWGZEoX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 00:44:23 -0400
From: Al Boldi <a1426z@gawab.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.4 for 2.6.18-rc2
Date: Wed, 26 Jul 2006 07:45:45 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200607241857.52389.a1426z@gawab.com> <200607252127.14024.a1426z@gawab.com> <44C6BC76.8010808@bigpond.net.au>
In-Reply-To: <44C6BC76.8010808@bigpond.net.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200607260745.45156.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Al Boldi wrote:
> > Peter Williams wrote:
> >> Al Boldi wrote:
> >>> Peter Williams wrote:
> >>>> Al Boldi wrote:
>
> [bits deleted]
>
> >>>>> It may be really great, to allow schedulers perPid parent, thus
> >>>>> allowing the stacking of different scheduler semantics.  This could
> >>>>> aid flexibility a lot.
> >>>>
> >>>> I'm don't understand what you mean here.  Could you elaborate?
> >>>
> >>> i.e:  Boot the kernel with spa_no_frills, then start X with spa_ws.
> >>
> >> It's probably not a good idea to have different schedulers managing the
> >> same resource.  The way to do different scheduling per process is to
> >> use the scheduling policy mechanism i.e. SCHED_FIFO, SCHED_RR, etc.
> >> (possibly extended) within each scheduler.  On the other hand, on an
> >> SMP system, having a different scheduler on each run queue (or sub set
> >> of queues) might be interesting :-).
> >
> > What's wrong with multiple run-queues on UP?
>
> A really high likelihood of starvation of some tasks.

Maybe you are thinking of running independent run-queues, in which case it 
would probably be unwise to run multiple RQs on a single CPU.

But I was more thinking of a run-queue of run-queues, with the masterRQ 
scheduling slaveRQs, each RQ possible running its own scheduling semantic.


Thanks!

--
Al

