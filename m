Return-Path: <linux-kernel-owner+willy=40w.ods.org-S273245AbUKAS6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273245AbUKAS6t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 13:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S288609AbUKASyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 13:54:12 -0500
Received: from mx2.elte.hu ([157.181.151.9]:63978 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S288238AbUKASpM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 13:45:12 -0500
Date: Mon, 1 Nov 2004 19:46:15 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Florian Schmidt <mista.tapas@gmx.net>, Lee Revell <rlrevell@joe-job.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041101184615.GB32009@elte.hu>
References: <1099227269.1459.45.camel@krustophenia.net> <20041031131318.GA23437@elte.hu> <20041031134016.GA24645@elte.hu> <20041031162059.1a3dd9eb@mango.fruits.de> <20041031165913.2d0ad21e@mango.fruits.de> <20041031200621.212ee044@mango.fruits.de> <20041101134235.GA18009@elte.hu> <20041101135358.GA19718@elte.hu> <20041101140630.GA20448@elte.hu> <1099324040.3337.32.camel@thomas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099324040.3337.32.camel@thomas>
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


* Thomas Gleixner <tglx@linutronix.de> wrote:

> >   http://redhat.com/~mingo/realtime-preempt/
> > 
> > Thomas, can you confirm that this kernel fixes the irqs-off latencies? 
> > (the priority loop indeed was done with irqs turned off.)
> 
> The latencies are still there. I have the feeling it's worse than 0.6.2.

what is the worst latency you can trigger with Florian's latest
rtc_wakeup code? (please re-download it, there has been a recent update)

also, there are no "arbitrary load" latency guarantees with
DEADLOCK_DETECTION turned on, since we search the list of all held locks
during task-exit time - this can generate pretty bad latencies e.g.
during hackbench.

	Ingo
