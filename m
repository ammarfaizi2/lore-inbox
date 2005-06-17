Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261897AbVFQFXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbVFQFXs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 01:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261902AbVFQFXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 01:23:48 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:20621 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261897AbVFQFXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 01:23:45 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] via-rhine trivial whitespace patch
Date: Fri, 17 Jun 2005 08:23:17 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_F5lsC5eH1wGW5o9"
Message-Id: <200506170823.17305.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_F5lsC5eH1wGW5o9
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Jeff,

In some messages in via-rhine.c there is a leading space
for no apparent reason. This patch removes it.
--
vda

--Boundary-00=_F5lsC5eH1wGW5o9
Content-Type: text/x-diff;
  charset="koi8-r";
  name="via-rhine.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="via-rhine.c.diff"

--- linux-2.6.12-rc5.src/drivers/net/via-rhine.c.orig	Tue May 31 16:18:42 2005
+++ linux-2.6.12-rc5.src/drivers/net/via-rhine.c	Thu Jun 16 23:19:56 2005
@@ -1397,7 +1397,7 @@ static void rhine_tx(struct net_device *
 	while (rp->dirty_tx != rp->cur_tx) {
 		txstatus = le32_to_cpu(rp->tx_ring[entry].tx_status);
 		if (debug > 6)
-			printk(KERN_DEBUG " Tx scavenge %d status %8.8x.\n",
+			printk(KERN_DEBUG "Tx scavenge %d status %8.8x.\n",
 			       entry, txstatus);
 		if (txstatus & DescOwn)
 			break;
@@ -1468,7 +1468,7 @@ static void rhine_rx(struct net_device *
 		int data_size = desc_status >> 16;
 
 		if (debug > 4)
-			printk(KERN_DEBUG " rhine_rx() status is %8.8x.\n",
+			printk(KERN_DEBUG "rhine_rx() status is %8.8x.\n",
 			       desc_status);
 		if (--boguscnt < 0)
 			break;
@@ -1486,7 +1486,7 @@ static void rhine_rx(struct net_device *
 			} else if (desc_status & RxErr) {
 				/* There was a error. */
 				if (debug > 2)
-					printk(KERN_DEBUG " rhine_rx() Rx "
+					printk(KERN_DEBUG "rhine_rx() Rx "
 					       "error was %8.8x.\n",
 					       desc_status);
 				rp->stats.rx_errors++;

--Boundary-00=_F5lsC5eH1wGW5o9--

