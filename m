Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbUCDQV1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 11:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbUCDQV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 11:21:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46026 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261876AbUCDQV0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 11:21:26 -0500
Date: Thu, 4 Mar 2004 11:21:08 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Christoph Hellwig <hch@infradead.org>
cc: Dave McCracken <dmccr@us.ibm.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 230-objrmap fixes for 2.6.3-mjb2
In-Reply-To: <20040304154742.A12277@infradead.org>
Message-ID: <Pine.LNX.4.44.0403041120450.20043-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Mar 2004, Christoph Hellwig wrote:

> void mlock_page(struct page *page)
> {
> 	if (!test_and_set_bit(PG_mlocked, &page->flags)
> 		remove_from_lru_if_there();
> 	atomic_inc(&page.some_union->mlock_count);
> }

Looks ok to me.

> if so that would help me greatly for xfs, but I'd also need a 2.4 variant..

I don't see why the same thing wouldn't work for 2.4 ...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

