Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264386AbUJTOmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264386AbUJTOmp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 10:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267866AbUJTOhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 10:37:47 -0400
Received: from pop.gmx.net ([213.165.64.20]:6575 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266683AbUJTOhS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 10:37:18 -0400
X-Authenticated: #4399952
Date: Wed, 20 Oct 2004 16:53:26 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
Message-ID: <20041020165326.5016fc5e@mango.fruits.de>
In-Reply-To: <20041020141822.GA16965@elte.hu>
References: <20041015102633.GA20132@elte.hu>
	<20041016153344.GA16766@elte.hu>
	<20041018145008.GA25707@elte.hu>
	<20041019124605.GA28896@elte.hu>
	<20041019180059.GA23113@elte.hu>
	<20041020094508.GA29080@elte.hu>
	<20041020145019.176826cb@mango.fruits.de>
	<20041020125500.GA8693@elte.hu>
	<20041020152507.3c167ca8@mango.fruits.de>
	<20041020162428.7c4c5f53@mango.fruits.de>
	<20041020141822.GA16965@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2004 16:18:22 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> note that the keyboard and USB interrupts are SCHED_OTHER by default, so
> they could be delayed quite long depending on the workload. To avoid
> that i'd suggest to:
> 
>         chrt --fifo --pid 30 `pidof 'IRQ 1'`
>         chrt --fifo --pid 30 `pidof 'IRQ 12'`
> 
> (do this for every IRQ you have for input devices.) This puts them below
> jackd's priority (which is FIFO 50 iirc) but above all SCHED_OTHER
> tasks. The soundcard IRQ i guess you have chrt-ed already?
> 
> or did you have them on SCHED_FIFO already?

setting them to SCHED_FIFO even with a prio of 99 won't help. will try
rebooting to see if it's reproducable 

flo
