Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267380AbUJBJui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267380AbUJBJui (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 05:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267377AbUJBJui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 05:50:38 -0400
Received: from scanner1.mail.elte.hu ([157.181.1.137]:42880 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267378AbUJBJtV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 05:49:21 -0400
Date: Sat, 2 Oct 2004 11:50:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "K.R. Foley" <kr@cybsft.com>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm4-S7
Message-ID: <20041002095058.GA10181@elte.hu>
References: <20040919122618.GA24982@elte.hu> <414F8CFB.3030901@cybsft.com> <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu> <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu> <20040928000516.GA3096@elte.hu> <1096686137.1397.3.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096686137.1397.3.camel@krustophenia.net>
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

> OK, I have been busy with other things, so haven't been able to test
> as much.  There might be a few regressions with S7.  Here is a trace
> from the ext3 journaling code that I never saw before.  It starts with
> some printks from the rtc_interrupt, due to having the rtc-debug patch
> installed, but these accout for less than 100 usecs of the ~600 usec
> latency.
> 
> http://krustophenia.net/testresults.php?dataset=2.6.9-rc2-mm4-S7
> 
> This part repeats many times:
> 
> 00000001 0.127ms (+0.000ms): journal_refile_buffer (journal_commit_transaction)

ok, will take another look at this one, it seems we dont break out of
the loop early enough.

	Ingo
