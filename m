Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbUKWOU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbUKWOU1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 09:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbUKWOU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 09:20:27 -0500
Received: from mx2.elte.hu ([157.181.151.9]:48584 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261253AbUKWOTK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 09:19:10 -0500
Date: Tue, 23 Nov 2004 16:21:26 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, linux-kernel@vger.kernel.org,
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
Message-ID: <20041123152126.GB22714@elte.hu>
References: <20041122020741.5d69f8bf@mango.fruits.de> <20041122094602.GA6817@elte.hu> <56781.195.245.190.93.1101119801.squirrel@195.245.190.93> <20041122132459.GB19577@elte.hu> <20041122142744.0a29aceb@mango.fruits.de> <65529.195.245.190.94.1101133129.squirrel@195.245.190.94> <20041122154516.GC2036@elte.hu> <9182.195.245.190.93.1101142412.squirrel@195.245.190.93> <20041123144622.GA20085@elte.hu> <20041123145718.250a7649@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041123145718.250a7649@mango.fruits.de>
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


* Florian Schmidt <mista.tapas@gmx.net> wrote:

> ~$ ps -C jack_test -cmL
>   PID   LWP CLS PRI TTY          TIME CMD
>   988     - -     - pts/1    00:00:00 jack_test
>     -   988 TS   20 -        00:00:00 -
>     -   989 FF   99 -        00:00:00 -
> 
> So when you ctrl-z out of jack_test you cause its process() thread to
> be suspended, too, thus jackd cannot finish processing its graph.

so in theory any scheduling delay of PID 988 in the above setup (the
SCHED_OTHER task) should not be able to negatively influence jackd,
correct? In fact, does in this particular jack_test case PID 988 do
anything substantial?

	Ingo
