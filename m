Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261623AbUJaN3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbUJaN3t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 08:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbUJaN3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 08:29:48 -0500
Received: from mx1.elte.hu ([157.181.1.137]:52391 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261623AbUJaN3h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 08:29:37 -0500
Date: Sun, 31 Oct 2004 14:30:34 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Lee Revell <rlrevell@joe-job.com>, Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041031133034.GA23922@elte.hu>
References: <20041030214738.1918ea1d@mango.fruits.de> <1099165925.1972.22.camel@krustophenia.net> <20041030221548.5e82fad5@mango.fruits.de> <1099167996.1434.4.camel@krustophenia.net> <20041030231358.6f1eeeac@mango.fruits.de> <1099171567.1424.9.camel@krustophenia.net> <20041030233849.498fbb0f@mango.fruits.de> <20041031120721.GA19450@elte.hu> <20041031124828.GA22008@elte.hu> <20041031151130.675cb012@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041031151130.675cb012@mango.fruits.de>
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

> also, i have uploaded an overhauled version of the wakeup timer
> program. It now deferres all output to another SCHED_FIFO thread [with
> prio 1 lower than the main process]. The data is passed via a lockless
> fifo [ripped from jack sourcecode]. [...]

it works really great - previously i had problems with 'secondary'
latencies when running the app with HZ=8192, now i get only the primary
message(s).

i also like it that if you run the app it does a very useful type of
measurement right out of box. The simpler you make a validation app for
kernel developers the more they will use it ;-)

[ btw., FC3's gcc produces this (harmless) warning during the build:

 cc1plus: warning: command line option "-Wstrict-prototypes" is valid 
 for Ada/C/ObjC but not for C++ ]

	Ingo
