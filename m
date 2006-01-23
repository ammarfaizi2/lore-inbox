Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbWAWMBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWAWMBR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 07:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbWAWMBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 07:01:17 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:38822 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750805AbWAWMBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 07:01:16 -0500
Date: Mon, 23 Jan 2006 13:00:56 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Cornelia Huck <cohuck@de.ibm.com>
Subject: [PATCH 3/4] s390: Fix modalias for ccw devices.
Message-ID: <20060123120056.GE9241@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cohuck@de.ibm.com>

Fix modalias for ccw devices: cu_type should be in capitals as well.

Signed-off-by: Cornelia Huck <cohuck@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 drivers/s390/cio/device.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urpN linux-2.6/drivers/s390/cio/device.c linux-2.6-patched/drivers/s390/cio/device.c
--- linux-2.6/drivers/s390/cio/device.c	2006-01-23 10:05:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/device.c	2006-01-23 10:05:31.000000000 +0100
@@ -254,7 +254,7 @@ modalias_show (struct device *dev, struc
 	struct ccw_device_id *id = &(cdev->id);
 	int ret;
 
-	ret = sprintf(buf, "ccw:t%04Xm%02x",
+	ret = sprintf(buf, "ccw:t%04Xm%02X",
 			id->cu_type, id->cu_model);
 	if (id->dev_type != 0)
 		ret += sprintf(buf + ret, "dt%04Xdm%02X\n",
