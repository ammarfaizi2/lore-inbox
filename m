Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261435AbUKFRz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbUKFRz7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 12:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbUKFRz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 12:55:58 -0500
Received: from smtp4.netcabo.pt ([212.113.174.31]:39021 "EHLO
	exch01smtp12.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S261435AbUKFRzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 12:55:52 -0500
Message-ID: <32891.192.168.1.5.1099763737.squirrel@192.168.1.5>
Date: Sat, 6 Nov 2004 17:55:37 -0000 (WET)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.18
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       "Bill Huey" <bhuey@lnxw.com>, "Adam Heath" <doogie@debian.org>,
       "Florian Schmidt" <mista.tapas@gmx.net>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>,
       "Karsten Wiese" <annabellesgarden@yahoo.de>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
References: <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu>
       <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu>   
    <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu>   
    <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu>   
    <20041027001542.GA29295@elte.hu> <20041103105840.GA3992@elte.hu>   
    <20041106155720.GA14950@elte.hu>
In-Reply-To: <20041106155720.GA14950@elte.hu>
X-OriginalArrivalTime: 06 Nov 2004 17:55:50.0874 (UTC) FILETIME=[DA5233A0:01C4C429]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
> i have released the -V0.7.18 Real-Time Preemption patch, which can be
> downloaded from:
>
>    http://redhat.com/~mingo/realtime-preempt/
>
> this release includes fixes and cleanups.
>

Sorry. Build error for a non-debug configuration:

drivers/char/drm/drm_stub.c: In function `drm_fill_in_dev':
drivers/char/drm/drm_stub.c:60: error: parse error before '{' token
make[3]: *** [drivers/char/drm/drm_stub.o] Error 1
make[2]: *** [drivers/char/drm] Error 2
make[1]: *** [drivers/char] Error 2
make: *** [drivers] Error 2

If CONFIG_DEBUG_PREEMPT and/or CONFIG_RT_DEADLOCK_DETECT are set, the
RT-V0.7.18 build succeeds.

Not big deal. However, my personal benchmarks (jackd-R + 8*fluidsynth) are
being based on production-like kernel configurations (no kernel debug
options set), so I guess it will have to wait :)

Cheers.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

