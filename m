Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261414AbUKALyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbUKALyr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 06:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbUKALyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 06:54:47 -0500
Received: from mx2.elte.hu ([157.181.151.9]:3502 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261414AbUKALyp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 06:54:45 -0500
Date: Mon, 1 Nov 2004 12:55:46 +0100
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
Message-ID: <20041101115546.GA2620@elte.hu>
References: <20041030231358.6f1eeeac@mango.fruits.de> <1099171567.1424.9.camel@krustophenia.net> <20041030233849.498fbb0f@mango.fruits.de> <20041031120721.GA19450@elte.hu> <20041031124828.GA22008@elte.hu> <1099227269.1459.45.camel@krustophenia.net> <20041031131318.GA23437@elte.hu> <20041031134016.GA24645@elte.hu> <20041031162059.1a3dd9eb@mango.fruits.de> <20041031165913.2d0ad21e@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041031165913.2d0ad21e@mango.fruits.de>
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

> i got a deadlock though. it was a weird one. mouse and keyboard
> [including sysrq] froze. but the find / i started kept on running in
> an xterm. had to press reset due to lack of second machine..

i've uploaded -V0.6.3 to the usual place:

    http://redhat.com/~mingo/realtime-preempt/

which fixes two issues:

 - priorities of SCHED_OTHER tasks not getting properly managed, hence 
   they could end up 'starving' other SCHED_OTHER tasks pretty
   indefinitely. This could possibly solve the 'temporary lockup'
   problem reported by Mark H Johnson.

 - fixed the 'high load average' bug

i dont know whether this will solve the 'hard lockups' reported though. 
It could solve your problem because the 'find /' kept running so it
wasnt a hard lockup. I'll keep testing and i'll fix any problem i can
reproduce myself.

	Ingo
