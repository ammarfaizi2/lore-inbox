Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266649AbSKLRfx>; Tue, 12 Nov 2002 12:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266645AbSKLRfx>; Tue, 12 Nov 2002 12:35:53 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:30376 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S266649AbSKLRfu>; Tue, 12 Nov 2002 12:35:50 -0500
Date: Tue, 12 Nov 2002 17:43:40 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "David S. Miller" <davem@redhat.com>
cc: akpm@digeo.com, <dmccr@us.ibm.com>, <riel@conectiva.com.br>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] flush_cache_page while pte valid 
In-Reply-To: <20021111.225333.122204472.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0211121732170.1187-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Nov 2002, David S. Miller wrote:
>    From: Hugh Dickins <hugh@veritas.com>
>    Date: Tue, 12 Nov 2002 06:53:04 +0000 (GMT)
>    
>    Thanks for shedding light on that; but I'm still wondering if there
>    might be data loss if userspace modifies the page in the tiny window
>    between correctly positioned flush_cache_page and pte invalidation?
> 
> The flush merely writes back the data, a copy-back operation, fully L2
> cache coherent.  All cpus will see correct data if an intermittant
> store occurs.

Sorry, I still don't get it.  If the flush_cache_page is doing something
necessary, then won't a user access in between it and invalidating pte
undo what was necessary?  And if it's not necessary, why do we do it?
(For better performance would be a very good reason.)

But don't worry about me: I may well have some fundamental misconception
which emailing back and forth will fail to resolve, would just waste your
time and expose my ignorance.  (I think Andrew has sometimes protested
that "flush" can mean too many different things.)  So I'm trying to
understand it better from over here - but glad to see Rik seems
to understand my concern.

Hugh

