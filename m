Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264124AbUESLWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264124AbUESLWq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 07:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263711AbUESLVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 07:21:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5008 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264124AbUESLS5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 07:18:57 -0400
Date: Wed, 19 May 2004 07:18:46 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Albert Cahalan <albert@users.sourceforge.net>
cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: pte_addr_t size reduction for 64 GB case?
In-Reply-To: <1084941731.955.836.camel@cube>
Message-ID: <Pine.LNX.4.44.0405190717330.22258-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 May 2004, Albert Cahalan wrote:

> When handling 64 GB on i386, pte_addr_t really only
> needs 33 bits to find the PTE. It sure doesn't need
> the full 64 bits it is using.

Alternatively, limit the amount of memory supported to
32GB ;)

With only 1GB of lowmem you can't support much more
than that anyway.  The RHEL3 -smp kernel limits itself
to 32GB in order to have a smaller pte_addr_t.

For larger systems there's the -hugemem kernel, which
has Ingo's 4:4 split enabled.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

