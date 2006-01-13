Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422998AbWAMWHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422998AbWAMWHn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 17:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423002AbWAMWHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 17:07:42 -0500
Received: from mail.gmx.de ([213.165.64.21]:53417 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1422998AbWAMWHl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 17:07:41 -0500
X-Authenticated: #6666257
Message-ID: <43C826D3.6040600@gmx.de>
Date: Fri, 13 Jan 2006 23:16:51 +0100
From: "M.Gehre" <M.Gehre@gmx.de>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kernel-janitors@lists.osdl.org
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [Patch] Fixes for output of scripts/checkversion.pl
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Gehre <M.Gehre@gmx.de>

Included is a patch for the output of scripts/checkversion.pl:
checkversion find uses of LINUX_VERSION_CODE, KERNEL_VERSION, or
UTS_RELEASE without including <linux/version.h>, or cases of
including <linux/version.h> that don't need it.
The Patch was made against 2.6.15-git9.

Signed-off-by: Matthias Gehre <M.Gehre@gmx.de>

---
Please CC answer to me.

diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/arch/arm/plat-omap/clock.c linux-2.6.15-git9_vpatch/arch/arm/plat-omap/clock.c
--- linux-2.6.15-git9/arch/arm/plat-omap/clock.c	2006-01-13 23:00:55.000000000 +0100
+++ linux-2.6.15-git9_vpatch/arch/arm/plat-omap/clock.c	2006-01-13 21:16:25.000000000 +0100
@@ -10,7 +10,6 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#include <linux/version.h>
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/arch/arm26/nwfpe/fpmodule.c linux-2.6.15-git9_vpatch/arch/arm26/nwfpe/fpmodule.c
--- linux-2.6.15-git9/arch/arm26/nwfpe/fpmodule.c	2006-01-13 23:00:55.000000000 +0100
+++ linux-2.6.15-git9_vpatch/arch/arm26/nwfpe/fpmodule.c	2006-01-13 21:16:41.000000000 +0100
@@ -24,7 +24,6 @@
 #include "fpa11.h"

 #include <linux/module.h>
-#include <linux/version.h>
 #include <linux/config.h>

 /* XXX */
diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/drivers/atm/adummy.c linux-2.6.15-git9_vpatch/drivers/atm/adummy.c
--- linux-2.6.15-git9/drivers/atm/adummy.c	2006-01-13 23:00:26.000000000 +0100
+++ linux-2.6.15-git9_vpatch/drivers/atm/adummy.c	2006-01-13 21:17:21.000000000 +0100
@@ -4,7 +4,6 @@

 #include <linux/config.h>
 #include <linux/module.h>
-#include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/skbuff.h>
 #include <linux/pci.h>
diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/drivers/char/synclink_gt.c linux-2.6.15-git9_vpatch/drivers/char/synclink_gt.c
--- linux-2.6.15-git9/drivers/char/synclink_gt.c	2006-01-13 23:00:56.000000000 +0100
+++ linux-2.6.15-git9_vpatch/drivers/char/synclink_gt.c	2006-01-13 21:19:46.000000000 +0100
@@ -48,7 +48,6 @@

 #include <linux/config.h>
 #include <linux/module.h>
-#include <linux/version.h>
 #include <linux/errno.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/drivers/net/gianfar_sysfs.c linux-2.6.15-git9_vpatch/drivers/net/gianfar_sysfs.c
--- linux-2.6.15-git9/drivers/net/gianfar_sysfs.c	2006-01-13 23:00:56.000000000 +0100
+++ linux-2.6.15-git9_vpatch/drivers/net/gianfar_sysfs.c	2006-01-13 21:17:39.000000000 +0100
@@ -35,7 +35,6 @@

 #include <asm/uaccess.h>
 #include <linux/module.h>
-#include <linux/version.h>

 #include "gianfar.h"

diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/drivers/net/ppp_mppe.c linux-2.6.15-git9_vpatch/drivers/net/ppp_mppe.c
--- linux-2.6.15-git9/drivers/net/ppp_mppe.c	2006-01-13 23:00:28.000000000 +0100
+++ linux-2.6.15-git9_vpatch/drivers/net/ppp_mppe.c	2006-01-13 21:19:14.000000000 +0100
@@ -46,7 +46,6 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/version.h>
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/slab.h>
diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/drivers/net/sky2.c linux-2.6.15-git9_vpatch/drivers/net/sky2.c
--- linux-2.6.15-git9/drivers/net/sky2.c	2006-01-13 23:00:56.000000000 +0100
+++ linux-2.6.15-git9_vpatch/drivers/net/sky2.c	2006-01-13 21:17:51.000000000 +0100
@@ -32,7 +32,6 @@
 #include <linux/config.h>
 #include <linux/crc32.h>
 #include <linux/kernel.h>
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/dma-mapping.h>
diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/drivers/net/wireless/ipw2100.c linux-2.6.15-git9_vpatch/drivers/net/wireless/ipw2100.c
--- linux-2.6.15-git9/drivers/net/wireless/ipw2100.c	2006-01-13 23:00:56.000000000 +0100
+++ linux-2.6.15-git9_vpatch/drivers/net/wireless/ipw2100.c	2006-01-13 21:18:43.000000000 +0100
@@ -159,7 +159,6 @@
 #include <linux/stringify.h>
 #include <linux/tcp.h>
 #include <linux/types.h>
-#include <linux/version.h>
 #include <linux/time.h>
 #include <linux/firmware.h>
 #include <linux/acpi.h>
diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/drivers/net/wireless/ipw2200.c linux-2.6.15-git9_vpatch/drivers/net/wireless/ipw2200.c
--- linux-2.6.15-git9/drivers/net/wireless/ipw2200.c	2006-01-13 23:00:56.000000000 +0100
+++ linux-2.6.15-git9_vpatch/drivers/net/wireless/ipw2200.c	2006-01-13 21:18:53.000000000 +0100
@@ -31,7 +31,6 @@
 ******************************************************************************/

 #include "ipw2200.h"
-#include <linux/version.h>

 #define IPW2200_VERSION "git-1.0.8"
 #define DRV_DESCRIPTION	"Intel(R) PRO/Wireless 2200/2915 Network Driver"
diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/drivers/scsi/gdth_proc.c linux-2.6.15-git9_vpatch/drivers/scsi/gdth_proc.c
--- linux-2.6.15-git9/drivers/scsi/gdth_proc.c	2006-01-13 23:00:29.000000000 +0100
+++ linux-2.6.15-git9_vpatch/drivers/scsi/gdth_proc.c	2006-01-13 21:20:30.000000000 +0100
@@ -3,6 +3,7 @@
  */

 #include <linux/completion.h>
+#include <linux/version.h>

 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
 int gdth_proc_info(struct Scsi_Host *host, char *buffer,char **start,off_t offset,int length,
diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/drivers/usb/atm/ueagle-atm.c linux-2.6.15-git9_vpatch/drivers/usb/atm/ueagle-atm.c
--- linux-2.6.15-git9/drivers/usb/atm/ueagle-atm.c	2006-01-13 23:00:57.000000000 +0100
+++ linux-2.6.15-git9_vpatch/drivers/usb/atm/ueagle-atm.c	2006-01-13 21:19:29.000000000 +0100
@@ -62,7 +62,6 @@
 #include <linux/firmware.h>
 #include <linux/ctype.h>
 #include <linux/kthread.h>
-#include <linux/version.h>
 #include <asm/unaligned.h>

 #include "usbatm.h"
diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/fs/9p/vfs_file.c linux-2.6.15-git9_vpatch/fs/9p/vfs_file.c
--- linux-2.6.15-git9/fs/9p/vfs_file.c	2006-01-13 23:00:57.000000000 +0100
+++ linux-2.6.15-git9_vpatch/fs/9p/vfs_file.c	2006-01-13 21:16:10.000000000 +0100
@@ -32,7 +32,6 @@
 #include <linux/string.h>
 #include <linux/smp_lock.h>
 #include <linux/inet.h>
-#include <linux/version.h>
 #include <linux/list.h>
 #include <asm/uaccess.h>
 #include <linux/idr.h>
diff -urN -X linux-2.6.15-git9/Documentation/dontdiff linux-2.6.15-git9/sound/mips/au1x00.c linux-2.6.15-git9_vpatch/sound/mips/au1x00.c
--- linux-2.6.15-git9/sound/mips/au1x00.c	2006-01-13 23:00:58.000000000 +0100
+++ linux-2.6.15-git9_vpatch/sound/mips/au1x00.c	2006-01-13 21:17:11.000000000 +0100
@@ -39,7 +39,6 @@
 #include <sound/driver.h>
 #include <linux/init.h>
 #include <linux/slab.h>
-#include <linux/version.h>
 #include <sound/core.h>
 #include <sound/initval.h>
 #include <sound/pcm.h>
