Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262895AbUKRTIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262895AbUKRTIR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 14:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262893AbUKRTFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 14:05:48 -0500
Received: from mx2.elte.hu ([157.181.151.9]:36744 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262895AbUKRS4v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 13:56:51 -0500
Date: Thu, 18 Nov 2004 20:58:30 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Christian Meder <chris@onestepahead.de>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.28-0
Message-ID: <20041118195830.GA25938@elte.hu>
References: <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu> <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu> <1100773441.3434.4.camel@localhost> <20041118161129.GD12483@elte.hu> <1100795964.3699.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100795964.3699.3.camel@localhost>
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


* Christian Meder <chris@onestepahead.de> wrote:

> > could you try this with the vanilla 2.6.10-rc2-mm1 kernel too? The crash
> > you got is an escallation of a crash within a critical section, but that
> > original crash does not seem to be directly related to PREEMPT_RT.
> 
> Ok, tried it now. The output from 2.6.10-rc2-mm1 on removal of the prism
> pccard is pretty innocuous and everything works fine:
> 
> Nov 18 17:29:27 localhost kernel: hostap_cs: CS_EVENT_CARD_REMOVAL
> Nov 18 17:29:27 localhost kernel: wifi0: card already removed or not
> configured during shutdown
> Nov 18 17:29:27 localhost kernel: wifi0: Interrupt, but dev not OK
> Nov 18 17:29:27 localhost kernel: hostap_cs: Driver unloaded

ok. Could you please retry with the latest kernel and USE_FRAME_POINTERS
enabled? It wasnt completely clear from your previous log precisely
which function generated the fault so it would be easier for me to sort
it out if you could reproduce it once more.

	Ingo
