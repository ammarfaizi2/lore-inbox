Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262311AbULOJwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262311AbULOJwe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 04:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbULOJwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 04:52:34 -0500
Received: from mx2.elte.hu ([157.181.151.9]:50893 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262311AbULOJwY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 04:52:24 -0500
Date: Wed, 15 Dec 2004 10:51:59 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: Steven Rostedt <rostedt@goodmis.org>, Rui Nuno Capela <rncbc@rncbc.org>,
       LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>,
       "K.R. Foley" <kr@cybsft.com>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>, emann@mrv.com,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-12
Message-ID: <20041215095159.GB14627@elte.hu>
References: <20041209131317.GA31573@elte.hu> <1102602829.25841.393.camel@localhost.localdomain> <1102619992.3882.9.camel@localhost.localdomain> <20041209221021.GF14194@elte.hu> <1102659089.3236.11.camel@localhost.localdomain> <20041210111105.GB6855@elte.hu> <1102731973.3228.8.camel@localhost.localdomain> <1102750669.32041.8.camel@cmn37.stanford.edu> <1102768203.3480.6.camel@localhost.localdomain> <1102980859.10968.691.camel@cmn37.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102980859.10968.691.camel@cmn37.stanford.edu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> [The following is all done booting into 0.7.32-19, interrupt
> scheduling and priorities unchanged from the defaults]
> 
> I'm using PREEMPT_DESKTOP. I don't know how to force the kernel to not
> thread hardirqs. [...]

this is now moot for your case, but here's how you can disable hardirq
threading: you can disable CONFIG_PREEMPT_HARDIRQS in the .config, or
you can disable it via the hardirq-preempt=0 boot-time kernel flag.

	Ingo
