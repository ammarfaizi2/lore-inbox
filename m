Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261476AbULAVYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbULAVYx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 16:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbULAVYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 16:24:53 -0500
Received: from mx1.elte.hu ([157.181.1.137]:729 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261476AbULAVYt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 16:24:49 -0500
Date: Wed, 1 Dec 2004 22:24:13 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Paul Davis <paul@linuxaudiosystems.com>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Rui Nuno Capela <rncbc@rncbc.org>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-2
Message-ID: <20041201212413.GF22671@elte.hu>
References: <20041201155353.GA30193@elte.hu> <Pine.OSF.4.05.10412011708520.8736-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10412011708520.8736-100000@da410.ifa.au.dk>
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


* Esben Nielsen <simlo@phys.au.dk> wrote:

> Don't worry about setting up the stuff. Once you have the pipe it
> ought to be RT in the usage of read/write, but setting it up is
> something you is something you do "under boot", just as allocating
> memory and other non-real-time stuff. 

actually, the main problem with fifos was they were _not_ atomic even in
read/write (i myself fully expected them to be that, but they arent). 
That's the bug/misfeature that i fixed in the latest kernels.

	Ingo
