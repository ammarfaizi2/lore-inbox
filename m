Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267690AbUH1Tnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267690AbUH1Tnz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 15:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267671AbUH1Tny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 15:43:54 -0400
Received: from mx1.elte.hu ([157.181.1.137]:656 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267708AbUH1TnU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 15:43:20 -0400
Date: Sat, 28 Aug 2004 21:44:49 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mark_H_Johnson@raytheon.com
Subject: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q2
Message-ID: <20040828194449.GA25732@elte.hu>
References: <20040823221816.GA31671@yoda.timesys> <20040824061459.GA29630@elte.hu> <20040828120309.GA17121@elte.hu> <200408281818.28159.lkml@felipe-alfaro.com> <4130B7BD.5070801@cybsft.com> <1093715573.8611.38.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093715573.8611.38.camel@krustophenia.net>
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

> > > I must be missing something, but after applying diff-bk-040828-2.6.8.1.bz2 and 
> > > voluntary-preempt-2.6.9-rc1-bk4-Q1 on top of 2.6.8.1, I'm unable to find 
> > > neither CONFIG_PREEMPT_VOLUNTARY, CONFIG_PREEMPT_SOFTIRQS, nor 
> > > CONFIG_PREEMPT_HARDIRQS.
> > > 
> > > Any ideas are welcome.
> > 
> > Looks like all of these config options are missing from Q1 also. I was 
> > just looking myself.
> > 
> 
> Same results here, none of those config options seem to exist.  I also
> get this warning a lot:
> 
> include/linux/rwsem.h: In function `down_read':
> include/linux/rwsem.h:43: warning: implicit declaration of function `cond_resched'

there's a Kconfig chunk missing from the Q0/Q1 patches, i've uploaded Q2
that fixes this:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk4-Q2

ontop of:

  http://redhat.com/~mingo/voluntary-preempt/diff-bk-040828-2.6.8.1.bz2

	Ingo
