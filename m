Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261726AbUK2PX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbUK2PX4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 10:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbUK2PXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 10:23:55 -0500
Received: from mx2.elte.hu ([157.181.151.9]:26065 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261726AbUK2PXy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 10:23:54 -0500
Date: Mon, 29 Nov 2004 16:23:44 +0100
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
Message-ID: <20041129152344.GA9938@elte.hu>
References: <36536.195.245.190.93.1101471176.squirrel@195.245.190.93> <20041129111634.GB10123@elte.hu> <41358.195.245.190.93.1101734020.squirrel@195.245.190.93> <20041129143316.GA3746@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041129143316.GA3746@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> but please try to the -31-10 kernel that i've just uploaded, it has a
> number of tracer enhancements:

make that -31-13 (or later). Earlier kernels had a bug in where the
process name tracking only worked for the first latency trace saved,
subsequent traces showed 'unknown' for the process name. In -13 i've
also added a printk that shows the latest user latency in a one-line
printk - just like the built-in latency tracing modes do:

 (gettimeofday/3671/CPU#0): new 3068 us user-latency.
 (gettimeofday/3784/CPU#0): new 1008627 us user-latency.

(this should also make it easier for helper scripts to save the traces,
whenever they happen.)

	Ingo
