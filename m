Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262199AbUKKKgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262199AbUKKKgL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 05:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262204AbUKKKgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 05:36:11 -0500
Received: from mx1.elte.hu ([157.181.1.137]:20418 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262199AbUKKKgI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 05:36:08 -0500
Date: Thu, 11 Nov 2004 12:38:04 +0100
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
Message-ID: <20041111113804.GA16645@elte.hu>
References: <OF2E0C528F.031A66E9-ON86256F48.00609DC6-86256F48.00609DDD@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF2E0C528F.031A66E9-ON86256F48.00609DC6-86256F48.00609DDD@raytheon.com>
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

> >you have to build another kernel for them. irqs-off and preempt-off
> >timing can be mixed freely (and both can be enabled in the same kernel),
> >but wakeup timing deserves its own .config space and since it's not
> >mixable with the other two methods i didnt see much point in enabling
> >all 3 at once with strange dependencies between them. Is this a big
> >issue? Normally i think the wakeup timing is more than enough to get a
> >feel of latencies, and if something specific is suspected the other ones
> >can be turned on.
> 
> Just that it takes an hour or so to rebuild the kernel plus the disk
> storage to keep two kernels instead of one.

ok, i added runtime configurability of the 3 options back, so that you
can build all 3 in and switch between them via the preempt_wakeup_timing
flag. Will be in the next release.

	Ingo
