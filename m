Return-Path: <linux-kernel-owner+w=401wt.eu-S1751485AbWLLQPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbWLLQPZ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 11:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbWLLQPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 11:15:25 -0500
Received: from smtp.osdl.org ([65.172.181.25]:40872 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751485AbWLLQPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 11:15:23 -0500
Date: Tue, 12 Dec 2006 08:13:54 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@davemloft.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] netpoll: fix netpoll lockups
In-Reply-To: <20061212101656.GA5064@elte.hu>
Message-ID: <Pine.LNX.4.64.0612120811180.6452@woody.osdl.org>
References: <20061212101656.GA5064@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 12 Dec 2006, Ingo Molnar wrote:
> 
> current -git doesnt boot on my laptop due to the following netpoll 
> breakages:
> 
>  - unlock the tx lock in the else branch too ...
>  - use irq-safe locking instead of bh-safe locking, netpoll is
>    often called from irq context.

This one doesn't apply for me any more, probably because David checked in 
the patch from Andrew that fixed at least _part_ of the problem.

Davem, Ingo, Herbert, can you verify whether the fixes in the current -git 
tree replace this patch from Ingo, or whether Ingo's patch is still needed 
and just needs to be refreshed.

		Linus
