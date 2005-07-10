Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262080AbVGJTka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbVGJTka (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 15:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbVGJTkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:40:15 -0400
Received: from mail.suse.de ([195.135.220.2]:64402 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261602AbVGJTff (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:35:35 -0400
Date: Sun, 10 Jul 2005 19:35:30 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: Eric Moore <Eric.Moore@lsil.com>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-scsi@vger.kernel.org
Subject: [PATCH 22/82] remove linux/version.h from drivers/message/fusion
Message-ID: <20050710193530.22.KSLVIt2863.2247.olh@nectarine.suse.de>
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

remove also drivers/message/fusion/linux_compat.h,
because it is empty after the change

Signed-off-by: Olaf Hering <olh@suse.de>

drivers/message/fusion/linux_compat.h |   18 ------------------
drivers/message/fusion/mptbase.c      |    1 -
drivers/message/fusion/mptbase.h      |    1 -
drivers/message/fusion/mptctl.c       |    1 -
drivers/message/fusion/mptctl.h       |    1 -
drivers/message/fusion/mptfc.c        |    1 -
drivers/message/fusion/mptlan.h       |    1 -
drivers/message/fusion/mptscsih.c     |    1 -
drivers/message/fusion/mptspi.c       |    1 -
9 files changed, 26 deletions(-)

Index: linux-2.6.13-rc2-mm1/drivers/message/fusion/linux_compat.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/message/fusion/linux_compat.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* drivers/message/fusion/linux_compat.h */
-
-#ifndef FUSION_LINUX_COMPAT_H
-#define FUSION_LINUX_COMPAT_H
-
-#include <linux/version.h>
-#include <scsi/scsi_device.h>
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,6))
-static int inline scsi_device_online(struct scsi_device *sdev)
-{
-	return sdev->online;
-}
-#endif
-
-
-/*}-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-#endif /* _LINUX_COMPAT_H */
Index: linux-2.6.13-rc2-mm1/drivers/message/fusion/mptbase.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/message/fusion/mptbase.c
+++ linux-2.6.13-rc2-mm1/drivers/message/fusion/mptbase.c
@@ -47,7 +47,6 @@
/*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/

#include <linux/config.h>
-#include <linux/version.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/errno.h>
Index: linux-2.6.13-rc2-mm1/drivers/message/fusion/mptbase.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/message/fusion/mptbase.h
+++ linux-2.6.13-rc2-mm1/drivers/message/fusion/mptbase.h
@@ -49,7 +49,6 @@
#define MPTBASE_H_INCLUDED
/*{-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/

-#include <linux/version.h>
#include <linux/config.h>
#include <linux/kernel.h>
#include <linux/pci.h>
Index: linux-2.6.13-rc2-mm1/drivers/message/fusion/mptctl.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/message/fusion/mptctl.c
+++ linux-2.6.13-rc2-mm1/drivers/message/fusion/mptctl.c
@@ -45,7 +45,6 @@
*/
/*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/

-#include <linux/version.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/errno.h>
Index: linux-2.6.13-rc2-mm1/drivers/message/fusion/mptctl.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/message/fusion/mptctl.h
+++ linux-2.6.13-rc2-mm1/drivers/message/fusion/mptctl.h
@@ -49,7 +49,6 @@
#define MPTCTL_H_INCLUDED
/*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/

-#include "linux/version.h"


/*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
Index: linux-2.6.13-rc2-mm1/drivers/message/fusion/mptlan.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/message/fusion/mptlan.h
+++ linux-2.6.13-rc2-mm1/drivers/message/fusion/mptlan.h
@@ -66,7 +66,6 @@
#include <linux/slab.h>
#include <linux/miscdevice.h>
#include <linux/spinlock.h>
-#include <linux/version.h>
#include <linux/workqueue.h>
#include <linux/delay.h>
// #include <linux/trdevice.h>
Index: linux-2.6.13-rc2-mm1/drivers/message/fusion/mptfc.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/message/fusion/mptfc.c
+++ linux-2.6.13-rc2-mm1/drivers/message/fusion/mptfc.c
@@ -43,7 +43,6 @@
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/
/*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-#include "linux_compat.h"	/* linux-2.6 tweaks */
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>
Index: linux-2.6.13-rc2-mm1/drivers/message/fusion/mptscsih.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/message/fusion/mptscsih.c
+++ linux-2.6.13-rc2-mm1/drivers/message/fusion/mptscsih.c
@@ -44,7 +44,6 @@
*/
/*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/

-#include "linux_compat.h"	/* linux-2.6 tweaks */
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>
Index: linux-2.6.13-rc2-mm1/drivers/message/fusion/mptspi.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/message/fusion/mptspi.c
+++ linux-2.6.13-rc2-mm1/drivers/message/fusion/mptspi.c
@@ -44,7 +44,6 @@
*/
/*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/

-#include "linux_compat.h"	/* linux-2.6 tweaks */
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>
