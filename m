Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262387AbVCBQ60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262387AbVCBQ60 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 11:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262358AbVCBQth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 11:49:37 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:4760 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S262359AbVCBQqY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 11:46:24 -0500
Date: Wed, 2 Mar 2005 17:46:23 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 7/9] s390: iucv driver init call.
Message-ID: <20050302164623.GG27829@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 7/9] s390: iucv driver init call.

From: Ursula Braun-Krahl <braunu@de.ibm.com>

iucv changes:
 - Initialize iucv with subsys_initcall to make sure that it is
   there before either vmlogrdr or netiucv start using it.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/net/iucv.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -urN linux-2.6/drivers/s390/net/iucv.c linux-2.6-patched/drivers/s390/net/iucv.c
--- linux-2.6/drivers/s390/net/iucv.c	2005-03-02 08:37:48.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/iucv.c	2005-03-02 17:00:15.000000000 +0100
@@ -1,5 +1,5 @@
 /* 
- * $Id: iucv.c,v 1.42 2005/01/07 10:49:54 braunu Exp $
+ * $Id: iucv.c,v 1.43 2005/02/09 14:47:43 braunu Exp $
  *
  * IUCV network driver
  *
@@ -29,7 +29,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: IUCV lowlevel driver $Revision: 1.42 $
+ * RELEASE-TAG: IUCV lowlevel driver $Revision: 1.43 $
  *
  */
 
@@ -355,7 +355,7 @@
 static void
 iucv_banner(void)
 {
-	char vbuf[] = "$Revision: 1.42 $";
+	char vbuf[] = "$Revision: 1.43 $";
 	char *version = vbuf;
 
 	if ((version = strchr(version, ':'))) {
@@ -2525,7 +2525,7 @@
 	return;
 }
 
-module_init(iucv_init);
+subsys_initcall(iucv_init);
 module_exit(iucv_exit);
 
 /**
