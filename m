Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263535AbTJLU2P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 16:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263536AbTJLU2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 16:28:15 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:38660 "EHLO
	cluless.boston.redhat.com") by vger.kernel.org with ESMTP
	id S263535AbTJLU2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 16:28:13 -0400
Date: Sun, 12 Oct 2003 16:28:09 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cluless.boston.redhat.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: linux-kernel@vger.kernel.org, <akpm@osdl.org>
Subject: Re: [RFC] invalidate_mmap_range() misses remap_file_pages()-affected
 targets
In-Reply-To: <20031012084842.GB765@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0310121626260.31963-100000@cluless.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Oct 2003, William Lee Irwin III wrote:

> invalidate_mmap_range(), and hence vmtruncate(), can miss its targets
> due to remap_file_pages()

Please don't.   Remap_file_pages() not 100% working the way
a normal mmap() works should be a case of "doctor, it hurts".

Making the VM more complex just to support the (allegedly
low overhead) hack of remap_file_pages() doesn't seem like
a worthwhile tradeoff to me.

In fact, I wouldn't mind if remap_file_pages() was simplified ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

