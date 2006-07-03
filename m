Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbWGCUqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbWGCUqT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 16:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWGCUqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 16:46:15 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:50099 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751286AbWGCUqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 16:46:09 -0400
Message-ID: <44A98274.2010904@oracle.com>
Date: Mon, 03 Jul 2006 13:47:48 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: akpm <akpm@osdl.org>, R.E.Wolff@BitWizard.nl
Subject: [Ubuntu PATCH] Add Specialix IO8+ card support hotplug support
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch Description:
Add "Specialix IO8+ card support" hotplug support

patch location:
http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commitdiff;h=d795cfc591bb44f6b3d86d8f054a227cecb44bb4

---
 drivers/char/specialix.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- linux-2617-g21.orig/drivers/char/specialix.c
+++ linux-2617-g21/drivers/char/specialix.c
@@ -2584,6 +2584,13 @@ static void __exit specialix_exit_module
 	func_exit();
 }
 
+static struct pci_device_id specialx_pci_tbl[] __devinitdata = {
+	{ PCI_VENDOR_ID_SPECIALIX, PCI_DEVICE_ID_SPECIALIX_IO8,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, specialx_pci_tbl);
+
 module_init(specialix_init_module);
 module_exit(specialix_exit_module);
 

