Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWGCGPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWGCGPM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 02:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWGCGPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 02:15:12 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:24970 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750768AbWGCGPL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 02:15:11 -0400
Date: Mon, 3 Jul 2006 08:10:31 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Miles Lane <miles.lane@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.17-mm4 + hostap + pcmcia + lockdep -- possible recursive locking detected -- (af_callback_keys + sk->sk_family#3){-.-?}, at: [<c119d8db>] sock_def_readable+0x15/0x69
Message-ID: <20060703061030.GA16046@elte.hu>
References: <a44ae5cd0607011804i2326c350ta6262feec1e6805e@mail.gmail.com> <20060702132946.GA25420@elte.hu> <20060702133451.GA27425@elte.hu> <a44ae5cd0607022308n646af3dh836df90b31e60dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a44ae5cd0607022308n646af3dh836df90b31e60dc@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5003]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Miles Lane <miles.lane@gmail.com> wrote:

> >> ok, lockdep should allow same-class read-lock recursion too, because
> >> it's used by real code and is being relied upon. Could you try the patch
> >> below? [...]
> >
> >the patches are also included in the latest -mm5 combo patch at:
> >
> >  http://redhat.com/~mingo/lockdep-patches/lockdep-combo-2.6.17-mm5.patch
> 
> I have not seen this particular INFO message show up again.

you know that the validator produces only one message per bootup, right? 
So unless you rebooted meanwhile, not seeing more messages after the 
first one is normal.

> Therefore, I haven't tested your latest patch yet.  I wanted to 
> determine whether this problem would occur often.  If you like I can 
> go ahead and test the patch anyhow.  I am currently testing mm5 + the 
> pcmcia patch and the hostap patch.  I am looking into a crashing 
> (system lockup) bug that is triggered by removing my Linksys USB 
> 10/100 Ethernet adapter.  This problem is 100% repeatable.  I am 
> working on setting up a remote debugging configuration.
> 
> Would you like me to go ahead and test your latest patch?

no hurries - just pick it up whenever you go to a new kernel.

	Ingo
