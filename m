Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268239AbUIGPBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268239AbUIGPBo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 11:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268169AbUIGOxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 10:53:36 -0400
Received: from verein.lst.de ([213.95.11.210]:4506 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268111AbUIGOxF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 10:53:05 -0400
Date: Tue, 7 Sep 2004 16:52:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] unexport is_subdir and shrink_dcache_anon
Message-ID: <20040907145256.GC8889@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00,UPPERCASE_25_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

two dcache.c functions that shouldn't be used by filesystems directly
(probably a leftover of the intermezzo mess)


--- 1.91/fs/dcache.c	2004-08-27 08:31:38 +02:00
+++ edited/fs/dcache.c	2004-09-07 14:52:27 +02:00
@@ -1655,8 +1655,6 @@
 EXPORT_SYMBOL(dput);
 EXPORT_SYMBOL(find_inode_number);
 EXPORT_SYMBOL(have_submounts);
-EXPORT_SYMBOL(is_subdir);
 EXPORT_SYMBOL(names_cachep);
-EXPORT_SYMBOL(shrink_dcache_anon);
 EXPORT_SYMBOL(shrink_dcache_parent);
 EXPORT_SYMBOL(shrink_dcache_sb);
