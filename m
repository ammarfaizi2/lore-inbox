Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751829AbWCFQfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751829AbWCFQfm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 11:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751914AbWCFQfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 11:35:42 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:14823 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751829AbWCFQfd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 11:35:33 -0500
Date: Mon, 6 Mar 2006 14:35:38 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>,
       linux-mtd@lists.infradead.org
Subject: [patch] Kill ifdefs in mtdcore.c
Message-ID: <20060306133538.GA7256@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kill unneccessary ifdefs in mtdcore.c.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index dade02a..f1f72ed 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -19,9 +19,7 @@
 #include <linux/ioctl.h>
 #include <linux/init.h>
 #include <linux/mtd/compatmac.h>
-#ifdef CONFIG_PROC_FS
 #include <linux/proc_fs.h>
-#endif
 
 #include <linux/mtd/mtd.h>
 
@@ -351,19 +349,15 @@ done:
 
 static int __init init_mtd(void)
 {
-#ifdef CONFIG_PROC_FS
 	if ((proc_mtd = create_proc_entry( "mtd", 0, NULL )))
 		proc_mtd->read_proc = mtd_read_proc;
-#endif
 	return 0;
 }
 
 static void __exit cleanup_mtd(void)
 {
-#ifdef CONFIG_PROC_FS
         if (proc_mtd)
 		remove_proc_entry( "mtd", NULL);
-#endif
 }
 
 module_init(init_mtd);


-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
