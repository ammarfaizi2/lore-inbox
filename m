Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262450AbSJKN7c>; Fri, 11 Oct 2002 09:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262455AbSJKN7c>; Fri, 11 Oct 2002 09:59:32 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:33962 "EHLO
	shaggy.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S262450AbSJKN7c>; Fri, 11 Oct 2002 09:59:32 -0400
Date: Fri, 11 Oct 2002 09:05:06 -0500
From: Dave Kleikamp <shaggy@austin.ibm.com>
Message-Id: <200210111405.g9BE56r07835@shaggy.austin.ibm.com>
To: torvalds@transmeta.com
Subject: [PATCH] Syntax error in fs/nls/Config.in (2.5.41-bk)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a missing space before the closing bracket which
causes CONFIG_NLS to not be defined.  This patch fixes this and
keeps the line under 80 characters.

diff -Nur linux-2.5.41-bk/fs/nls/Config.in linux/fs/nls/Config.in
--- linux-2.5.41-bk/fs/nls/Config.in	Fri Oct 11 08:50:36 2002
+++ linux/fs/nls/Config.in	Fri Oct 11 08:51:12 2002
@@ -12,7 +12,8 @@
 # msdos and Joliet want NLS
 if [ "$CONFIG_JOLIET" = "y" -o "$CONFIG_FAT_FS" != "n" \
 	-o "$CONFIG_NTFS_FS" != "n" -o "$CONFIG_NCPFS_NLS" = "y" \
-	-o "$CONFIG_SMB_NLS" = "y" -o "$CONFIG_JFS_FS" != "n" -o "$CONFIG_CIFS" != "n"]; then
+	-o "$CONFIG_SMB_NLS" = "y" -o "$CONFIG_JFS_FS" != "n" \
+	-o "$CONFIG_CIFS" != "n" ]; then
   define_bool CONFIG_NLS y
 else
   define_bool CONFIG_NLS n
