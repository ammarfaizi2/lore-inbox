Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbWC2P3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWC2P3P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 10:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWC2P3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 10:29:15 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:51158 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751173AbWC2P3O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 10:29:14 -0500
Date: Wed, 29 Mar 2006 17:26:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Ulrich Drepper <drepper@gmail.com>, linux-kernel@vger.kernel.org,
       jakub@redhat.com
Subject: Re: [PATCH] 2.6.16 - futex: small optimization (?)
Message-ID: <20060329152643.GA13194@elte.hu>
References: <4428E7B7.8040408@bull.net> <a36005b50603280702n2979d8ddh97484615ea9d4f3a@mail.gmail.com> <4429BCAC.80208@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4429BCAC.80208@tmr.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Bill Davidsen <davidsen@tmr.com> wrote:

> Ulrich Drepper wrote:
> >On 3/27/06, Pierre PEIFFER <pierre.peiffer@bull.net> wrote:
> >>I found a (optimization ?) problem in the futexes, during a futex_wake,
> >>  if the waiter has a higher priority than the waker.
> >
> >There are no such situations anymore in an optimal userlevel
> >implementation.  The last problem (in pthread_cond_signal) was fixed
> >by the addition of FUTEX_WAKE_OP.  The userlevel code you're looking
> >at is simply not optimized for the modern kernels.
> 
> What are you suggesting here, that the kernel can be inefficient as 
> long as the user has a way to program around it?

What are you suggesting here, that FUTEX_WAKE_UP is a "user way to 
program around" an inefficiency? If yes then please explain to me why 
and what you would do differently.

	Ingo
