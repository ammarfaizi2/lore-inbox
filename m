Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263143AbUCMRxh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 12:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263145AbUCMRxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 12:53:37 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:2431 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263143AbUCMRxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 12:53:34 -0500
Date: Sat, 13 Mar 2004 17:53:36 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@osdl.org>, Rik van Riel <riel@redhat.com>,
       William Lee Irwin III <wli@holomorphy.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: anon_vma RFC2
In-Reply-To: <20040313173348.GI30940@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0403131743140.3635-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Mar 2004, Andrea Arcangeli wrote:
> 
> I certainly agree it's simpler. I'm quite undecided if to giveup on the
> anon_vma and to use anonmm plus your unshared during mremap at the
> moment, while it's simpler it's also a definitely inferior solution

I think you should persist with anon_vma and I should resurrect
anonmm, and let others decide between those two and pte_chains.

But while in this trial phase, can we both do it in such a way as to
avoid too much trivial change all over the tree?  For example, I'm
thinking I need to junk my irrelevant renaming of put_dirty_page to
put_stack_page, and for the moment it would help if you cut out your
mapping -> as.mapping changes (when I came to build yours, I had to
go through various filesystems I had in my config updating them
accordingly).  It's a correct change (which I was too lazy to do,
used evil casting instead) but better left as a tidyup for later?

Hugh

