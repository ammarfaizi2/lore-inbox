Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbVL2PiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbVL2PiO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 10:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbVL2PiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 10:38:14 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:8173 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750760AbVL2PiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 10:38:13 -0500
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
From: Arjan van de Ven <arjan@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>
In-Reply-To: <20051229153529.GH3811@stusta.de>
References: <20051228114637.GA3003@elte.hu>
	 <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org>
	 <1135798495.2935.29.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org>
	 <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu>
	 <20051229143846.GA18833@infradead.org>
	 <1135868049.2935.49.camel@laptopd505.fenrus.org>
	 <20051229153529.GH3811@stusta.de>
Content-Type: text/plain
Date: Thu, 29 Dec 2005 16:38:09 +0100
Message-Id: <1135870689.2935.54.camel@laptopd505.fenrus.org>
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


> > You describe a nice utopia where only the most essential functions are
> > inlined.. but so far that hasn't worked out all that well ;) Turning
> > "inline" back into the hint to the compiler that the C language makes it
> > is maybe a cop-out, but it's a sustainable approach at least.
> >...
> 
> But shouldn't nowadays gcc be able to know best even without an "inline" 
> hint?

it will, the inline hint only affects the thresholds so it's not
entirely without effects, but I can imagine that there are cases that
truely are performance critical and can be optimized out and where you
don't want to help gcc a bit (say a one line wrapper around readl or
writel). Otoh I suspect that modern gcc will be more than smart enough
and inline one liners anyway (if they're static of course).


