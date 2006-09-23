Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964973AbWIWAcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964973AbWIWAcm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 20:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964976AbWIWAcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 20:32:41 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:8371 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964973AbWIWAcl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 20:32:41 -0400
Date: Sat, 23 Sep 2006 01:32:40 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] restore __iomem annotations in e1000
Message-ID: <20060923003240.GF29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/net/e1000/e1000_hw.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/e1000/e1000_hw.h b/drivers/net/e1000/e1000_hw.h
index 375b955..a7e3a82 100644
--- a/drivers/net/e1000/e1000_hw.h
+++ b/drivers/net/e1000/e1000_hw.h
@@ -1365,8 +1365,8 @@ struct e1000_hw_stats {
 
 /* Structure containing variables used by the shared code (e1000_hw.c) */
 struct e1000_hw {
-    uint8_t *hw_addr;
-    uint8_t *flash_address;
+    uint8_t __iomem *hw_addr;
+    uint8_t __iomem *flash_address;
     e1000_mac_type mac_type;
     e1000_phy_type phy_type;
     uint32_t phy_init_script;
-- 
1.4.2.GIT
