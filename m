Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263690AbUJ3LQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263690AbUJ3LQs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 07:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263691AbUJ3LQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 07:16:48 -0400
Received: from mx2.elte.hu ([157.181.151.9]:55714 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263690AbUJ3LPt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 07:15:49 -0400
Date: Sat, 30 Oct 2004 13:16:40 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041030111640.GA23493@elte.hu>
References: <20041029193303.7d3990b4@mango.fruits.de> <20041029172151.GB16276@elte.hu> <20041029172243.GA19630@elte.hu> <20041029203619.37b54cba@mango.fruits.de> <20041029204220.GA6727@elte.hu> <20041029233117.6d29c383@mango.fruits.de> <20041029212545.GA13199@elte.hu> <20041030003122.03bcf01b@mango.fruits.de> <1099107364.1551.7.camel@krustophenia.net> <1099108122.1551.12.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099108122.1551.12.camel@krustophenia.net>
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


* Lee Revell <rlrevell@joe-job.com> wrote:

>   835 80000000 0.473ms (+0.000ms): finish_task_switch (__schedule)
>   835 80000000 0.474ms (+0.000ms): trace_stop_sched_switched (finish_task_switch)
>   835 80000000 0.474ms (+0.849ms): (835) ((49))
>   835 80000000 1.324ms (+0.000ms): do_IRQ (finish_task_switch)
>   835 80000000 1.324ms (+0.001ms): do_IRQ ((0))
>   835 80000000 1.325ms (+0.002ms): mask_and_ack_8259A (__do_IRQ)

this seems to be very similar to the DMA problems Mark H Johnson had. It
is almost certainly not caused by the kernel. It could in theory be some
SMM overhead, but the bigger likelyhood is disk DMA.

	Ingo
