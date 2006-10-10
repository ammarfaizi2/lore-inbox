Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030522AbWJJVsB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030522AbWJJVsB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030496AbWJJVre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:47:34 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:26811 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030516AbWJJVrS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:47:18 -0400
To: torvalds@osdl.org
Subject: [PATCH] acpi NULL noise removal
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXPRV-0007Nt-BT@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 22:47:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/acpi/cm_sbs.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/cm_sbs.c b/drivers/acpi/cm_sbs.c
index a01ce67..4a9b7bf 100644
--- a/drivers/acpi/cm_sbs.c
+++ b/drivers/acpi/cm_sbs.c
@@ -67,7 +67,7 @@ void acpi_unlock_ac_dir(struct proc_dir_
 		lock_ac_dir_cnt--;
 	if (lock_ac_dir_cnt == 0 && acpi_ac_dir_param && acpi_ac_dir) {
 		remove_proc_entry(ACPI_AC_CLASS, acpi_root_dir);
-		acpi_ac_dir = 0;
+		acpi_ac_dir = NULL;
 	}
 	mutex_unlock(&cm_sbs_mutex);
 }
@@ -99,7 +99,7 @@ void acpi_unlock_battery_dir(struct proc
 	if (lock_battery_dir_cnt == 0 && acpi_battery_dir_param
 	    && acpi_battery_dir) {
 		remove_proc_entry(ACPI_BATTERY_CLASS, acpi_root_dir);
-		acpi_battery_dir = 0;
+		acpi_battery_dir = NULL;
 	}
 	mutex_unlock(&cm_sbs_mutex);
 	return;
-- 
1.4.2.GIT


