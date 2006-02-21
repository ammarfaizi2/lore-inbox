Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161411AbWBUGbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161411AbWBUGbu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 01:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161412AbWBUGbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 01:31:50 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:50157 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1161411AbWBUGbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 01:31:49 -0500
Message-ID: <43FAB330.2080701@jp.fujitsu.com>
Date: Tue, 21 Feb 2006 15:29:04 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       akpm@osdl.org, greg@kroah.com
CC: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, ak@suse.de,
       rmk+lkml@arm.linux.org.uk
Subject: [PATCH 2/6] PCI legacy I/O port free driver (take2) - Fix minor bug
 in store_new_id()
References: <43FAB283.8090206@jp.fujitsu.com>
In-Reply-To: <43FAB283.8090206@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes invalid use of sscanf() in store_new_id().

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

---
 drivers/pci/pci-driver.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.16-rc4/drivers/pci/pci-driver.c
===================================================================
--- linux-2.6.16-rc4.orig/drivers/pci/pci-driver.c	2006-02-21 14:40:46.000000000 +0900
+++ linux-2.6.16-rc4/drivers/pci/pci-driver.c	2006-02-21 14:40:55.000000000 +0900
@@ -47,7 +47,7 @@
 	unsigned long driver_data=0;
 	int fields=0;
 
-	fields = sscanf(buf, "%x %x %x %x %x %x %lux",
+	fields = sscanf(buf, "%x %x %x %x %x %x %lx",
 			&vendor, &device, &subvendor, &subdevice,
 			&class, &class_mask, &driver_data);
 	if (fields < 0)


