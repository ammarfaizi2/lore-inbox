Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131385AbRCSJuf>; Mon, 19 Mar 2001 04:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131393AbRCSJuZ>; Mon, 19 Mar 2001 04:50:25 -0500
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:48651 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S131385AbRCSJuN>; Mon, 19 Mar 2001 04:50:13 -0500
Date: Mon, 19 Mar 2001 09:49:51 +0000
From: Tim Waugh <twaugh@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.3-pre4: allow more than 3 printers
Message-ID: <20010319094951.D1204@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's easier to add parallel ports to a machine nowadays, so the
default maximum of three printer devices is becoming a bit
restrictive.

Here's a patch to increase it.  Any objections?

Tim.
*/

2001-03-19  Tim Waugh  <twaugh@redhat.com>

	* include/linux/parport.h: Increase PARPORT_MAX to 16.
	* drivers/char/lp.c: Increase LP_NO to 16.

--- linux/include/linux/parport.h.printers	Mon Mar 19 09:41:22 2001
+++ linux/include/linux/parport.h	Mon Mar 19 09:42:08 2001
@@ -11,8 +11,8 @@
 
 /* Start off with user-visible constants */
 
-/* Maximum of 8 ports per machine */
-#define PARPORT_MAX  8 
+/* Maximum of 16 ports per machine */
+#define PARPORT_MAX  16
 
 /* Magic numbers */
 #define PARPORT_IRQ_NONE  -1
--- linux/drivers/char/lp.c.printers	Mon Mar 19 09:41:12 2001
+++ linux/drivers/char/lp.c	Mon Mar 19 09:41:41 2001
@@ -135,8 +135,8 @@
 #include <asm/uaccess.h>
 #include <asm/system.h>
 
-/* if you have more than 3 printers, remember to increase LP_NO */
-#define LP_NO 3
+/* if you have more than 16 printers, remember to increase LP_NO */
+#define LP_NO 16
 
 /* ROUND_UP macro from fs/select.c */
 #define ROUND_UP(x,y) (((x)+(y)-1)/(y))
