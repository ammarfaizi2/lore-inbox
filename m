Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270716AbTHOS1S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 14:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270700AbTHOSZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 14:25:49 -0400
Received: from mail.kroah.org ([65.200.24.183]:57986 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270703AbTHOSZc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 14:25:32 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10609719481470@kroah.com>
Subject: Re: [PATCH] Driver Core fixes for 2.6.0-test3
In-Reply-To: <10609719473549@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 15 Aug 2003 11:25:48 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1152.2.3, 2003/08/14 16:52:13-07:00, greg@kroah.com

Remove usage of struct device.name from ide core


 drivers/ide/ide-probe.c |    3 ---
 1 files changed, 3 deletions(-)


diff -Nru a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c	Fri Aug 15 11:16:05 2003
+++ b/drivers/ide/ide-probe.c	Fri Aug 15 11:16:05 2003
@@ -648,7 +648,6 @@
 {
 	/* register with global device tree */
 	strlcpy(hwif->gendev.bus_id,hwif->name,BUS_ID_SIZE);
-	snprintf(hwif->gendev.name,DEVICE_NAME_SIZE,"IDE Controller");
 	hwif->gendev.driver_data = hwif;
 	if (hwif->pci_dev)
 		hwif->gendev.parent = &hwif->pci_dev->dev;
@@ -1217,8 +1216,6 @@
 		ide_add_generic_settings(drive);
 		snprintf(drive->gendev.bus_id,BUS_ID_SIZE,"%u.%u",
 			 hwif->index,unit);
-		snprintf(drive->gendev.name,DEVICE_NAME_SIZE,
-			 "%s","IDE Drive");
 		drive->gendev.parent = &hwif->gendev;
 		drive->gendev.bus = &ide_bus_type;
 		drive->gendev.driver_data = drive;

