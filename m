Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031349AbWKUTmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031349AbWKUTmT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 14:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031345AbWKUTmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 14:42:15 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:5129 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1031349AbWKUTmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 14:42:13 -0500
Date: Tue, 21 Nov 2006 20:42:13 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: [-mm patch] unexport {,__}remove_from_page_cache
Message-ID: <20061121194213.GJ5200@stusta.de>
References: <20061114014125.dd315fff.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114014125.dd315fff.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the no longer required export of 
{,__}remove_from_page_cache introduced by 
reiser4-export-remove_from_page_cache.patch.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc5-mm2/mm/filemap.c.old	2006-11-21 19:48:44.000000000 +0100
+++ linux-2.6.19-rc5-mm2/mm/filemap.c	2006-11-21 19:48:51.000000000 +0100
@@ -127,7 +127,6 @@
 	mapping->nrpages--;
 	__dec_zone_page_state(page, NR_FILE_PAGES);
 }
-EXPORT_SYMBOL(__remove_from_page_cache);
 
 void remove_from_page_cache(struct page *page)
 {
@@ -139,7 +138,6 @@
 	__remove_from_page_cache(page);
 	write_unlock_irq(&mapping->tree_lock);
 }
-EXPORT_SYMBOL(remove_from_page_cache);
 
 static int sync_page(void *word)
 {

