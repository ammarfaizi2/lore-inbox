Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136450AbRD3GQj>; Mon, 30 Apr 2001 02:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136451AbRD3GQa>; Mon, 30 Apr 2001 02:16:30 -0400
Received: from www.wen-online.de ([212.223.88.39]:42258 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S136450AbRD3GQK>;
	Mon, 30 Apr 2001 02:16:10 -0400
Date: Mon, 30 Apr 2001 08:15:43 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Frank de Lange <frank@unternet.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Severe trashing in 2.4.4
In-Reply-To: <Pine.GSO.4.21.0104291349530.2210-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0104300757110.601-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Apr 2001, Alexander Viro wrote:

> On Sun, 29 Apr 2001, Frank de Lange wrote:
>
> > On Sun, Apr 29, 2001 at 12:27:29PM -0400, Alexander Viro wrote:
> > > What about /proc/slabinfo? Notice that 2.4.4 (and couple of the 2.4.4-pre)
> > > has a bug in prune_icache() that makes it underestimate the amount of
> > > freeable inodes.
> >
> > Gotcha, wrt. slabinfo. Seems 2.4.4 (at least on my box) only knows how to
> > allocate skbuff_head_cache entries, not how to free them. Here's the last
> > /proc/slabinfo entry before I sysRQ'd the box:
>
> > skbuff_head_cache 341136 341136    160 14214 14214    1 :  252  126
> > size-2048          66338  66338   2048 33169 33169    1 :   60   30
>
> Hmm... I'd say that you also have a leak in kmalloc()'ed stuff - something
> in 1K--2K range. From your logs it looks like the thing never shrinks and
> grows prettu fast...

If it turns out to be difficult to track down, holler and I'll expedite
updating my IKD tree to 2.4.4.

	-Mike  (memleak maintenance weenie)

