Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261742AbTBJR2Y>; Mon, 10 Feb 2003 12:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261799AbTBJR2X>; Mon, 10 Feb 2003 12:28:23 -0500
Received: from virtisp1.zianet.com ([216.234.192.105]:59154 "HELO
	mesatop.zianet.com") by vger.kernel.org with SMTP
	id <S261742AbTBJR2V>; Mon, 10 Feb 2003 12:28:21 -0500
Subject: [PATCH] 2.5.59-bk4 finish job of trimming ".o" module extension in
	Kconfig help texts.
From: Steven Cole <elenstev@mesatop.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rusty Trivial Russell <rusty@rustcorp.com.au>,
       GertJan Spoelman <kl@gjs.cc>, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 10 Feb 2003 10:30:20 -0700
Message-Id: <1044898222.25378.890.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.5.59-bk4 in the Kconfig files, most of the instances of <module>.o
have had the ".o" extension trimmed.  This change came from GertJan
Spoelman through Rusty "Trivial" Russell.

However, I had some Kconfig help additions queued up through Rusty,
which still had the ".o" extensions and which did not get trimmed.  And
for some reason the Kconfig files in arch/s390 and arch/s390x also did
not get trimmed.

Here is a patch which brings the following four files in line with the
rest of the -bk4 tree.

 arch/s390/Kconfig             |    6 +++---
 arch/s390x/Kconfig            |    6 +++---
 drivers/char/watchdog/Kconfig |    6 +++---
 drivers/i2c/Kconfig           |    4 ++--
 4 files changed, 11 insertions(+), 11 deletions(-)

Steven

diff -ur linux-2.5.59-bk4-orig/arch/s390/Kconfig linux-2.5.59-bk4/arch/s390/Kconfig
--- linux-2.5.59-bk4-orig/arch/s390/Kconfig	Thu Jan 16 19:22:03 2003
+++ linux-2.5.59-bk4/arch/s390/Kconfig	Mon Feb 10 10:02:31 2003
@@ -110,7 +110,7 @@
 
 	  This driver is also available as a module ( = code which can be
 	  inserted in and removed from the running kernel whenever you want).
-	  The module will be called qdio.o. If you want to compile it as a
+	  The module will be called qdio. If you want to compile it as a
 	  module, say M here and read <file:Documentation/modules.txt>.
 
 	  If unsure, say Y.
@@ -210,7 +210,7 @@
 	  If you want to compile this as a module ( = code which can be
 	  inserted in and removed from the running kernel whenever you want),
 	  say M here and read <file:Documentation/modules.txt>.  The module
-	  will be called binfmt_elf.o. Saying M or N here is dangerous because
+	  will be called binfmt_elf. Saying M or N here is dangerous because
 	  some crucial programs on your system might be in ELF format.
 
 config BINFMT_MISC
@@ -235,7 +235,7 @@
 	  use this part of the kernel.
 
 	  You may say M here for module support and later load the module when
-	  you have use for it; the module is called binfmt_misc.o. If you
+	  you have use for it; the module is called binfmt_misc. If you
 	  don't know what to answer at this point, say Y.
 
 config PROCESS_DEBUG
diff -ur linux-2.5.59-bk4-orig/arch/s390x/Kconfig linux-2.5.59-bk4/arch/s390x/Kconfig
--- linux-2.5.59-bk4-orig/arch/s390x/Kconfig	Thu Jan 16 19:22:13 2003
+++ linux-2.5.59-bk4/arch/s390x/Kconfig	Mon Feb 10 10:02:52 2003
@@ -124,7 +124,7 @@
 
 	  This driver is also available as a module ( = code which can be
 	  inserted in and removed from the running kernel whenever you want).
-	  The module will be called qdio.o. If you want to compile it as a
+	  The module will be called qdio. If you want to compile it as a
 	  module, say M here and read <file:Documentation/modules.txt>.
 
 	  If unsure, say Y.
@@ -224,7 +224,7 @@
 	  If you want to compile this as a module ( = code which can be
 	  inserted in and removed from the running kernel whenever you want),
 	  say M here and read <file:Documentation/modules.txt>.  The module
-	  will be called binfmt_elf.o. Saying M or N here is dangerous because
+	  will be called binfmt_elf. Saying M or N here is dangerous because
 	  some crucial programs on your system might be in ELF format.
 
 config BINFMT_MISC
@@ -249,7 +249,7 @@
 	  use this part of the kernel.
 
 	  You may say M here for module support and later load the module when
-	  you have use for it; the module is called binfmt_misc.o. If you
+	  you have use for it; the module is called binfmt_misc. If you
 	  don't know what to answer at this point, say Y.
 
 config PROCESS_DEBUG
diff -ur linux-2.5.59-bk4-orig/drivers/char/watchdog/Kconfig linux-2.5.59-bk4/drivers/char/watchdog/Kconfig
--- linux-2.5.59-bk4-orig/drivers/char/watchdog/Kconfig	Mon Feb 10 10:06:35 2003
+++ linux-2.5.59-bk4/drivers/char/watchdog/Kconfig	Mon Feb 10 10:03:27 2003
@@ -311,7 +311,7 @@
 	  amount of time.
 	
 	  You can compile this driver directly into the kernel, or use
-	  it as a module.  The module will be called sc520_wdt.o.
+	  it as a module.  The module will be called sc520_wdt.
 
 config ALIM7101_WDT
 	tristate "ALi M7101 PMU Computer Watchdog"
@@ -322,7 +322,7 @@
 
 	  This driver is also available as a module ( = code which can be
 	  inserted in and removed from the running kernel whenever you want).
-	  The module is called alim7101_wdt.o.  If you want to compile it as a
+	  The module is called alim7101_wdt.  If you want to compile it as a
 	  module, say M here and read Documentation/modules.txt.  Most
 	  people will say N.
 
@@ -337,7 +337,7 @@
 
 	  This driver is also available as a module ( = code which can be
 	  inserted in and removed from the running kernel whenever you want).
-	  The module is called sc1200wdt.o.  If you want to compile it as a
+	  The module is called sc1200wdt.  If you want to compile it as a
 	  module, say M here and read Documentation/modules.txt.  Most
 	  people will say N.
 
diff -ur linux-2.5.59-bk4-orig/drivers/i2c/Kconfig linux-2.5.59-bk4/drivers/i2c/Kconfig
--- linux-2.5.59-bk4-orig/drivers/i2c/Kconfig	Mon Feb 10 10:06:35 2003
+++ linux-2.5.59-bk4/drivers/i2c/Kconfig	Mon Feb 10 10:03:58 2003
@@ -152,7 +152,7 @@
 
 	  This support is also available as a module. If you want to compile
 	  it as a module, say M here and read Documentation/modules.txt.
-	  The module will be called i2c-algo-ite.o.
+	  The module will be called i2c-algo-ite.
 
 config ITE_I2C_ADAP
 	tristate "ITE I2C Adapter"
@@ -164,7 +164,7 @@
 
 	  This support is also available as a module. If you want to compile
 	  it as a module, say M here and read Documentation/modules.txt.
-	  The module will be called i2c-adap-ite.o.
+	  The module will be called i2c-adap-ite.
 
 config I2C_ALGO8XX
 	tristate "MPC8xx CPM I2C interface"






