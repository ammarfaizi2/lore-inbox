Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263169AbTDWIat (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 04:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263208AbTDWIat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 04:30:49 -0400
Received: from smtp2.wanadoo.fr ([193.252.22.26]:49624 "EHLO
	mwinf0501.wanadoo.fr") by vger.kernel.org with ESMTP
	id S263169AbTDWIaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 04:30:46 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: linux-usb-devel@lists.sourceforge.net
Subject: [PATCH] USB speedtouch: bump the version number
Date: Wed, 23 Apr 2003 10:42:45 +0200
User-Agent: KMail/1.5.1
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_FIlp+jAzCglqFqT"
Message-Id: <200304231042.45879.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_FIlp+jAzCglqFqT
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Patches against the 2.4 and 2.5 USB trees attached.
Here is the 2.5 version for reference:

 speedtch.c |   21 +++++++++++++++++----
 1 files changed, 17 insertions(+), 4 deletions(-)


diff -Nru a/drivers/usb/misc/speedtch.c b/drivers/usb/misc/speedtch.c
--- a/drivers/usb/misc/speedtch.c	Wed Apr 23 10:38:22 2003
+++ b/drivers/usb/misc/speedtch.c	Wed Apr 23 10:38:22 2003
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


--Boundary-00=_FIlp+jAzCglqFqT
Content-Type: text/x-diff;
  charset="us-ascii";
  name="bump-2.5.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="bump-2.5.diff"

 speedtch.c |   21 +++++++++++++++++----
 1 files changed, 17 insertions(+), 4 deletions(-)


diff -Nru a/drivers/usb/misc/speedtch.c b/drivers/usb/misc/speedtch.c
--- a/drivers/usb/misc/speedtch.c	Wed Apr 23 10:38:22 2003
+++ b/drivers/usb/misc/speedtch.c	Wed Apr 23 10:38:22 2003
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


--Boundary-00=_FIlp+jAzCglqFqT
Content-Type: text/x-diff;
  charset="us-ascii";
  name="bump-2.4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="bump-2.4.diff"

 speedtouch.c |   21 +++++++++++++++++----
 1 files changed, 17 insertions(+), 4 deletions(-)


diff -Nru a/drivers/usb/speedtouch.c b/drivers/usb/speedtouch.c
--- a/drivers/usb/speedtouch.c	Wed Apr 23 10:38:44 2003
+++ b/drivers/usb/speedtouch.c	Wed Apr 23 10:38:44 2003
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
  *  1.5A:	- Backport of version for inclusion in 2.5 series kernel
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


--Boundary-00=_FIlp+jAzCglqFqT--
