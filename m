Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbUKOReH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbUKOReH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 12:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbUKOReC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 12:34:02 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:42169 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261342AbUKORdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 12:33:39 -0500
Date: Mon, 15 Nov 2004 10:33:38 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH 2.6.10-rc2] ppc32: Fix Motorola Sandpoint builds
Message-ID: <20041115173338.GB2105@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Motorola Sandpoint builds broke recently, as part of the pci_find_device
-> pci_get_device change.  The following is the trivial fix.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

--- 1.28/arch/ppc/platforms/sandpoint.c	2004-11-15 09:19:42 -07:00
+++ edited/arch/ppc/platforms/sandpoint.c	2004-11-15 10:31:45 -07:00
@@ -584,7 +584,7 @@
 		sandpoint_ide_ctl_regbase[0]=pdev->resource[1].start;
 		sandpoint_ide_ctl_regbase[1]=pdev->resource[3].start;
 		sandpoint_idedma_regbase=pdev->resource[4].start;
-		pci_dev_put(dev);
+		pci_dev_put(pdev);
 	}
 
 	sandpoint_ide_ports_known = 1;

-- 
Tom Rini
http://gate.crashing.org/~trini/
