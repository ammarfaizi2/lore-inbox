Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262024AbUKJRgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262024AbUKJRgg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 12:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbUKJRgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 12:36:35 -0500
Received: from lax-gate3.raytheon.com ([199.46.200.232]:16824 "EHLO
	lax-gate3.raytheon.com") by vger.kernel.org with ESMTP
	id S262022AbUKJRgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 12:36:23 -0500
To: Ingo Molnar <mingo@elte.hu>
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
From: Mark_H_Johnson@raytheon.com
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.23
Date: Wed, 10 Nov 2004 11:35:18 -0600
Message-ID: <OF2E0C528F.031A66E9-ON86256F48.00609DC6-86256F48.00609DDD@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 11/10/2004 11:35:29 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>you have to build another kernel for them. irqs-off and preempt-off
>timing can be mixed freely (and both can be enabled in the same kernel),
>but wakeup timing deserves its own .config space and since it's not
>mixable with the other two methods i didnt see much point in enabling
>all 3 at once with strange dependencies between them. Is this a big
>issue? Normally i think the wakeup timing is more than enough to get a
>feel of latencies, and if something specific is suspected the other ones
>can be turned on.

Just that it takes an hour or so to rebuild the kernel plus the
disk storage to keep two kernels instead of one.

The wakeup latencies I am seeing are all quite small, but the overhead
I am seeing at the application level have been quite high. Only 40 wakeup
latencies > 50 usec in a half hour of testing. I guess I'll build a
.24 without wakeup timing to see what kind of problems I'm having.
I can send you the wakeup timing traces if you are interested but
they are all really short (< 100 usec) or appear to indicate a hardware
contention problem (one step at 100 usec or so).

 --Mark

