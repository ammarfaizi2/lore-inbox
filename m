Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264472AbTDXXeK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 19:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264506AbTDXXeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 19:34:10 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:24574 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264472AbTDXXd6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 19:33:58 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10512280523879@kroah.com>
Subject: Re: [PATCH] More USB fixes for 2.5.68
In-Reply-To: <10512280523224@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 24 Apr 2003 16:47:32 -0700
Content-Transfer-Encoding: 7BIT
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1165.2.5, 2003/04/23 12:06:14-07:00, baldrick@wanadoo.fr

[PATCH] USB speedtouch: bump the version number


 drivers/usb/misc/speedtch.c |   21 +++++++++++++++++----
 1 files changed, 17 insertions(+), 4 deletions(-)


diff -Nru a/drivers/usb/misc/speedtch.c b/drivers/usb/misc/speedtch.c
--- a/drivers/usb/misc/speedtch.c	Thu Apr 24 16:27:00 2003
+++ b/drivers/usb/misc/speedtch.c	Thu Apr 24 16:27:00 2003
@@ -20,7 +20,19 @@
  ******************************************************************************/
 
 /*
- *  Written by Johan Verrept (Johan.Verrept@advalvas.be)
+ *  Written by Johan Verrept, maintained by Duncan Sands (duncan.sands@wanadoo.fr)
+ *
+ *  1.6:	- No longer opens a connection if the firmware is not loaded
+ *  		- Added support for the speedtouch 330
+ *  		- Removed the limit on the number of devices
+ *  		- Module now autoloads on device plugin
+ *  		- Merged relevant parts of sarlib
+ *  		- Replaced the kernel thread with a tasklet
+ *  		- New packet transmission code
+ *  		- Changed proc file contents
+ *  		- Fixed all known SMP races
+ *  		- Many fixes and cleanups
+ *  		- Various fixes by Oliver Neukum (oliver@neukum.name)
  *
  *  1.5A:	- Version for inclusion in 2.5 series kernel
  *		- Modifications by Richard Purdie (rpurdie@rpsys.net)
@@ -28,6 +40,7 @@
  *		udsl_usb_send_data_context->urb to a pointer and adding code
  *		to alloc and free it
  *		- remove_wait_queue() added to udsl_atm_processqueue_thread()
+ *		- Duncan Sands (duncan.sands@wanadoo.fr) is the new maintainer
  *
  *  1.5:	- fixed memory leak when atmsar_decode_aal5 returned NULL.
  *		(reported by stephen.robinson@zen.co.uk)
@@ -77,9 +90,9 @@
 #define PACKETDEBUG(arg...)
 #endif
 
-#define DRIVER_AUTHOR	"Johan Verrept, Johan.Verrept@advalvas.be"
-#define DRIVER_DESC	"Driver for the Alcatel SpeedTouch USB ADSL modem"
-#define DRIVER_VERSION	"1.5A"
+#define DRIVER_AUTHOR	"Johan Verrept, Duncan Sands <duncan.sands@wanadoo.fr>"
+#define DRIVER_DESC	"Alcatel SpeedTouch USB driver"
+#define DRIVER_VERSION	"1.6"
 
 #define SPEEDTOUCH_VENDORID		0x06b9
 #define SPEEDTOUCH_PRODUCTID		0x4061

