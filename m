Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266040AbSKFTLN>; Wed, 6 Nov 2002 14:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266049AbSKFTLN>; Wed, 6 Nov 2002 14:11:13 -0500
Received: from mg02.austin.ibm.com ([192.35.232.12]:33492 "EHLO
	mg02.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S266040AbSKFTLM>; Wed, 6 Nov 2002 14:11:12 -0500
Date: Wed, 6 Nov 2002 13:19:17 -0600 (CST)
From: Kent Yoder <key@austin.ibm.com>
To: linux-mm@kvack.org
cc: linux-kernel@vger.kernel.org
Subject: 2.5.46: sleeping function called from illegal context at mm/slab.c:1305
Message-ID: <Pine.LNX.4.44.0211061308510.14931-100000@ennui.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Seen on boot from 2.5.46-bk pulled earlier today.  This is a UP pentium 3 
w/ 256 MB RAM. For some reason this sounds like a duplicate but I didn't see 
anything...

Kent

slab: reap timer started for cpu 0
Starting kswapd
aio_setup: sizeof(struct page) = 40
[cfea2020] eventpoll: driver installed.
Debug: sleeping function called from illegal context at mm/slab.c:1305
Call Trace:
 [<c0143367>] kmem_flagcheck+0x67/0x70
 [<c0143d47>] kmalloc+0x67/0xc0
 [<c01461bf>] set_shrinker+0x1f/0xa0
 [<c0188a10>] mb_cache_create+0x1f0/0x2d0
 [<c0188640>] mb_cache_shrink_fn+0x0/0x1e0
 [<c0160299>] do_kern_mount+0xa9/0xe0
 [<c01050c3>] init+0x83/0x1b0
 [<c0105040>] init+0x0/0x1b0
 [<c010730d>] kernel_thread_helper+0x5/0x18



