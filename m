Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313026AbSDOHNH>; Mon, 15 Apr 2002 03:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313038AbSDOHNG>; Mon, 15 Apr 2002 03:13:06 -0400
Received: from mx1.elte.hu ([157.181.1.137]:29366 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S313026AbSDOHNF>;
	Mon, 15 Apr 2002 03:13:05 -0400
Date: Mon, 15 Apr 2002 07:09:16 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] move the mempool list_head out of the managed elements
In-Reply-To: <3CB7CAF0.FC2768B8@zip.com.au>
Message-ID: <Pine.LNX.4.44.0204150708320.4243-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 12 Apr 2002, Andrew Morton wrote:

> But when the page allocator starts failing, and radix tree node
> allocations are satisfied from the mempool, they come back with a
> defunct list_head at the first eight bytes, and the ratcache dies in
> subtle ways.
> 
> A nasty part about this is that the problem only exhibits under very
> high load.

good catch - your patch looks good to me.

	Ingo

