Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751056AbVHXPR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbVHXPR6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 11:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbVHXPR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 11:17:58 -0400
Received: from de01egw01.freescale.net ([192.88.165.102]:41209 "EHLO
	de01egw01.freescale.net") by vger.kernel.org with ESMTP
	id S1751056AbVHXPR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 11:17:58 -0400
Date: Wed, 24 Aug 2005 10:17:43 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Remove non-arch consumers of asm/segment.h 
Message-ID: <Pine.LNX.4.61.0508241016140.23831@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

asm/segment.h varies greatly on different architectures but is clearly
deprecated.  Removing all non-architecture consumers will make it easier
for us to get ride of asm/segment.h all together.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 2ce31e41967fc58548561a601ffa671c0864d3b8
tree dc693869ee136e6fd06ca4792991d1e0984ec8dd
parent 58d478e75ac5d6cb3a1f738a22555c3841445264
author Kumar K. Gala <kumar.gala@freescale.com> Wed, 24 Aug 2005 10:15:41 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Wed, 24 Aug 2005 10:15:41 -0500

 drivers/char/mxser.c          |    1 -
 drivers/isdn/hisax/hisax.h    |    1 -
 drivers/media/video/adv7170.c |    1 -
 drivers/media/video/adv7175.c |    1 -
 drivers/media/video/bt819.c   |    1 -
 drivers/media/video/bt856.c   |    1 -
 drivers/media/video/saa7111.c |    1 -
 drivers/media/video/saa7114.c |    1 -
 drivers/media/video/saa7185.c |    1 -
 drivers/serial/68328serial.c  |    1 -
 drivers/serial/crisv10.c      |    1 -
 drivers/serial/icom.c         |    1 -
 drivers/serial/mcfserial.c    |    1 -
 drivers/video/q40fb.c         |    1 -
 include/linux/isdn.h          |    1 -
 sound/oss/os.h                |    3 ---
 16 files changed, 0 insertions(+), 18 deletions(-)

diff --git a/drivers/char/mxser.c b/drivers/char/mxser.c
--- a/drivers/char/mxser.c
+++ b/drivers/char/mxser.c
@@ -63,7 +63,6 @@
 #include <asm/system.h>
 #include <asm/io.h>
 #include <asm/irq.h>
-#include <asm/segment.h>
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
 
diff --git a/drivers/isdn/hisax/hisax.h b/drivers/isdn/hisax/hisax.h
--- a/drivers/isdn/hisax/hisax.h
+++ b/drivers/isdn/hisax/hisax.h
@@ -10,7 +10,6 @@
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/major.h>
-#include <asm/segment.h>
 #include <asm/io.h>
 #include <linux/delay.h>
 #include <linux/kernel.h>
diff --git a/drivers/media/video/adv7170.c b/drivers/media/video/adv7170.c
--- a/drivers/media/video/adv7170.c
+++ b/drivers/media/video/adv7170.c
@@ -43,7 +43,6 @@
 #include <asm/pgtable.h>
 #include <asm/page.h>
 #include <linux/sched.h>
-#include <asm/segment.h>
 #include <linux/types.h>
 
 #include <linux/videodev.h>
diff --git a/drivers/media/video/adv7175.c b/drivers/media/video/adv7175.c
--- a/drivers/media/video/adv7175.c
+++ b/drivers/media/video/adv7175.c
@@ -39,7 +39,6 @@
 #include <asm/pgtable.h>
 #include <asm/page.h>
 #include <linux/sched.h>
-#include <asm/segment.h>
 #include <linux/types.h>
 
 #include <linux/videodev.h>
diff --git a/drivers/media/video/bt819.c b/drivers/media/video/bt819.c
--- a/drivers/media/video/bt819.c
+++ b/drivers/media/video/bt819.c
@@ -43,7 +43,6 @@
 #include <asm/pgtable.h>
 #include <asm/page.h>
 #include <linux/sched.h>
-#include <asm/segment.h>
 #include <linux/types.h>
 
 #include <linux/videodev.h>
diff --git a/drivers/media/video/bt856.c b/drivers/media/video/bt856.c
--- a/drivers/media/video/bt856.c
+++ b/drivers/media/video/bt856.c
@@ -43,7 +43,6 @@
 #include <asm/pgtable.h>
 #include <asm/page.h>
 #include <linux/sched.h>
-#include <asm/segment.h>
 #include <linux/types.h>
 
 #include <linux/videodev.h>
diff --git a/drivers/media/video/saa7111.c b/drivers/media/video/saa7111.c
--- a/drivers/media/video/saa7111.c
+++ b/drivers/media/video/saa7111.c
@@ -42,7 +42,6 @@
 #include <asm/pgtable.h>
 #include <asm/page.h>
 #include <linux/sched.h>
-#include <asm/segment.h>
 #include <linux/types.h>
 
 #include <linux/videodev.h>
diff --git a/drivers/media/video/saa7114.c b/drivers/media/video/saa7114.c
--- a/drivers/media/video/saa7114.c
+++ b/drivers/media/video/saa7114.c
@@ -45,7 +45,6 @@
 #include <asm/pgtable.h>
 #include <asm/page.h>
 #include <linux/sched.h>
-#include <asm/segment.h>
 #include <linux/types.h>
 
 #include <linux/videodev.h>
diff --git a/drivers/media/video/saa7185.c b/drivers/media/video/saa7185.c
--- a/drivers/media/video/saa7185.c
+++ b/drivers/media/video/saa7185.c
@@ -39,7 +39,6 @@
 #include <asm/pgtable.h>
 #include <asm/page.h>
 #include <linux/sched.h>
-#include <asm/segment.h>
 #include <linux/types.h>
 
 #include <linux/videodev.h>
diff --git a/drivers/serial/68328serial.c b/drivers/serial/68328serial.c
--- a/drivers/serial/68328serial.c
+++ b/drivers/serial/68328serial.c
@@ -40,7 +40,6 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/system.h>
-#include <asm/segment.h>
 #include <asm/delay.h>
 #include <asm/uaccess.h>
 
diff --git a/drivers/serial/crisv10.c b/drivers/serial/crisv10.c
--- a/drivers/serial/crisv10.c
+++ b/drivers/serial/crisv10.c
@@ -446,7 +446,6 @@ static char *serial_version = "$Revision
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/system.h>
-#include <asm/segment.h>
 #include <asm/bitops.h>
 #include <linux/delay.h>
 
diff --git a/drivers/serial/icom.c b/drivers/serial/icom.c
--- a/drivers/serial/icom.c
+++ b/drivers/serial/icom.c
@@ -56,7 +56,6 @@
 #include <linux/bitops.h>
 
 #include <asm/system.h>
-#include <asm/segment.h>
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/uaccess.h>
diff --git a/drivers/serial/mcfserial.c b/drivers/serial/mcfserial.c
--- a/drivers/serial/mcfserial.c
+++ b/drivers/serial/mcfserial.c
@@ -40,7 +40,6 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/system.h>
-#include <asm/segment.h>
 #include <asm/semaphore.h>
 #include <asm/delay.h>
 #include <asm/coldfire.h>
diff --git a/drivers/video/q40fb.c b/drivers/video/q40fb.c
--- a/drivers/video/q40fb.c
+++ b/drivers/video/q40fb.c
@@ -21,7 +21,6 @@
 
 #include <asm/uaccess.h>
 #include <asm/setup.h>
-#include <asm/segment.h>
 #include <asm/system.h>
 #include <asm/q40_master.h>
 #include <linux/fb.h>
diff --git a/include/linux/isdn.h b/include/linux/isdn.h
--- a/include/linux/isdn.h
+++ b/include/linux/isdn.h
@@ -150,7 +150,6 @@ typedef struct {
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/major.h>
-#include <asm/segment.h>
 #include <asm/io.h>
 #include <linux/kernel.h>
 #include <linux/signal.h>
diff --git a/sound/oss/os.h b/sound/oss/os.h
--- a/sound/oss/os.h
+++ b/sound/oss/os.h
@@ -19,9 +19,6 @@
 #include <linux/ioport.h>
 #include <asm/page.h>
 #include <asm/system.h>
-#ifdef __alpha__
-#include <asm/segment.h>
-#endif
 #include <linux/vmalloc.h>
 #include <asm/uaccess.h>
 #include <linux/poll.h>
