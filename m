Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262115AbUKROwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbUKROwl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 09:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbUKROwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 09:52:41 -0500
Received: from mx2.elte.hu ([157.181.151.9]:7845 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262115AbUKROwj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 09:52:39 -0500
Date: Thu, 18 Nov 2004 16:54:11 +0100
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
Message-ID: <20041118155411.GB12483@elte.hu>
References: <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu> <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu> <1100732223.3472.10.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100732223.3472.10.camel@localhost>
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

> after successfully running the last couple of rt patches on my Dell
> Inspiron laptop I thought I'd give it a try on my combined vdr/router
> box which is probably more interesting from a rt point of view. This
> box is bridging wireless/ADSL and working as a digital vdr using the
> kernel DVB-S drivers.
> 
> I got the appended logging messages with the appended config.  Is
> there anything else I should provide for debugging purposes or are the
> messages just harmless ?

the messages mean that i havent converted the bridge code's RCU locking
to PREEMPT_RT yet. I've done this in the -V0.7.28-2 patch that i've just
uploaded to:

        http://redhat.com/~mingo/realtime-preempt/

does bridging work fine with this patch, and if yes, do you get any
(other) warning messages?

	Ingo
