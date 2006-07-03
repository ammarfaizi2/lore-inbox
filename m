Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbWGCUqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbWGCUqK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 16:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbWGCUqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 16:46:09 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:26291 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S932091AbWGCUqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 16:46:01 -0400
Message-ID: <44A9826C.90202@oracle.com>
Date: Mon, 03 Jul 2006 13:47:40 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: akpm <akpm@osdl.org>, mhw@wittsend.com
Subject: [Ubuntu PATCH] Add Computone IntelliPort Plus serial hotplug support
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch Description:
Add "Computone IntelliPort Plus serial" hotplug support

patch location:
http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commitdiff;h=8c36723187c0fa5efe0e5c6a9b1e66ed4b824792

---
 drivers/char/ip2/ip2main.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- linux-2617-g21.orig/drivers/char/ip2/ip2main.c
+++ linux-2617-g21/drivers/char/ip2/ip2main.c
@@ -3186,3 +3186,11 @@ ip2trace (unsigned short pn, unsigned ch
 
 
 MODULE_LICENSE("GPL");
+
+static struct pci_device_id ip2main_pci_tbl[] __devinitdata = {
+	{ PCI_VENDOR_ID_COMPUTONE, PCI_DEVICE_ID_COMPUTONE_IP2EX,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ }
+};
+
+MODULE_DEVICE_TABLE(pci, ip2main_pci_tbl);



