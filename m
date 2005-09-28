Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751447AbVI1RWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbVI1RWa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 13:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbVI1RWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 13:22:30 -0400
Received: from fmr22.intel.com ([143.183.121.14]:1459 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751447AbVI1RW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 13:22:29 -0400
Date: Wed, 28 Sep 2005 10:22:20 -0700
From: "Seth, Rohit" <rohit.seth@intel.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH]: show_free_area shows free pages in pcp list
Message-ID: <20050928102219.A29282@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



	[PATCH]: The count field in pcp list represents the free pages in that list.  Change the "used" to "free" in the print message in show_free_area routine.

	Signed-off-by: Rohit Seth <rohit.seth@intel.com>


--- linux-2.6.14-rc2-mm1.org/mm/page_alloc.c	2005-09-27 10:03:51.000000000 -0700
+++ linux-2.6.14-rc2-mm1/mm/page_alloc.c	2005-09-28 09:09:21.000000000 -0700
@@ -1409,7 +1409,7 @@
 			pageset = zone_pcp(zone, cpu);
 
 			for (temperature = 0; temperature < 2; temperature++)
-				printk("cpu %d %s: low %d, high %d, batch %d used:%d\n",
+				printk("cpu %d %s: low %d, high %d, batch %d free:%d\n",
 					cpu,
 					temperature ? "cold" : "hot",
 					pageset->pcp[temperature].low,
