Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbUCVDnw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 22:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbUCVDnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 22:43:52 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38295 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261654AbUCVDnu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 22:43:50 -0500
Date: Sun, 21 Mar 2004 22:43:41 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Christoph Hellwig <hch@infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.5-rc2-aa1
In-Reply-To: <20040321234355.GB3649@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0403212239170.20045-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2004, Andrea Arcangeli wrote:

> >  - the struct anon_vma_s / anon_vma_t naming is awkward, why not just
> >    struct anon_vma *insert reference to Documentation/CodingStyle here*
> 
> Andrew already complained about that, I don't mind either ways now that
> it's implemented, it never needs forward declaration so it's not
> required to be a struct and I don't see why we should restrict us to a
> subset of the C language when a typedef can save characters. While
> coding I want to be efficient so I want to save characters,

You won't be spending anywhere near as much time typing the
code as you (and everybody else) will be spending _reading_
the code.

> typedefs help in saving my time

Presuming you'll never debug your code ;)

> >  - the inclusion guards in objrmap.h are wrong
> 
> can you elaborate?

They're _LINUX_RMAP_H and not _LINUX_OBJRMAP_H.  If you want
to be consistent you may want to either rename the inclusion
guards, or the file ;)

> >  - is renaming rmap.c to objrmap.c really nessecary?  It contains >  about
> >    the same functions, and keeping the old, implementation-agnostic name
> >    makes it easiert to follow the radical changes..
> 
> b*tkeeper will automagically notice the rename when Linus merges

Only if (1) you're using bitkeeper and (2) you used 'bk mv'
to move rmap.c to objrmap.c and (3) Linus pulls from your
bitkeeper tree.

Unless all 3 of these are true, you're giving bitkeeper more
credit than it deserves ;)

> I renamed it primarly because rmap is the common name for the tecnique
> of traking the pagetables with pte_chains

Funny, first thing I hear about that ;)


-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

