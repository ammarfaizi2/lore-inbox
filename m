Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263350AbTDVSP5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 14:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263340AbTDVSOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 14:14:37 -0400
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:32264 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S263330AbTDVSO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 14:14:28 -0400
Date: Tue, 22 Apr 2003 10:57:54 -0500
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: [PATCH] C99 initializers for drivers/net/amd8111e.c
Message-ID: <20030422155754.GC7260@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This trivial patch converts the file to use C99 initializers. The patch
is against the current BK.

Art Haas

===== drivers/net/amd8111e.c 1.3 vs edited =====
--- 1.3/drivers/net/amd8111e.c	Mon Apr 21 00:41:09 2003
+++ edited/drivers/net/amd8111e.c	Tue Apr 22 10:04:23 2003
@@ -1632,12 +1632,12 @@
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
-- 
To announce that there must be no criticism of the President, or that we
are to stand by the President, right or wrong, is not only unpatriotic
and servile, but is morally treasonable to the American public.
 -- Theodore Roosevelt, Kansas City Star, 1918
