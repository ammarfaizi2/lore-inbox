Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267386AbUHPDZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267386AbUHPDZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 23:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267387AbUHPDZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 23:25:28 -0400
Received: from mx1.elte.hu ([157.181.1.137]:43405 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267386AbUHPDZ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 23:25:26 -0400
Date: Mon, 16 Aug 2004 05:26:52 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P0
Message-ID: <20040816032652.GB11598@elte.hu>
References: <1092432929.3450.78.camel@mindpipe> <20040814072009.GA6535@elte.hu> <20040815115649.GA26259@elte.hu> <20040816022554.16c3c84a@mango.fruits.de> <1092622121.867.109.camel@krustophenia.net> <20040816023655.GA8746@elte.hu> <1092624221.867.118.camel@krustophenia.net> <20040816025051.GA9481@elte.hu> <20040816025846.GA10240@elte.hu> <1092626279.867.135.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092626279.867.135.camel@krustophenia.net>
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

> On Sun, 2004-08-15 at 22:58, Ingo Molnar wrote:
> > * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > if it doesnt change the xruns then it shows that it's not the locking of
> > make_pages_present() that interacts with jackd, but it's what it does
> > that interacts with it (or with the audio driver).
> > 
> > assuming the DMA-starvation theory isnt excluded via mlock-test2.c:
> 
> Sorry, you lost me here.  Does the behavior of mlock-test2 point to
> the locking of make_pages_present interfering with jackd, or with the
> audio driver?

it's rather pointing in the direction of locking, away from DMA issues. 
Any DMA issue should not depend if we do the activity in 8 chunks or in
one go. Locking on the other hand depends on the length of a single
chunk, not on the length of the total activity.

	Ingo
