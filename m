Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262403AbTD3UD7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 16:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbTD3UD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 16:03:59 -0400
Received: from muss.CIS.mcmaster.ca ([130.113.64.9]:44728 "EHLO
	cgpsrv1.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S262403AbTD3UD6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 16:03:58 -0400
From: Gabriel Devenyi <devenyga@mcmaster.ca>
To: hermes@gibson.dropbear.id.au
Subject: [PATCH] Linux 2.5.68 - Fix debug statement after return in devices/net/wireless/arlan.c
Date: Thu, 1 May 2003 16:13:33 -0400
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200305011613.34078.devenyga@mcmaster.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This patch applies to 2.5.68 and is listed on kbugs.org. The debug statement is never executed becasue it is after a return.

Please CC me with any discussion.
- -- 
Building the Future,
Gabriel Devenyi
devenyga@mcmaster.ca

- ---FILE---

- --- linux-2.5.68/drivers/net/wireless/arlan.c	2003-04-19 22:50:06.000000000 -0400
+++ linux-2.5.68-changed/drivers/net/wireless/arlan.c	2003-05-01 15:07:06.000000000 -0400
@@ -798,9 +798,9 @@
 	else
 	{
 		netif_stop_queue (dev);
- -		return -1;
 		IFDEBUG(ARLAN_DEBUG_TX_CHAIN)
 			printk(KERN_ERR "TX TAIL & HEAD full, return, tailStart %d headEnd %d\n", tailStarts, headEnds);
+		return -1;
 	}
 	priv->out_bytes += length;
 	priv->out_bytes10 += length;

- ---ENDFILE---
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+sX/t7I5UBdiZaF4RAqcIAJ9DX4cjmRq7qym+xqOufQ9qctMN4ACeJyIg
bB90sFAXAQrwY7SxIzosFaM=
=QDal
-----END PGP SIGNATURE-----

