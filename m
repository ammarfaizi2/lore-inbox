Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbTHYJ6Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 05:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbTHYJ6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 05:58:24 -0400
Received: from vtens.prov-liege.be ([193.190.122.60]:53922 "EHLO
	mesepl.epl.prov-liege.be") by vger.kernel.org with ESMTP
	id S261663AbTHYJ6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 05:58:21 -0400
To: <akpm@osdl.org>
Subject: [PATCH 2.6.0-test2] abi doc
From: <ffrederick@prov-liege.be>
Cc: <linux-kernel@vger.kernel.org>
Date: Mon, 25 Aug 2003 12:23:16 CEST
Reply-To: <ffrederick@prov-liege.be>
X-Priority: 3 (Normal)
X-Originating-Ip: [10.10.0.30]
X-Mailer: NOCC v0.9.5
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <S261663AbTHYJ6V/20030825095821Z+189143@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

             Here's a sysctl doc patch against 2.6.0-test2 for abi.
Could you apply ?

Regards,
Fabian

diff -Naur orig/Documentation/sysctl/README edited/Documentation/sysctl/README
--- orig/Documentation/sysctl/README	2003-07-27 17:07:20.000000000 +0000
+++ edited/Documentation/sysctl/README	2003-08-11 22:42:59.000000000 +0000
@@ -55,6 +55,7 @@
 by piece basis, or just some 'thematic frobbing'.
 
 The subdirs are about:
+abi/		execution domains & personalities
 debug/		<empty>
 dev/		device specific information (eg dev/cdrom/info)
 fs/		specific filesystems
diff -Naur orig/Documentation/sysctl/abi.txt edited/Documentation/sysctl/abi.txt
--- orig/Documentation/sysctl/abi.txt	1970-01-01 00:00:00.000000000 +0000
+++ edited/Documentation/sysctl/abi.txt	2003-08-11 22:41:29.000000000 +0000
@@ -0,0 +1,54 @@
+Documentation for /proc/sys/abi/* kernel version 2.6.0.test2
+	(c) 2003,  Fabian Frederick <ffrederick@users.sourceforge.net>
+
+For general info : README.
+
+==============================================================
+
+This path is binary emulation relevant aka personality types aka abi.
+When a process is executed, it's linked to an exec_domain whose
+personality is defined using values available from /proc/sys/abi.
+You can find further details about abi in include/linux/personality.h.
+
+Here are the files featuring in 2.6 kernel :
+
+- defhandler_coff
+- defhandler_elf
+- defhandler_lcall7
+- defhandler_libcso
+- fake_utsname
+- trace
+
+===========================================================
+defhandler_coff:
+defined value :
+PER_SCOSVR3
+0x0003 | STICKY_TIMEOUTS | WHOLE_SECONDS | SHORT_INODE
+
+===========================================================
+defhandler_elf:
+defined value : 
+PER_LINUX
+0
+
+===========================================================
+defhandler_lcall7:
+defined value :
+PER_SVR4
+0x0001 | STICKY_TIMEOUTS | MMAP_PAGE_ZERO,
+
+===========================================================
+defhandler_libsco:
+defined value:
+PER_SVR4
+0x0001 | STICKY_TIMEOUTS | MMAP_PAGE_ZERO,
+
+===========================================================
+fake_utsname:
+Unused
+
+===========================================================
+trace:
+Unused
+
+===========================================================


___________________________________



