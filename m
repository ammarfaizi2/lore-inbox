Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262862AbUJ1JvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262862AbUJ1JvN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 05:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262851AbUJ1Jsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 05:48:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:45489 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262862AbUJ1Jm7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 05:42:59 -0400
Date: Thu, 28 Oct 2004 02:40:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Michael Clark <michael@metaparadigm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 page allocation failure. order:0, mode:0x20
Message-Id: <20041028024039.1a9f5056.akpm@osdl.org>
In-Reply-To: <41808419.8070104@metaparadigm.com>
References: <41808419.8070104@metaparadigm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Clark <michael@metaparadigm.com> wrote:
>
> BTW - 2.6 is much more responsive than 2.4 while this is all
>  going on - i'm just worried about these messages.

It's just debugging stuff.

>  ~mc
> 
>  cc1: page allocation failure. order:0, mode:0x20
>    [<c013ba43>] __alloc_pages+0x1c3/0x390
>    [<c013bc35>] __get_free_pages+0x25/0x40
>    [<c013f283>] kmem_getpages+0x23/0xd0
>    [<c013ffcf>] cache_grow+0xaf/0x160
>    [<c0140202>] cache_alloc_refill+0x182/0x230
>    [<c0140499>] kmem_cache_alloc+0x49/0x50
>    [<c01c07df>] radix_tree_node_alloc+0x1f/0x70
>    [<c01c0aad>] radix_tree_insert+0xed/0x110
>    [<c014d841>] __add_to_swap_cache+0x71/0x100
>    [<c014da5f>] add_to_swap+0x5f/0xc0
>    [<c0142d32>] shrink_list+0x442/0x480
>    [<c014bf7c>] page_referenced_anon+0x7c/0x90
>    [<c01419c8>] __pagevec_release+0x28/0x40

I'm confused.  2.6.9 uses __GFP_NOWARN in add_to_swap() so the messages
should be suppressed.  Are you sure you're using 2.6.9?
