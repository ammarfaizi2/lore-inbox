Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271680AbRICLQF>; Mon, 3 Sep 2001 07:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271681AbRICLP4>; Mon, 3 Sep 2001 07:15:56 -0400
Received: from mustard.heime.net ([194.234.65.222]:62177 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S271680AbRICLPo>; Mon, 3 Sep 2001 07:15:44 -0400
Date: Mon, 3 Sep 2001 13:16:02 +0200 (CEST)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: <linux-kernel@vger.kernel.org>
Subject: Page size
Message-ID: <Pine.LNX.4.30.0109031307070.10886-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all

I don't know if this may be considered already, but after reading a few
articles about plans for 2.5, I came to think of this.

As far as I can see, a page size increase is being discussed, and problems
are how to allow for small and large pages at the same time.

I came to think of a good old method used by some file systems to reduce
slack; suballocation. In Novell NetWare's "classic" file system, this is
done by setting a rather high block size (often 64k), and then splitting
each block in eight. This way, all reads and writes are done in whole
blocks, the allocation table is kept quite small, and should you need to
save a small file, it is saved in one or more slices of a block.

Could this translate to kernel memory allocation with, say, a block size
of 256k and possibilities for suballocating blocks down to 4 or 8 k (a 32
or 64 split).

I am not really a kernel hacker, but thought it might be worth mentioning
the ide.

Please cc: any answers to me, as I'm not on the list.

roy

