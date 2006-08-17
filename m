Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbWHQHTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWHQHTx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 03:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWHQHTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 03:19:52 -0400
Received: from msr39.hinet.net ([168.95.4.139]:707 "EHLO msr39.hinet.net")
	by vger.kernel.org with ESMTP id S932111AbWHQHTv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 03:19:51 -0400
Subject: [PATCH 4/6] IP100A Change search phy addr start form 0
From: Jesse Huang <jesse@icplus.com.tw>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, akpm@osdl.org,
       jgarzik@pobox.com, jesse@icplus.com.tw
Content-Type: text/plain
Date: Thu, 17 Aug 2006 15:07:16 -0400
Message-Id: <1155841636.4532.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesse Huang <jesse@icplus.com.tw>

Change search phy addr start form 0

Change Logs:
    Change search phy addr start form 0

---

 drivers/net/sundance.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

212cd4ffa21a57300eae4254bf02e5b33b96f544
diff --git a/drivers/net/sundance.c b/drivers/net/sundance.c
index 2bde1b3..f63871a 100755
--- a/drivers/net/sundance.c
+++ b/drivers/net/sundance.c
@@ -21,7 +21,7 @@
 */
 
 #define DRV_NAME	"sundance"
-#define DRV_VERSION	"1.01+LK1.13"
+#define DRV_VERSION	"1.01+LK1.14"
 #define DRV_RELDATE	"04-Aug-2006"
 
 
@@ -559,8 +559,9 @@ #endif
 	/*
 	 * It seems some phys doesn't deal well with address 0 being accessed
 	 * first, so leave address zero to the end of the loop (32 & 31).
+	 * for IP100A the phy should start from 0
 	 */
-	for (phy = 1; phy <= 32 && phy_idx < MII_CNT; phy++) {
+	for (phy = 0; phy <= 32 && phy_idx < MII_CNT; phy++) {
 		int phyx = phy & 0x1f;
 		int mii_status = mdio_read(dev, phyx, MII_BMSR);
 		if (mii_status != 0xffff  &&  mii_status != 0x0000) {
-- 
1.3.GIT



