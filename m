Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279589AbRKVNtq>; Thu, 22 Nov 2001 08:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279581AbRKVNth>; Thu, 22 Nov 2001 08:49:37 -0500
Received: from [212.169.100.200] ([212.169.100.200]:10494 "EHLO
	sexything.nextframe.net") by vger.kernel.org with ESMTP
	id <S279589AbRKVNt1>; Thu, 22 Nov 2001 08:49:27 -0500
Date: Thu, 22 Nov 2001 14:55:27 +0100
From: Morten Helgesen <admin@nextframe.net>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [PATCH] remove last references to linux/malloc.h
Message-ID: <20011122145527.A117@sexything>
Reply-To: admin@nextframe.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-Editor: VIM - Vi IMproved 6.0
X-Keyboard: PFU Happy Hacking Keyboard
X-Operating-System: Slackware Linux (of course)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey, Linus and the rest of you.

Quite obvious what this does, right ? :) Yep - removes the last 3 references to linux/malloc.h found in 2.4.15-pre9.

Ok people - stop submitting patches which include malloc.h. Include slab.h instead. :)

== Morten

-- 
mvh
Morten Helgesen 
UNIX System Administrator & C Developer 
Nextframe AS
admin@nextframe.net / 93445641
http://www.nextframe.net


diff -ur vanilla-2.4.15-pre9/arch/arm/mach-epxa10db/dma.c patched-2.4.15-pre9/arch/arm/mach-epxa10db/dma.c
--- vanilla-2.4.15-pre9/arch/arm/mach-epxa10db/dma.c    Thu Oct 25 22:53:45 2001
+++ patched-2.4.15-pre9/arch/arm/mach-epxa10db/dma.c    Thu Nov 22 14:06:20 2001
@@ -19,7 +19,7 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 #include <linux/sched.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/mman.h>
 #include <linux/init.h>

diff -ur vanilla-2.4.15-pre9/drivers/s390/s390io.c patched-2.4.15-pre9/drivers/s390/s390io.c
--- vanilla-2.4.15-pre9/drivers/s390/s390io.c   Sun Sep 30 21:26:07 2001
+++ patched-2.4.15-pre9/drivers/s390/s390io.c   Thu Nov 22 14:08:51 2001
@@ -33,7 +33,7 @@
 #include <linux/signal.h>
 #include <linux/sched.h>
 #include <linux/interrupt.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/smp.h>
 #include <linux/threads.h>
diff -ur vanilla-2.4.15-pre9/drivers/scsi/sym53c8xx_2/sym_glue.h patched-2.4.15-pre9/drivers/scsi/sym53c8xx_2/sym_glue.h
--- vanilla-2.4.15-pre9/drivers/scsi/sym53c8xx_2/sym_glue.h     Thu Nov 22 14:13:59 2001
+++ patched-2.4.15-pre9/drivers/scsi/sym53c8xx_2/sym_glue.h     Thu Nov 22 14:07:21 2001
@@ -77,7 +77,7 @@
 #include <linux/errno.h>
 #include <linux/pci.h>
 #include <linux/string.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/ioport.h>
 #include <linux/time.h>





