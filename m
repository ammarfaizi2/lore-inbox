Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263996AbUDOOIu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 10:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264022AbUDOOIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 10:08:49 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:49331
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263996AbUDOOIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 10:08:47 -0400
Date: Thu, 15 Apr 2004 16:08:51 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Benchmarking objrmap under memory pressure
Message-ID: <20040415140851.GF2150@dualathlon.random>
References: <20040415132256.GC2150@dualathlon.random> <Pine.LNX.4.44.0404151439140.8774-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0404151439140.8774-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2004 at 02:45:21PM +0100, Hugh Dickins wrote:
> I like file vma merging, but I am puzzled why we (you) bothered 
> to implement anon vma merging before and not file vma merging,
> if the file vma merging is so much more important.  I suppose
> it's something you learnt later, or the apps evolved.

both things, I learnt it later, but it's also because the anon-vma
pretty much "forced" me not to be lazy about the inodes ;). It's
something I planned already when I changed the mmap mering to handle
inodes too  and submitted to Andrew that merged it in 2.5 mainline, the
only reason I didn't do it at that time, is that it was originally
developed for 2.4, and the less changes the better, so at that time I
only fixed the showstopper inode-merging for mmap and not mprotect.

At 2.4 time I also planned eventually to add the vma merging to mlock
but it didn't happen yet ;).

> Indeed.  If anonmm does live on, I would want to add the file
> vma merging; but when things (mpol, prio_tree, i_shared locking)
> have settled down rather than now - we've lived without it for
> some years, can live without it for a few weeks more.

Sure.
