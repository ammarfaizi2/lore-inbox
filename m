Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269753AbUICSmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269753AbUICSmP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 14:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269760AbUICSjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 14:39:40 -0400
Received: from mx1.elte.hu ([157.181.1.137]:37016 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269750AbUICSin (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 14:38:43 -0400
Date: Fri, 3 Sep 2004 20:39:47 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Lee Revell <rlrevell@joe-job.com>,
       Mark_H_Johnson@raytheon.com,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R0
Message-ID: <20040903183947.GA11417@elte.hu>
References: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com> <20040902063335.GA17657@elte.hu> <20040902065549.GA18860@elte.hu> <20040902111003.GA4256@elte.hu> <20040902215728.GA28571@elte.hu> <4138A56B.4050006@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4138A56B.4050006@cybsft.com>
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

> Managed to hang the system again under heavy load. This time with the 
> above patch:
> 
> http://www.cybsft.com/testresults/crashes/2.6.9-rc1-bk4-R0.txt

do you have CONFIG_DEBUG_SPINLOCK and CONFIG_DEBUG_SPINLOCK_SLEEP
enabled? These are pretty good at e.g. catching illegal scheduling in
critical sections much earlier. You can enable them on !SMP kernels as
well.

	Ingo

