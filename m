Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751386AbWAEOox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbWAEOox (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWAEOow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:44:52 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:26636 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751386AbWAEOov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:44:51 -0500
To: LKML <linux-kernel@vger.kernel.org>
CC: Greg K-H <greg@kroah.com>, SCSI <linux-scsi@vger.kernel.org>
Subject: [CFT 29/29] Add Pseudo LLD bus_type probe and remove methods
Date: Thu, 05 Jan 2006 14:44:46 +0000
Message-ID: <20060105142951.13.29@flint.arm.linux.org.uk>
In-reply-to: <20060105142951.13.01@flint.arm.linux.org.uk>
References: <20060105142951.13.01@flint.arm.linux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

---
 drivers/scsi/scsi_debug.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej -x .git linus/drivers/scsi/scsi_debug.c linux/drivers/scsi/scsi_debug.c
--- linus/drivers/scsi/scsi_debug.c	Sat Nov 12 07:32:38 2005
+++ linux/drivers/scsi/scsi_debug.c	Sun Nov 13 16:45:02 2005
@@ -221,8 +221,6 @@ static struct bus_type pseudo_lld_bus;
 static struct device_driver sdebug_driverfs_driver = {
 	.name 		= sdebug_proc_name,
 	.bus		= &pseudo_lld_bus,
-	.probe          = sdebug_driver_probe,
-	.remove         = sdebug_driver_remove,
 };
 
 static const int check_condition_result =
@@ -1796,6 +1794,8 @@ static int pseudo_lld_bus_match(struct d
 static struct bus_type pseudo_lld_bus = {
         .name = "pseudo",
         .match = pseudo_lld_bus_match,
+	.probe = sdebug_driver_probe,
+	.remove = sdebug_driver_remove,
 };
 
 static void sdebug_release_adapter(struct device * dev)
