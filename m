Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267149AbTABVdd>; Thu, 2 Jan 2003 16:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267119AbTABVcy>; Thu, 2 Jan 2003 16:32:54 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:14533 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267149AbTABVbD>; Thu, 2 Jan 2003 16:31:03 -0500
From: Tomas Szepe <kala@pinerecords.com>
Date: Thu, 02 Jan 2003 22:39:29 +0100
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [unify netdev config 22/22] Bring the "Networking support" menu 
 to life
Message-ID: <3E14B191.mailM0C11O9D4@louise.pinerecords.com>
User-Agent: nail 10.3 11/29/02
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urN a/init/Kconfig b/init/Kconfig
--- a/init/Kconfig	2002-12-16 07:02:05.000000000 +0100
+++ b/init/Kconfig	2003-01-02 22:06:46.000000000 +0100
@@ -37,22 +37,6 @@
 
 menu "General setup"
 
-config NET
-	bool "Networking support"
-	---help---
-	  Unless you really know what you are doing, you should say Y here.
-	  The reason is that some programs need kernel networking support even
-	  when running on a stand-alone machine that isn't connected to any
-	  other computer. If you are upgrading from an older kernel, you
-	  should consider updating your networking tools too because changes
-	  in the kernel and the tools often go hand in hand. The tools are
-	  contained in the package net-tools, the location and version number
-	  of which are given in <file:Documentation/Changes>.
-
-	  For a general introduction to Linux networking, it is highly
-	  recommended to read the NET-HOWTO, available from
-	  <http://www.linuxdoc.org/docs.html#howto>.
-
 config SYSVIPC
 	bool "System V IPC"
 	---help---
diff -urN a/net/Kconfig b/net/Kconfig
--- a/net/Kconfig	2002-12-08 20:06:41.000000000 +0100
+++ b/net/Kconfig	2003-01-02 22:06:46.000000000 +0100
@@ -2,6 +2,24 @@
 # Network configuration
 #
 
+menu "Networking support"
+
+config NET
+	bool "Networking support"
+	---help---
+	  Unless you really know what you are doing, you should say Y here.
+	  The reason is that some programs need kernel networking support even
+	  when running on a stand-alone machine that isn't connected to any
+	  other computer. If you are upgrading from an older kernel, you
+	  should consider updating your networking tools too because changes
+	  in the kernel and the tools often go hand in hand. The tools are
+	  contained in the package net-tools, the location and version number
+	  of which are given in <file:Documentation/Changes>.
+
+	  For a general introduction to Linux networking, it is highly
+	  recommended to read the NET-HOWTO, available from
+	  <http://www.linuxdoc.org/docs.html#howto>.
+
 menu "Networking options"
 	depends on NET
 
@@ -652,3 +670,6 @@
 
 endmenu
 
+source "drivers/net/Kconfig"
+
+endmenu
