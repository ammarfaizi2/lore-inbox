Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWIYTfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWIYTfT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 15:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWIYTfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 15:35:19 -0400
Received: from havoc.gtf.org ([69.61.125.42]:31461 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1750731AbWIYTfR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 15:35:17 -0400
Date: Mon, 25 Sep 2006 15:35:11 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [git patch] libata fix
Message-ID: <20060925193511.GA6129@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[hey Linus, your git summary hint helped, thanks]

Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-linus

to receive the following updates:

 include/asm-alpha/libata-portmap.h   |    1 -
 include/asm-frv/libata-portmap.h     |    1 -
 include/asm-i386/libata-portmap.h    |    1 -
 include/asm-ia64/libata-portmap.h    |    1 -
 include/asm-powerpc/libata-portmap.h |    1 -
 include/asm-sparc/libata-portmap.h   |    1 -
 include/asm-sparc64/libata-portmap.h |    1 -
 include/asm-x86_64/libata-portmap.h  |    1 -
 include/linux/libata.h               |    8 ++++++++
 9 files changed, 8 insertions(+), 8 deletions(-)
 delete mode 100644 include/asm-alpha/libata-portmap.h
 delete mode 100644 include/asm-frv/libata-portmap.h
 delete mode 100644 include/asm-i386/libata-portmap.h
 delete mode 100644 include/asm-ia64/libata-portmap.h
 delete mode 100644 include/asm-powerpc/libata-portmap.h
 delete mode 100644 include/asm-sparc/libata-portmap.h
 delete mode 100644 include/asm-sparc64/libata-portmap.h
 delete mode 100644 include/asm-x86_64/libata-portmap.h

Jeff Garzik:
      [libata] No need for all those arch libata-portmap.h headers

diff --git a/include/asm-alpha/libata-portmap.h b/include/asm-alpha/libata-portmap.h
deleted file mode 100644
index 75484ef..0000000
--- a/include/asm-alpha/libata-portmap.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/libata-portmap.h>
diff --git a/include/asm-frv/libata-portmap.h b/include/asm-frv/libata-portmap.h
deleted file mode 100644
index 75484ef..0000000
--- a/include/asm-frv/libata-portmap.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/libata-portmap.h>
diff --git a/include/asm-i386/libata-portmap.h b/include/asm-i386/libata-portmap.h
deleted file mode 100644
index 75484ef..0000000
--- a/include/asm-i386/libata-portmap.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/libata-portmap.h>
diff --git a/include/asm-ia64/libata-portmap.h b/include/asm-ia64/libata-portmap.h
deleted file mode 100644
index 75484ef..0000000
--- a/include/asm-ia64/libata-portmap.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/libata-portmap.h>
diff --git a/include/asm-powerpc/libata-portmap.h b/include/asm-powerpc/libata-portmap.h
deleted file mode 100644
index 75484ef..0000000
--- a/include/asm-powerpc/libata-portmap.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/libata-portmap.h>
diff --git a/include/asm-sparc/libata-portmap.h b/include/asm-sparc/libata-portmap.h
deleted file mode 100644
index 75484ef..0000000
--- a/include/asm-sparc/libata-portmap.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/libata-portmap.h>
diff --git a/include/asm-sparc64/libata-portmap.h b/include/asm-sparc64/libata-portmap.h
deleted file mode 100644
index 75484ef..0000000
--- a/include/asm-sparc64/libata-portmap.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/libata-portmap.h>
diff --git a/include/asm-x86_64/libata-portmap.h b/include/asm-x86_64/libata-portmap.h
deleted file mode 100644
index 75484ef..0000000
--- a/include/asm-x86_64/libata-portmap.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/libata-portmap.h>
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 1ef3d39..d6a3d4b 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -36,7 +36,15 @@ #include <linux/ata.h>
 #include <linux/workqueue.h>
 #include <scsi/scsi_host.h>
 
+/*
+ * Define if arch has non-standard setup.  This is a _PCI_ standard
+ * not a legacy or ISA standard.
+ */
+#ifdef CONFIG_ATA_NONSTANDARD
 #include <asm/libata-portmap.h>
+#else
+#include <asm-generic/libata-portmap.h>
+#endif
 
 /*
  * compile-time options: to be removed as soon as all the drivers are
