Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263124AbUJ2HcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263124AbUJ2HcO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 03:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263128AbUJ2HcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 03:32:14 -0400
Received: from mx1.elte.hu ([157.181.1.137]:28033 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263124AbUJ2H3F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 03:29:05 -0400
Date: Fri, 29 Oct 2004 09:30:01 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4
Message-ID: <20041029073001.GB30400@elte.hu>
References: <20041027211957.GA28571@elte.hu> <33083.192.168.1.5.1098919913.squirrel@192.168.1.5> <20041028063630.GD9781@elte.hu> <20668.195.245.190.93.1098952275.squirrel@195.245.190.93> <20041028085656.GA21535@elte.hu> <26253.195.245.190.93.1098955051.squirrel@195.245.190.93> <20041028093215.GA27694@elte.hu> <43163.195.245.190.94.1098981230.squirrel@195.245.190.94> <20041028191605.GA3877@elte.hu> <32806.192.168.1.5.1099007364.squirrel@192.168.1.5>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32806.192.168.1.5.1099007364.squirrel@192.168.1.5>
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


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

> BTW, this means that I have to re-enable LATENCY_TIMING back again?

yes. I'd suggest to start with the simplest setup - i.e. just one
fluidsynth instance running. I suspect 3-4 instances later on will be
enough to trigger some xruns or at least some of the bigger delays.

you possibly wont be able to debug the 'production' setup, but that's
not an issue because the latencies should show up under just 2-3
instances running as well.

> > Also, i'd suggest to simply remove that line (or apply the attached
> > patch) - does the driver still work fine with that?
> >
> 
> Now that you call, I remember to hack that very same line, some time
> go, but couldn't get no better than a udelay(33). Removing that line
> just ended in some kind of malfunction, but can't remember what
> exactly. One thing's for sure, sound didn't came out of it :-/

ugh. Possibly some sort of interaction with the firmware and/or an
outright driver bug?

	Ingo
