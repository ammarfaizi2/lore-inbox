Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbVLTSnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbVLTSnl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 13:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbVLTSnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 13:43:41 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:32686 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750715AbVLTSnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 13:43:40 -0500
Subject: Re: About 4k kernel stack size....
From: Arjan van de Ven <arjan@infradead.org>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: "Linux-Kernel," <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0512201316350.27879@chaos.analogic.com>
References: <20051218231401.6ded8de2@werewolf.auna.net>
	 <43A77205.2040306@rtr.ca> <20051220133729.GC6789@stusta.de>
	 <170fa0d20512200637l169654c9vbe38c9931c23dfb1@mail.gmail.com>
	 <46578.10.10.10.28.1135094132.squirrel@linux1>
	 <Pine.LNX.4.61.0512201202090.27692@chaos.analogic.com>
	 <Pine.LNX.4.64.0512201157140.7859@turbotaz.ourhouse>
	 <Pine.LNX.4.61.0512201316350.27879@chaos.analogic.com>
Content-Type: text/plain
Date: Tue, 20 Dec 2005 19:43:29 +0100
Message-Id: <1135104210.2952.26.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> A kernel stack is simply an implimentation detail. Somebody made
> an early decision to use non-paged memory for stacks. From that
> point one, we have to either live with it or change it. The
> change doesn't involve size. It involves kind.

it involves a whole lot, like banning dma from the stack, and to make it
swapable or kmapped you'd even need to fix all the places that put
things like wait queues on the stack, as well as many other similar data
structures. Staying at 4Kb is a lot easier than that ;)


