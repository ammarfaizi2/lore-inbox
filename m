Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291279AbSBSLfp>; Tue, 19 Feb 2002 06:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291268AbSBSLfZ>; Tue, 19 Feb 2002 06:35:25 -0500
Received: from dsl-213-023-040-169.arcor-ip.net ([213.23.40.169]:58775 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S291267AbSBSLfR>;
	Tue, 19 Feb 2002 06:35:17 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] Page table sharing
Date: Tue, 19 Feb 2002 12:39:15 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Rik van Riel <riel@conectiva.com.br>, Hugh Dickins <hugh@veritas.com>,
        <dmccr@us.ibm.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Robert Love <rml@tech9.net>, <mingo@redhat.co>,
        Andrew Morton <akpm@zip.com.au>, <manfred@colorfullife.com>,
        <wli@holomorphy.com>
In-Reply-To: <Pine.LNX.4.33.0202181908210.24803-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0202181908210.24803-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16d8c8-0001Ea-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 19, 2002 04:22 am, Linus Torvalds wrote:
> That still leaves the TLB invalidation issue, but we could handle that
> with an alternate approach: use the same "free_pte_ctx" kind of gathering
> that the zap_page_range() code uses for similar reasons (ie gather up the
> pte entries that you're going to free first, and then do a global
> invalidate later).

I think I'll fall back to unsharing the page table on swapout as Hugh 
suggested, until we sort this out.

It's not that bad.

-- 
Daniel
