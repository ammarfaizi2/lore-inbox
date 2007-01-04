Return-Path: <linux-kernel-owner+w=401wt.eu-S1750955AbXADSxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbXADSxI (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 13:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbXADSxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 13:53:08 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2902 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750955AbXADSxE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 13:53:04 -0500
Date: Thu, 4 Jan 2007 19:53:07 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jdike@karaya.com
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove duplicate MMAPPER Kconfig option
Message-ID: <20070104185307.GE20714@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This option is already in arch/um/Kconfig.char

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.20-rc2-mm1/drivers/block/Kconfig.old	2007-01-04 17:43:51.000000000 +0100
+++ linux-2.6.20-rc2-mm1/drivers/block/Kconfig	2007-01-04 17:44:19.000000000 +0100
@@ -236,23 +236,6 @@
 	bool
 	default BLK_DEV_UBD
 
-config MMAPPER
-	tristate "Example IO memory driver (BROKEN)"
-	depends on UML && BROKEN
-	---help---
-          The User-Mode Linux port can provide support for IO Memory
-          emulation with this option.  This allows a host file to be
-          specified as an I/O region on the kernel command line. That file
-          will be mapped into UML's kernel address space where a driver can
-          locate it and do whatever it wants with the memory, including
-          providing an interface to it for UML processes to use.
-
-          For more information, see
-          <http://user-mode-linux.sourceforge.net/iomem.html>.
-
-          If you'd like to be able to provide a simulated IO port space for
-          User-Mode Linux processes, say Y.  If unsure, say N.
-
 config BLK_DEV_LOOP
 	tristate "Loopback device support"
 	---help---

