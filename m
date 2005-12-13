Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030182AbVLMR7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030182AbVLMR7i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 12:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030187AbVLMR7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 12:59:38 -0500
Received: from verein.lst.de ([213.95.11.210]:49107 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S932597AbVLMR7g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 12:59:36 -0500
Date: Tue, 13 Dec 2005 18:59:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] don't include ioctl32.h in drivers
Message-ID: <20051213175930.GA17249@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These days ioctl32.h is only used for communication of fs/compat.c and
fs/compat_ioctl.c and doesn't contain anything of interest to drivers.

Remove inclusion in various drivers.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6.15-rc5/arch/s390/kernel/s390_ksyms.c
===================================================================
--- linux-2.6.15-rc5.orig/arch/s390/kernel/s390_ksyms.c	2005-12-13 18:37:57.000000000 +0100
+++ linux-2.6.15-rc5/arch/s390/kernel/s390_ksyms.c	2005-12-13 18:39:04.000000000 +0100
@@ -10,7 +10,6 @@
 #include <linux/smp.h>
 #include <linux/syscalls.h>
 #include <linux/interrupt.h>
-#include <linux/ioctl32.h>
 #include <asm/checksum.h>
 #include <asm/cpcmd.h>
 #include <asm/delay.h>
Index: linux-2.6.15-rc5/arch/x86_64/kernel/x8664_ksyms.c
===================================================================
--- linux-2.6.15-rc5.orig/arch/x86_64/kernel/x8664_ksyms.c	2005-12-13 18:37:57.000000000 +0100
+++ linux-2.6.15-rc5/arch/x86_64/kernel/x8664_ksyms.c	2005-12-13 18:38:11.000000000 +0100
@@ -13,7 +13,6 @@
 #include <linux/string.h>
 #include <linux/syscalls.h>
 #include <linux/tty.h>
-#include <linux/ioctl32.h>
 
 #include <asm/semaphore.h>
 #include <asm/processor.h>
Index: linux-2.6.15-rc5/drivers/char/drm/drm_ioc32.c
===================================================================
--- linux-2.6.15-rc5.orig/drivers/char/drm/drm_ioc32.c	2005-12-13 18:37:57.000000000 +0100
+++ linux-2.6.15-rc5/drivers/char/drm/drm_ioc32.c	2005-12-13 18:38:13.000000000 +0100
@@ -28,7 +28,6 @@
  * IN THE SOFTWARE.
  */
 #include <linux/compat.h>
-#include <linux/ioctl32.h>
 
 #include "drmP.h"
 #include "drm_core.h"
Index: linux-2.6.15-rc5/drivers/char/drm/i915_ioc32.c
===================================================================
--- linux-2.6.15-rc5.orig/drivers/char/drm/i915_ioc32.c	2005-12-13 18:37:57.000000000 +0100
+++ linux-2.6.15-rc5/drivers/char/drm/i915_ioc32.c	2005-12-13 18:38:15.000000000 +0100
@@ -30,7 +30,6 @@
  * IN THE SOFTWARE.
  */
 #include <linux/compat.h>
-#include <linux/ioctl32.h>
 
 #include "drmP.h"
 #include "drm.h"
Index: linux-2.6.15-rc5/drivers/char/drm/mga_ioc32.c
===================================================================
--- linux-2.6.15-rc5.orig/drivers/char/drm/mga_ioc32.c	2005-12-13 18:37:57.000000000 +0100
+++ linux-2.6.15-rc5/drivers/char/drm/mga_ioc32.c	2005-12-13 18:38:17.000000000 +0100
@@ -31,7 +31,6 @@
  * IN THE SOFTWARE.
  */
 #include <linux/compat.h>
-#include <linux/ioctl32.h>
 
 #include "drmP.h"
 #include "drm.h"
Index: linux-2.6.15-rc5/drivers/char/drm/r128_ioc32.c
===================================================================
--- linux-2.6.15-rc5.orig/drivers/char/drm/r128_ioc32.c	2005-12-13 18:37:57.000000000 +0100
+++ linux-2.6.15-rc5/drivers/char/drm/r128_ioc32.c	2005-12-13 18:38:19.000000000 +0100
@@ -30,7 +30,6 @@
  * IN THE SOFTWARE.
  */
 #include <linux/compat.h>
-#include <linux/ioctl32.h>
 
 #include "drmP.h"
 #include "drm.h"
Index: linux-2.6.15-rc5/drivers/char/drm/radeon_ioc32.c
===================================================================
--- linux-2.6.15-rc5.orig/drivers/char/drm/radeon_ioc32.c	2005-12-13 18:37:57.000000000 +0100
+++ linux-2.6.15-rc5/drivers/char/drm/radeon_ioc32.c	2005-12-13 18:38:21.000000000 +0100
@@ -28,7 +28,6 @@
  * IN THE SOFTWARE.
  */
 #include <linux/compat.h>
-#include <linux/ioctl32.h>
 
 #include "drmP.h"
 #include "drm.h"
Index: linux-2.6.15-rc5/drivers/ieee1394/amdtp.c
===================================================================
--- linux-2.6.15-rc5.orig/drivers/ieee1394/amdtp.c	2005-12-13 18:37:58.000000000 +0100
+++ linux-2.6.15-rc5/drivers/ieee1394/amdtp.c	2005-12-13 18:38:23.000000000 +0100
@@ -80,7 +80,6 @@
 #include <linux/pci.h>
 #include <linux/interrupt.h>
 #include <linux/poll.h>
