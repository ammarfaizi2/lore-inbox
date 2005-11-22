Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbVKVHL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbVKVHL5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 02:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbVKVHL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 02:11:57 -0500
Received: from silver.veritas.com ([143.127.12.111]:10563 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932179AbVKVHL4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 02:11:56 -0500
Date: Tue, 22 Nov 2005 07:12:02 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Paul Mackerras <paulus@samba.org>
cc: Andrew Morton <akpm@osdl.org>,
       Ben Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] mm: powerpc ptlock comments
In-Reply-To: <17282.21410.203627.607569@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.61.0511220705110.22267@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511212025220.19274@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0511212033330.19274@goblin.wat.veritas.com>
 <17282.21410.203627.607569@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 22 Nov 2005 07:11:56.0345 (UTC) FILETIME=[05BBAA90:01C5EF34]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2005, Paul Mackerras wrote:
> 
> > Update comments (only) on page_table_lock and mmap_sem in arch/powerpc.
> 
> [snip]
> 
> >  	/*
> > -	 * No need to use ldarx/stdcx here because all who
> > -	 * might be updating the pte will hold the
> > -	 * page_table_lock
> > +	 * No need to use ldarx/stdcx here
> >  	 */
> 
> If you're going to remove the because clause you might as well remove
> the whole comment.  What you have left is either redundant or
> mystifying (according to the depth of knowledge of the reader).  And
> in fact I don't think I could now say why we don't need an atomic
> update sequence there, so I would appreciate something that updates
> the "because" part.

All I'm doing here is tidying up by removing the no-longer-appropriate
reference to page_table_lock.  As my snipped patch comment said:

> Update comments (only) on page_table_lock and mmap_sem in arch/powerpc.
> Removed the comment on page_table_lock from hash_huge_page: since it's
> no longer taking page_table_lock itself, it's irrelevant whether others
> are; but how it is safe (even against huge file truncation?) I can't say.

I'd appreciate something that updates the "because" part too, but don't
know the answer.  That other patch will need to come from your end - Ben?

Hugh
