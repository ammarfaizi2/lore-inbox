Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbTEIGG7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 02:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262297AbTEIGG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 02:06:59 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:15015 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id S262034AbTEIGG6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 02:06:58 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [patch] comments patch
Date: Fri, 9 May 2003 11:49:16 +0530
Message-ID: <E935C89216CC5D4AB77D89B253ADED2A922AF0@blr-m2-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] comments patch
Thread-Index: AcMV8uqbrLnInqlPSBeZO2uCifgC6A==
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Andrew Morton" <akpm@digeo.com>,
       "Kiran Vijayakumar" <kiran.vijayakumar@wipro.com>
X-OriginalArrivalTime: 09 May 2003 06:19:16.0563 (UTC) FILETIME=[EB033230:01C315F2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux/mm/truncate.c	2003-04-21 10:28:19.000000000 -0700
+++ tmp/linux/mm/truncate.c	2003-05-08 12:25:52.000000000 -0700
@@ -172,23 +172,23 @@
 			unlock_page(page);
 		}
 		pagevec_release(&pvec);
 	}
 	if (lstart == 0 && mapping->nrpages)
 		printk("%s: I goofed!\n", __FUNCTION__);
 }
 
 /**
  * invalidate_mapping_pages - Invalidate all the unlocked pages of one
inode
- * @inode: the address_space which holds the pages to invalidate
- * @end: the index of the last page to invalidate (inclusive)
- * @nr_pages: defines the pagecache span.  Invalidate up to @start +
@nr_pages
+ * @mapping: the address_space which holds the pages to invalidate
+ * @start: the offset 'from' which to invalidate
+ * @end: the offset 'to' which to invalidate (inclusive)
  *
  * This function only removes the unlocked pages, if you want to
  * remove all the pages of one inode, you must call
truncate_inode_pages.
  *
  * invalidate_mapping_pages() will not block on IO activity. It will
not
  * invalidate pages which are dirty, locked, under writeback or mapped
into
  * pagetables.
  */
 unsigned long invalidate_mapping_pages(struct address_space *mapping,
 				pgoff_t start, pgoff_t end)
