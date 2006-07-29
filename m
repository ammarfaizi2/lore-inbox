Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbWG2Tom@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbWG2Tom (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 15:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752078AbWG2TnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 15:43:06 -0400
Received: from mx1.suse.de ([195.135.220.2]:23511 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1752081AbWG2Tm5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 15:42:57 -0400
Date: Sat, 29 Jul 2006 21:42:55 +0200
From: "Andi Kleen" <ak@suse.de>
To: torvalds@osdl.org
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org,
       trond.myklebust@fys.uio.no
Subject: [PATCH for 2.6.18] [8/8] MM: Remove rogue readahead printk
Message-ID: <44cbba3f.mPUieUe31/EOZ6FZ%ak@suse.de>
User-Agent: nail 11.25 7/29/05
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For some reason it triggers always with NFS root and spams the kernel
logs of my nfs root boxes a lot.

Cc: trond.myklebust@fys.uio.no
Signed-off-by: Andi Kleen <ak@suse.de>

---
 mm/filemap.c |    2 --
 1 files changed, 2 deletions(-)

Index: linux-2.6.18-rc2-git7/mm/filemap.c
===================================================================
--- linux-2.6.18-rc2-git7.orig/mm/filemap.c
+++ linux-2.6.18-rc2-git7/mm/filemap.c
@@ -849,8 +849,6 @@ static void shrink_readahead_size_eio(st
 		return;
 
 	ra->ra_pages /= 4;
-	printk(KERN_WARNING "Reducing readahead size to %luK\n",
-			ra->ra_pages << (PAGE_CACHE_SHIFT - 10));
 }
 
 /**
