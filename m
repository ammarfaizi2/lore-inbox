Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271122AbTGPVkY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 17:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271125AbTGPVkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 17:40:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:52629 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271122AbTGPVkR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 17:40:17 -0400
Date: Wed, 16 Jul 2003 14:55:08 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, karim@opersys.com, bob@watson.ibm.com
Subject: [PATCH] relayfs
Message-Id: <20030716145508.1742d722.shemminger@osdl.org>
In-Reply-To: <16148.6807.578262.720332@gargle.gargle.HOWL>
References: <16148.6807.578262.720332@gargle.gargle.HOWL>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shouldn't relayfs be in the "Pseudo filesystems" part of Kconfig.
Also don't need the .ko suffix.

diff -Nru a/fs/Kconfig b/fs/Kconfig
--- a/fs/Kconfig	Wed Jul 16 14:49:58 2003
+++ b/fs/Kconfig	Wed Jul 16 14:49:58 2003
@@ -881,6 +881,26 @@
 	  say M here and read <file:Documentation/modules.txt>.  The module
 	  will be called ramfs.
 
+config RELAYFS_FS
+	tristate "Relayfs file system support"
+	---help---
+	  Relayfs is a high-speed data relay filesystem designed to provide
+	  an efficient mechanism for tools and facilities to relay large
+	  amounts of data from kernel space to user space.  It's not useful
+	  on its own, and should only be enabled if other facilities that
+	  need it are enabled, such as for example dynamic printk or the
+	  Linux Trace Toolkit.
+
+	  See <file:Documentation/filesystems/relayfs.txt> for further
+	  information.
+
+	  This file system is also available as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want).
+	  The module is called relayfs.  If you want to compile it as a
+	  module, say M here and read <file:Documentation/modules.txt>.
+
+	  If unsure, say N.
+
 endmenu
 
 menu "Miscellaneous filesystems"
@@ -1220,26 +1240,6 @@
 	  will be called sysv.
 
 	  If you haven't heard about all of this before, it's safe to say N.
-
-config RELAYFS_FS
-	tristate "Relayfs file system support"
-	---help---
-	  Relayfs is a high-speed data relay filesystem designed to provide
-	  an efficient mechanism for tools and facilities to relay large
-	  amounts of data from kernel space to user space.  It's not useful
-	  on its own, and should only be enabled if other facilities that
-	  need it are enabled, such as for example dynamic printk or the
-	  Linux Trace Toolkit.
-
-	  See <file:Documentation/filesystems/relayfs.txt> for further
-	  information.
-
-	  This file system is also available as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want).
-	  The module is called relayfs.ko.  If you want to compile it as a
-	  module, say M here and read <file:Documentation/modules.txt>.
-
-	  If unsure, say N.
 
 config UFS_FS
 	tristate "UFS file system support (read only)"
