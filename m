Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267170AbUHMTHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267170AbUHMTHN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 15:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266914AbUHMTDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 15:03:30 -0400
Received: from fep02fe.ttnet.net.tr ([212.156.4.132]:6366 "EHLO
	fep02.ttnet.net.tr") by vger.kernel.org with ESMTP id S267168AbUHMS7v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 14:59:51 -0400
Message-ID: <411D0F73.6070301@ttnet.net.tr>
Date: Fri, 13 Aug 2004 21:58:59 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4] ns83820.c fixes from 2.6
Content-Type: multipart/mixed;
	boundary="------------040204050002070203030908"
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040204050002070203030908
Content-Type: text/plain;
	charset=ISO-8859-9;
	format=flowed
Content-Transfer-Encoding: quoted-printable

ns83820.c warning fix from 2.6

=D6zkan Sezer


--------------040204050002070203030908
Content-Type: text/plain;
	name="ns83820.c-2.6-warning.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="ns83820.c-2.6-warning.diff"

--- 27rc5~/drivers/net/ns83820.c	2004-02-18 15:36:31.000000000 +0200
+++ 27rc5/drivers/net/ns83820.c	2004-08-07 14:09:39.000000000 +0300
@@ -1585,6 +1585,7 @@
 	dprintk("%s: done %s in %d loops\n", dev->net_dev.name, name, loops);
 }
 
+#ifdef PHY_CODE_IS_FINISHED
 static void ns83820_mii_write_bit(struct ns83820 *dev, int bit)
 {
 	/* drive MDC low */
@@ -1757,6 +1758,7 @@
 		dprintk("version: 0x%04x 0x%04x\n", a, b);
 	}
 }
+#endif
 
 static int __devinit ns83820_init_one(struct pci_dev *pci_dev, const struct pci_device_id *id)
 {


--------------040204050002070203030908--
