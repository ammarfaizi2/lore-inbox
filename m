Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbUKXCsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbUKXCsU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 21:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbUKXCsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 21:48:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:46268 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261697AbUKXCrn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 21:47:43 -0500
X-Authenticated: #4399952
Date: Wed, 24 Nov 2004 03:48:57 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-9
Message-ID: <20041124034857.084e2e05@mango.fruits.de>
In-Reply-To: <20041124031908.GA12028@elte.hu>
References: <20041111215122.GA5885@elte.hu>
	<20041116125402.GA9258@elte.hu>
	<20041116130946.GA11053@elte.hu>
	<20041116134027.GA13360@elte.hu>
	<20041117124234.GA25956@elte.hu>
	<20041118123521.GA29091@elte.hu>
	<20041118164612.GA17040@elte.hu>
	<20041122005411.GA19363@elte.hu>
	<20041123175823.GA8803@elte.hu>
	<20041124012827.625fa7e1@mango.fruits.de>
	<20041124031908.GA12028@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2004 04:19:08 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Florian Schmidt <mista.tapas@gmx.net> wrote:
> 
> > Hi, i have some problem with unresolved symbols loading my alsa sound
> > card driver with this kernel version. At first i suspected an unclean
> > build, but then i did make clean bzImage modules and the unresolved
> > symbols persist (i have wakeup/nonpreemptible/interrupts-off tracing
> > enabled (see .config)):
> > 
> > snd_pcm: Unknown symbol user_trace_stop
> 
> does adding this line to kernel/latency.c resolve it?:
> 
>   EXPORT_SYMBOL(user_trace_stop);

yes, modules load fine now. thanks.

flo
