Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266915AbSKKS3H>; Mon, 11 Nov 2002 13:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266916AbSKKS3H>; Mon, 11 Nov 2002 13:29:07 -0500
Received: from packet.digeo.com ([12.110.80.53]:44255 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266915AbSKKS3G>;
	Mon, 11 Nov 2002 13:29:06 -0500
Message-ID: <3DCFF883.AFE1B55C@digeo.com>
Date: Mon, 11 Nov 2002 10:35:47 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Dave McCracken <dmccr@us.ibm.com>, Rik van Riel <riel@conectiva.com.br>,
       "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] flush_cache_page while pte valid
References: <Pine.LNX.4.44.0211111808240.1236-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Nov 2002 18:35:47.0888 (UTC) FILETIME=[27270300:01C289B1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> 
> On some architectures (cachetlb.txt gives HyperSparc as an example)
> it is essential to flush_cache_page while pte is still valid: the
> rmap VM diverged from the base 2.4 VM before that fix was made,
> so this error has crept back into 2.5.

OK, thanks.

> Patch below applies to 2.5.47 or 2.5.47-mm1 - needs more work over
> shared pagetables, but they've silently fallen out of 2.5.47-mm1:
> oversight?

Yes, oversight.  dcache-rcu was similarly lost.  Pathetic, isn't it?
