Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262020AbVGJWyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbVGJWyV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 18:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262053AbVGJThZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:37:25 -0400
Received: from ns2.suse.de ([195.135.220.15]:56028 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262040AbVGJTg3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:36:29 -0400
Date: Sun, 10 Jul 2005 19:36:28 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: kraxel@suse.de
Subject: [PATCH 80/82] remove linux/version.h from drivers/media/
Message-ID: <20050710193628.80.cnhfER4396.2247.olh@nectarine.suse.de>
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

use linux/utsname.h to get KERNEL_VERSION macro

Signed-off-by: Olaf Hering <olh@suse.de>

drivers/media/video/bttvp.h           |    2 +-
drivers/media/video/cx88/cx88.h       |    2 +-
drivers/media/video/saa7134/saa7134.h |    2 +-
drivers/media/video/zoran_driver.c    |    2 +-
include/media/saa7146.h               |    2 +-
5 files changed, 5 insertions(+), 5 deletions(-)

Index: linux-2.6.13-rc2-mm1/drivers/media/video/bttvp.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/media/video/bttvp.h
+++ linux-2.6.13-rc2-mm1/drivers/media/video/bttvp.h
@@ -26,7 +26,7 @@
#ifndef _BTTVP_H_
#define _BTTVP_H_

-#include <linux/version.h>
+#include <linux/utsname.h>
#define BTTV_VERSION_CODE KERNEL_VERSION(0,9,15)

#include <linux/types.h>
Index: linux-2.6.13-rc2-mm1/drivers/media/video/cx88/cx88.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/media/video/cx88/cx88.h
+++ linux-2.6.13-rc2-mm1/drivers/media/video/cx88/cx88.h
@@ -35,7 +35,7 @@
#include "btcx-risc.h"
#include "cx88-reg.h"

-#include <linux/version.h>
+#include <linux/utsname.h>
#define CX88_VERSION_CODE KERNEL_VERSION(0,0,4)

#ifndef TRUE
Index: linux-2.6.13-rc2-mm1/drivers/media/video/saa7134/saa7134.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/media/video/saa7134/saa7134.h
+++ linux-2.6.13-rc2-mm1/drivers/media/video/saa7134/saa7134.h
@@ -20,7 +20,7 @@
*  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
*/

-#include <linux/version.h>
+#include <linux/utsname.h>
#define SAA7134_VERSION_CODE KERNEL_VERSION(0,2,13)

#include <linux/pci.h>
Index: linux-2.6.13-rc2-mm1/drivers/media/video/zoran_driver.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/media/video/zoran_driver.c
+++ linux-2.6.13-rc2-mm1/drivers/media/video/zoran_driver.c
@@ -45,7 +45,7 @@
*/

#include <linux/config.h>
-#include <linux/version.h>
+#include <linux/utsname.h>
#include <linux/init.h>
#include <linux/module.h>
#include <linux/delay.h>
Index: linux-2.6.13-rc2-mm1/include/media/saa7146.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/include/media/saa7146.h
+++ linux-2.6.13-rc2-mm1/include/media/saa7146.h
@@ -1,7 +1,6 @@
#ifndef __SAA7146__
#define __SAA7146__

-#include <linux/version.h>	/* for version macros */
#include <linux/module.h>	/* for module-version */
#include <linux/delay.h>	/* for delay-stuff */
#include <linux/slab.h>		/* for kmalloc/kfree */
@@ -14,6 +13,7 @@
#include <linux/stringify.h>
#include <linux/vmalloc.h>	/* for vmalloc() */
#include <linux/mm.h>		/* for vmalloc_to_page() */
+#include <linux/utsname.h>	/* for KERNEL_VERSION */

#define SAA7146_VERSION_CODE KERNEL_VERSION(0,5,0)

