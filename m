Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270476AbUKAQsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270476AbUKAQsr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 11:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270453AbUKAQsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 11:48:47 -0500
Received: from smtp3.netcabo.pt ([212.113.174.30]:3038 "EHLO
	exch01smtp11.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S270476AbUKAQsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 11:48:08 -0500
Message-ID: <32840.192.168.1.5.1099327643.squirrel@192.168.1.5>
In-Reply-To: <20041101115546.GA2620@elte.hu>
References: <20041030231358.6f1eeeac@mango.fruits.de>
    <1099171567.1424.9.camel@krustophenia.net>
    <20041030233849.498fbb0f@mango.fruits.de>
    <20041031120721.GA19450@elte.hu> <20041031124828.GA22008@elte.hu>
    <1099227269.1459.45.camel@krustophenia.net>
    <20041031131318.GA23437@elte.hu> <20041031134016.GA24645@elte.hu>
    <20041031162059.1a3dd9eb@mango.fruits.de>
    <20041031165913.2d0ad21e@mango.fruits.de>
    <20041101115546.GA2620@elte.hu>
Date: Mon, 1 Nov 2004 16:47:23 -0000 (WET)
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: "Florian Schmidt" <mista.tapas@gmx.net>,
       "Lee Revell" <rlrevell@joe-job.com>,
       "Paul Davis" <paul@linuxaudiosystems.com>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "LKML" <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       "Bill Huey" <bhuey@lnxw.com>, "Adam Heath" <doogie@debian.org>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>,
       "Karsten Wiese" <annabellesgarden@yahoo.de>,
       "jackit-devel" <jackit-devel@lists.sourceforge.net>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 01 Nov 2004 16:47:54.0001 (UTC) FILETIME=[88400010:01C4C032]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
>
> i've uploaded -V0.6.3 to the usual place:
>
>     http://redhat.com/~mingo/realtime-preempt/
>
> which fixes two issues:
>
>  - priorities of SCHED_OTHER tasks not getting properly managed, hence
>    they could end up 'starving' other SCHED_OTHER tasks pretty
>    indefinitely. This could possibly solve the 'temporary lockup'
>    problem reported by Mark H Johnson.
>
>  - fixed the 'high load average' bug
>
> i dont know whether this will solve the 'hard lockups' reported though.
> It could solve your problem because the 'find /' kept running so it
> wasnt a hard lockup. I'll keep testing and i'll fix any problem i can
> reproduce myself.
>

OK. Just tested in a hurry with RT-V0.6.4, and it passed three times in a
row my jackd-R + 9*fluidsynth tests, without freezing, so I think the
problem was the 'starvation' one.

OTOH, I can say that the results I'm early reading are really an
improvement. Fewer xruns and smaller delays. Nice.

Cheers.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

