Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265641AbSKFES3>; Tue, 5 Nov 2002 23:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265643AbSKFES3>; Tue, 5 Nov 2002 23:18:29 -0500
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:50414 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S265641AbSKFES2>;
	Tue, 5 Nov 2002 23:18:28 -0500
Date: Tue, 5 Nov 2002 23:25:01 -0500
From: Adam Kropelin <akropel1@rochester.rr.com>
To: linux-kernel@vger.kernel.org
Subject: [2.5.46] sleeping function called from illegal context (set_shrinker)
Message-ID: <20021106042501.GB9489@www.kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the one and only illegal sleep trace remaining for me on 2.5.46.
Haven't seen it posted yet, apologies if it's a duplicate. Context
included in case it's helpful.

--Adam

slab: reap timer started for cpu 0
slab: reap timer started for cpu 1
Starting kswapd
aio_setup: sizeof(struct page) = 40
[c1290040] eventpoll: driver installed.
Debug: sleeping function called from illegal context at
+include/asm/semaphore.h:119
Call Trace:
 [<c013e032>] set_shrinker+0x52/0xa0
 [<c017a728>] mb_cache_create+0x1b8/0x270
 [<c017a420>] mb_cache_shrink_fn+0x0/0x150
 [<c0105094>] init+0x54/0x180
 [<c0105040>] init+0x0/0x180
 [<c01072ad>] kernel_thread_helper+0x5/0x18

Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).

