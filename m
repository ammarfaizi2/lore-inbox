Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932601AbWAKB1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932601AbWAKB1T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 20:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932759AbWAKB1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 20:27:19 -0500
Received: from pacific.moreton.com.au ([203.143.235.130]:25525 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932601AbWAKB1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 20:27:18 -0500
Date: Wed, 11 Jan 2006 11:28:04 +1000
From: Greg Ungerer <gerg@snapgear.com>
Message-Id: <200601110128.k0B1S4tU013956@localhost.localdomain>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] remove uneccesary page++
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unecessary page++ from memmap_init_zone loop.

Signed-off-by: Greg Ungerer <gerg@uclinux.org>


--- linux-2.6.15/mm/page_alloc.c	2006-01-03 13:21:10.000000000 +1000
+++ linux-2.6.15-uc0/mm/page_alloc.c	2006-01-11 11:16:46.981376296 +1000
@@ -1706,7 +1706,7 @@
 	unsigned long end_pfn = start_pfn + size;
 	unsigned long pfn;
 
-	for (pfn = start_pfn; pfn < end_pfn; pfn++, page++) {
+	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
 		if (!early_pfn_valid(pfn))
 			continue;
 		if (!early_pfn_in_nid(pfn, nid))
