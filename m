Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbUJaMiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbUJaMiR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 07:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbUJaMiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 07:38:16 -0500
Received: from mx2.elte.hu ([157.181.151.9]:47809 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261596AbUJaMh6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 07:37:58 -0500
Date: Sun, 31 Oct 2004 13:39:03 +0100
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
       Rui Nuno Capela <rncbc@rncbc.org>, axboe@suse.de
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041031123903.GA21621@elte.hu>
References: <20041030214738.1918ea1d@mango.fruits.de> <1099165925.1972.22.camel@krustophenia.net> <20041030221548.5e82fad5@mango.fruits.de> <1099167996.1434.4.camel@krustophenia.net> <20041030231358.6f1eeeac@mango.fruits.de> <1099189225.1754.1.camel@krustophenia.net> <20041031110039.4575e49c@mango.fruits.de> <1099224598.1459.28.camel@krustophenia.net> <20041031121937.GA20036@elte.hu> <1099226110.1459.42.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099226110.1459.42.camel@krustophenia.net>
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

> Hmm, maybe the timer interrupt should be 99 and the rest say 50.
> Wouldn't it be bad if you had a fully loaded jackd (DSP load in JACK
> is the proportion of the process cycle to the period time; in a fully
> loaded jack setup the clients are using all the available time) and
> jackd + the soundcard IRQ's RT priorities are higher than the timer
> interrupt?  Seems like you could starve the timer interrupt
> indefinitely.

i misspoke when i said timer interrupt - that one is the lone
non-threaded IRQ so its priority is 100 in essence.

	Ingo
