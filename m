Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261820AbUJYOKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbUJYOKF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 10:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbUJYOKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 10:10:04 -0400
Received: from mx2.elte.hu ([157.181.151.9]:49073 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261820AbUJYOJj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 10:09:39 -0400
Date: Mon, 25 Oct 2004 16:10:08 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
Message-ID: <20041025141008.GA13512@elte.hu>
References: <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <417CDE90.6040201@cybsft.com> <20041025111046.GA3630@elte.hu> <20041025121210.GA6555@elte.hu> <20041025152458.3e62120a@mango.fruits.de> <20041025132605.GA9516@elte.hu> <20041025160330.394e9071@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041025160330.394e9071@mango.fruits.de>
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


* Florian Schmidt <mista.tapas@gmx.net> wrote:

> > does the patch below fix this?
> 
> looks like it. they didn't show on first boot of the new kernel with
> patch applied. 

ok, i've added it and uploaded -V0.2 together with another fix: there
was a scheduler recursion possible via the delayed-put mechanism using
workqueues - now it's using its own separate lists and per-CPU threads.

> Btw: i still experience some "pauses". They are different now though.
> It seems i can trigger them by reloading a page in mozilla (not
> always). This BUG definetly looks related. Dunno, when exactly it
> happened (related to what i did at that moment), but it's the only one
> in dmesg output on this bootup. Each of the pauses is accompanied by a
> high cpu usage of ksoftirqd. I cannot retrigger the BUG though.

please try -V0.2 - maybe the delayed-put fix is somehow related. (but
only maybe...)

	Ingo
