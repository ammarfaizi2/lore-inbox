Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbUKUOsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbUKUOsy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 09:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbUKUOsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 09:48:54 -0500
Received: from pop.gmx.net ([213.165.64.20]:57792 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261197AbUKUOsw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 09:48:52 -0500
X-Authenticated: #4399952
Date: Sun, 21 Nov 2004 15:49:44 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.29-0
Message-ID: <20041121154944.29a0b5ff@mango.fruits.de>
In-Reply-To: <20041121124555.GA7972@elte.hu>
References: <20041117124234.GA25956@elte.hu>
	<20041118123521.GA29091@elte.hu>
	<20041118164612.GA17040@elte.hu>
	<1100920963.1424.1.camel@krustophenia.net>
	<20041120125536.GC8091@elte.hu>
	<1100971141.6879.18.camel@krustophenia.net>
	<20041120191403.GA16262@elte.hu>
	<1100975745.6879.35.camel@krustophenia.net>
	<20041120201155.6dc43c39@mango.fruits.de>
	<20041120214035.2deceaeb@mango.fruits.de>
	<20041121124555.GA7972@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Nov 2004 13:45:55 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Florian Schmidt <mista.tapas@gmx.net> wrote:
> 
> > > Will build 29-4 PREEMPT_REALTIME now and see how this one behaves.
> > 
> > Pretty much as bad as 29-1. Sadly i have no idea on how to find out
> > what is causing jackd to act so weird under a PREEMPT_REALTIME kernel.
> > It seems there is some correlation to activity on X. Hiding and
> > showing windows has a certain chance of triggering a large xrun.
> 
> do you have chrt-ed the IRQ#0 thread and the soundcard thread as well?

yes. I tried the following combinations with PREEMPT_RT:

- IRQ 0 prio 40, IRQ 3 (soundcard) prio 98
- IRQ 0 prio 99, IRQ 3 prio 98

all other IRQ's at prios around 40-50 (default or set explicitly to 40).
What is the recommended setting for IRQ 0? I thought in this typical
thread-wakeup-by-IRQ scenario the scheduler is "shorted" anyways when an IRQ
occurs, so IRQ 0's prio shouldn't really matter.

flo
