Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266333AbUJLMcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266333AbUJLMcn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 08:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266341AbUJLMcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 08:32:43 -0400
Received: from mx1.elte.hu ([157.181.1.137]:9179 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266333AbUJLMcc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 08:32:32 -0400
Date: Tue, 12 Oct 2004 14:33:19 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Daniel Walker <dwalker@mvista.com>, "K.R. Foley" <kr@cybsft.com>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Wen-chien Jesse Sung <jesse@cola.voip.idv.tw>,
       Mark_H_Johnson@Raytheon.com
Subject: Re: [patch] VP-2.6.9-rc4-mm1-T6
Message-ID: <20041012123318.GA2102@elte.hu>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041012091501.GA18562@elte.hu>
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


i've uploaded -T7:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-T7

Changes since -T6:

- further stabilization of PREEMPT_REALTIME: fixed the task-reaping
  problem by moving TASK_ZOMBIE out of p->state and thus completely
  separating preemption from the child-exit mechanism. This got rid of 
  the 'Badness in exit.c' warnings on my SMP testbox (and related
  crashes).

- fixed the _mutex_trylock_bh missing symbol problem reported by K.R. 
  Foley and Florian Schmidt.

- turned the sysrq lock into a raw spinlock, to enable direct keyboard
  irqs.

PREEMPT_REALTIME is still experimental, but it's already looking much
better on my testboxes.

to create a -T7 tree from scratch the patching order is:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.8.tar.bz2
 + http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.9-rc4.bz2
 + http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/2.6.9-rc4-mm1.bz2
 + http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-T7

	Ingo
