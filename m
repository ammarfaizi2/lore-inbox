Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266100AbTBGREY>; Fri, 7 Feb 2003 12:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266095AbTBGREX>; Fri, 7 Feb 2003 12:04:23 -0500
Received: from nycsmtp2out.rdc-nyc.rr.com ([24.29.99.223]:18147 "EHLO
	nycsmtp2out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S266114AbTBGRES>; Fri, 7 Feb 2003 12:04:18 -0500
Date: Fri, 7 Feb 2003 12:23:22 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@master
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com, <trivial@rustcorp.com.au>
Subject: [PATCH] 2.5.59 : drivers/net/fc/iph5526.c
Message-ID: <Pine.LNX.4.44.0302071221490.6917-100000@master>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
   The following patch addresses buzilla bug # 323, and removes a double 
logical issue. Please review for inclusion.

Regards,
Frank

--- linux/drivers/net/fc/iph5526.c.old	2003-01-16 21:21:45.000000000 -0500
+++ linux/drivers/net/fc/iph5526.c	2003-02-07 02:13:43.000000000 -0500
@@ -3769,7 +3769,7 @@
 	for (i = 0; i <= MAX_FC_CARDS; i++) 
 		fc[i] = NULL;
 
-	for (i = 0; i < clone_list[i].vendor_id != 0; i++)
+	for (i = 0; ((i < clone_list[i].vendor_id) && (clone_list[i].vendor_id != 0)); i++)
 	while ((pdev = pci_find_device(clone_list[i].vendor_id, clone_list[i].device_id, pdev))) {
 		unsigned short pci_command;
 		if (pci_enable_device(pdev))

