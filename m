Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268247AbUH2SAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268247AbUH2SAP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 14:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268248AbUH2SAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 14:00:14 -0400
Received: from mx1.elte.hu ([157.181.1.137]:38629 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268247AbUH2R75 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 13:59:57 -0400
Date: Sun, 29 Aug 2004 20:01:35 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Daniel Schmitt <pnambic@unu.nu>, "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mark_H_Johnson@raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q4
Message-ID: <20040829180135.GA28767@elte.hu>
References: <20040828194449.GA25732@elte.hu> <200408282210.03568.pnambic@unu.nu> <20040828203116.GA29686@elte.hu> <1093727453.8611.71.camel@krustophenia.net> <20040828211334.GA32009@elte.hu> <1093727817.860.1.camel@krustophenia.net> <1093737080.1385.2.camel@krustophenia.net> <1093746912.1312.4.camel@krustophenia.net> <20040829054339.GA16673@elte.hu> <1093762642.1348.3.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093762642.1348.3.camel@krustophenia.net>
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

> > > The problem only occurs when CONFIG_PREEMPT_HARDIRQS=y.  Works fine
> > > otherwise.
> > 
> > i suspect it's the generic_synchronize_irq() change. Does -Q4 boot?:
> > 
> >   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk4-Q4
> > 
> > -Q4 reverts this change. (this doesnt solve the problems Scott noticed
> > though.)
> > 
> > another solution would be to boot Q3 with preempt_hardirqs=0 and then
> > turn on threading for all IRQs but the keyboard.
> > 
> 
> Nope, neither of these fixes the problem.

the correct boot parameter is hardirq-preempt=0.

	Ingo
