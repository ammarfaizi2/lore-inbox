Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278691AbRJXSFf>; Wed, 24 Oct 2001 14:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278693AbRJXSF0>; Wed, 24 Oct 2001 14:05:26 -0400
Received: from Expansa.sns.it ([192.167.206.189]:18692 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S278691AbRJXSFQ>;
	Wed, 24 Oct 2001 14:05:16 -0400
Date: Wed, 24 Oct 2001 20:05:32 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: safemode <safemode@speakeasy.net>
cc: Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: time tells all about kernel VM's
In-Reply-To: <20011024115518Z279543-17408+4334@vger.kernel.org>
Message-ID: <Pine.LNX.4.33.0110241957170.1991-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 24 Oct 2001, safemode wrote:

> ok.  Reran e2defrag and got the same effect.
> This is the vmstat output by the second.  It starts out with my normal load
> (but no mp3s playing).  Then i start e2defrag with the same arguments as
> before and allow it to run all the way through.  It ends but i dont close it
> until near the very end (which is seen by the swap dropoff.  Then i let my
> normal load again be displayed a bit.  One thing i did notice, however, was
> that the vm handled that quite a lot better than how it handled it after
> being up for 5 days even though it created the 600MB of buffer.

If I do remember well e2defrag was working just with ext2 with 1k as block
size, and latest version compiled with 2.0.12 kernel, (I made also a patch
to compile with 2.0.X kernels after), then ext2 simply evolved and
e2defrag did not.  (by the way e2defrag sources are really isstructive to
learn how a blockFS works).

I used e2defrag since earlier versions, (just with old slow disk, now it
is almost useless, and I went to journaled FSes). If I do remember well,
the behavoiur you are telling was usual with 2.0 kernels.
If the pool is to big, i saw that e2dump shows a lot of inode that left
their group (sic!), and also there could be some FS corruption.
e2defrag was writter to use buffer cache, and now VM changed in details
this behaviour. It could be that what you see is due to those changes?


>
> Here are some /proc/meminfo readings
>
>         total:    used:    free:  shared: buffers:  cached:
> Mem:  790016000 784146432  5869568  1929216 506896384 116387840
> Swap: 133885952 87826432 46059520
> MemTotal:       771500 kB
> MemFree:          5732 kB
> MemShared:        1884 kB
> Buffers:        495016 kB
> Cached:          29848 kB
> SwapCached:      83812 kB
> Active:         312468 kB
> Inact_dirty:    298092 kB
> Inact_clean:         0 kB
> Inact_target:   157272 kB
> HighTotal:           0 kB
> HighFree:            0 kB
> LowTotal:       771500 kB
> LowFree:          5732 kB
> SwapTotal:      130748 kB
> SwapFree:        44980 kB
>
>         total:    used:    free:  shared: buffers:  cached:
> Mem:  790016000 782893056  7122944   188416 633905152 13586432
> Swap: 133885952 116785152 17100800
> MemTotal:       771500 kB
> MemFree:          6956 kB
> MemShared:         184 kB
> Buffers:        619048 kB
> Cached:           7920 kB
> SwapCached:       5348 kB
> Active:         320744 kB
> Inact_dirty:    311756 kB
> Inact_clean:         0 kB
> Inact_target:   157272 kB
> HighTotal:           0 kB
> HighFree:            0 kB
> LowTotal:       771500 kB
> LowFree:          6956 kB
> SwapTotal:      130748 kB
> SwapFree:        16700 kB
>

