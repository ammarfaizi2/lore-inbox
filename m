Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267782AbTBYHNs>; Tue, 25 Feb 2003 02:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267783AbTBYHNs>; Tue, 25 Feb 2003 02:13:48 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:16659 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S267782AbTBYHNr>; Tue, 25 Feb 2003 02:13:47 -0500
Date: Tue, 25 Feb 2003 16:24:03 +0900 (JST)
Message-Id: <20030225.162403.106358044.yoshfuji@linux-ipv6.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/pcmcia/i82365.c compilation failure
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Failed to compile linux-2.5.63 at drivers/pcmcia/i82365.c.
Here's the fix.

Index: drivers/pcmcia/i82365.c
===================================================================
RCS file: /cvsroot/usagi/usagi/kernel/linux25/drivers/pcmcia/i82365.c,v
retrieving revision 1.1.1.12
retrieving revision 1.2
diff -u -r1.1.1.12 -r1.2
--- drivers/pcmcia/i82365.c	25 Feb 2003 05:29:17 -0000	1.1.1.12
+++ drivers/pcmcia/i82365.c	25 Feb 2003 07:05:37 -0000	1.2
@@ -846,7 +846,7 @@
 	
 	    printk("PNP ");
 	    
-	    if (pnp_activate_dev(dev, NULL) < 0) {
+	    if (pnp_activate_dev(dev) < 0) {
 		printk("activate failed\n");
 		pnp_device_detach(dev);
 		break;

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
