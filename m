Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264105AbTEWRcL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 13:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264106AbTEWRcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 13:32:11 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:38855 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id S264105AbTEWRcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 13:32:11 -0400
Date: Fri, 23 May 2003 18:47:31 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Daniel Phillips <phillips@arcor.de>
cc: "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@digeo.com>,
       <hch@infradead.org>, <linux-mm@kvack.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Avoid vmtruncate/mmap-page-fault race
In-Reply-To: <200305231910.58743.phillips@arcor.de>
Message-ID: <Pine.LNX.4.44.0305231840300.1713-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 May 2003, Daniel Phillips wrote:
> On Friday 23 May 2003 18:21, Hugh Dickins wrote:
> > Sorry, I miss the point of this patch entirely.  At the moment it just
> > looks like an unattractive rearrangement - the code churn akpm advised
> > against - with no bearing on that vmtruncate race.  Please correct me.
> 
> This is all about supporting cross-host mmap (nice trick, huh?).  Yes, 
> somebody should post a detailed rfc on that subject.

Ah, thanks - translated into terms that I can understand, so that
some ->nopage() not yet in the tree could do something after the
install_new_page() returns.  Hmm.  Can we be sure it's appropriate
for install_new_page to drop mm->page_table_lock before it returns?

Hugh

