Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266702AbSLJHoZ>; Tue, 10 Dec 2002 02:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266708AbSLJHoZ>; Tue, 10 Dec 2002 02:44:25 -0500
Received: from gettysburg.edu ([138.234.4.100]:63731 "EHLO gettysburg.edu")
	by vger.kernel.org with ESMTP id <S266702AbSLJHoX>;
	Tue, 10 Dec 2002 02:44:23 -0500
Date: Tue, 10 Dec 2002 02:51:52 -0500
To: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
       pryzju01@gettysburg.edu
Subject: [PATCH] 2.5.51 ntfs - GCC3
Message-ID: <20021210075152.GA12219@perseus.homeunix.net>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	linux-ntfs-dev@lists.sourceforge.net, pryzju01@gettysburg.edu
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Justin Pryzby <justinpryzby@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Trivial patch for GCC3.
What was going on with 2.96<=__GNUC__<3 ?!

Justin

diff -Naur linux-2.5.51.org/fs/ntfs/types.h linux-2.5.51.ntfs/fs/ntfs/types.h
--- linux-2.5.51.org/fs/ntfs/types.h	2002-12-10 02:17:52.000000000 -0500
+++ linux-2.5.51.ntfs/fs/ntfs/types.h	2002-12-10 02:41:31.000000000 -0500
@@ -23,12 +23,12 @@
 #ifndef _LINUX_NTFS_TYPES_H
 #define _LINUX_NTFS_TYPES_H
 
-#if __GNUC__ < 2 || (__GNUC__ == 2 && __GNUC_MINOR__ < 96)
-#define SN(X)   X	/* Struct Name */
-#define SC(P,N) P.N	/* ShortCut: Prefix, Name */
-#else
+#if __GNUC__ == 2 && __GNUC_MINOR__ >= 96
 #define SN(X)
 #define SC(P,N) N
+#else
+#define SN(X)   X	/* Struct Name */
+#define SC(P,N) P.N	/* ShortCut: Prefix, Name */
 #endif
 
 /* 2-byte Unicode character type. */


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Description: Patch for Linux 2.5.51 ntfs with gcc3
Content-Disposition: attachment; filename="linux-2.5.51.ntfs"

diff -Naur linux-2.5.51.org/fs/ntfs/types.h linux-2.5.51.ntfs/fs/ntfs/types.h
--- linux-2.5.51.org/fs/ntfs/types.h	2002-12-10 02:17:52.000000000 -0500
+++ linux-2.5.51.ntfs/fs/ntfs/types.h	2002-12-10 02:41:31.000000000 -0500
@@ -23,12 +23,12 @@
 #ifndef _LINUX_NTFS_TYPES_H
 #define _LINUX_NTFS_TYPES_H
 
-#if __GNUC__ < 2 || (__GNUC__ == 2 && __GNUC_MINOR__ < 96)
-#define SN(X)   X	/* Struct Name */
-#define SC(P,N) P.N	/* ShortCut: Prefix, Name */
-#else
+#if __GNUC__ == 2 && __GNUC_MINOR__ >= 96
 #define SN(X)
 #define SC(P,N) N
+#else
+#define SN(X)   X	/* Struct Name */
+#define SC(P,N) P.N	/* ShortCut: Prefix, Name */
 #endif
 
 /* 2-byte Unicode character type. */

--J2SCkAp4GZ/dPZZf--
