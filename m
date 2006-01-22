Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbWAVUHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbWAVUHy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 15:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWAVUHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 15:07:54 -0500
Received: from xenotime.net ([66.160.160.81]:40866 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751330AbWAVUHy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 15:07:54 -0500
Date: Sun, 22 Jan 2006 12:06:19 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: penberg@cs.helsinki.fi, akpm <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] slab: fix sparse warning
Message-Id: <20060122120619.5bae6004.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

fix sparse warning:
mm/slab.c:1522:13: error: incompatible types for operation (&)

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 mm/slab.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2616-rc1g4.orig/mm/slab.c
+++ linux-2616-rc1g4/mm/slab.c
@@ -1501,7 +1501,7 @@ static inline void set_up_list3s(kmem_ca
  * towards high-order requests, this should be changed.
  */
 static inline size_t calculate_slab_order(kmem_cache_t *cachep, size_t size,
-					  size_t align, gfp_t flags)
+					  size_t align, unsigned long flags)
 {
 	size_t left_over = 0;
 


---
