Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbUA0ETR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 23:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbUA0ETR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 23:19:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:2018 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262360AbUA0ETP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 23:19:15 -0500
Date: Mon, 26 Jan 2004 20:19:12 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: schwidefsky@de.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: More exports for dasd in 2.6
Message-Id: <20040126201912.3f5875ad.zaitcev@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin,

here's a little patch to add two more exports, based on my tests.

-- Pete

diff -ur -X dontdiff linux-2.6.1-1.144/drivers/s390/block/dasd.c linux-2.6.1-1.144.z1/drivers/s390/block/dasd.c
--- linux-2.6.1-1.144/drivers/s390/block/dasd.c	2004-01-21 11:22:51.000000000 -0500
+++ linux-2.6.1-1.144.z1/drivers/s390/block/dasd.c	2004-01-23 11:37:06.000000000 -0500
@@ -1982,6 +1982,7 @@
 EXPORT_SYMBOL_GPL(dasd_generic_remove);
 EXPORT_SYMBOL_GPL(dasd_generic_set_online);
 EXPORT_SYMBOL_GPL(dasd_generic_set_offline);
+EXPORT_SYMBOL_GPL(dasd_generic_notify);
 EXPORT_SYMBOL_GPL(dasd_generic_auto_online);
 
 /*
diff -ur -X dontdiff linux-2.6.1-1.144/drivers/s390/cio/device.c linux-2.6.1-1.144.z1/drivers/s390/cio/device.c
--- linux-2.6.1-1.144/drivers/s390/cio/device.c	2004-01-21 11:22:51.000000000 -0500
+++ linux-2.6.1-1.144.z1/drivers/s390/cio/device.c	2004-01-23 11:39:53.000000000 -0500
@@ -908,3 +908,4 @@
 EXPORT_SYMBOL(ccw_driver_unregister);
 EXPORT_SYMBOL(get_ccwdev_by_busid);
 EXPORT_SYMBOL(ccw_bus_type);
+EXPORT_SYMBOL(ccw_device_work);
