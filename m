Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267424AbUJRS4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267424AbUJRS4o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 14:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267254AbUJRSz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 14:55:26 -0400
Received: from mx1.elte.hu ([157.181.1.137]:4527 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267424AbUJRSsS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 14:48:18 -0400
Date: Mon, 18 Oct 2004 20:49:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U5
Message-ID: <20041018184943.GB4625@elte.hu>
References: <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <41740F19.1080502@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41740F19.1080502@cybsft.com>
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


* K.R. Foley <kr@cybsft.com> wrote:

> Ingo Molnar wrote:
> >i have released the -U5 Real-Time Preemption patch:
> >
> >  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U5
> >
> 
> Ingo,
> 
> *** Warning: "__you_cannot_kmalloc_that_much" 
> [drivers/scsi/aacraid/aacraid.ko] undefined!
> 
> This just appeared in U5. I was trying to track this one down just
> because I saw it, even though I don't need aacraid. I am having a hell
> of a time tracking down what changed that would cause this, but I
> figure you will know exactly what changed that would cause it. :)

i suspect this is due to the size increase of semaphores if
CONFIG_RWSEM_DEADLOCK_DETECT is enabled. Try lowering
CONFIG_RWSEM_MAX_OWNERS from the default 64 to 32, does that help?

	Ingo
