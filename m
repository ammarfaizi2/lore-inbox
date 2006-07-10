Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932489AbWGJJa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbWGJJa6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 05:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbWGJJa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 05:30:58 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:13771 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932489AbWGJJa5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 05:30:57 -0400
Date: Mon, 10 Jul 2006 11:25:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.18-rc1-mm1
Message-ID: <20060710092528.GA8455@elte.hu>
References: <20060709021106.9310d4d1.akpm@osdl.org> <6bffcb0e0607090332i477d594fq9ef96721574ae91b@mail.gmail.com> <20060709035203.cdc3926f.akpm@osdl.org> <20060710074039.GA26853@elte.hu> <6bffcb0e0607100222m5cbdba31ia39d47f3f1f94b26@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bffcb0e0607100222m5cbdba31ia39d47f3f1f94b26@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5010]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:

> >> rofl.  You broke lockdep.
> >
> >ouch! the lock identifications look quite funny :-| Never saw that
> >happen before,
> 
> :)
> 
> >i'm wondering what's going on. Michal, did this happen
> >straight during bootup? Or did you remove/recompile/reinsert any modules
> >perhaps?
> 
> It's happening while /etc/init.d/cpuspeed execution.
> 
> I forgot about "make O=/dir/ clean". When new -mm is out I always 
> remove kernel directory and create new one.

ah, ok. So i'll put this under the 'unclean-build artifact' section, 
i.e. not a lockdep bug for now, it seems. Please re-report if it ever 
occurs again with a clean kernel build.

	Ingo
