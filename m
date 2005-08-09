Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932506AbVHIKTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbVHIKTN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 06:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbVHIKTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 06:19:13 -0400
Received: from grendel.sisk.pl ([217.67.200.140]:13208 "HELO mail.sisk.pl")
	by vger.kernel.org with SMTP id S932506AbVHIKTN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 06:19:13 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [RFC][patch 0/2] mm: remove PageReserved
Date: Tue, 9 Aug 2005 12:24:36 +0200
User-Agent: KMail/1.8.2
Cc: Arjan van de Ven <arjan@infradead.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, ncunningham@cyclades.com,
       Daniel Phillips <phillips@arcor.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Pavel Machek <pavel@ucw.cz>
References: <42F57FCA.9040805@yahoo.com.au> <1123576719.3839.13.camel@laptopd505.fenrus.org> <42F877FF.9000803@yahoo.com.au>
In-Reply-To: <42F877FF.9000803@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508091224.37668.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 9 of August 2005 11:31, Nick Piggin wrote:
> Arjan van de Ven wrote:
> > On Tue, 2005-08-09 at 08:08 +0100, Russell King wrote:
> 
> >>Can we straighten out the terminology so it's less confusing please?
> >>
> > 
> > 
> > and..... can we make a general page_is_ram() function that does what it
> > says? on x86 it can go via the e820 table, other architectures can do
> > whatever they need....
> > 
> 
> That would be very helpful. That should cover the remaining (ab)users
> of PageReserved.
> 
> It would probably be fastest to implement this with a page flag,
> however if swsusp and ioremap are the only users then it shouldn't
> be a problem to go through slower lookups (and this would remove the
> need for the PageValidRAM flag that I had worried about earlier).

I think swsusp can be modified to use PageNosave only and everything
that is not to be touched by swsusp should be marked as no-save.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
