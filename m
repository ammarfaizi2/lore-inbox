Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319564AbSH3NeN>; Fri, 30 Aug 2002 09:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319565AbSH3NeN>; Fri, 30 Aug 2002 09:34:13 -0400
Received: from srv1.mail.cv.net ([167.206.112.40]:28393 "EHLO srv1.mail.cv.net")
	by vger.kernel.org with ESMTP id <S319564AbSH3NeM>;
	Fri, 30 Aug 2002 09:34:12 -0400
Date: Fri, 30 Aug 2002 09:38:37 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] befs not compiled in 2.4.20-pre5
X-X-Sender: proski@portland.hansa.lan
To: linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.44.0208300931470.27069-100000@portland.hansa.lan>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

fs/Makefile in Linux-2.4.20-pre5 doesn't add fs/befs to the directories to 
be processed.  The patch is trivial:

========================
--- linux.orig/fs/Makefile
+++ linux/fs/Makefile
@@ -66,6 +66,7 @@
 subdir-$(CONFIG_REISERFS_FS)	+= reiserfs
 subdir-$(CONFIG_DEVPTS_FS)	+= devpts
 subdir-$(CONFIG_SUN_OPENPROMFS)	+= openpromfs
+subdir-$(CONFIG_BEFS_FS)	+= befs
 subdir-$(CONFIG_JFS_FS)		+= jfs
 
 
========================

This line is present in 2.4.20-pre4-ac2, so I added it exactly to the same 
position as Alan.

-- 
Regards,
Pavel Roskin

