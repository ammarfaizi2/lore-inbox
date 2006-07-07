Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbWGGVwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbWGGVwR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 17:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWGGVwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 17:52:17 -0400
Received: from mga03.intel.com ([143.182.124.21]:50022 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932325AbWGGVwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 17:52:15 -0400
X-IronPort-AV: i="4.06,218,1149490800"; 
   d="scan'208"; a="62839902:sNHT19368391"
Subject: [patch] acpi: init dock notifier list
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: linux-acpi@vger.kernel.org
Cc: len.brown@intel.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 07 Jul 2006 15:06:27 -0700
Message-Id: <1152309987.8695.24.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
X-OriginalArrivalTime: 07 Jul 2006 21:52:13.0346 (UTC) FILETIME=[9AE3B020:01C6A20F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize the atomic notifier list

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

---
 drivers/acpi/dock.c |    1 +
 1 file changed, 1 insertion(+)

--- 2.6-mm.orig/drivers/acpi/dock.c
+++ 2.6-mm/drivers/acpi/dock.c
@@ -627,6 +627,7 @@ static int dock_add(acpi_handle handle)
 	INIT_LIST_HEAD(&dock_station->hotplug_devices);
 	spin_lock_init(&dock_station->dd_lock);
 	spin_lock_init(&dock_station->hp_lock);
+	ATOMIC_INIT_NOTIFIER_HEAD(&dock_notifier_list);
 
 	/* Find dependent devices */
 	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
