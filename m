Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261893AbUKJOZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbUKJOZI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 09:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbUKJOUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 09:20:51 -0500
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:28600 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261987AbUKJOTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 09:19:10 -0500
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.23
Date: Wed, 10 Nov 2004 15:20:43 +0100
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
References: <20041021132717.GA29153@elte.hu> <200411101452.36007.annabellesgarden@yahoo.de> <20041110150136.GA8668@elte.hu>
In-Reply-To: <20041110150136.GA8668@elte.hu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200411101520.43192.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch 10 November 2004 16:01 schrieb Ingo Molnar:
> 
> * Karsten Wiese <annabellesgarden@yahoo.de> wrote:
> 
> > Hi
> > 
> > On SMP/HT/P4 I get:
> >  BUG: lock held at task exit time!
> 
> > sh/5429: BUG in __up_mutex at /home/ka/kernel/2.6/linux-2.6.9-rc1-mm3-RT/kernel/rt.c:1064
> > BUG: sleeping function called from invalid context sh(5429) at /home/ka/kernel/2.6/linux-2.6.9-rc1-mm3-RT/kernel/rt.c:1314
> > in_atomic():1 [00000003], irqs_disabled():0
> 
> hm, apparently something leaked a BKL count. Unfortunately we dont know
> precisely what did it, only that it happened. Did this happen during
> bootup, or during normal use. Can you trigger it arbitrarily?

Yes, it always happens, when callling ./cvscompile script of a project, that is mounted via nfs.
Haven't tried to do that ./cvscompile locally, should I?
