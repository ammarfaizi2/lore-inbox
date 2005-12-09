Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbVLIPSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbVLIPSb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 10:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbVLIPSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 10:18:31 -0500
Received: from ap1.cs.vt.edu ([128.173.40.39]:57557 "EHLO ap1.cs.vt.edu")
	by vger.kernel.org with ESMTP id S932223AbVLIPSa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 10:18:30 -0500
Date: Fri, 9 Dec 2005 10:18:11 -0500
From: Matt Tolentino <metolent@cs.vt.edu>
Message-Id: <200512091518.jB9FIBTk006637@ap1.cs.vt.edu>
To: ak@muc.de, akpm@osdl.org
Subject: [patch 1/3] remove unused pgdat in sparsemem add_section
Cc: apw@shadowen.org, linux-kernel@vger.kernel.org,
       matthew.e.tolentino@intel.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial patch to remove an used variable in the __add_section 
function.  Looks like pgdat updating was moved into a subfunction.  

Signed-off-by: Matt Tolentino <matthew.e.tolentino@intel.com>
---

diff -urNp linux-2.6.15-rc5/mm/memory_hotplug.c linux-2.6.15-rc5-mt/mm/memory_hotplug.c
--- linux-2.6.15-rc5/mm/memory_hotplug.c	2005-12-04 00:10:42.000000000 -0500
+++ linux-2.6.15-rc5-mt/mm/memory_hotplug.c	2005-12-08 15:41:46.000000000 -0500
@@ -42,7 +42,6 @@ extern int sparse_add_one_section(struct
 				  int nr_pages);
 static int __add_section(struct zone *zone, unsigned long phys_start_pfn)
 {
-	struct pglist_data *pgdat = zone->zone_pgdat;
 	int nr_pages = PAGES_PER_SECTION;
 	int ret;
 
