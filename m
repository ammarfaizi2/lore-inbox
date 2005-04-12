Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262133AbVDMDAD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbVDMDAD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 23:00:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262178AbVDMC56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 22:57:58 -0400
Received: from mail.aknet.ru ([217.67.122.194]:26630 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S262184AbVDLTmX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 15:42:23 -0400
Message-ID: <425C24AD.7070309@aknet.ru>
Date: Tue, 12 Apr 2005 23:42:37 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: petkov@uni-muenster.de, jamagallon@able.es, linux-kernel@vger.kernel.org
Subject: [patch 1/3]: move config option for BAD_SYSCALL_EXIT
References: <20050411012532.58593bc1.akpm@osdl.org>	<1113209793l.7664l.1l@werewolf.able.es>	<20050411024322.786b83de.akpm@osdl.org>	<200504112359.40487.petkov@uni-muenster.de>	<20050411152243.22835d96.akpm@osdl.org>	<425B4C92.1070507@aknet.ru> <20050411212712.0dbd821d.akpm@osdl.org>
In-Reply-To: <20050411212712.0dbd821d.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------040600040001090903090407"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040600040001090903090407
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

This patch moves the CONFIG_TRAP_BAD_SYSCALL_EXIT
from "Executable file formats" section to the
KGDB section. I had real problems finding that
option where it was.

Signed-off-by: Stas Sergeev <stsp@aknet.ru>

--------------040600040001090903090407
Content-Type: text/x-patch;
 name="kgdbconf.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kgdbconf.diff"

--- linux/arch/i386/Kconfig.old	2005-04-12 09:47:38.000000000 +0400
+++ linux/arch/i386/Kconfig	2005-04-12 09:56:48.000000000 +0400
@@ -1267,14 +1267,6 @@
 
 source "fs/Kconfig.binfmt"
 
-config TRAP_BAD_SYSCALL_EXITS
-	bool "Debug bad system call exits"
-	depends on KGDB
-	help
-	  If you say Y here the kernel will check for system calls which
-	  return without clearing preempt.
-        default n
-
 endmenu
 
 source "drivers/Kconfig"
--- linux/arch/i386/Kconfig.kgdb.old	2005-04-12 09:47:38.000000000 +0400
+++ linux/arch/i386/Kconfig.kgdb	2005-04-12 09:57:11.000000000 +0400
@@ -140,6 +140,14 @@
 	  to check for kernel stack overflow on interrupts and system
 	  calls.  This is part of the kgdb code on x86 systems.
 
+config TRAP_BAD_SYSCALL_EXITS
+	bool "Debug bad system call exits"
+	depends on KGDB
+	help
+	  If you say Y here the kernel will check for system calls which
+	  return without clearing preempt.
+        default n
+
 config KGDB_CONSOLE
 	bool "Enable serial console thru kgdb port"
 	depends on KGDB

--------------040600040001090903090407--
