Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbWGCElW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbWGCElW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 00:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWGCElW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 00:41:22 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:28101 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751305AbWGCElV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 00:41:21 -0400
Date: Mon, 3 Jul 2006 06:36:11 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: pageexec@freemail.hu, Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] i386: clean up user_mode() use
Message-ID: <20060703043611.GA12438@elte.hu>
References: <200607021612_MC3-1-C3FD-CC89@compuserve.com> <44A85518.24327.2FBD646A@pageexec.freemail.hu> <Pine.LNX.4.64.0607021433320.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607021433320.12404@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> On Sun, 2 Jul 2006, pageexec@freemail.hu wrote:
> > 
> > the fact that arch *independent* code makes use of user_mode() was 
> > apparently lost on you.
> 
> Argh. Yes, there's one single use, apparently.
> 
> Sad.

but even for new non-generic per-arch code a couple of security holes 
were introduced due to the existing semantics of user_mode(). So this 
indeed changes semantics and it's totally intentional.

so i think we should bite the bullet and should apply this patch. We 
have a constant influx of user_mode() using code and as practice has 
shown it, people dont really consider the vm86 angle of it.

	Ingo
