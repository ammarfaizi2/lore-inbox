Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263595AbTEDNtK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 09:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263597AbTEDNtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 09:49:10 -0400
Received: from sol.cc.u-szeged.hu ([160.114.8.24]:12538 "EHLO
	sol.cc.u-szeged.hu") by vger.kernel.org with ESMTP id S263595AbTEDNtJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 09:49:09 -0400
Date: Sun, 4 May 2003 16:01:38 +0200 (CEST)
From: Geller Sandor <wildy@petra.hos.u-szeged.hu>
To: linux-kernel@vger.kernel.org
cc: alan@redhat.com
Subject: compile fix for IBM PCI hotplug driver (linux 2.4.21rc1-ac4)
Message-ID: <Pine.LNX.4.44.0305041555310.14568-100000@petra.hos.u-szeged.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A small fix for the IBM PCI hotplug driver.

--- ibmphp_ebda.c.orig	Sun May  4 15:35:42 2003
+++ ibmphp_ebda.c	Sun May  4 15:54:04 2003
@@ -754,7 +754,7 @@
 	struct ebda_hpc_slot *slot_ptr;
 	struct bus_info *bus_info_ptr1, *bus_info_ptr2;
 	int rc;
-	struct slot *tmp_slot;
+	struct slot *slot_cur, *tmp_slot;
 	struct list_head *list;
 	char buf[32];

@@ -992,7 +992,7 @@
 		slot_cur = list_entry (list, struct slot, ibm_slot_list);
 		if(create_file_name (slot_cur, buf)==0)
 		{
-			snprintf (slot_cur->hotplug_slot->name, 30, "%s", );
+			snprintf (slot_cur->hotplug_slot->name, 30, "%s" );
 			pci_hp_register (slot_cur->hotplug_slot);
 		}
 	}

