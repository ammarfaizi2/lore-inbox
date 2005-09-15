Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030509AbVIOQNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030509AbVIOQNd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 12:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030510AbVIOQNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 12:13:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39603 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030509AbVIOQNc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 12:13:32 -0400
Date: Thu, 15 Sep 2005 09:13:02 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
cc: Hugh Dickins <hugh@veritas.com>, Nick Piggin <npiggin@novell.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Roland McGrath <roland@redhat.com>
Subject: Re: ptrace can't be transparent on readonly MAP_SHARED
In-Reply-To: <20050915154702.GA4122@opteron.random>
Message-ID: <Pine.LNX.4.58.0509150911180.26803@g5.osdl.org>
References: <20050914212405.GD4966@opteron.random>
 <Pine.LNX.4.61.0509151337260.16231@goblin.wat.veritas.com>
 <Pine.LNX.4.58.0509150805150.26803@g5.osdl.org> <20050915154702.GA4122@opteron.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 15 Sep 2005, Andrea Arcangeli wrote:

> On Thu, Sep 15, 2005 at 08:12:59AM -0700, Linus Torvalds wrote:
> > have a PROT_READONLY/PROT_NONE area that is visible from the debugger, but
> > continues to cause SIGSEGV's if the user process itself tries to access
> > it. To me, that's good.
> 
> Continue to cause sigsegv yes, but on the wrong page, when it will read
> the page it can contain different data compared to what is on
> disk/pagecache.

So? You're not making any sense.

I repeat: we CANNOT AVOID the fact that we will do COW.

That COW is required. No way we can avoid it. It has _nothing_ to do with 
maybe_mkwrite().

So I don't know why you continually refuse to just admit that fact. Why do 
you mix up the COW semantics with the maybe_mkwrite() semantics.

If you can't argue against maybe_mkwrite() without involving the COW
argument, then stop arguing. They are two totally different thigns.

		Linus
