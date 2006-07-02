Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751386AbWGBNjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbWGBNjb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 09:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWGBNjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 09:39:31 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:1691 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751386AbWGBNja (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 09:39:30 -0400
Date: Sun, 2 Jul 2006 15:34:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Miles Lane <miles.lane@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.17-mm4 + hostap + pcmcia + lockdep -- possible recursive locking detected -- (af_callback_keys + sk->sk_family#3){-.-?}, at: [<c119d8db>] sock_def_readable+0x15/0x69
Message-ID: <20060702133451.GA27425@elte.hu>
References: <a44ae5cd0607011804i2326c350ta6262feec1e6805e@mail.gmail.com> <20060702132946.GA25420@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060702132946.GA25420@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5001]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> * Miles Lane <miles.lane@gmail.com> wrote:
> 
> > I have patches for hostap, pcmcia and lockdep applied to this kernel. 
> > These patches are the ones resulting from several recent message 
> > threads. I just noticed this in my kernel log:
> > 
> > [ INFO: possible recursive locking detected ]
> > ---------------------------------------------
> 
> ok, lockdep should allow same-class read-lock recursion too, because 
> it's used by real code and is being relied upon. Could you try the patch 
> below? [...]

the patches are also included in the latest -mm5 combo patch at:

  http://redhat.com/~mingo/lockdep-patches/lockdep-combo-2.6.17-mm5.patch

	Ingo
