Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265768AbUHPDN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265768AbUHPDN2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 23:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267385AbUHPDN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 23:13:28 -0400
Received: from mx1.elte.hu ([157.181.1.137]:27272 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265768AbUHPDNX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 23:13:23 -0400
Date: Mon, 16 Aug 2004 05:14:20 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P0
Message-ID: <20040816031420.GA10919@elte.hu>
References: <1092432929.3450.78.camel@mindpipe> <20040814072009.GA6535@elte.hu> <20040815115649.GA26259@elte.hu> <20040816022554.16c3c84a@mango.fruits.de> <1092622121.867.109.camel@krustophenia.net> <20040816023655.GA8746@elte.hu> <1092624221.867.118.camel@krustophenia.net> <20040816025051.GA9481@elte.hu> <20040816025846.GA10240@elte.hu> <1092625901.867.130.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092625901.867.130.camel@krustophenia.net>
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

> > i've attached mlock-test2.cc that should test this theory. The code
> > breaks up the mlock-ed region into 8 equal pieces and does mlock() on
> > them separately. It's basically a lock-break done in user-space. Does
> > this change the nature of xruns?
> 
> This does change the xruns.  I have to `mlock-test2 8000' to produce
> any xrun at all, and that only produces a 2-300 usec xrun.  With
> mlockall-test the threshold to produce an xrun was ~1500.

did you try mlock-test.cc too? Just to make sure that mlock-test.cc is
equivalent to mlockall-test.cc.

	Ingo
