Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263060AbUKANsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263060AbUKANsi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 08:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbUKANsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 08:48:38 -0500
Received: from mx2.elte.hu ([157.181.151.9]:46305 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263060AbUKANsG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 08:48:06 -0500
Date: Mon, 1 Nov 2004 14:48:37 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Lee Revell <rlrevell@joe-job.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041101134837.GA19546@elte.hu>
References: <20041031131318.GA23437@elte.hu> <20041031134016.GA24645@elte.hu> <20041031162059.1a3dd9eb@mango.fruits.de> <20041031165913.2d0ad21e@mango.fruits.de> <20041101115546.GA2620@elte.hu> <20041101123701.GA4443@elte.hu> <1099312527.3337.5.camel@thomas> <20041101125127.GA13442@elte.hu> <20041101131511.GA16832@elte.hu> <20041101144018.24a7fea9@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041101144018.24a7fea9@mango.fruits.de>
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

> well, how would i best check for the presence of the process/thread "IRQ 8"?

pidof 'IRQ 8' seems to work pretty well.

> Although: is rtc always garanteed to be "IRQ 8" or is this only the
> case on ia32 with XT-PIC?

no. But the following command should work even if rtc is not on 
IRQ8:

 chrt -f 99 -p `pidof "IRQ \`ls -d /proc/irq/*/rtc | cut -d/ -f4\`"`

	Ingo
