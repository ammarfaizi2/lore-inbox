Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbUDINuY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 09:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbUDINuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 09:50:24 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:45828 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S261258AbUDINuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 09:50:22 -0400
Date: Fri, 9 Apr 2004 21:52:51 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-mm3
In-Reply-To: <20040408203451.51f583a5.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0404092151340.10404@raven.themaw.net>
References: <20040408203451.51f583a5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.5, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, PATCH_UNIFIED_DIFF, REFERENCES,
	REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Apr 2004, Andrew Morton wrote:

> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5/2.6.5-mm3/
> 

Small compile problem

--- mm/hugetlb.c.orig	2004-04-09 20:29:03.000000000 +0800
+++ mm/hugetlb.c	2004-04-09 20:33:20.000000000 +0800
@@ -140,11 +140,11 @@
 	for (i = 0; i < MAX_NUMNODES; ++i) {
 		struct page *page;
 		list_for_each_entry(page, &hugepage_freelists[i], lru) {
-			if (PageHighmem(page))
+			if (PageHighMem(page))
 				continue;
 			list_del(&page->lru);
 			update_and_free_page(page);
-			--free_huge_pages
+			--free_huge_pages;
 			if (!--count)
 				return 0;
 		}
