Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263096AbUK0Aed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263096AbUK0Aed (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 19:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262421AbUKZX4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 18:56:33 -0500
Received: from zeus.kernel.org ([204.152.189.113]:26565 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263089AbUKZTnG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:43:06 -0500
Date: Thu, 25 Nov 2004 12:17:28 +0100
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
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-0
Message-ID: <20041125111728.GA18084@elte.hu>
References: <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu> <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu> <20041124112745.GA3294@elte.hu> <21889.195.245.190.93.1101377024.squirrel@195.245.190.93> <20041125111344.GA17786@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041125111344.GA17786@elte.hu>
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

> > [...] Jackd XRUN rates are pretty low and on the same level (e.g. less
> > than 5 per hour with the default jack_test3.1 test), [...]
> 
> could you post the jack_test summary outputs?

also, could you change JACKD_PRIO from 20 to 50? Otherwise normal IRQ
handlers (IDE, etc.) will preempt jackd.

(the test-clients inherit this prio 50 setting, right?)

	Ingo
