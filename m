Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271050AbUJVDAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271050AbUJVDAA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 23:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271186AbUJVC5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 22:57:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59567 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S271169AbUJVCwD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 22:52:03 -0400
Date: Thu, 21 Oct 2004 22:51:34 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@novell.com>
cc: Andrew Morton <akpm@osdl.org>, <shaggy@austin.ibm.com>,
       <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH] zap_pte_range should not mark non-uptodate pages dirty
In-Reply-To: <20041022004159.GB14325@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0410212250500.13944-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Oct 2004, Andrea Arcangeli wrote:

> The pte shootdown from my point of view is just an additional coherency
> feature, but it cannot provide full coherency anyways, since the
> invalidate arrives after the I/O hit the disk, so the page will be out
> of sync with the disk if it's dirty, and no coherency can be provided
> anyways, because no locking happens to get max scalability.

That depends on the filesystem.  I hope the clustered filesystems
will be able to provide full coherency by doing the invalidates
in the right order.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

