Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262999AbVCXDNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262999AbVCXDNM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 22:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263000AbVCXDLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 22:11:30 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:50193 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262999AbVCXDJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 22:09:22 -0500
Date: Thu, 24 Mar 2005 04:09:16 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, wli@holomorphy.com
Subject: [2.6 patch] unexport hugetlb_total_pages
Message-ID: <20050324030916.GQ1948@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't find any possible modular usage in the kernel.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Acked-by: William Irwin <wli@holomorphy.com>

---

This patch was already sent on:
- 6 Mar 2005

--- linux-2.6.11-mm1-full/mm/hugetlb.c.old	2005-03-04 15:47:11.000000000 +0100
+++ linux-2.6.11-mm1-full/mm/hugetlb.c	2005-03-04 15:47:29.000000000 +0100
@@ -230,7 +230,6 @@
 {
 	return nr_huge_pages * (HPAGE_SIZE / PAGE_SIZE);
 }
-EXPORT_SYMBOL(hugetlb_total_pages);
 
 /*
  * We cannot handle pagefaults against hugetlb pages at all.  They cause

