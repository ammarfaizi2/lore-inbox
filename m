Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267370AbUHPC7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267370AbUHPC7h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 22:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267372AbUHPC7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 22:59:37 -0400
Received: from mx1.elte.hu ([157.181.1.137]:29313 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267370AbUHPC7g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 22:59:36 -0400
Date: Mon, 16 Aug 2004 05:00:53 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P0
Message-ID: <20040816030053.GA10323@elte.hu>
References: <1092382825.3450.19.camel@mindpipe> <20040813104817.GI8135@elte.hu> <1092432929.3450.78.camel@mindpipe> <20040814072009.GA6535@elte.hu> <20040815115649.GA26259@elte.hu> <20040816022554.16c3c84a@mango.fruits.de> <1092622121.867.109.camel@krustophenia.net> <20040816023655.GA8746@elte.hu> <1092624221.867.118.camel@krustophenia.net> <20040816025051.GA9481@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040816025051.GA9481@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> could this be some DMA starvation effect? Or is this xrun calculated
> from arrival of the audio interrupt (hence DMA completion) to the
> actual running of jackd?

would there be a way to find out what portion of the xrun is caused by
latencies of the audio card (DMA, etc.) vs. latency from the point jackd
is woken up by the sound-driver to the point jackd preempts the mlock
process and runs?

	Ingo
