Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263180AbTEGNN3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 09:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263182AbTEGNN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 09:13:29 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:32247 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id S263180AbTEGNN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 09:13:28 -0400
Date: Wed, 7 May 2003 14:28:07 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Manfred Spraul <manfred@colorfullife.com>
cc: Andrew Morton <akpm@digeo.com>, Ingo Molnar <mingo@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: initcall kmem_cache cpu 1 oops
In-Reply-To: <3EB81809.4080003@colorfullife.com>
Message-ID: <Pine.LNX.4.44.0305071424220.9955-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 May 2003, Manfred Spraul wrote:
> 
> attached is the promised cleanup/bugfix patch for the slab bootstrap:
>... 
> Andrew, what do you think? The minimal fix for the bug is a two-liner: 
> move g_cpucache_up=FULL from cpucache_init to kmem_cache_sizes_init, but 
> I want to get rid of kmem_cache_sizes_init, too.

Thanks, Manfred, both ways work for me (but my vote would be for your
simplifying patch which eliminates the separate kmem_cache_sizes_init).

Hugh