-#include <linux/ioctl32.h>
 #include <linux/compat.h>
 #include <linux/cdev.h>
 #include <asm/uaccess.h>
Index: linux-2.6.15-rc5/drivers/ieee1394/dv1394.c
===================================================================
--- linux-2.6.15-rc5.orig/drivers/ieee1394/dv1394.c	2005-12-13 18:37:58.000000000 +0100
+++ linux-2.6.15-rc5/drivers/ieee1394/dv1394.c	2005-12-13 18:38:25.000000000 +0100
@@ -108,7 +108,6 @@
 #include <linux/types.h>
 #include <linux/vmalloc.h>
 #include <linux/string.h>
-#include <linux/ioctl32.h>
 #include <linux/compat.h>
 #include <linux/cdev.h>
 
Index: linux-2.6.15-rc5/drivers/ieee1394/video1394.c
===================================================================
--- linux-2.6.15-rc5.orig/drivers/ieee1394/video1394.c	2005-12-13 18:37:58.000000000 +0100
+++ linux-2.6.15-rc5/drivers/ieee1394/video1394.c	2005-12-13 18:38:27.000000000 +0100
@@ -48,7 +48,6 @@
 #include <linux/vmalloc.h>
 #include <linux/timex.h>
 #include <linux/mm.h>
-#include <linux/ioctl32.h>
 #include <linux/compat.h>
 #include <linux/cdev.h>
 
Index: linux-2.6.15-rc5/drivers/message/fusion/mptctl.c
===================================================================
--- linux-2.6.15-rc5.orig/drivers/message/fusion/mptctl.c	2005-12-13 18:37:58.000000000 +0100
+++ linux-2.6.15-rc5/drivers/message/fusion/mptctl.c	2005-12-13 18:38:30.000000000 +0100
@@ -2585,8 +2585,6 @@
 
 #ifdef CONFIG_COMPAT
 
-#include <linux/ioctl32.h>
-
 static int
 compat_mptfwxfer_ioctl(struct file *filp, unsigned int cmd,
 			unsigned long arg)
Index: linux-2.6.15-rc5/drivers/s390/crypto/z90main.c
===================================================================
--- linux-2.6.15-rc5.orig/drivers/s390/crypto/z90main.c	2005-12-13 18:37:58.000000000 +0100
+++ linux-2.6.15-rc5/drivers/s390/crypto/z90main.c	2005-12-13 18:38:32.000000000 +0100
@@ -30,7 +30,6 @@
 #include <linux/delay.h>       // mdelay
 #include <linux/init.h>
 #include <linux/interrupt.h>   // for tasklets
-#include <linux/ioctl32.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
Index: linux-2.6.15-rc5/drivers/scsi/aacraid/linit.c
===================================================================
--- linux-2.6.15-rc5.orig/drivers/scsi/aacraid/linit.c	2005-12-13 18:37:58.000000000 +0100
+++ linux-2.6.15-rc5/drivers/scsi/aacraid/linit.c	2005-12-13 18:38:35.000000000 +0100
@@ -46,7 +46,6 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/syscalls.h>
-#include <linux/ioctl32.h>
 #include <linux/delay.h>
 #include <linux/smp_lock.h>
 #include <asm/semaphore.h>
Index: linux-2.6.15-rc5/drivers/scsi/ch.c
===================================================================
--- linux-2.6.15-rc5.orig/drivers/scsi/ch.c	2005-12-13 18:37:58.000000000 +0100
+++ linux-2.6.15-rc5/drivers/scsi/ch.c	2005-12-13 18:38:37.000000000 +0100
@@ -20,7 +20,6 @@
 #include <linux/interrupt.h>
 #include <linux/blkdev.h>
 #include <linux/completion.h>
-#include <linux/ioctl32.h>
 #include <linux/compat.h>
 #include <linux/chio.h>			/* here are all the ioctls */
 
Index: linux-2.6.15-rc5/drivers/scsi/megaraid/megaraid_mm.h
===================================================================
--- linux-2.6.15-rc5.orig/drivers/scsi/megaraid/megaraid_mm.h	2005-12-13 18:37:58.000000000 +0100
+++ linux-2.6.15-rc5/drivers/scsi/megaraid/megaraid_mm.h	2005-12-13 18:38:39.000000000 +0100
@@ -22,7 +22,6 @@
 #include <linux/moduleparam.h>
 #include <linux/pci.h>
 #include <linux/list.h>
-#include <linux/ioctl32.h>
 
 #include "mbox_defs.h"
 #include "megaraid_ioctl.h"
Index: linux-2.6.15-rc5/fs/xfs/linux-2.6/xfs_ioctl32.c
===================================================================
--- linux-2.6.15-rc5.orig/fs/xfs/linux-2.6/xfs_ioctl32.c	2005-12-13 18:37:58.000000000 +0100
+++ linux-2.6.15-rc5/fs/xfs/linux-2.6/xfs_ioctl32.c	2005-12-13 18:39:00.000000000 +0100
@@ -19,7 +19,6 @@
 #include <linux/compat.h>
 #include <linux/init.h>
 #include <linux/ioctl.h>
-#include <linux/ioctl32.h>
 #include <linux/syscalls.h>
 #include <linux/types.h>
 #include <linux/fs.h>
