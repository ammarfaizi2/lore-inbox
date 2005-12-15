Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422633AbVLOJSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422633AbVLOJSI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 04:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422640AbVLOJSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 04:18:06 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:9386 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1422633AbVLOJRa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 04:17:30 -0500
To: torvalds@osdl.org
Subject: [PATCH] s2io: __iomem annotations for recent changes
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EmpEv-0007yR-Ug@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 15 Dec 2005 09:17:29 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>


---

 drivers/net/s2io.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

d213ae18301f7cd95eb39db8095aded5283e541e
diff --git a/drivers/net/s2io.c b/drivers/net/s2io.c
index e57df8d..669dd52 100644
--- a/drivers/net/s2io.c
+++ b/drivers/net/s2io.c
@@ -3078,7 +3078,7 @@ int s2io_set_swapper(nic_t * sp)
 
 static int wait_for_msix_trans(nic_t *nic, int i)
 {
-	XENA_dev_config_t *bar0 = (XENA_dev_config_t *) nic->bar0;
+	XENA_dev_config_t __iomem *bar0 = nic->bar0;
 	u64 val64;
 	int ret = 0, cnt = 0;
 
@@ -3099,7 +3099,7 @@ static int wait_for_msix_trans(nic_t *ni
 
 void restore_xmsi_data(nic_t *nic)
 {
-	XENA_dev_config_t *bar0 = (XENA_dev_config_t *) nic->bar0;
+	XENA_dev_config_t __iomem *bar0 = nic->bar0;
 	u64 val64;
 	int i;
 
@@ -3117,7 +3117,7 @@ void restore_xmsi_data(nic_t *nic)
 
 static void store_xmsi_data(nic_t *nic)
 {
-	XENA_dev_config_t *bar0 = (XENA_dev_config_t *) nic->bar0;
+	XENA_dev_config_t __iomem *bar0 = nic->bar0;
 	u64 val64, addr, data;
 	int i;
 
@@ -3140,7 +3140,7 @@ static void store_xmsi_data(nic_t *nic)
 
 int s2io_enable_msi(nic_t *nic)
 {
-	XENA_dev_config_t *bar0 = (XENA_dev_config_t *) nic->bar0;
+	XENA_dev_config_t __iomem *bar0 = nic->bar0;
 	u16 msi_ctrl, msg_val;
 	struct config_param *config = &nic->config;
 	struct net_device *dev = nic->dev;
@@ -3190,7 +3190,7 @@ int s2io_enable_msi(nic_t *nic)
 
 int s2io_enable_msi_x(nic_t *nic)
 {
-	XENA_dev_config_t *bar0 = (XENA_dev_config_t *) nic->bar0;
+	XENA_dev_config_t __iomem *bar0 = nic->bar0;
 	u64 tx_mat, rx_mat;
 	u16 msi_control; /* Temp variable */
 	int ret, i, j, msix_indx = 1;
-- 
0.99.9.GIT

