Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261393AbSJEBC6>; Fri, 4 Oct 2002 21:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261585AbSJEBC6>; Fri, 4 Oct 2002 21:02:58 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:53633 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261393AbSJEBC5>;
	Fri, 4 Oct 2002 21:02:57 -0400
Message-ID: <3D9E3B65.5070901@colorfullife.com>
Date: Sat, 05 Oct 2002 03:07:49 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: akpm@digeo.com, linux-kernel@vger.kernel.org
CC: mbligh@aracnet.com
Subject: [PATCH] patch-slab-split-07-inline
Content-Type: multipart/mixed;
 boundary="------------080109050801090306040403"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080109050801090306040403
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

part 7:
- remove inline from the cache poison checks: the functions are not 
performance critical.

--
	Manfred


--------------080109050801090306040403
Content-Type: text/plain;
 name="patch-slab-split-07-inline"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-slab-split-07-inline"

--- 2.5/mm/slab.c	Sat Oct  5 02:55:52 2002
+++ build-2.5/mm/slab.c	Sat Oct  5 03:05:27 2002
@@ -688,7 +688,7 @@
 }
 
 #if DEBUG
-static inline void poison_obj (kmem_cache_t *cachep, void *addr)
+static void poison_obj (kmem_cache_t *cachep, void *addr)
 {
 	int size = cachep->objsize;
 	if (cachep->flags & SLAB_RED_ZONE) {
@@ -699,7 +699,7 @@
 	*(unsigned char *)(addr+size-1) = POISON_END;
 }
 
-static inline int check_poison_obj (kmem_cache_t *cachep, void *addr)
+static int check_poison_obj (kmem_cache_t *cachep, void *addr)
 {
 	int size = cachep->objsize;
 	void *end;

--------------080109050801090306040403--


