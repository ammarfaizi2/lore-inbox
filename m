Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266846AbUHOTPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266846AbUHOTPq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 15:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266849AbUHOTPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 15:15:46 -0400
Received: from mx2.elte.hu ([157.181.151.9]:3272 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266846AbUHOTPp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 15:15:45 -0400
Date: Sun, 15 Aug 2004 21:17:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P0
Message-ID: <20040815191715.GA30643@elte.hu>
References: <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu> <20040812235116.GA27838@elte.hu> <1092382825.3450.19.camel@mindpipe> <20040813104817.GI8135@elte.hu> <1092432929.3450.78.camel@mindpipe> <20040814072009.GA6535@elte.hu> <20040815115649.GA26259@elte.hu> <1092578502.6543.4.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092578502.6543.4.camel@twins>
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


* Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> It still locks up hard for me when voluntary-preempt=3, however it
> does finish the boot; dmesg attached. The lockup occurs several
> minutes into use; usually by by the time I've started X, launched
> evolution and selected my first imap folder the machine's dead.

can you set up a serial logging via a null modem cable from that box to
another box? Then enable the NMI watchdog via nmi_watchdog=1 and
reproduce the lockup - the NMI watchdog should trigger and should
produce a traceback to the serial console.

	Ingo
