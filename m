Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751300AbWJKNey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbWJKNey (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 09:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbWJKNey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 09:34:54 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:59928 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751300AbWJKNex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 09:34:53 -0400
Date: Wed, 11 Oct 2006 15:34:57 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, cornelia.huck@de.ibm.com
Subject: [S390] cio: add missing KERN_INFO printk header.
Message-ID: <20061011133457.GB9305@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

[S390] cio: add missing KERN_INFO printk header.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device_fsm.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/drivers/s390/cio/device_fsm.c linux-2.6-patched/drivers/s390/cio/device_fsm.c
--- linux-2.6/drivers/s390/cio/device_fsm.c	2006-10-11 15:23:22.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device_fsm.c	2006-10-11 15:23:35.000000000 +0200
@@ -885,7 +885,8 @@ ccw_device_w4sense(struct ccw_device *cd
 			/* Basic sense hasn't started. Try again. */
 			ccw_device_do_sense(cdev, irb);
 		else {
-			printk("Huh? %s(%s): unsolicited interrupt...\n",
+			printk(KERN_INFO "Huh? %s(%s): unsolicited "
+			       "interrupt...\n",
 			       __FUNCTION__, cdev->dev.bus_id);
 			if (cdev->handler)
 				cdev->handler (cdev, 0, irb);
