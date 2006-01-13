Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422896AbWAMT5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422896AbWAMT5x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 14:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422880AbWAMTub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 14:50:31 -0500
Received: from mail.kroah.org ([69.55.234.183]:40084 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422870AbWAMTu2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:50:28 -0500
Cc: rmk@arm.linux.org.uk
Subject: [PATCH] Add Pseudo LLD bus_type probe and remove methods
In-Reply-To: <11371818121788@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 13 Jan 2006 11:50:12 -0800
Message-Id: <1137181812570@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Add Pseudo LLD bus_type probe and remove methods

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit bbbe3a41f7ee529f7f4fdcc1bc1157234bac0766
tree a1915bb813d98f68d231d19e762c57d6ddd52e5e
parent fc3d3ddd3e628d9f22d4aa56a640d0b31c977a8f
author Russell King <rmk@arm.linux.org.uk> Thu, 05 Jan 2006 14:44:46 +0000
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 13 Jan 2006 11:26:10 -0800

 drivers/scsi/scsi_debug.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 3ded9da..0e529f8 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
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

