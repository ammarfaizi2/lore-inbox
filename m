Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268222AbUIGO5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268222AbUIGO5S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 10:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268167AbUIGOyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 10:54:50 -0400
Received: from verein.lst.de ([213.95.11.210]:58777 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268204AbUIGOuN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 10:50:13 -0400
Date: Tue, 7 Sep 2004 16:50:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] unexport proc_sys_root
Message-ID: <20040907145004.GA8889@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

only used by kernel/sysctl.c which absolutely can't be modular


--- 1.19/fs/proc/root.c	2004-06-30 17:32:17 +02:00
+++ edited/fs/proc/root.c	2004-09-07 14:02:26 +02:00
@@ -147,9 +147,6 @@
 	.parent		= &proc_root,
 };
 
-#ifdef CONFIG_SYSCTL
-EXPORT_SYMBOL(proc_sys_root);
-#endif
 EXPORT_SYMBOL(proc_symlink);
 EXPORT_SYMBOL(proc_mkdir);
 EXPORT_SYMBOL(create_proc_entry);
