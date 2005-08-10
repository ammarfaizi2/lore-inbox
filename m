Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932512AbVHJJeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512AbVHJJeo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 05:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbVHJJeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 05:34:44 -0400
Received: from gate.crashing.org ([63.228.1.57]:22403 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932512AbVHJJen (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 05:34:43 -0400
Subject: Re: [RFC][patch 0/2] mm: remove PageReserved
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, ncunningham@cyclades.com,
       Daniel Phillips <phillips@arcor.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <20050809204100.B29945@flint.arm.linux.org.uk>
References: <42F57FCA.9040805@yahoo.com.au>
	 <200508090710.00637.phillips@arcor.de>
	 <1123562392.4370.112.camel@localhost> <42F83849.9090107@yahoo.com.au>
	 <20050809080853.A25492@flint.arm.linux.org.uk>
	 <523240000.1123598289@[10.10.2.4]>
	 <20050809204100.B29945@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Wed, 10 Aug 2005 11:27:24 +0200
Message-Id: <1123666046.30257.226.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-09 at 20:41 +0100, Russell King wrote:
> On Tue, Aug 09, 2005 at 07:38:52AM -0700, Martin J. Bligh wrote:
> > pfn_valid() doesn't tell you it's RAM or not - it tells you whether you
> > have a backing struct page for that address. Could be an IO mapped device,
> > a small memory hole, whatever.
> 
> The only things which have a struct page is RAM.  Nothing else does.

Well, not anymore :)

With sparsemem, you can cheat now and have struct page for non-RAM, and
this is actually useful. I want some IO space to be "context switchable"
and thus map it with nopage() functionality, etc...

Ben.

