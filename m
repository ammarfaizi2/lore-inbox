Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262781AbTCQEB4>; Sun, 16 Mar 2003 23:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262782AbTCQEB4>; Sun, 16 Mar 2003 23:01:56 -0500
Received: from pop018pub.verizon.net ([206.46.170.212]:27880 "EHLO
	pop018.verizon.net") by vger.kernel.org with ESMTP
	id <S262781AbTCQEBy>; Sun, 16 Mar 2003 23:01:54 -0500
Message-ID: <3E754AAB.358C4230@verizon.net>
Date: Sun, 16 Mar 2003 20:10:19 -0800
From: "Randy.Dunlap" <randy.dunlap@verizon.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.59 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, akpm@digeo.com, torvalds@transmeta.com
Subject: [PATCH] fsmenu update
Content-Type: multipart/mixed;
 boundary="------------A3BD09E0D17ED0F762995ECB"
X-Authentication-Info: Submitted using SMTP AUTH at pop018.verizon.net from [4.64.238.61] at Sun, 16 Mar 2003 22:12:42 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------A3BD09E0D17ED0F762995ECB
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

As requested by Andrew, this moves the hugetlbfs config option
into the Pseudo filesystems section near tmpfs.

Patch is to 2.5.64-current.  Please apply.

Thanks,
~Randy
--------------A3BD09E0D17ED0F762995ECB
Content-Type: text/plain; charset=us-ascii;
 name="fsmenu-tlb.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fsmenu-tlb.patch"

patch_name:	fsmenu-tlb.patch
patch_version:	2003-03-16.19:48:25
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	"you need to move hugetlbfs down to the same menu as tmpfs"
product:	Linux
product_versions: 2.5.64
changelog:	move HUGETLBFS config option to the Pseudo filesystems section
requires:	previous 2.5.64 filesystem menu update patch;
diffstat:	=
 fs/Kconfig |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


diff -Naur ./fs/Kconfig%FS2 ./fs/Kconfig
--- ./fs/Kconfig%FS2	Sun Mar 16 19:28:15 2003
+++ ./fs/Kconfig	Sun Mar 16 19:38:31 2003
@@ -377,10 +377,6 @@
 	  If you don't know whether you need it, then you don't need it:
 	  answer N.
 
-config HUGETLBFS
-	bool "HugeTLB file system support"
-	depends on HUGETLB_PAGE
-
 config QUOTA
 	bool "Quota support"
 	help
@@ -818,6 +814,10 @@
 	  lost.
 
 	  See <file:Documentation/filesystems/tmpfs.txt> for details.
+
+config HUGETLBFS
+	bool "HugeTLB file system support"
+	depends on HUGETLB_PAGE
 
 config RAMFS
 	bool

--------------A3BD09E0D17ED0F762995ECB--

