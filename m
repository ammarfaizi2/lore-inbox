Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161366AbWGJHE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161366AbWGJHE3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 03:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161365AbWGJHE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 03:04:28 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:28034 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1161362AbWGJHE1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 03:04:27 -0400
Date: Mon, 10 Jul 2006 08:59:52 +0200
From: Ingo Molnar <mingo@elte.hu>
To: David Miller <davem@davemloft.net>
Cc: arjan@infradead.org, davej@redhat.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: auro deadlock
Message-ID: <20060710065952.GA25867@elte.hu>
References: <20060707171916.GA16343@redhat.com> <1152295989.3111.116.camel@laptopd505.fenrus.org> <20060707.120936.98532669.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060707.120936.98532669.davem@davemloft.net>
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


* David Miller <davem@davemloft.net> wrote:

> The lockdep fixes are starting to cause us to go in and start adding 
> hard IRQ protection to many socket layer objects and I want this 
> thinking to end quickly :)

In earlier lockdep versions we had many such hacks, but in the current 
upstream kernel we've only got one such case so far: one netlink 
function, where the alternative was to rewrite softmac. I fixed all the 
earlier hacks to be proper annotations - and the plan is to keep things 
clean in the future too :-)

	Ingo
