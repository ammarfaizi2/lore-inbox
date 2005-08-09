Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964978AbVHIVQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978AbVHIVQm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 17:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbVHIVQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 17:16:42 -0400
Received: from dvhart.com ([64.146.134.43]:52097 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S964960AbVHIVQl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 17:16:41 -0400
Date: Tue, 09 Aug 2005 14:16:37 -0700
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
Message-ID: <1162240000.1123622197@flay>
In-Reply-To: <20050809204100.B29945@flint.arm.linux.org.uk>
References: <42F57FCA.9040805@yahoo.com.au> <200508090710.00637.phillips@arcor.de> <1123562392.4370.112.camel@localhost> <42F83849.9090107@yahoo.com.au> <20050809080853.A25492@flint.arm.linux.org.uk> <523240000.1123598289@[10.10.2.4]> <20050809204100.B29945@flint.arm.linux.org.uk>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Tuesday, August 09, 2005 20:41:00 +0100 Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> On Tue, Aug 09, 2005 at 07:38:52AM -0700, Martin J. Bligh wrote:
>> pfn_valid() doesn't tell you it's RAM or not - it tells you whether you
>> have a backing struct page for that address. Could be an IO mapped device,
>> a small memory hole, whatever.
> 
> The only things which have a struct page is RAM.  Nothing else does.

That's not true at all. Every physical address covered by the machine
that we may need to access, plus every small hole we didn't use 
discontigmem to exclude has a backing struct page. See e820 maps.

Unless you're speaking only with respect to ARM, in which case, I'll
bow to your knowledge, but it's certainly not true in general ...

M.

