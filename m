Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268368AbUJUKif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268368AbUJUKif (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 06:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270373AbUJUJvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 05:51:41 -0400
Received: from mx1.elte.hu ([157.181.1.137]:12014 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268368AbUJUJoY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 05:44:24 -0400
Date: Thu, 21 Oct 2004 11:44:38 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>,
       Thomas Gleixner <tglx@linutronix.de>, Rui Nuno Capela <rncbc@rncbc.org>,
       LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
Message-ID: <20041021094438.GA30986@elte.hu>
References: <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <30690.195.245.190.93.1098349976.squirrel@195.245.190.93> <1098350190.26758.24.camel@thomas> <20041021093532.GA2482@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041021093532.GA2482@infradead.org>
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


* Christoph Hellwig <hch@infradead.org> wrote:

> > The problem is that semaphores are hold by Process A and released by
> > Process B, which makes Ingo's checks trigger
> 
> Which is perfectly valid for a semaphore.

yes, it is valid and perfectly fine code, but i'm trying to separate out
the simple 'mutex' functionality (99% of the semaphore users are just
that) and implement a 'counted semaphore' separately. This removes a
number of implementational constraints from mutexes.

	Ingo
