Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbUKBVJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbUKBVJZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 16:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbUKBVJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 16:09:04 -0500
Received: from mx1.elte.hu ([157.181.1.137]:65164 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261409AbUKBVIo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 16:08:44 -0500
Date: Tue, 2 Nov 2004 22:09:25 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Lee Revell <rlrevell@joe-job.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       LKML <linux-kernel@vger.kernel.org>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.6.8
Message-ID: <20041102210925.GA7029@elte.hu>
References: <OF8F6308EA.F9FADA81-ON86256F40.0071B981-86256F40.0071B9A6@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF8F6308EA.F9FADA81-ON86256F40.0071B981-86256F40.0071B9A6@raytheon.com>
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


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> >The only other way for the NMI watchdog to
> >trigger is if for whatever reason the local APIC timer interrupts are
> >not getting through and the NMI ticks (which come via a different
> >interrupt pin) get through.
> 
> The other symptoms I was seeing appeared to be timer related
>  - never returned from "sleep 1s" in the shell script
>  - "ps -fe" worked fine, but "top" did not
> You may be on to something here.

was this already in the default bootup, or only after the crash
happened? Does this also happen if you chrt ksoftirqd to FIFO prio 1? 
Does the 'LOC' count increase for both cpus in /proc/interrupts?

	Ingo
