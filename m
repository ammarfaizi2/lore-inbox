Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266051AbSKFTXu>; Wed, 6 Nov 2002 14:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266056AbSKFTXu>; Wed, 6 Nov 2002 14:23:50 -0500
Received: from packet.digeo.com ([12.110.80.53]:29637 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266051AbSKFTXt>;
	Wed, 6 Nov 2002 14:23:49 -0500
Message-ID: <3DC96DCC.A7094AEC@digeo.com>
Date: Wed, 06 Nov 2002 11:30:20 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kent Yoder <key@austin.ibm.com>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.46: sleeping function called from illegal context at 
 mm/slab.c:1305
References: <Pine.LNX.4.44.0211061308510.14931-100000@ennui.austin.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Nov 2002 19:30:21.0092 (UTC) FILETIME=[F2118E40:01C285CA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kent Yoder wrote:
> 
>   Seen on boot from 2.5.46-bk pulled earlier today.  This is a UP pentium 3
> w/ 256 MB RAM. For some reason this sounds like a duplicate but I didn't see
> anything...
> 
> Kent
> 
> slab: reap timer started for cpu 0
> Starting kswapd
> aio_setup: sizeof(struct page) = 40
> [cfea2020] eventpoll: driver installed.
> Debug: sleeping function called from illegal context at mm/slab.c:1305
> Call Trace:
>  [<c0143367>] kmem_flagcheck+0x67/0x70
>  [<c0143d47>] kmalloc+0x67/0xc0
>  [<c01461bf>] set_shrinker+0x1f/0xa0
>  [<c0188a10>] mb_cache_create+0x1f0/0x2d0
>  [<c0188640>] mb_cache_shrink_fn+0x0/0x1e0
>  [<c0160299>] do_kern_mount+0xa9/0xe0
>  [<c01050c3>] init+0x83/0x1b0
>  [<c0105040>] init+0x0/0x1b0
>  [<c010730d>] kernel_thread_helper+0x5/0x18

Yup, thanks.  Andreas has prepared a patch which fixes this up.
