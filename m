Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964926AbVHIVvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbVHIVvp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 17:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964933AbVHIVvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 17:51:45 -0400
Received: from dvhart.com ([64.146.134.43]:56193 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S964926AbVHIVvp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 17:51:45 -0400
Date: Tue, 09 Aug 2005 14:51:40 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, ncunningham@cyclades.com,
       Daniel Phillips <phillips@arcor.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC][patch 0/2] mm: remove PageReserved
Message-ID: <1178630000.1123624300@flay>
In-Reply-To: <1162240000.1123622197@flay>
References: <42F57FCA.9040805@yahoo.com.au> <200508090710.00637.phillips@arcor.de> <1123562392.4370.112.camel@localhost> <42F83849.9090107@yahoo.com.au> <20050809080853.A25492@flint.arm.linux.org.uk> <523240000.1123598289@[10.10.2.4]> <20050809204100.B29945@flint.arm.linux.org.uk> <1162240000.1123622197@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> On Tue, Aug 09, 2005 at 07:38:52AM -0700, Martin J. Bligh wrote:
>>> pfn_valid() doesn't tell you it's RAM or not - it tells you whether you
>>> have a backing struct page for that address. Could be an IO mapped device,
>>> a small memory hole, whatever.
>> 
>> The only things which have a struct page is RAM.  Nothing else does.
> 
> That's not true at all. Every physical address covered by the machine
> that we may need to access, plus every small hole we didn't use 
> discontigmem to exclude has a backing struct page. See e820 maps.

OK, on second thoughts, that's not quite true. Not every phys address
will (eg PCI window etc). but it's certianly not just RAM pages.

M.

