Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268693AbUJPKe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268693AbUJPKe6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 06:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268696AbUJPKe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 06:34:58 -0400
Received: from mx1.elte.hu ([157.181.1.137]:28643 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268693AbUJPKeq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 06:34:46 -0400
Date: Sat, 16 Oct 2004 12:36:08 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Daniel Walker <dwalker@mvista.com>,
       Bill Huey <bhuey@lnxw.com>, Andrew Morton <akpm@osdl.org>,
       Adam Heath <doogie@debian.org>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       Andrew Rodland <arodland@entermail.net>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U3
Message-ID: <20041016103608.GA3548@elte.hu>
References: <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <1097888438.6737.63.camel@krustophenia.net> <1097894120.31747.1.camel@krustophenia.net> <20041016064205.GA30371@elte.hu> <1097917325.1424.13.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097917325.1424.13.camel@krustophenia.net>
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


* Lee Revell <rlrevell@joe-job.com> wrote:

> > i regularly test it on UP. Do you have SPINLOCK_DEBUG enabled perhaps? 
> > That doesnt work right now. You can enable DEBUG_SPINLOCK_SLEEP and
> > DEBUG_PREEMPT.
> 
> Sorry, I did have that enabled.  This caused a build failure with a UP
> build and a boot failure with CONFIG_SMP.

not your fault at all - i cleaned this up in my tree so that only valid
combinations can be selected, these fixes will show up in -U4.

it seems that SMP + PREEMPT_TIMING is not stable though, somehow the
latency printk's cause a crash sooner or later. I'm still debugging this
problem. Without PREEMPT_TIMING the SMP kernel is stable.

	Ingo
