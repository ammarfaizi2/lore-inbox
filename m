Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265784AbTIJVgU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 17:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265792AbTIJVgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 17:36:20 -0400
Received: from zok.SGI.COM ([204.94.215.101]:40109 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S265784AbTIJVgQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 17:36:16 -0400
Date: Wed, 10 Sep 2003 14:36:02 -0700
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] you have how many nodes??
Message-ID: <20030910213602.GC17266@sgi.com>
Mail-Followup-To: akpm@osdl.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Needed this for booting on a 128 node system.

Thanks,
Jesse


diff -Nru a/include/linux/mm.h b/include/linux/mm.h
--- a/include/linux/mm.h	Wed Sep 10 14:31:09 2003
+++ b/include/linux/mm.h	Wed Sep 10 14:31:09 2003
@@ -324,7 +324,7 @@
  * sets it, so none of the operations on it need to be atomic.
  */
 #define NODE_SHIFT 4
-#define ZONE_SHIFT (BITS_PER_LONG - 8)
+#define ZONE_SHIFT (BITS_PER_LONG - 10)
 
 struct zone;
 extern struct zone *zone_table[];
diff -Nru a/include/linux/mmzone.h b/include/linux/mmzone.h
--- a/include/linux/mmzone.h	Wed Sep 10 14:31:09 2003
+++ b/include/linux/mmzone.h	Wed Sep 10 14:31:09 2003
@@ -311,8 +311,8 @@
 
 #include <asm/mmzone.h>
 
-/* page->zone is currently 8 bits ... */
-#define MAX_NR_NODES		(255 / MAX_NR_ZONES)
+/* page->zone is currently 10 bits ... */
+#define MAX_NR_NODES		NR_NODES
 
 #endif /* !CONFIG_DISCONTIGMEM */
 
