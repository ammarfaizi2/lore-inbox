Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280332AbRKEIEe>; Mon, 5 Nov 2001 03:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280329AbRKEIEX>; Mon, 5 Nov 2001 03:04:23 -0500
Received: from sj-msg-core-1.cisco.com ([171.71.163.11]:44161 "EHLO
	sj-msg-core-1.cisco.com") by vger.kernel.org with ESMTP
	id <S280328AbRKEIEM>; Mon, 5 Nov 2001 03:04:12 -0500
Date: Mon, 5 Nov 2001 13:34:00 +0530 (IST)
From: Manik Raina <manik@cisco.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] unused function in arch/i386
Message-ID: <Pine.GSO.4.33.0111051331400.14887-100000@cbin2-view1.cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The function disable_ide_dma is no longer in use in the
codebase, and hence this patch removes it from the build ....

Index: kernel/dmi_scan.c
===================================================================
RCS file: /vger/linux/arch/i386/kernel/dmi_scan.c,v
retrieving revision 1.10
diff -u -r1.10 dmi_scan.c
--- kernel/dmi_scan.c	13 Oct 2001 01:47:27 -0000	1.10
+++ kernel/dmi_scan.c	5 Nov 2001 07:59:16 -0000
@@ -189,7 +189,7 @@
  *	rule needs to be improved to match specific BIOS revisions with
  *	corruption problems
  */
-
+#ifdef OLDVERSION
 static __init int disable_ide_dma(struct dmi_blacklist *d)
 {
 #ifdef CONFIG_BLK_DEV_IDE
@@ -202,6 +202,8 @@
 #endif
 	return 0;
 }
+
+#endif /* OLDVERSION */

 /*
  * Reboot options and system auto-detection code provided by

