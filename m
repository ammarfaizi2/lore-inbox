Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263715AbTCUSbY>; Fri, 21 Mar 2003 13:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263708AbTCUSaY>; Fri, 21 Mar 2003 13:30:24 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:61571
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262595AbTCUS3b>; Fri, 21 Mar 2003 13:29:31 -0500
Date: Fri, 21 Mar 2003 19:44:46 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211944.h2LJikBx025935@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fix bogus if in advansys driver
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/scsi/advansys.c linux-2.5.65-ac2/drivers/scsi/advansys.c
--- linux-2.5.65/drivers/scsi/advansys.c	2003-03-03 19:20:11.000000000 +0000
+++ linux-2.5.65-ac2/drivers/scsi/advansys.c	2003-03-06 22:05:42.000000000 +0000
@@ -7099,7 +7099,7 @@
          * then return the number of underrun bytes.
          */
         if (scp->request_bufflen != 0 && qdonep->remain_bytes != 0 &&
-            qdonep->remain_bytes <= scp->request_bufflen != 0) {
+            qdonep->remain_bytes <= scp->request_bufflen) {
             ASC_DBG1(1, "asc_isr_callback: underrun condition %u bytes\n",
             (unsigned) qdonep->remain_bytes);
             scp->resid = qdonep->remain_bytes;
