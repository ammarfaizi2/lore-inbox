Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312178AbSD2Nxm>; Mon, 29 Apr 2002 09:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312194AbSD2Nxl>; Mon, 29 Apr 2002 09:53:41 -0400
Received: from conn6m.toms.net ([64.32.246.219]:9453 "EHLO conn6m.toms.net")
	by vger.kernel.org with ESMTP id <S312178AbSD2Nxk>;
	Mon, 29 Apr 2002 09:53:40 -0400
Date: Mon, 29 Apr 2002 08:07:15 -0400 (EDT)
From: Tom Oehser <tom@toms.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: linux-kernel@vger.rutgers.org, <torvalds@transmeta.com>
Subject: Re: I made a bzip2 bootloader and ramdisk patch, ?useful/not?
In-Reply-To: <3CCCD819.4080108@mandrakesoft.com>
Message-ID: <Pine.LNX.4.44.0204290738470.32489-100000@conn6m.toms.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 29 Apr 2002, Jeff Garzik wrote:

> I made this patch for 2.2.x kernels long ago, and if you search

Ah.  But it looks like you only patched the ramdisk loader, I did
the bootloader also.  My intention is that it would be used as a
replacement for the gzip thoughout, the kernel I have on tomsrtbt
2.0.88 does the bzip2 kernel load and bzip2 ramdisk load, and does
not include the gzip code at all.

As for figures-

I have only tested with bzip2 -9, and my patch only supports small
(not fast), (remember that I'm coming from a floppy diskette...).
I'm aiming for compression then memory then speed, so, I don't have
numbers for what bzip2 -1 or fast-RLE would be like.  Moreover, the
tomsrtbt is loading a 4MB ramdisk from a 1.722 floppy, so I'm not
testing memory usage beyond pass/fail on an 8MB machine.

In _my_ configuration, (tomsrtbt 2.0.88), the numbers (to the best
accuracy I have, using the current best measure I have performed):

Size:

             gzip    bzip2    savings

Kernel     862209   831381      30828

Ramdisk    939474   880756      58718
           ______   ______      _____

Total     1801683  1712137      89546


              Speed    Memory

Gzip      Lightning   Thimble

Bzip2      Molasses   Bathtub


-Tom


