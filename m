Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751388AbWJERF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbWJERF5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 13:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbWJERF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 13:05:57 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:20363 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1751001AbWJERF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 13:05:56 -0400
From: Matthew Wilcox <matthew@wil.cx>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
       Matthew Wilcox <matthew@wil.cx>,
       Matthew Wilcox <willy@parisc-linux.org>
Subject: [PATCH] Use linux/io.h instead of asm/io.h
Reply-To: Matthew Wilcox <matthew@wil.cx>
Date: Thu, 05 Oct 2006 11:05:54 -0600
Message-Id: <11600679551209-git-send-email-matthew@wil.cx>
X-Mailer: git-send-email 1.4.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for moving check_signature, change these users from
asm/io.h to linux/io.h

Signed-off-by: Matthew Wilcox <willy@parisc-linux.org>
---
 drivers/block/xd.c                |    2 +-
 drivers/input/misc/wistron_btns.c |    2 +-
 drivers/net/eth16i.c              |    2 +-
 drivers/scsi/aha152x.c            |    2 +-
 drivers/scsi/dtc.c                |    2 +-
 drivers/scsi/fdomain.c            |    2 +-
 drivers/scsi/seagate.c            |    2 +-
 drivers/scsi/t128.c               |    2 +-
 drivers/scsi/wd7000.c             |    2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/block/xd.c b/drivers/block/xd.c
index ebf3025..dd43361 100644
--- a/drivers/block/xd.c
+++ b/drivers/block/xd.c
@@ -48,9 +48,9 @@ #include <linux/wait.h>
 #include <linux/blkdev.h>
 #include <linux/blkpg.h>
 #include <linux/delay.h>
+#include <linux/io.h>
 
 #include <asm/system.h>
-#include <asm/io.h>
 #include <asm/uaccess.h>
 #include <asm/dma.h>
 
diff --git a/drivers/input/misc/wistron_btns.c b/drivers/input/misc/wistron_btns.c
index 4639537..7b9d1c1 100644
--- a/drivers/input/misc/wistron_btns.c
+++ b/drivers/input/misc/wistron_btns.c
@@ -17,7 +17,7 @@
  * with this program; if not, write to the Free Software Foundation, Inc.,
  * 59 Temple Place Suite 330, Boston, MA 02111-1307, USA.
  */
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/dmi.h>
 #include <linux/init.h>
 #include <linux/input.h>
diff --git a/drivers/net/eth16i.c b/drivers/net/eth16i.c
index f16b6a5..a731c10 100644
--- a/drivers/net/eth16i.c
+++ b/drivers/net/eth16i.c
@@ -162,9 +162,9 @@ #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
 #include <linux/bitops.h>
 #include <linux/jiffies.h>
+#include <linux/io.h>		  
 
 #include <asm/system.h>
-#include <asm/io.h>
 #include <asm/dma.h>
 
 
diff --git a/drivers/scsi/aha152x.c b/drivers/scsi/aha152x.c
index fb6a476..004c152 100644
--- a/drivers/scsi/aha152x.c
+++ b/drivers/scsi/aha152x.c
@@ -238,7 +238,7 @@
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <asm/irq.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/blkdev.h>
 #include <asm/system.h>
 #include <linux/errno.h>
diff --git a/drivers/scsi/dtc.c b/drivers/scsi/dtc.c
index 0d5713d..5475672 100644
--- a/drivers/scsi/dtc.c
+++ b/drivers/scsi/dtc.c
@@ -82,7 +82,7 @@ #include <linux/stat.h>
 #include <linux/string.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include "scsi.h"
 #include <scsi/scsi_host.h>
 #include "dtc.h"
diff --git a/drivers/scsi/fdomain.c b/drivers/scsi/fdomain.c
index b0694dc..df1ec7c 100644
--- a/drivers/scsi/fdomain.c
+++ b/drivers/scsi/fdomain.c
@@ -278,9 +278,9 @@ #include <linux/proc_fs.h>
 #include <linux/pci.h>
 #include <linux/stat.h>
 #include <linux/delay.h>
+#include <linux/io.h>
 #include <scsi/scsicam.h>
 
-#include <asm/io.h>
 #include <asm/system.h>
 
 #include <scsi/scsi.h>
diff --git a/drivers/scsi/seagate.c b/drivers/scsi/seagate.c
index 4e6666c..0ade232 100644
--- a/drivers/scsi/seagate.c
+++ b/drivers/scsi/seagate.c
@@ -97,8 +97,8 @@ #include <linux/init.h>
 #include <linux/blkdev.h>
 #include <linux/stat.h>
 #include <linux/delay.h>
+#include <linux/io.h>
 
-#include <asm/io.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
 
diff --git a/drivers/scsi/t128.c b/drivers/scsi/t128.c
index 2df6747..0b7a70f 100644
--- a/drivers/scsi/t128.c
+++ b/drivers/scsi/t128.c
@@ -109,7 +109,7 @@ #define PSEUDO_DMA
 #include <asm/system.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/blkdev.h>
 #include <linux/interrupt.h>
 #include <linux/stat.h>
diff --git a/drivers/scsi/wd7000.c b/drivers/scsi/wd7000.c
index a0b61af..96ec581 100644
--- a/drivers/scsi/wd7000.c
+++ b/drivers/scsi/wd7000.c
@@ -178,10 +178,10 @@ #include <linux/proc_fs.h>
 #include <linux/blkdev.h>
 #include <linux/init.h>
 #include <linux/stat.h>
+#include <linux/io.h>
 
 #include <asm/system.h>
 #include <asm/dma.h>
-#include <asm/io.h>
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
-- 
1.4.1.1

