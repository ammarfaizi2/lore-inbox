Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbWAVUHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbWAVUHz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 15:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbWAVUHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 15:07:54 -0500
Received: from xenotime.net ([66.160.160.81]:43170 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751331AbWAVUHy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 15:07:54 -0500
Date: Sun, 22 Jan 2006 12:07:57 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: dthompson@linuxnetworx.com, akpm <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] edac: use C99 initializers (sparse warnings)
Message-Id: <20060122120757.6632eb54.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

fix sparse warnings:
drivers/edac/e752x_edac.c:1042:7: warning: obsolete struct initializer, use C99 syntax

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/edac/e752x_edac.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

--- linux-2616-rc1g4.orig/drivers/edac/e752x_edac.c
+++ linux-2616-rc1g4/drivers/edac/e752x_edac.c
@@ -1039,10 +1039,10 @@ MODULE_DEVICE_TABLE(pci, e752x_pci_tbl);
 
 
 static struct pci_driver e752x_driver = {
-      name: BS_MOD_STR,
-      probe: e752x_init_one,
-      remove: __devexit_p(e752x_remove_one),
-      id_table: e752x_pci_tbl,
+	.name = BS_MOD_STR,
+	.probe = e752x_init_one,
+	.remove = __devexit_p(e752x_remove_one),
+	.id_table = e752x_pci_tbl,
 };
 
 


---
