Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbWISPNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbWISPNd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 11:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWISPNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 11:13:33 -0400
Received: from server6.greatnet.de ([83.133.96.26]:58515 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP
	id S1750832AbWISPNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 11:13:32 -0400
Message-ID: <4510092A.6060408@nachtwindheim.de>
Date: Tue, 19 Sep 2006 17:13:46 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [MM] scsi: included header cleanup
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henrik Kretzschmar <henne@nachtwindheim.de>

Free seagate.h from obsolete drivers/scsi.h, remove a double inclusion
od linux/delay.h and remove the unneeded scsi/scsi_ioctl.h

Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---

--- linux-2.6.18-rc7-mm1/drivers/scsi/seagate.c	2006-09-19 17:01:38.000000000 +0200
+++ devel/drivers/scsi/seagate.c	2006-09-19 16:58:53.000000000 +0200
@@ -94,7 +94,6 @@
 #include <linux/string.h>
 #include <linux/proc_fs.h>
 #include <linux/init.h>
-#include <linux/delay.h>
 #include <linux/blkdev.h>
 #include <linux/stat.h>
 #include <linux/delay.h>
@@ -103,11 +102,13 @@
 #include <asm/system.h>
 #include <asm/uaccess.h>
 
-#include "scsi.h"
+#include <scsi/scsi_cmnd.h>
+#include <scsi/scsi_device.h>
+#include <scsi/scsi.h>
+
 #include <scsi/scsi_dbg.h>
 #include <scsi/scsi_host.h>
 
-#include <scsi/scsi_ioctl.h>
 
 #ifdef DEBUG
 #define DPRINTK( when, msg... ) do { if ( (DEBUG & (when)) == (when) ) printk( msg ); } while (0)


