Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbUGQWfC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbUGQWfC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 18:35:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbUGQWfC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 18:35:02 -0400
Received: from digitalimplant.org ([64.62.235.95]:16105 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S262279AbUGQWex
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 18:34:53 -0400
Date: Sat, 17 Jul 2004 15:34:41 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org
cc: pavel@ucw.cz
Subject: [1/25] Merge pmdisk and swsusp
Message-ID: <Pine.LNX.4.50.0407171525280.20921-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1843, 2004/07/17 09:01:18-07:00, mochel@digitalimplant.org

[Power Mgmt] Make pmdisk dependent on swsusp.


 kernel/power/Kconfig |   23 +++++++----------------
 1 files changed, 7 insertions(+), 16 deletions(-)


diff -Nru a/kernel/power/Kconfig b/kernel/power/Kconfig
--- a/kernel/power/Kconfig	2004-07-17 14:51:56 -07:00
+++ b/kernel/power/Kconfig	2004-07-17 14:51:56 -07:00
@@ -43,25 +43,16 @@
 	  For more information take a look at Documentation/power/swsusp.txt.

 config PM_DISK
-	bool "Suspend-to-Disk Support"
-	depends on PM && SWAP && X86 && !X86_64
+	bool "PMDisk Support"
+	depends on SOFTWARE_SUSPEND && X86 && !X86_64
 	---help---
-	  Suspend-to-disk is a power management state in which the contents
-	  of memory are stored on disk and the entire system is shut down or
-	  put into a low-power state (e.g. ACPI S4). When the computer is
-	  turned back on, the stored image is loaded from disk and execution
-	  resumes from where it left off before suspending.

-	  This config option enables the core infrastructure necessary to
-	  perform the suspend and resume transition.
+	This option enables an alternative implementation of Suspend-to-Disk.
+	It is functionally equivalent to Software Suspend, and uses many of
+	the same internal routines. But, it offers a slightly different
+	interface.

-	  Currently, this suspend-to-disk implementation is based on a forked
-	  version of the swsusp code base. As such, it's still experimental,
-	  and still relies on CONFIG_SWAP.
-
-	  More information can be found in Documentation/power/.
-
-	  If unsure, Say N.
+	If unsure, Say N.

 config PM_DISK_PARTITION
 	string "Default resume partition"
