Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759117AbWLAGWI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759117AbWLAGWI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 01:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759131AbWLAGWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 01:22:07 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:9732 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1759117AbWLAGWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 01:22:05 -0500
Date: Fri, 1 Dec 2006 07:22:10 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove EXPORT_UNUSED_SYMBOL'ed symbols
Message-ID: <20061201062210.GM11084@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In time for 2.6.20, we can get rid of this junk.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 kernel/printk.c |    3 ---
 mm/bootmem.c    |    2 --
 mm/memory.c     |    1 -
 mm/mmzone.c     |    5 -----
 4 files changed, 11 deletions(-)

--- linux-2.6.19-rc6-mm2/kernel/printk.c.old	2006-12-01 06:54:08.000000000 +0100
+++ linux-2.6.19-rc6-mm2/kernel/printk.c	2006-12-01 06:54:15.000000000 +0100
@@ -53,8 +53,6 @@
 	DEFAULT_CONSOLE_LOGLEVEL,	/* default_console_loglevel */
 };
 
-EXPORT_UNUSED_SYMBOL(console_printk);  /*  June 2006  */
-
 /*
  * Low lever drivers may need that to know if they can schedule in
  * their unblank() callback or not. So let's export it.
@@ -753,7 +751,6 @@
 {
 	return console_locked;
 }
-EXPORT_UNUSED_SYMBOL(is_console_locked);  /*  June 2006  */
 
 /**
  * release_console_sem - unlock the console system
--- linux-2.6.19-rc6-mm2/mm/bootmem.c.old	2006-12-01 06:54:22.000000000 +0100
+++ linux-2.6.19-rc6-mm2/mm/bootmem.c	2006-12-01 06:54:26.000000000 +0100
@@ -27,8 +27,6 @@
 unsigned long min_low_pfn;
 unsigned long max_pfn;
 
-EXPORT_UNUSED_SYMBOL(max_pfn);  /*  June 2006  */
-
 static LIST_HEAD(bdata_list);
 #ifdef CONFIG_CRASH_DUMP
 /*
--- linux-2.6.19-rc6-mm2/mm/memory.c.old	2006-12-01 06:54:33.000000000 +0100
+++ linux-2.6.19-rc6-mm2/mm/memory.c	2006-12-01 06:54:36.000000000 +0100
@@ -1902,7 +1902,6 @@
 
 	return 0;
 }
-EXPORT_UNUSED_SYMBOL(vmtruncate_range);  /*  June 2006  */
 
 /**
  * swapin_readahead - swap in pages in hope we need them soon
--- linux-2.6.19-rc6-mm2/mm/mmzone.c.old	2006-12-01 06:54:49.000000000 +0100
+++ linux-2.6.19-rc6-mm2/mm/mmzone.c	2006-12-01 06:55:18.000000000 +0100
@@ -14,8 +14,6 @@
 	return NODE_DATA(first_online_node);
 }
 
-EXPORT_UNUSED_SYMBOL(first_online_pgdat);  /*  June 2006  */
-
 struct pglist_data *next_online_pgdat(struct pglist_data *pgdat)
 {
 	int nid = next_online_node(pgdat->node_id);
@@ -24,8 +22,6 @@
 		return NULL;
 	return NODE_DATA(nid);
 }
-EXPORT_UNUSED_SYMBOL(next_online_pgdat);  /*  June 2006  */
-
 
 /*
  * next_zone - helper magic for for_each_zone()
@@ -45,5 +41,4 @@
 	}
 	return zone;
 }
-EXPORT_UNUSED_SYMBOL(next_zone);  /*  June 2006  */
 

