Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261921AbUKHRGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbUKHRGN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 12:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbUKHRFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 12:05:33 -0500
Received: from imap.gmx.net ([213.165.64.20]:16315 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261921AbUKHQRu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 11:17:50 -0500
X-Authenticated: #4399952
Date: Mon, 8 Nov 2004 17:17:56 +0100
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
       Shane Shrybman <shrybman@aei.ca>,
       Peter Zijlstra <peter@programming.kicks-ass.net>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.20
Message-ID: <20041108171756.1451b460@mango.fruits.de>
In-Reply-To: <20041108095048.GA11920@elte.hu>
References: <20041020094508.GA29080@elte.hu>
	<20041021132717.GA29153@elte.hu>
	<20041022133551.GA6954@elte.hu>
	<20041022155048.GA16240@elte.hu>
	<20041022175633.GA1864@elte.hu>
	<20041025104023.GA1960@elte.hu>
	<20041027001542.GA29295@elte.hu>
	<20041103105840.GA3992@elte.hu>
	<20041106155720.GA14950@elte.hu>
	<20041108091619.GA9897@elte.hu>
	<20041108095048.GA11920@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Nov 2004 10:50:48 +0100
Ingo Molnar <mingo@elte.hu> wrote:


> i have released the -V0.7.20 Real-Time Preemption patch, which can be
> downloaded from the usual place:
> 
>    http://redhat.com/~mingo/realtime-preempt/
> 
> this release includes a single fix relative to -V0.7.19: it fixes the
> nondebug build errors reported by Rui Nuno Capela and Peter Zijlstra,
> introduced in -V0.7.18.
> 
> to create a -V0.7.20 tree from scratch, the patching order is:
> 
>   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.9.tar.bz2
>   http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.10-rc1.bz2
>   http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm3/2.6.10-rc1-mm3.bz2
>   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.10-rc1-mm3-V0.7.20

Hi,

i just wanted to let you know that this one doesn't lock up for me. I
actually built for 486 [to be able to run the image in qemu first]. After
the run in qemu showed no problems, i went to boot the kernel on my real
machine. It seems to work fine so far with rtc_wakeup showing max. jitters
around 30 usec (at f=1024) under load (find's + kernel compile)..

Will build a kernel (0.7.21) with debugging enabled to see if i miss any
BUG's.

flo

