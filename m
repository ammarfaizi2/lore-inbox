Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267518AbUGWDVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267518AbUGWDVQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 23:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267517AbUGWDVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 23:21:16 -0400
Received: from mail.aei.ca ([206.123.6.14]:39638 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S267518AbUGWDU6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 23:20:58 -0400
Subject: [PATCH] page_cache_readahead unused variable
From: Shane Shrybman <shrybman@aei.ca>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-KmpWsSaGCZFsGSuFschi"
Message-Id: <1090552979.2887.13.camel@mars>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 22 Jul 2004 23:22:59 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-KmpWsSaGCZFsGSuFschi
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Minor cleanup. Removal of unused variable in mm/readahead.c.

Shane

--=-KmpWsSaGCZFsGSuFschi
Content-Disposition: attachment; filename=page_cache_readahead_unused_var.diff
Content-Type: text/x-patch; name=page_cache_readahead_unused_var.diff; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

Binary files linux-2.6.7-mm7.orig/mm/.readahead.c.swp and linux-2.6.7-mm7/mm/.readahead.c.swp differ
diff -urN linux-2.6.7-mm7.orig/mm/readahead.c linux-2.6.7-mm7/mm/readahead.c
--- linux-2.6.7-mm7.orig/mm/readahead.c	2004-07-22 22:28:47.000000000 -0400
+++ linux-2.6.7-mm7/mm/readahead.c	2004-07-22 23:04:50.000000000 -0400
@@ -349,7 +349,6 @@
 			struct file *filp, unsigned long offset)
 {
 	unsigned max;
-	unsigned min;
 	unsigned orig_next_size;
 	unsigned actual;
 	int first_access=0;
@@ -374,7 +373,6 @@
 	if (max == 0)
 		goto out;	/* No readahead */
 
-	min = get_min_readahead(ra);
 	orig_next_size = ra->next_size;
 
 	if (ra->next_size == 0) {

--=-KmpWsSaGCZFsGSuFschi--

