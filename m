Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbULJLGC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbULJLGC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 06:06:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbULJLGC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 06:06:02 -0500
Received: from mx2.elte.hu ([157.181.151.9]:11426 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261168AbULJLF7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 06:05:59 -0500
Date: Fri, 10 Dec 2004 12:05:37 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>,
       Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>,
       "K.R. Foley" <kr@cybsft.com>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>, emann@mrv.com,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-12
Message-ID: <20041210110537.GA6855@elte.hu>
References: <32950.192.168.1.5.1102529664.squirrel@192.168.1.5> <1102532625.25841.327.camel@localhost.localdomain> <32788.192.168.1.5.1102541960.squirrel@192.168.1.5> <1102543904.25841.356.camel@localhost.localdomain> <20041209093211.GC14516@elte.hu> <20041209131317.GA31573@elte.hu> <1102602829.25841.393.camel@localhost.localdomain> <1102619992.3882.9.camel@localhost.localdomain> <20041209221021.GF14194@elte.hu> <1102659089.3236.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102659089.3236.11.camel@localhost.localdomain>
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


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Hi Ingo,
> 
> Here's your fix. I haven't seen anything else cause the bug, and since
> it uses local_irq_save, I guess the bounce_copy_vec can be called with
> interrupts disabled. Since the kmap_atomic (or just kmap) checks for
> that, I don't think I need more than what I've done.

yeah, it looks good to me too - thx. I've uploaded -32-16 with your fix
included.

	Ingo
