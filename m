Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbULMWg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbULMWg3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 17:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbULMWfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 17:35:03 -0500
Received: from mx2.elte.hu ([157.181.151.9]:22491 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261346AbULMWcF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 17:32:05 -0500
Date: Mon, 13 Dec 2004 23:31:53 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>,
       Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, LKML <linux-kernel@vger.kernel.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
Message-ID: <20041213223153.GA6793@elte.hu>
References: <OF737A0ECF.4ECB9A35-ON86256F65.006249D6@raytheon.com> <1102722147.3300.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102722147.3300.7.camel@localhost.localdomain>
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


* Steven Rostedt <rostedt@goodmis.org> wrote:

> [RFC] Has there been previously any thought of adding priority
> inheriting wait queues. [...]

this will make sense at a certain point.

> [...] it would really help to solve the problem of a high priority
> process waiting for an interrupt that can be starved by other high
> priority processes.

the primary use i think would be kernel-internal task <-> task
waitqueues such as the futex queues, to transport the effects of RT
priorities across waitqueues as well. IRQ related waitqueues are a nice
'side-effect'.

another next step would be to transport PI effects to userspace code,
for user-controlled synchronization objects such as futexes or e.g. SysV
semaphores.

	Ingo
