Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753372AbWKCQr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753372AbWKCQr5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 11:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753371AbWKCQr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 11:47:57 -0500
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:2015 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1753369AbWKCQr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 11:47:56 -0500
From: Thomas Klein <osstklei@de.ibm.com>
Subject: [PATCH 2.6.19-rc4 2/3] ehea: Removed redundant define
Date: Fri, 3 Nov 2006 17:47:52 +0100
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 1288
To: Jeff Garzik <jeff@garzik.org>
Cc: Christoph Raisch <raisch@de.ibm.com>,
       "Jan-Bernd Themann" <ossthema@de.ibm.com>,
       "Jan-Bernd Themann" <themann@de.ibm.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "linux-ppc" <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>,
       netdev <netdev@vger.kernel.org>, Thomas Klein <tklein@de.ibm.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200611031747.52210.osstklei@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removed define H_CB_ALIGNMENT which is already defined in include/asm-powerpc/hvcall.h

Signed-off-by: Thomas Klein <tklein@de.ibm.com>
---

diff -Nurp git.netdev-2.6.base/drivers/net/ehea/ehea.h git.netdev-2.6/drivers/net/ehea/ehea.h
--- git.netdev-2.6.base/drivers/net/ehea/ehea.h	2006-11-03 14:19:51.000000000 +0100
+++ git.netdev-2.6/drivers/net/ehea/ehea.h	2006-11-03 14:37:30.000000000 +0100
@@ -39,7 +39,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"ehea"
-#define DRV_VERSION	"EHEA_0034"
+#define DRV_VERSION	"EHEA_0043"
 
 #define EHEA_MSG_DEFAULT (NETIF_MSG_LINK | NETIF_MSG_TIMER \
 	| NETIF_MSG_RX_ERR | NETIF_MSG_TX_ERR)
@@ -105,9 +105,6 @@
 #define EHEA_BCMC_VLANID_ALL	0x01
 #define EHEA_BCMC_VLANID_SINGLE	0x00
 
-/* Use this define to kmallocate pHYP control blocks */
-#define H_CB_ALIGNMENT		4096
-
 #define EHEA_CACHE_LINE          128
 
 /* Memory Regions */
