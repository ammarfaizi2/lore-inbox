Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbULALZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbULALZq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 06:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261372AbULALZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 06:25:46 -0500
Received: from mx2.elte.hu ([157.181.151.9]:23173 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261371AbULALZl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 06:25:41 -0500
Date: Wed, 1 Dec 2004 12:25:20 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-7
Message-ID: <20041201112520.GA20919@elte.hu>
References: <36536.195.245.190.93.1101471176.squirrel@195.245.190.93> <20041129111634.GB10123@elte.hu> <41358.195.245.190.93.1101734020.squirrel@195.245.190.93> <20041129143316.GA3746@elte.hu> <20041129152344.GA9938@elte.hu> <48590.195.245.190.94.1101810584.squirrel@195.245.190.94> <20041130131956.GA23451@elte.hu> <17532.195.245.190.94.1101829198.squirrel@195.245.190.94> <20041201103251.GA18838@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041201103251.GA18838@elte.hu>
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


> New XRUN traces are attached, while running RT-V0.7.31-15 now.
> However, I don't seem to get any notorious difference on the results,
> since previous ones. All latencies traced ca. 26-27 usecs.

another thing: could you try the latest jackd CVS tree too? I found
spurious xruns in 99-0 (the last official release), while with 99-11 i
dont see any xruns on my box, up until i completely saturate CPU time.

I.e. both latest -RT kernels are needed for this (earlier RT kernels,
prior the PI fixes still generated lots of xruns even with latest jack
CVS), and latest jack CVS is needed.

	Ingo
