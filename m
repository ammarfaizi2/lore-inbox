Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272612AbTHKOGi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 10:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272615AbTHKNmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 09:42:42 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:37515 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272612AbTHKNk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 09:40:58 -0400
To: torvalds@transmeta.com
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org, jgarzik@redhat.com
Subject: [PATCH] c99 struct initialisers for AMD8111e driver.
Message-Id: <E19mCuQ-0003ds-00@tetrachloride>
Date: Mon, 11 Aug 2003 14:40:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/net/amd8111e.c linux-2.5/drivers/net/amd8111e.c
--- bk-linus/drivers/net/amd8111e.c	2003-08-04 01:00:26.000000000 +0100
+++ linux-2.5/drivers/net/amd8111e.c	2003-08-06 18:59:37.000000000 +0100
@@ -1940,12 +1940,12 @@ err_disable_pdev:
 }
 
 static struct pci_driver amd8111e_driver = {
-	name:		MODULE_NAME,
-	id_table:	amd8111e_pci_tbl,
-	probe:		amd8111e_probe_one,
-	remove:		__devexit_p(amd8111e_remove_one),
-	suspend:	amd8111e_suspend,
-	resume:		amd8111e_resume
+	.name		= MODULE_NAME,
+	.id_table	= amd8111e_pci_tbl,
+	.probe		= amd8111e_probe_one,
+	.remove		= __devexit_p(amd8111e_remove_one),
+	.suspend	= amd8111e_suspend,
+	.resume		= amd8111e_resume
 };
 
 static int __init amd8111e_init(void)
