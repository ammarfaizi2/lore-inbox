Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262824AbVBDAlC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262824AbVBDAlC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 19:41:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262831AbVBDAlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 19:41:01 -0500
Received: from fmr14.intel.com ([192.55.52.68]:34176 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S263307AbVBDAhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 19:37:43 -0500
Subject: [Patch] fix an error in /proc/slabinfo print
From: Zou Nan hai <nanhai.zou@intel.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Content-Type: text/plain
Organization: 
Message-Id: <1107472220.2555.40.camel@linux-znh>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 04 Feb 2005 07:10:20 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is an obvious error in the header of /proc/slabinfo

Signed-off-by: Zou Nan hai <nanhai.zou@intel.com>

--- linux-2.6.11-rc3/mm/slab.c	2005-02-03 13:29:33.000000000 +0800
+++ linux-2.6.11-rc3-fix/mm/slab.c	2005-02-03 13:32:42.318821400 +0800
@@ -2860,7 +2860,7 @@ static void *s_start(struct seq_file *m,
 		seq_puts(m, "slabinfo - version: 2.1\n");
 #endif
 		seq_puts(m, "# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab>");
-		seq_puts(m, " : tunables <batchcount> <limit> <sharedfactor>");
+		seq_puts(m, " : tunables <limit> <batchcount> <sharedfactor>");
 		seq_puts(m, " : slabdata <active_slabs> <num_slabs> <sharedavail>");
 #if STATS
 		seq_puts(m, " : globalstat <listallocs> <maxobjs> <grown> <reaped>"



