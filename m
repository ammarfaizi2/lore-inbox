Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269726AbUHZWtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269726AbUHZWtY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 18:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269693AbUHZWpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 18:45:33 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:63910 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S269660AbUHZWnx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 18:43:53 -0400
Subject: [PATCH] Fix comment in include/linux/nodemask.h
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
       LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1093560210.4769.7.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 26 Aug 2004 15:43:31 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, here's a small comment fix for include/linux/nodemask.h.  It's a
comment that is only relevant to cpumasks and accidentally got copied
over during my (failed) attempt to correctly post the nodemask code. 
The patch just updates the comment to make sense for nodemasks.

Thanks!

-Matt

--- linux-2.6.9-rc1-mm1/include/linux/nodemask.h	2004-08-26 15:38:42.000000000 -0700
+++ linux-2.6.9-rc1-mm1/include/linux/nodemask.h.fixed	2004-08-26 15:39:04.000000000 -0700
@@ -69,12 +69,9 @@
  *
  * Subtlety:
  * 1) The 'type-checked' form of node_isset() causes gcc (3.3.2, anyway)
- *    to generate slightly worse code.  Note for example the additional
- *    40 lines of assembly code compiling the "for each possible node"
- *    loops buried in the disk_stat_read() macros calls when compiling
- *    drivers/block/genhd.c (arch i386, CONFIG_SMP=y).  So use a simple
- *    one-line #define for node_isset(), instead of wrapping an inline
- *    inside a macro, the way we do the other calls.
+ *    to generate slightly worse code.  So use a simple one-line #define 
+ *    for node_isset(), instead of wrapping an inline inside a macro, the 
+ *    way we do the other calls.
  */
 
 #include <linux/kernel.h>


