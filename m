Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261518AbUKVOlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbUKVOlx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 09:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261483AbUKVOli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 09:41:38 -0500
Received: from mx2.elte.hu ([157.181.151.9]:18820 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261484AbUKVOil (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 09:38:41 -0500
Date: Mon, 22 Nov 2004 16:41:09 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: Florian Schmidt <mista.tapas@gmx.net>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-2
Message-ID: <20041122154109.GB2036@elte.hu>
References: <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu> <20041122020741.5d69f8bf@mango.fruits.de> <20041122094602.GA6817@elte.hu> <56781.195.245.190.93.1101119801.squirrel@195.245.190.93> <20041122132459.GB19577@elte.hu> <20041122142744.0a29aceb@mango.fruits.de> <65529.195.245.190.94.1101133129.squirrel@195.245.190.94>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65529.195.245.190.94.1101133129.squirrel@195.245.190.94>
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

> Yes, I know all this, and I warned before that this tests were
> strictly and specific to the hardware, jackd and fludisynth code which
> are intentionally kept the same along the several RT kernels that have
> been issued.

i'm aware of this - and i'm perfectly happy about all the testing that
is done, even if a latency problem in the end it turns out to be some
'side issue', an application or configuration bug. You are doing very
useful QA no matter what the problem turns out to be in the end.

when fixing stuff i tend to go from the simpler testcases to the more
complex ones (it's naturally simpler to validate the simpler ones), but
currently all the simple ones are working fine, so i'm looking at more
complex ones again.

Having said that, (not in small part based on the care you are taking to
keep your test environment consistent) it very much looks like as if the
latency problems you are reporting are related to -RT itself. It could
easily be something else, but as usual, there's only one way to find out
...

anyway, dont worry about presenting me with some problem that in the end
turns out to be something else. As Florian's jackd-xrun report from two
days ago has proven, jackd is still triggering genuine -RT bugs that
none of the simple workloads/apps are triggering. Less than one day
after half a dozen such latency bugs were fixed in the -RT patchset i
have no basis to go and blame Jackd or ALSA for any of the remaining
latency problems =B-)

	Ingo
