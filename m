Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283658AbRLIROr>; Sun, 9 Dec 2001 12:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281461AbRLIROh>; Sun, 9 Dec 2001 12:14:37 -0500
Received: from www.wen-online.de ([212.223.88.39]:46097 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S283658AbRLIROZ>;
	Sun, 9 Dec 2001 12:14:25 -0500
Date: Sun, 9 Dec 2001 18:17:11 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Leigh Orf <orf@mailbag.com>
cc: "M.H.VanLeeuwen" <vanl@megsinet.net>, Mark Hahn <hahn@physics.mcmaster.ca>,
        Andrew Morton <akpm@zip.com.au>, Ken Brownfield <brownfld@irridia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.16 memory badness (fixed?)
In-Reply-To: <200112091607.fB9G7mj01944@orp.orf.cx>
Message-ID: <Pine.LNX.4.33.0112091758180.411-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Dec 2001, Leigh Orf wrote:

> In a personal email, Mike Galbraith wrote to me:
>
> |   On Sat, 8 Dec 2001, Leigh Orf wrote:
> |
> |   > inode_cache       439584 439586    512 62798 62798    1
> |   > dentry_cache      454136 454200    128 15140 15140    1
> |
> |   I'd try moving shrink_[id]cache_memory to the very top of vmscan.c::shrink_caches.
> |
> |   	-Mike
>
> Mike,
>
> I tried what you suggested starting with a stock 2.4.16 kernel, and it
> did fix the problem with 2.4.16 ENOMEM being returned.
>
> Now with that change and after updatedb runs, here's what the memory
> situation looks like. Note inode_cache and dentry_cache are almost
> nothing. Dunno if that's a good thing or not, but I'd definitely

Almost nothing isn't particularly good after updatedb ;-)

> consider this for a patch.

No, but those do need faster pruning imho.  The growth rate can be
really really fast at times.

	-Mike

