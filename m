Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030302AbWBHDXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030302AbWBHDXA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 22:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030499AbWBHDT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 22:19:57 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:3201 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030494AbWBHDTr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 22:19:47 -0500
To: torvalds@osdl.org
Subject: [PATCH 23/29] bogus extern in low_i2c.c
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Message-Id: <E1F6frv-0006Ds-5Y@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 03:19:47 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1138796714 -0500

extern in function definition is an odd thing..

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/powerpc/platforms/powermac/low_i2c.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

1d0bd717c86949e97a11855482b4a118029c10a9
diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
index 535c802..87eb6bb 100644
--- a/arch/powerpc/platforms/powermac/low_i2c.c
+++ b/arch/powerpc/platforms/powermac/low_i2c.c
@@ -1052,8 +1052,7 @@ struct pmac_i2c_bus *pmac_i2c_adapter_to
 }
 EXPORT_SYMBOL_GPL(pmac_i2c_adapter_to_bus);
 
-extern int pmac_i2c_match_adapter(struct device_node *dev,
-				  struct i2c_adapter *adapter)
+int pmac_i2c_match_adapter(struct device_node *dev, struct i2c_adapter *adapter)
 {
 	struct pmac_i2c_bus *bus = pmac_i2c_find_bus(dev);
 
-- 
0.99.9.GIT

