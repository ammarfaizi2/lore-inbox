Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267740AbUJTMlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267740AbUJTMlZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 08:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267558AbUJTMgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 08:36:55 -0400
Received: from pop.gmx.net ([213.165.64.20]:64962 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267668AbUJTMeF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 08:34:05 -0400
X-Authenticated: #4399952
Date: Wed, 20 Oct 2004 14:50:19 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
Message-ID: <20041020145019.176826cb@mango.fruits.de>
In-Reply-To: <20041020094508.GA29080@elte.hu>
References: <20041012195424.GA3961@elte.hu>
	<20041013061518.GA1083@elte.hu>
	<20041014002433.GA19399@elte.hu>
	<20041014143131.GA20258@elte.hu>
	<20041014234202.GA26207@elte.hu>
	<20041015102633.GA20132@elte.hu>
	<20041016153344.GA16766@elte.hu>
	<20041018145008.GA25707@elte.hu>
	<20041019124605.GA28896@elte.hu>
	<20041019180059.GA23113@elte.hu>
	<20041020094508.GA29080@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2004 11:45:08 +0200
Ingo Molnar <mingo@elte.hu> wrote:

>   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-rc4-mm1-U8

Hi,

i just wanted to let you know that with U8 i still experience the "pauses" i
reported on U6, too. I would guess that it's some scheduler thing as jackd
running SCHED_FIFO and all its clients (at least the audio threads running
SCHED_FIFO) are not affected by the pauses (i don't see any xruns from jackd
and audio processing happily goes along without audible dropouts).

Also it seems that /proc/sys/kernel/trace_enabled == 1 is not the only thing
being able to trigger the pauses. With U6 i also experienced them with
trace_enabled == 0. I have to add though that it took quite a while for them
to kick in (hours) after setting trace_enabled to 0. So my conclusion is
that trace_enabled == 1 just increases the probability of such pauses by
several magnitudes (with 1 i get about one of these pauses per 2-10 minutes,
with 0 it took several hours for the first pause to occur and then they
stayed less frequent than with 1).

Ah and i forgot: dmesg -n 1 does not help..

flo
