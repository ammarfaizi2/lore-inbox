Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269381AbUJSNCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269381AbUJSNCr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 09:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269395AbUJSNCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 09:02:47 -0400
Received: from mx1.elte.hu ([157.181.1.137]:43195 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269381AbUJSNCp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 09:02:45 -0400
Date: Tue, 19 Oct 2004 15:04:01 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Kevin Hilman <kevin@hilman.org>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U5
Message-ID: <20041019130401.GA1781@elte.hu>
References: <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <83wtxmuaqm.fsf@www2.muking.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83wtxmuaqm.fsf@www2.muking.org>
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


* Kevin Hilman <kevin@hilman.org> wrote:

> > the generic semaphore implementation (which uses rwsems) makes it
> > possible to use the deadlock detection mechanism for all the mutex types
> > we currently have: semaphores, rw-semaphores, spinlock-mutexes and
> > rwlock-mutexes. Another benefit is that PREEMPT_REALTIME becomes much
> > more portable this way. (although it's still x86-only at the moment.)
> 
> Speaking of portability, is anyone yet working on ports to other
> platforms?  I'm particularily interested in ARM.

i'll do x64 a couple of days after stability has been reached. I dont
know of any ARM efforts though.

a good starting point would be to enhance the generic-hardirqs framework
for ARM. Generic-hardirqs is a portion of the PREEMPT_REALTIME patch
that i've split out and submitted upstream, and which is expected to be
merged into 2.6.10. The generic irq subsystem makes the irq-threading
feature really simple and maintainable. So for PREEMPT_REALTIME to work
on ARM the first step is to enable generic-hardirqs on ARM. (which is
far from simple though.)

	Ingo
