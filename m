Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262101AbUKVNiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbUKVNiI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 08:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262097AbUKVNiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 08:38:07 -0500
Received: from mx1.elte.hu ([157.181.1.137]:43690 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262101AbUKVNgk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 08:36:40 -0500
Date: Mon, 22 Nov 2004 15:38:40 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Christian Meder <chris@onestepahead.de>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.28-1
Message-ID: <20041122143840.GA27551@elte.hu>
References: <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu> <49222.195.245.190.94.1100789179.squirrel@195.245.190.94> <20041118210517.GA8703@elte.hu> <1100818448.3476.17.camel@localhost> <20041119095451.GC27642@elte.hu> <1101115860.4182.7.camel@localhost> <20041122130519.GB13574@elte.hu> <1101130365.3356.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101130365.3356.4.camel@localhost>
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

> On Mon, 2004-11-22 at 14:05 +0100, Ingo Molnar wrote:
> > * Christian Meder <chris@onestepahead.de> wrote:
> > 
> > > * the other important factor is running the jvm in profiling mode,
> > > running without jvm or with the jvm in non-profiling mode leaves the
> > > box stable
> > 
> > ah ... CPU profiling i suspect needs SIGPROF, and that is one of the
> > things that i had to disable in -RT. But it seems this disabling wasnt
> > fully correct - could you try the patch i attached, does it change the
> > symptoms?
> 
> I tried it on top of 0.7.29-0 and it seemed to survive a little bit
> longer but it doesn't change fundamentally i.e. I've got to wiggle the
> mouse for maybe 20 seconds instead of 10 before the kernel locks up.

do you have serial logging (or working netdump) from that box? If yes
then you could try the debug_direct_keyboard switch still, and when the
lockup happens, do SysRq-P a number of times, and then do a SysRq-D and
a SysRq-T and send me any log output that this might produce.

> > is my java setup botched perhaps?
> 
> I'd rather guess your jython setup is botched. I'm sending you offlist
> another simple test case which just involves a simple start of the
> Jetty servlet container.

ok.

	Ingo
