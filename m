Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261963AbSL2Wux>; Sun, 29 Dec 2002 17:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261996AbSL2Wux>; Sun, 29 Dec 2002 17:50:53 -0500
Received: from jive.SoftHome.net ([66.54.152.27]:15594 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id <S261963AbSL2Wur>;
	Sun, 29 Dec 2002 17:50:47 -0500
Subject: [PATCH 2.5] Enable ALIGN #undef for drivers/net/defxx.c
From: Steven Barnhart <sbarn03@softhome.net>
To: alan@redhat.com
Cc: linux-kernel@vger.kernel.org
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 29 Dec 2002 17:59:12 -0500
Message-Id: <1041202757.19002.3.camel@sbarn.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_jive-405-1041202748-0001-2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_jive-405-1041202748-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

The following patch #undef's the variable ALIGN in include/linux/cache.h
so that drivers/net/defxx.c can use the same variable. Patch has been
tested and defxx.c compiles. Please apply.

Steven

--------

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or
higher.
# This patch includes the following deltas:
#	           ChangeSet	1.974   -> 1.975  
#	include/linux/cache.h	1.5     -> 1.6    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/12/29	steven@sbarn.net	1.975
# [PATCH] This patch allows drivers/net/defxx.c to compile and use the
variable ALIGN which was left defined by include/linux/cache.h.
# --------------------------------------------
#
diff -Nru a/include/linux/cache.h b/include/linux/cache.h
--- a/include/linux/cache.h	Sun Dec 29 17:39:44 2002
+++ b/include/linux/cache.h	Sun Dec 29 17:39:44 2002
@@ -52,5 +52,5 @@
 #define ____cacheline_maxaligned_in_smp
 #endif
 #endif
-
+#undef ALIGN
 #endif /* __LINUX_CACHE_H */


--=_jive-405-1041202748-0001-2
Content-Type: text/plain; name="cache.h-patch"; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=cache.h-patch

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher=
.
# This patch includes the following deltas:
#	           ChangeSet	1.974   -> 1.975 =20
#	include/linux/cache.h	1.5     -> 1.6   =20
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/12/29	steven@sbarn.net	1.975
# [PATCH] This patch allows drivers/net/defxx.c to compile and use the vari=
able ALIGN which was left defined by include/linux/cache.h.
# --------------------------------------------
#
diff -Nru a/include/linux/cache.h b/include/linux/cache.h
--- a/include/linux/cache.h	Sun Dec 29 17:39:44 2002
+++ b/include/linux/cache.h	Sun Dec 29 17:39:44 2002
@@ -52,5 +52,5 @@
 #define ____cacheline_maxaligned_in_smp
 #endif
 #endif
-
+#undef ALIGN
 #endif /* __LINUX_CACHE_H */

--=_jive-405-1041202748-0001-2--
