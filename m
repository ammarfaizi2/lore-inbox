Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267089AbTCEE17>; Tue, 4 Mar 2003 23:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267091AbTCEE17>; Tue, 4 Mar 2003 23:27:59 -0500
Received: from out006pub.verizon.net ([206.46.170.106]:64749 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP
	id <S267089AbTCEE16>; Tue, 4 Mar 2003 23:27:58 -0500
Message-ID: <3E657EBD.59E167D6@verizon.net>
Date: Tue, 04 Mar 2003 20:36:13 -0800
From: "Randy.Dunlap" <randy.dunlap@verizon.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.59 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] move SWAP option in menu
Content-Type: multipart/mixed;
 boundary="------------66783FF1E7355B54CB30A405"
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [4.64.238.61] at Tue, 4 Mar 2003 22:38:22 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------66783FF1E7355B54CB30A405
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

Please apply this patch (option B of 2 choices) from
Tomas Szepe to move the SWAP option into the General Setup
menu.

Patch is to 2.5.64.

Thanks,
~Randy
--------------66783FF1E7355B54CB30A405
Content-Type: text/plain; charset=us-ascii;
 name="swap_option.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="swap_option.patch"

diff -urN a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	2003-03-03 20:04:08.000000000 +0100
+++ b/arch/i386/Kconfig	2003-03-03 19:58:48.000000000 +0100
@@ -18,15 +18,6 @@
 	bool
 	default y
 
-config SWAP
-	bool "Support for paging of anonymous memory"
-	default y
-	help
-	  This option allows you to choose whether you want to have support
-	  for socalled swap devices or swap files in your kernel that are
-	  used to provide more virtual memory than the actual RAM present
-	  in your computer.  If unusre say Y.
-
 config SBUS
 	bool
 
diff -urN a/init/Kconfig b/init/Kconfig
--- a/init/Kconfig	2003-02-11 01:09:48.000000000 +0100
+++ b/init/Kconfig	2003-03-03 20:02:11.000000000 +0100
@@ -34,9 +34,18 @@
 
 endmenu
 
-
 menu "General setup"
 
+config SWAP
+	depends on X86
+	bool "Support for paging of anonymous memory"
+	default y
+	help
+	  This option allows you to choose whether you want to have support
+	  for the so-called swap devices or swap files.  There are used to
+	  provide more virtual memory than the actual RAM presents in your
+	  computer.  If unsure, say Y.
+
 config SYSVIPC
 	bool "System V IPC"
 	---help---

--------------66783FF1E7355B54CB30A405--

