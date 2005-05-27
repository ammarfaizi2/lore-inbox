Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262417AbVE0JNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262417AbVE0JNK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 05:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262411AbVE0JKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 05:10:18 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:61390 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S262398AbVE0JBf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 05:01:35 -0400
Date: Fri, 27 May 2005 11:03:13 +0200
To: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: [patch 6/10] s390: enable iucv_send2way_xxx functions
Message-ID: <20050527090313.GF8213@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: Frank Pavlic <pavlic@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[patch 6/10] s390: enable iucv_send2way_xxx functions.

From: Ursula Braun-Krahl <braunu@de.ibm.com>

The SSL-Server of z/VM wants to use the iucv_send2way
and iucv_send2way_array function. Enable them again.

Signed-off-by: Frank Pavlic <pavlic@de.ibm.com>

diffstat:
 drivers/s390/net/iucv.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff -urpN linux-2.6/drivers/s390/net/iucv.c linux-2.6-patched/drivers/s390/net/iucv.c
--- linux-2.6/drivers/s390/net/iucv.c	2005-05-06 11:25:57.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/iucv.c	2005-05-06 11:26:18.000000000 +0200
@@ -1,5 +1,5 @@
 /* 
- * $Id: iucv.c,v 1.43 2005/02/09 14:47:43 braunu Exp $
+ * $Id: iucv.c,v 1.45 2005/04/26 22:59:06 braunu Exp $
  *
  * IUCV network driver
  *
@@ -29,7 +29,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: IUCV lowlevel driver $Revision: 1.43 $
+ * RELEASE-TAG: IUCV lowlevel driver $Revision: 1.45 $
  *
  */
 
@@ -355,7 +355,7 @@ do { \
 static void
 iucv_banner(void)
 {
-	char vbuf[] = "$Revision: 1.43 $";
+	char vbuf[] = "$Revision: 1.45 $";
 	char *version = vbuf;
 
 	if ((version = strchr(version, ':'))) {
@@ -2553,12 +2553,12 @@ EXPORT_SYMBOL (iucv_resume);
 #endif
 EXPORT_SYMBOL (iucv_reply_prmmsg);
 EXPORT_SYMBOL (iucv_send);
-#if 0
 EXPORT_SYMBOL (iucv_send2way);
 EXPORT_SYMBOL (iucv_send2way_array);
-EXPORT_SYMBOL (iucv_send_array);
 EXPORT_SYMBOL (iucv_send2way_prmmsg);
 EXPORT_SYMBOL (iucv_send2way_prmmsg_array);
+#if 0
+EXPORT_SYMBOL (iucv_send_array);
 EXPORT_SYMBOL (iucv_send_prmmsg);
 EXPORT_SYMBOL (iucv_setmask);
 #endif
