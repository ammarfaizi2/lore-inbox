Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261917AbUKJQJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbUKJQJI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 11:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbUKJQJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 11:09:08 -0500
Received: from mx1.elte.hu ([157.181.1.137]:63468 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261917AbUKJQGc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 11:06:32 -0500
Date: Wed, 10 Nov 2004 18:06:15 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.23
Message-ID: <20041110170615.GA21780@elte.hu>
References: <OF6B443F60.4896500B-ON86256F48.00567207@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF6B443F60.4896500B-ON86256F48.00567207@raytheon.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-2.201, required 5.9,
	BAYES_00 -4.90, SORTED_RECIPS 2.70
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> OK. So maybe I didn't understand what you said previously. Now, if I
> build to get maximum-latency wakeup values, I can't get the IRQ off or
> preempt off timing and traces? If that's not true, how do I switch
> between the different sampling methods?

you have to build another kernel for them. irqs-off and preempt-off
timing can be mixed freely (and both can be enabled in the same kernel),
but wakeup timing deserves its own .config space and since it's not
mixable with the other two methods i didnt see much point in enabling
all 3 at once with strange dependencies between them. Is this a big
issue? Normally i think the wakeup timing is more than enough to get a
feel of latencies, and if something specific is suspected the other ones
can be turned on.

	Ingo
