Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268000AbUIUTUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268000AbUIUTUQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 15:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267998AbUIUTUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 15:20:15 -0400
Received: from mx2.elte.hu ([157.181.151.9]:55007 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268003AbUIUTUE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 15:20:04 -0400
Date: Tue, 21 Sep 2004 21:21:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Mark_H_Johnson@Raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm1-S1
Message-ID: <20040921192143.GA1184@elte.hu>
References: <1094473527.13114.4.camel@boxen> <20040906122954.GA7720@elte.hu> <20040907092659.GA17677@elte.hu> <20040907115722.GA10373@elte.hu> <1094597988.16954.212.camel@krustophenia.net> <20040908082050.GA680@elte.hu> <1094683020.1362.219.camel@krustophenia.net> <20040909061729.GH1362@elte.hu> <20040919122618.GA24982@elte.hu> <415071D4.9060601@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <415071D4.9060601@cybsft.com>
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
> >i've released the -S1 VP patch:
> >
> >  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc2-mm1-S1
> >
> 
> Two separate oopses this morning running that above patch. One appears
> to happen in locks_delete_lock. [...]

i too got this one today. Seems to be related to the BKL changes -
locks.c is a heavy user of the BKL. You have an SMP system, right? Does
the oops happen if you boot with maxcpus=1?

	Ingo
