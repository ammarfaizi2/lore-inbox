Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261483AbUKANOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbUKANOG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 08:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbUKANOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 08:14:06 -0500
Received: from mx1.elte.hu ([157.181.1.137]:44514 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261483AbUKANOE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 08:14:04 -0500
Date: Mon, 1 Nov 2004 14:15:11 +0100
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
Message-ID: <20041101131511.GA16832@elte.hu>
References: <20041031124828.GA22008@elte.hu> <1099227269.1459.45.camel@krustophenia.net> <20041031131318.GA23437@elte.hu> <20041031134016.GA24645@elte.hu> <20041031162059.1a3dd9eb@mango.fruits.de> <20041031165913.2d0ad21e@mango.fruits.de> <20041101115546.GA2620@elte.hu> <20041101123701.GA4443@elte.hu> <1099312527.3337.5.camel@thomas> <20041101125127.GA13442@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041101125127.GA13442@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> [...] I am too seeing rtc_wakeup weirdnesses that were not present in
> earlier -V0.6 kernels.

this turned out to be a user error - used the wrong script to renice
IRQ8. Perhaps rtc_wakeup could check for the presence of IRQ 8 and chrt
it to 99 if it's present? :-|

	Ingo
