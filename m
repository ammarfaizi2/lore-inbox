Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270477AbUJUNwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270477AbUJUNwt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 09:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269216AbUJUNwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 09:52:33 -0400
Received: from mx2.elte.hu ([157.181.151.9]:18883 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S270420AbUJUNwP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 09:52:15 -0400
Date: Thu, 21 Oct 2004 15:53:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
Message-ID: <20041021135330.GA32206@elte.hu>
References: <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <30690.195.245.190.93.1098349976.squirrel@195.245.190.93> <21840.195.245.190.94.1098363807.squirrel@195.245.190.94> <20041021134156.GA30791@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041021134156.GA30791@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> i tried to pole jackd a little bit (just using things like
> jack_freewheel and jack_impulse_grabber - i dont even know what they 
> do), and got jackd into some sort of userspace loop:
> 
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>  2558 root      16   0 27900 1852 2152 S 97.8  0.8   2:36.38 jackd

ah ... i should have guessed that "jack_freewheel y" puts jackd into ...
freewheeling mode. So this is by design.

i still suspect that it's some sort of userspace loop causing the jackd
problems - just that under SCHED_OTHER you dont normally notice it,
while with jack -R it's fatal.

	Ingo
