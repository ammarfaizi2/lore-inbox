Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbWGDVN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbWGDVN0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 17:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWGDVN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 17:13:26 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:38611 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932401AbWGDVNZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 17:13:25 -0400
Date: Tue, 4 Jul 2006 23:08:33 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Pavel Machek <pavel@ucw.cz>
Cc: Fabio Comolli <fabio.comolli@gmail.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, mingo@redhat.com,
       "Rafael J. Wysocki" <rjw@sisk.pl>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.17-mm5: lockdep prevents suspend to disk
Message-ID: <20060704210833.GA17961@elte.hu>
References: <b637ec0b0607041258j36007132kdb7dbca1fa8f7dd5@mail.gmail.com> <20060704183244.GB4420@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060704183244.GB4420@ucw.cz>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Pavel Machek <pavel@ucw.cz> wrote:

> > Jul  4 21:48:08 tycho kernel:   rt-test-4
> > Jul  4 21:48:08 tycho kernel:   rt-test-5
> > Jul  4 21:48:08 tycho kernel:   rt-test-6
> > Jul  4 21:48:08 tycho kernel:   rt-test-7
> 
> Are rt-test-X tasks kernel threads or userspace programs? (Kernel
> threads need explicit try_to_freeze in them to allow suspend).
> 
> Are they normally killable?

hm, that's not lockdep but due to CONFIG_RT_MUTEX_TESTER.

	Ingo
