Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261945AbSJNR2u>; Mon, 14 Oct 2002 13:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262025AbSJNR2u>; Mon, 14 Oct 2002 13:28:50 -0400
Received: from plum.csi.cam.ac.uk ([131.111.8.3]:42206 "EHLO
	plum.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S261945AbSJNR2t>; Mon, 14 Oct 2002 13:28:49 -0400
Subject: [PATCH-2.5] Compile fix for net/llc
To: torvalds@transmeta.com (Linus Torvalds)
Date: Mon, 14 Oct 2002 18:34:40 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel), acme@conectiva.com.br
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E181972-00029d-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

I needed the below patchlet to complete compilation of net/llc in your
current bk tree.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

--- tng/net/llc/llc_proc.c.old	2002-10-14 18:29:25.000000000 +0100
+++ tng/net/llc/llc_proc.c	2002-10-14 18:29:15.000000000 +0100
@@ -258,7 +258,7 @@ out_socket:
 	goto out;
 }
 
-void __exit llc_proc_exit(void)
+void llc_proc_exit(void)
 {
 	remove_proc_entry("socket", llc_proc_dir);
 	remove_proc_entry("core", llc_proc_dir);
@@ -270,7 +270,7 @@ int __init llc_proc_init(void)
 	return 0;
 }
 
-void __exit llc_proc_exit(void)
+void llc_proc_exit(void)
 {
 }
 #endif /* CONFIG_PROC_FS */
