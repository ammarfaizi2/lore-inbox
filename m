Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbVJ2Fgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbVJ2Fgb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 01:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbVJ2Fgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 01:36:31 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:8361 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750992AbVJ2Fgb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 01:36:31 -0400
Date: Sat, 29 Oct 2005 06:36:27 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] s2io iomem annotations
Message-ID: <20051029053627.GX7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-base/drivers/net/s2io.c current/drivers/net/s2io.c
--- RC14-base/drivers/net/s2io.c	2005-10-28 18:17:09.000000000 -0400
+++ current/drivers/net/s2io.c	2005-10-28 22:27:05.000000000 -0400
@@ -3045,7 +3045,7 @@
 
 int wait_for_msix_trans(nic_t *nic, int i)
 {
-	XENA_dev_config_t *bar0 = (XENA_dev_config_t *) nic->bar0;
+	XENA_dev_config_t __iomem *bar0 = nic->bar0;
 	u64 val64;
 	int ret = 0, cnt = 0;
 
@@ -3066,7 +3066,7 @@
 
 void restore_xmsi_data(nic_t *nic)
 {
-	XENA_dev_config_t *bar0 = (XENA_dev_config_t *) nic->bar0;
+	XENA_dev_config_t __iomem *bar0 = nic->bar0;
 	u64 val64;
 	int i;
 
@@ -3084,7 +3084,7 @@
 
 void store_xmsi_data(nic_t *nic)
 {
-	XENA_dev_config_t *bar0 = (XENA_dev_config_t *) nic->bar0;
+	XENA_dev_config_t __iomem *bar0 = nic->bar0;
 	u64 val64, addr, data;
 	int i;
 
@@ -3107,7 +3107,7 @@
 
 int s2io_enable_msi(nic_t *nic)
 {
-	XENA_dev_config_t *bar0 = (XENA_dev_config_t *) nic->bar0;
+	XENA_dev_config_t __iomem *bar0 = nic->bar0;
 	u16 msi_ctrl, msg_val;
 	struct config_param *config = &nic->config;
 	struct net_device *dev = nic->dev;
@@ -3157,7 +3157,7 @@
 
 int s2io_enable_msi_x(nic_t *nic)
 {
-	XENA_dev_config_t *bar0 = (XENA_dev_config_t *) nic->bar0;
+	XENA_dev_config_t __iomem *bar0 = nic->bar0;
 	u64 tx_mat, rx_mat;
 	u16 msi_control; /* Temp variable */
 	int ret, i, j, msix_indx = 1;
