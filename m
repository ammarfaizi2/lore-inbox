Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264205AbUEHWcp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264205AbUEHWcp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 18:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264213AbUEHWcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 18:32:45 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:31505 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S264205AbUEHWci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 18:32:38 -0400
Date: Sat, 8 May 2004 23:32:26 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Christoph Hellwig <hch@infradead.org>
cc: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rmap 24 no rmap fastcalls
In-Reply-To: <20040508232143.A12293@infradead.org>
Message-ID: <Pine.LNX.4.44.0405082327420.26646-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 May 2004, Christoph Hellwig wrote:
> >  	/*
> > -	 * The warning below may appear if page_referenced catches the
> > -	 * page in between page_add_{anon,file}_rmap and its replacement
> > +	 * The warning below may appear if page_referenced_anon catches
> > +	 * the page in between page_add_anon_rmap and its replacement
> 
> is this backing out of my comment fixup intentional? :)

I wouldn't dare!  No, look again, it doesn't back it out, it refines
it to refer solely to page_add_anon_rmap, page_add_file_rmap is not
relevant here - your fixup was that the original comment still said
page_add_rmap after that had been replaced by anon, file variants.

What was not intentional was having two rmap 24s:
this was the real 24, and the pte_young one should have said 25.

Hugh

