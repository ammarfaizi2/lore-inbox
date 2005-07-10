Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261983AbVGJWyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261983AbVGJWyS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 18:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbVGJTh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:37:57 -0400
Received: from cantor.suse.de ([195.135.220.2]:17811 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261998AbVGJTgL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:36:11 -0400
Date: Sun, 10 Jul 2005 19:36:06 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net
Subject: [PATCH 58/82] remove linux/version.h from drivers/usb
Message-ID: <20050710193606.58.Shahir3815.2247.olh@nectarine.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
In-Reply-To: <20050710193508.0.PmFpst2252.2247.olh@nectarine.suse.de>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


changing CONFIG_LOCALVERSION rebuilds too much, for no appearent reason.

remove code for obsolete kernels from drivers/usb/media/pwc/pwc-ctrl.c
and drivers/usb/misc/sisusbvga/sisusb.h

Signed-off-by: Olaf Hering <olh@suse.de>

drivers/media/dvb/ttusb-dec/ttusb_dec.c |    1 -
drivers/usb/gadget/dummy_hcd.c          |    1 -
drivers/usb/gadget/lh7a40x_udc.h        |    1 -
drivers/usb/gadget/pxa2xx_udc.c         |    1 -
drivers/usb/gadget/rndis.c              |    1 -
drivers/usb/host/hc_crisv10.c           |    1 -
drivers/usb/media/pwc/pwc-ctrl.c        |   29 -----------------------------
drivers/usb/media/pwc/pwc-if.c          |    4 ----
drivers/usb/media/pwc/pwc.h             |    2 --
drivers/usb/media/w9968cf.c             |    1 -
drivers/usb/misc/sisusbvga/sisusb.c     |    1 -
drivers/usb/misc/sisusbvga/sisusb.h     |    5 -----
12 files changed, 48 deletions(-)

Index: linux-2.6.13-rc2-mm1/drivers/media/dvb/ttusb-dec/ttusb_dec.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/media/dvb/ttusb-dec/ttusb_dec.c
+++ linux-2.6.13-rc2-mm1/drivers/media/dvb/ttusb-dec/ttusb_dec.c
@@ -28,7 +28,6 @@
#include <linux/slab.h>
#include <linux/spinlock.h>
#include <linux/usb.h>
-#include <linux/version.h>
#include <linux/interrupt.h>
#include <linux/firmware.h>
#include <linux/crc32.h>
Index: linux-2.6.13-rc2-mm1/drivers/usb/gadget/dummy_hcd.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/usb/gadget/dummy_hcd.c
+++ linux-2.6.13-rc2-mm1/drivers/usb/gadget/dummy_hcd.c
@@ -49,7 +49,6 @@
#include <linux/timer.h>
#include <linux/list.h>
#include <linux/interrupt.h>
-#include <linux/version.h>

#include <linux/usb.h>
#include <linux/usb_gadget.h>
Index: linux-2.6.13-rc2-mm1/drivers/usb/gadget/lh7a40x_udc.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/usb/gadget/lh7a40x_udc.h
+++ linux-2.6.13-rc2-mm1/drivers/usb/gadget/lh7a40x_udc.h
@@ -29,7 +29,6 @@
#include <linux/kernel.h>
#include <linux/ioport.h>
#include <linux/types.h>
-#include <linux/version.h>
#include <linux/errno.h>
#include <linux/delay.h>
#include <linux/sched.h>
Index: linux-2.6.13-rc2-mm1/drivers/usb/gadget/pxa2xx_udc.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/usb/gadget/pxa2xx_udc.c
+++ linux-2.6.13-rc2-mm1/drivers/usb/gadget/pxa2xx_udc.c
@@ -32,7 +32,6 @@
#include <linux/kernel.h>
#include <linux/ioport.h>
#include <linux/types.h>
-#include <linux/version.h>
#include <linux/errno.h>
#include <linux/delay.h>
#include <linux/sched.h>
Index: linux-2.6.13-rc2-mm1/drivers/usb/gadget/rndis.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/usb/gadget/rndis.c
+++ linux-2.6.13-rc2-mm1/drivers/usb/gadget/rndis.c
@@ -28,7 +28,6 @@
#include <linux/moduleparam.h>
#include <linux/kernel.h>
#include <linux/errno.h>
-#include <linux/version.h>
#include <linux/init.h>
#include <linux/list.h>
#include <linux/proc_fs.h>
Index: linux-2.6.13-rc2-mm1/drivers/usb/host/hc_crisv10.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/usb/host/hc_crisv10.c
+++ linux-2.6.13-rc2-mm1/drivers/usb/host/hc_crisv10.c
@@ -14,7 +14,6 @@
#include <linux/unistd.h>
#include <linux/interrupt.h>
#include <linux/init.h>
-#include <linux/version.h>
#include <linux/list.h>
#include <linux/spinlock.h>

Index: linux-2.6.13-rc2-mm1/drivers/usb/media/pwc/pwc-ctrl.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/usb/media/pwc/pwc-ctrl.c
+++ linux-2.6.13-rc2-mm1/drivers/usb/media/pwc/pwc-ctrl.c
@@ -41,7 +41,6 @@
#include <asm/uaccess.h>
#endif
#include <asm/errno.h>
-#include <linux/version.h>

#include "pwc.h"
#include "pwc-ioctl.h"
@@ -1152,15 +1151,6 @@ int pwc_get_cmos_sensor(struct pwc_devic
/* End of Add-Ons                                    */
/* ************************************************* */

-/* Linux 2.5.something and 2.6 pass direct pointers to arguments of
-   ioctl() calls. With 2.4, you have to do tedious copy_from_user()
-   and copy_to_user() calls. With these macros we circumvent this,
-   and let me maintain only one source file. The functionality is
-   exactly the same otherwise.
- */
-
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0)
-
/* define local variable for arg */
#define ARG_DEF(ARG_type, ARG_name) 	ARG_type *ARG_name = arg;
@@ -1173,25 +1163,6 @@ int pwc_get_cmos_sensor(struct pwc_devic
/* copy local variable to arg */
#define ARG_OUT(ARG_name) /* nothing */

-#else
-
-#define ARG_DEF(ARG_type, ARG_name)-	ARG_type ARG_name;
-#define ARG_IN(ARG_name)-	if (copy_from_user(&ARG_name, arg, sizeof(ARG_name))) {-		ret = -EFAULT;-		break;-	}
-#define ARGR(ARG_name) ARG_name
-#define ARGA(ARG_name) &ARG_name
-#define ARG_OUT(ARG_name)-	if (copy_to_user(arg, &ARG_name, sizeof(ARG_name))) {-		ret = -EFAULT;-		break;-	}
-
-#endif
-
int pwc_ioctl(struct pwc_device *pdev, unsigned int cmd, void *arg)
{
int ret = 0;
Index: linux-2.6.13-rc2-mm1/drivers/usb/media/pwc/pwc-if.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/usb/media/pwc/pwc-if.c
+++ linux-2.6.13-rc2-mm1/drivers/usb/media/pwc/pwc-if.c
@@ -826,13 +826,9 @@ static int pwc_isoc_init(struct pwc_devi
/* Get the current alternate interface, adjust packet size */
if (!udev->actconfig)
return -EFAULT;
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,5)
-	idesc = &udev->actconfig->interface[0]->altsetting[pdev->valternate];
-#else
intf = usb_ifnum_to_if(udev, 0);
if (intf)
idesc = usb_altnum_to_altsetting(intf, pdev->valternate);
-#endif

if (!idesc)
return -EFAULT;
Index: linux-2.6.13-rc2-mm1/drivers/usb/media/pwc/pwc.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/usb/media/pwc/pwc.h
+++ linux-2.6.13-rc2-mm1/drivers/usb/media/pwc/pwc.h
@@ -25,8 +25,6 @@
#ifndef PWC_H
#define PWC_H

-#include <linux/version.h>
-
#include <linux/config.h>
#include <linux/module.h>
#include <linux/usb.h>
Index: linux-2.6.13-rc2-mm1/drivers/usb/media/w9968cf.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/usb/media/w9968cf.c
+++ linux-2.6.13-rc2-mm1/drivers/usb/media/w9968cf.c
@@ -25,7 +25,6 @@
* Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.               *
***************************************************************************/

-#include <linux/version.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/kmod.h>
Index: linux-2.6.13-rc2-mm1/drivers/usb/misc/sisusbvga/sisusb.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/usb/misc/sisusbvga/sisusb.c
+++ linux-2.6.13-rc2-mm1/drivers/usb/misc/sisusbvga/sisusb.c
@@ -35,7 +35,6 @@
*/

#include <linux/config.h>
-#include <linux/version.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/signal.h>
Index: linux-2.6.13-rc2-mm1/drivers/usb/misc/sisusbvga/sisusb.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/usb/misc/sisusbvga/sisusb.h
+++ linux-2.6.13-rc2-mm1/drivers/usb/misc/sisusbvga/sisusb.h
@@ -38,13 +38,8 @@
#define _SISUSB_H_

#ifdef CONFIG_COMPAT
-#if LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,10)
-#include <linux/ioctl32.h>
-#define SISUSB_OLD_CONFIG_COMPAT
-#else
#define SISUSB_NEW_CONFIG_COMPAT
#endif
-#endif

/* Version Information */

