Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265124AbUGNXlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265124AbUGNXlJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 19:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265141AbUGNXlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 19:41:09 -0400
Received: from sark4.cc.gatech.edu ([130.207.7.19]:43753 "EHLO
	sark4.cc.gatech.edu") by vger.kernel.org with ESMTP id S265124AbUGNXjv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 19:39:51 -0400
Date: Wed, 14 Jul 2004 19:39:40 -0400
From: Himanshu Raj <rhim@cc.gatech.edu>
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: A trivial patch for removing unnecessary comment in mm/filemap.c
Message-ID: <20040714233940.GA8289@cc.gatech.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

This patch removes some unnecessary comments in mm/filemap.c in function find_get_page. First, there is no 
longer a hash list being used, second the lock being used is the same for search as well as addition/removal.

Thanks,
Himanshu
-- 
-------------------------------------------------------------------------
Himanshu Raj
PhD Student, GaTech (www.cc.gatech.edu/~rhim)
I prefer to receive attachments in an open, non-proprietary format.
-------------------------------------------------------------------------

--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch_useless_comment

--- linux-2.6.8-rc1-old/mm/filemap.c	2004-07-14 19:29:53.757633968 -0400
+++ linux-2.6.8-rc1/mm/filemap.c	2004-07-14 19:30:05.365869248 -0400
@@ -440,10 +440,6 @@
 {
 	struct page *page;
 
-	/*
-	 * We scan the hash list read-only. Addition to and removal from
-	 * the hash-list needs a held write-lock.
-	 */
 	spin_lock_irq(&mapping->tree_lock);
 	page = radix_tree_lookup(&mapping->page_tree, offset);
 	if (page)

--h31gzZEtNLTqOjlF--
