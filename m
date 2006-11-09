Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965326AbWKIUAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965326AbWKIUAL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 15:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965511AbWKIUAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 15:00:11 -0500
Received: from mta13.adelphia.net ([68.168.78.44]:36793 "EHLO
	mta13.adelphia.net") by vger.kernel.org with ESMTP id S965326AbWKIUAJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 15:00:09 -0500
Date: Thu, 9 Nov 2006 14:02:31 -0600
From: Corey Minyard <minyard@acm.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Cc: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH] IPMI: Fix more && typos
Message-ID: <20061109200231.GA8446@localdomain>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix improper use of "&&" when "&" was intended.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Corey Minyard <minyard@acm.org>

---
 drivers/char/ipmi/ipmi_msghandler.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.19-rc5.orig/drivers/char/ipmi/ipmi_msghandler.c	2006-11-09 18:43:18.000000000 +0100
+++ linux-2.6.19-rc5/drivers/char/ipmi/ipmi_msghandler.c	2006-11-09 18:44:01.000000000 +0100
@@ -1854,7 +1854,7 @@
 	struct bmc_device *bmc = dev_get_drvdata(dev);
 
 	return snprintf(buf, 10, "%u\n",
-			bmc->id.device_revision && 0x80 >> 7);
+			(bmc->id.device_revision & 0x80) >> 7);
 }
 
 static ssize_t revision_show(struct device *dev, struct device_attribute *attr,
@@ -1863,7 +1863,7 @@
 	struct bmc_device *bmc = dev_get_drvdata(dev);
 
 	return snprintf(buf, 20, "%u\n",
-			bmc->id.device_revision && 0x0F);
+			bmc->id.device_revision & 0x0F);
 }
 
 static ssize_t firmware_rev_show(struct device *dev,
