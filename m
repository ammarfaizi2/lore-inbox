Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbVBQWwD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVBQWwD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 17:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbVBQWvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 17:51:55 -0500
Received: from gate.crashing.org ([63.228.1.57]:19113 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261214AbVBQWvC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 17:51:02 -0500
Subject: Re: [PATCH 2/2] page table iterators
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andi Kleen <ak@suse.de>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050217194336.GA8314@wotan.suse.de>
References: <4214A1EC.4070102@yahoo.com.au> <4214A437.8050900@yahoo.com.au>
	 <20050217194336.GA8314@wotan.suse.de>
Content-Type: text/plain
Date: Fri, 18 Feb 2005 09:49:37 +1100
Message-Id: <1108680578.5665.14.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-17 at 20:43 +0100, Andi Kleen wrote:
> On Fri, Feb 18, 2005 at 01:03:35AM +1100, Nick Piggin wrote:
> > I am pretty surprised myself that I was able to consolidate
> > all "page table range" functions into a single type of iterator
> > (well, there are a couple of variations, but it's not too bad).
> 
> I started a similar project - but it uses the existing loops,
> just using {pte,pmd,pud,pgd}_next. The idea is to optimize
> page table walking by keeping some state in the struct page
> of the page table page that says whether an entry is set 
> or not. To make this work I switched everything to indexes
> instead of pointers.
> 
> Main problem are some nasty include loops. 

I though about both ways yesterday, and in the end, I prefer Nick stuff,
at least for now. It gives us also more flexibility to change gory
implementation details in the future. I still have to run it through a
bit of torture testing though.

Ben.


