Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbUKVOgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbUKVOgS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 09:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbUKVOej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 09:34:39 -0500
Received: from mx2.elte.hu ([157.181.151.9]:40426 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262107AbUKVORw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 09:17:52 -0500
Date: Mon, 22 Nov 2004 16:20:02 +0100
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
Message-ID: <20041122152002.GA1321@elte.hu>
References: <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu> <20041122020741.5d69f8bf@mango.fruits.de> <20041122094602.GA6817@elte.hu> <56781.195.245.190.93.1101119801.squirrel@195.245.190.93> <20041122132459.GB19577@elte.hu> <18923.195.245.190.93.1101128215.squirrel@195.245.190.93> <20041122150046.GA30371@elte.hu> <20041122151027.GA32546@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041122151027.GA32546@elte.hu>
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

> ah, i think i understand: fluidsynth has roughly the same CPU overhead
> when it is 'silent' (it's generating small static noise in that case),
> compared to when it's playing a MIDI file - so i should be able to see
> the xruns if i just run jackd and 8 fluidsynth instances, and then
> load the box - correct?

another question: it seems the fluidsynth threads are running as non-RT
threads - they are soft-synthesizing sound that jackd will mix and play. 
Now, can any delay of these fluidsynth threads (they are non-RT tasks
and can get delayed indefinitely) cause an xrun in Jackd, or should it
'only' make the sound more choppy?

	Ingo
