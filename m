Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267437AbUHPFFA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267437AbUHPFFA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 01:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267438AbUHPFFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 01:05:00 -0400
Received: from mx1.elte.hu ([157.181.1.137]:12998 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267437AbUHPFEq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 01:04:46 -0400
Date: Mon, 16 Aug 2004 07:04:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P0
Message-ID: <20040816050427.GA16851@elte.hu>
References: <1092432929.3450.78.camel@mindpipe> <20040814072009.GA6535@elte.hu> <20040815115649.GA26259@elte.hu> <20040816022554.16c3c84a@mango.fruits.de> <1092622121.867.109.camel@krustophenia.net> <20040816024314.GA8960@elte.hu> <20040816030818.GA10685@elte.hu> <1092629953.810.23.camel@krustophenia.net> <20040816042653.GA14738@elte.hu> <1092632488.801.6.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092632488.801.6.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> > oh well, indeed it cannot be disabled. Then i'd suggest to return early
> > from extract_entropy(), without doing anything. That is the function
> > that seems to introduce the worst overhead.
> 
> OK, I tried the quick hack of just returning 0 before taking the
> spinlock in extract_entropy, but this broke /dev/random which
> prevented me from logging in.  I guess we will have to properly fake
> it here.

you should return nbytes, not zero.

	Ingo
