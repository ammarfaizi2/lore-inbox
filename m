Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261438AbUKFS4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbUKFS4L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 13:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbUKFS4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 13:56:11 -0500
Received: from amsfep12-int.chello.nl ([213.46.243.17]:28257 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S261438AbUKFS4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 13:56:07 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.18
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>
In-Reply-To: <32891.192.168.1.5.1099763737.squirrel@192.168.1.5>
References: <20041019124605.GA28896@elte.hu>
	 <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu>
	 <20041021132717.GA29153@elte.hu>    <20041022133551.GA6954@elte.hu>
	 <20041022155048.GA16240@elte.hu>    <20041022175633.GA1864@elte.hu>
	 <20041025104023.GA1960@elte.hu>    <20041027001542.GA29295@elte.hu>
	 <20041103105840.GA3992@elte.hu>    <20041106155720.GA14950@elte.hu>
	 <32891.192.168.1.5.1099763737.squirrel@192.168.1.5>
Content-Type: text/plain
Date: Sat, 06 Nov 2004 19:56:05 +0100
Message-Id: <1099767365.8149.1.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-11-06 at 17:55 +0000, Rui Nuno Capela wrote:

> 
> Sorry. Build error for a non-debug configuration:
> 
> drivers/char/drm/drm_stub.c: In function `drm_fill_in_dev':
> drivers/char/drm/drm_stub.c:60: error: parse error before '{' token
> make[3]: *** [drivers/char/drm/drm_stub.o] Error 1
> make[2]: *** [drivers/char/drm] Error 2
> make[1]: *** [drivers/char] Error 2
> make: *** [drivers] Error 2
> 

make that line look like: 
	spin_lock_init( &dev->count_lock );

> If CONFIG_DEBUG_PREEMPT and/or CONFIG_RT_DEADLOCK_DETECT are set, the
> RT-V0.7.18 build succeeds.
> 
> Not big deal. However, my personal benchmarks (jackd-R + 8*fluidsynth) are
> being based on production-like kernel configurations (no kernel debug
> options set), so I guess it will have to wait :)
> 
> Cheers.
-- 
Peter Zijlstra <a.p.zijlstra@chello.nl>

