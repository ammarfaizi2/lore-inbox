Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265476AbTFSME7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 08:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265427AbTFSME7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 08:04:59 -0400
Received: from smtp3.libero.it ([193.70.192.127]:35503 "EHLO smtp3.libero.it")
	by vger.kernel.org with ESMTP id S265476AbTFSME4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 08:04:56 -0400
Subject: (Resent) [PATCH] 2.5.72 smb_proc_setattr_unix warnings
From: Flameeyes <dgp85@users.sourceforge.net>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-tsMxapXKggmU7LKzKrml"
Message-Id: <1056025258.940.6.camel@laurelin>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 19 Jun 2003 14:20:58 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tsMxapXKggmU7LKzKrml
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch fixes these warnings:

  CC      fs/smbfs/proc.o
fs/smbfs/proc.c: In function `smb_proc_setattr_unix':
fs/smbfs/proc.c:3044: warning: integer constant is too large for "long"
type
fs/smbfs/proc.c:3045: warning: integer constant is too large for "long"
type
fs/smbfs/proc.c:3046: warning: integer constant is too large for "long"
type
fs/smbfs/proc.c:3047: warning: integer constant is too large for "long"
type
fs/smbfs/proc.c:3048: warning: integer constant is too large for "long"
type

it simply adds the ULL attr at the end of the constants in
include/linux/smbno.h
-- 
Flameeyes <dgp85@users.sf.net>

--=-tsMxapXKggmU7LKzKrml
Content-Disposition: attachment; filename=patch-smb.diff
Content-Type: text/plain; name=patch-smb.diff; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

--- include/linux/smbno.h.orig	2003-06-17 13:11:22.000000000 +0200
+++ include/linux/smbno.h	2003-06-17 13:11:38.000000000 +0200
@@ -347,8 +347,8 @@
 #define SMB_MODE_NO_CHANGE		0xFFFFFFFF
 #define SMB_UID_NO_CHANGE		0xFFFFFFFF
 #define SMB_GID_NO_CHANGE		0xFFFFFFFF
-#define SMB_TIME_NO_CHANGE		0xFFFFFFFFFFFFFFFF
-#define SMB_SIZE_NO_CHANGE		0xFFFFFFFFFFFFFFFF
+#define SMB_TIME_NO_CHANGE		0xFFFFFFFFFFFFFFFFULL
+#define SMB_SIZE_NO_CHANGE		0xFFFFFFFFFFFFFFFFULL
 
 /* UNIX filetype mappings. */
 #define UNIX_TYPE_FILE		0

--=-tsMxapXKggmU7LKzKrml--


