Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932542AbVHIN05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542AbVHIN05 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 09:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932538AbVHIN05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 09:26:57 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:46288 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932542AbVHIN04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 09:26:56 -0400
Subject: Re: [RFC][patch 0/2] mm: remove PageReserved
From: Arjan van de Ven <arjan@infradead.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Hugh Dickins <hugh@veritas.com>, Russell King <rmk+lkml@arm.linux.org.uk>,
       ncunningham@cyclades.com, Daniel Phillips <phillips@arcor.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <42F8AC87.5060403@yahoo.com.au>
References: <42F57FCA.9040805@yahoo.com.au>
	 <200508090710.00637.phillips@arcor.de>
	 <1123562392.4370.112.camel@localhost> <42F83849.9090107@yahoo.com.au>
	 <20050809080853.A25492@flint.arm.linux.org.uk>
	 <Pine.LNX.4.61.0508091012480.10693@goblin.wat.veritas.com>
	 <42F88514.9080104@yahoo.com.au>
	 <Pine.LNX.4.61.0508091145570.11660@goblin.wat.veritas.com>
	 <42F8AC87.5060403@yahoo.com.au>
Content-Type: text/plain
Date: Tue, 09 Aug 2005 15:26:35 +0200
Message-Id: <1123593996.3839.27.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-09 at 23:15 +1000, Nick Piggin wrote:

> I understand what you mean, and I agree. Though as far away from the
> business end of the drivers I am, I tend to get the feeling that
> drivers need the most hand holding.

they do. It's important to make driver APIs as fool proof as possible.

> 
> Anyway, I guess the way to understand the problem is finding the
> reason why ioremap checks PageReserved, and whether or not ioremap
> should be expected (or allowed) to remap physical RAM in use by
> the kernel.

I can't think of ANY valid reason for that, in fact, it'll break a lot
due to cache aliases etc etc, on various cpus if not even on x86


