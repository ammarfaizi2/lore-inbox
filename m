Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262106AbUKVPfD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbUKVPfD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 10:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbUKVOjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 09:39:49 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:30726 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261387AbUKVObW (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 09:31:22 -0500
Date: Mon, 22 Nov 2004 14:31:02 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Nikita Danilov <nikita@clusterfs.com>, <Linux-Kernel@vger.kernel.org>,
       <linux-mm@kvack.org>
Subject: Re: [PATCH]: 3/4 mm/rmap.c cleanup
In-Reply-To: <20041121131437.4c3bcee0.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0411221428080.2867-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Nov 2004, Andrew Morton wrote:
> Nikita Danilov <nikita@clusterfs.com> wrote:
> >
> > mm/rmap.c:page_referenced_one() and mm/rmap.c:try_to_unmap_one() contain
> >  identical code that
> > 
> >   - takes mm->page_table_lock;
> > 
> >   - drills through page tables;
> > 
> >   - checks that correct pte is reached.
> > 
> >  Coalesce this into page_check_address()
> 
> Looks sane, but it comes at a bad time.  Please rework and resubmit after
> the 4-level pagetable code is merged into Linus's tree, post-2.6.10.

Personally, I prefer the straightforward way it looks without Nikita's
patch.  But it is a matter of personal taste, and I may well be in the
minority.

Would be better justified if the common function were not "inline"?

Hugh

