Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262415AbSL3AGN>; Sun, 29 Dec 2002 19:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262446AbSL3AGN>; Sun, 29 Dec 2002 19:06:13 -0500
Received: from jive.SoftHome.net ([66.54.152.27]:62643 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id <S262415AbSL3AGL>;
	Sun, 29 Dec 2002 19:06:11 -0500
Subject: [PATCH] vlsi_ir.h, add #define for KERNEL_VERSION
From: Steven Barnhart <sbarn03@softhome.net>
To: alan@redhat.com
Cc: linux-kernel@vger.kernel.org
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 29 Dec 2002 19:14:38 -0500
Message-Id: <1041207283.23364.6.camel@sbarn.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_jive-11492-1041207273-0001-2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_jive-11492-1041207273-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

This patch defines (what seems to be missing) KERNEL_VERSION for the
header file, include/net/irda/vlsi_ir.h to use. This fixes the bug that
the compiler spits out saying "no binary before (" or something of the
like. drivers/net/irda/vlsi_ir.c now compiles flawlessly.

Steven

------
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or
higher.
# This patch includes the following deltas:
#	           ChangeSet	1.975   -> 1.976  
#	include/net/irda/vlsi_ir.h	1.5     -> 1.6    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/12/29	steven@sbarn.net	1.976
# [PATCH] Allows /drivers/net/irda/vlsi_ir.c to compile by adding
missing
# #define to the include file include/net/irda/vlsi_ir.h.
# --------------------------------------------
#
diff -Nru a/include/net/irda/vlsi_ir.h b/include/net/irda/vlsi_ir.h
--- a/include/net/irda/vlsi_ir.h	Sun Dec 29 19:02:54 2002
+++ b/include/net/irda/vlsi_ir.h	Sun Dec 29 19:02:54 2002
@@ -26,8 +26,8 @@
 
 #ifndef IRDA_VLSI_FIR_H
 #define IRDA_VLSI_FIR_H
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,4)
+#define KERNEL_VERSION
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,4) 
 #ifdef CONFIG_PROC_FS
 /* PDE() introduced in 2.5.4 */
 #define PDE(inode) ((inode)->u.generic_ip)




--=_jive-11492-1041207273-0001-2
Content-Type: text/plain; name="vlsi_ir.h-patch"; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=vlsi_ir.h-patch

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher=
.
# This patch includes the following deltas:
#	           ChangeSet	1.975   -> 1.976 =20
#	include/net/irda/vlsi_ir.h	1.5     -> 1.6   =20
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/12/29	steven@sbarn.net	1.976
# [PATCH] Allows /drivers/net/irda/vlsi_ir.c to compile by adding missing
# #define to the include file include/net/irda/vlsi_ir.h.
# --------------------------------------------
#
diff -Nru a/include/net/irda/vlsi_ir.h b/include/net/irda/vlsi_ir.h
--- a/include/net/irda/vlsi_ir.h	Sun Dec 29 19:02:54 2002
+++ b/include/net/irda/vlsi_ir.h	Sun Dec 29 19:02:54 2002
@@ -26,8 +26,8 @@
=20
 #ifndef IRDA_VLSI_FIR_H
 #define IRDA_VLSI_FIR_H
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,4)
+#define KERNEL_VERSION
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,4)=20
 #ifdef CONFIG_PROC_FS
 /* PDE() introduced in 2.5.4 */
 #define PDE(inode) ((inode)->u.generic_ip)

--=_jive-11492-1041207273-0001-2--
