Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbWJFLe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWJFLe1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 07:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbWJFLe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 07:34:26 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:20450 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750803AbWJFLeZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 07:34:25 -0400
Date: Fri, 6 Oct 2006 13:25:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Howells <dhowells@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Thomas Gleixner <tglx@linutronix.de>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>,
       Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than	passing to IRQ handlers
Message-ID: <20061006112550.GA21733@elte.hu>
References: <20061002132116.2663d7a3.akpm@osdl.org> <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com> <20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com> <18975.1160058127@warthog.cambridge.redhat.com> <4525A8D8.9050504@garzik.org> <1160133932.1607.68.camel@localhost.localdomain> <45263ABC.4050604@garzik.org> <20061006111156.GA19678@elte.hu> <45263D9C.9030200@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45263D9C.9030200@garzik.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jeff Garzik <jeff@garzik.org> wrote:

> >but pt_regs is alot less frequently used than irq - and where it's 
> >used they arent "drivers" but mostly arch level code like hw-timer 
> >handlers.
> 
> Nonetheless the -vast majority- of drivers don't use the argument at 
> all, and the minority that do use it are not modern drivers.

i'm all for changing that too :)

	Ingo
