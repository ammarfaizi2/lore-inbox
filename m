Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751081AbWFEMww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbWFEMww (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 08:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbWFEMww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 08:52:52 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:34727 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751081AbWFEMwv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 08:52:51 -0400
Date: Mon, 5 Jun 2006 14:52:19 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, arjan@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [patch, -rc5-mm3] fix irqpoll some more
Message-ID: <20060605125219.GB5868@elte.hu>
References: <200606050600.k5560GdU002338@shell0.pdx.osdl.net> <1149497459.23209.39.camel@localhost.localdomain> <20060605084938.GA31915@elte.hu> <1149512708.30554.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149512708.30554.20.camel@localhost.localdomain>
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


* Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Unfortunately we've got a load of handlers that just blindly say "Yes 
> I handled something" so they bogusly cause completion to be assumed.
> 
> We'd actually have to know if the IRQ source had "gone away" on the 
> chip I fear.

ok. Then lets keep what we have right now, and first do the 
disable/enable_irq_handler() API, and once the commonly used drivers are 
covered by the new disable/enable API, apply the unconditional 
desc->depth check to irqpoll?

	Ingo
