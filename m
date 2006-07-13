Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750982AbWGMNWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbWGMNWe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 09:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbWGMNWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 09:22:34 -0400
Received: from ns.suse.de ([195.135.220.2]:52973 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750982AbWGMNWe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 09:22:34 -0400
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: utrace vs. ptrace
Date: Thu, 13 Jul 2006 15:21:52 +0200
User-Agent: KMail/1.9.3
Cc: Albert Cahalan <acahalan@gmail.com>, torvalds@osdl.org,
       alan@lxorguk.ukuu.org.uk, arjan@infradead.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>
References: <787b0d920607122243g24f5a003p1f004c9a1779f75c@mail.gmail.com> <200607131437.28727.ak@suse.de> <20060713124316.GA18852@elte.hu>
In-Reply-To: <20060713124316.GA18852@elte.hu>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200607131521.52505.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I'm not sure that's particularly useful (I think I would prefer to 
> > keep it in kernel), [...]
> 
> why would we want to keep this in the kernel? Coredumping in the kernel 
> is fragile, and it's nowhere near performance-critical to really live 
> within the kernel.

Mostly because I fear it would become another udev like disaster, requiring user 
space updates regularly, and core dumps are a fairly critical debugging feature
that I wouldn't like to become unreliable.

That said extended core dumping (e.g. automatic processing of the output) 
in user space makes sense. I had a prototype for that once that uploaded
a simple crash report to a web page.

-Andi
