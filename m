Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263352AbUJ2OiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263352AbUJ2OiU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 10:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263341AbUJ2OfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 10:35:20 -0400
Received: from mx1.elte.hu ([157.181.1.137]:10208 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263339AbUJ2Oad (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 10:30:33 -0400
Date: Fri, 29 Oct 2004 16:31:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041029143134.GA27343@elte.hu>
References: <20041029134820.GA21746@elte.hu> <200410291419.i9TEJD75006459@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410291419.i9TEJD75006459@localhost.localdomain>
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


* Paul Davis <paul@linuxaudiosystems.com> wrote:

>      (c) the audio interface doesn't interrupt independently for
>                capture and playback. Rui will need to get back
> 	       to me with details on what type of audio interface
> 	       he is using for me to comment on this. If its
> 	       a consumer device with poor support for full
> 	       duplex operation, then it can happen that
> 	       capture and playback streams are running out
> 	       of sync and this can cause some odd timing.

here's Rui's setup:

| Note: all tests were carried out running jackd -v -dalsa -dhw:0 
| -r44100 -p128 -n2 -S -P, loaded with 9 (nine) fluidsynth instances,
| on a P4@2.533Ghz laptop, against the onboard sound device 
| (snd-ali5451).

i suspect this means there was playback only, no capture, and thus the 
capture/playback interrupt interaction cannot be the case, right?

	Ingo
