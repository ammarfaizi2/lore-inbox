Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbULNUgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbULNUgI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 15:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbULNUgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 15:36:07 -0500
Received: from mx2.elte.hu ([157.181.151.9]:63415 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261652AbULNUf7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 15:35:59 -0500
Date: Tue, 14 Dec 2004 21:35:21 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc3-mm1-V0.7.33-0
Message-ID: <20041214203521.GA15752@elte.hu>
References: <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu> <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu> <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu> <20041207141123.GA12025@elte.hu> <20041214132834.GA32390@elte.hu> <1103054849.12653.102.camel@cmn37.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103054849.12653.102.camel@cmn37.stanford.edu>
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


* Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> If I build a cvs version of alsa without those patches, will it work
> on top of the 0.7.33 kernel? Or do I have to try to isolate the
> patches and apply them to current alsa cvs?

these are the modified files:

 linux/sound/core/oss/pcm_oss.c.orig
 linux/sound/core/oss/mixer_oss.c.orig
 linux/sound/core/pcm_lib.c.orig
 linux/sound/core/control.c.orig
 linux/sound/core/seq/oss/seq_oss.c.orig
 linux/sound/core/seq/seq_clientmgr.c.orig
 linux/sound/core/hwdep.c.orig
 linux/sound/core/pcm_native.c.orig
 linux/sound/core/timer.c.orig
 linux/sound/core/info.c.orig
 linux/sound/core/rawmidi.c.orig

cvs alsa should work just fine, but to get optimal results you might
want to try to apply the above changes (all linux/sound/ changes) to
alsa-cvs.

	Ingo
