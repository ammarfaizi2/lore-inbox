Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268810AbUHLVU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268810AbUHLVU1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 17:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268800AbUHLVUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 17:20:19 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:4323 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268806AbUHLVTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 17:19:25 -0400
Date: Thu, 12 Aug 2004 23:19:17 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: chrisw@osdl.org
Cc: linux-security-module@wirex.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] small simplification for two SECURITY dependencies
Message-ID: <20040812211916.GO13377@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'd suggest the patch below to let the SECURITY_CAPABILITIES and 
SECURITY_ROOTPLUG dependencies look a bit more simple.


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.8-rc4-mm1-full-3.4/security/Kconfig.old	2004-08-12 23:16:17.000000000 +0200
+++ linux-2.6.8-rc4-mm1-full-3.4/security/Kconfig	2004-08-12 23:16:34.000000000 +0200
@@ -43,14 +43,14 @@
 
 config SECURITY_CAPABILITIES
 	tristate "Default Linux Capabilities"
-	depends on SECURITY!=n
+	depends on SECURITY
 	help
 	  This enables the "default" Linux capabilities functionality.
 	  If you are unsure how to answer this question, answer Y.
 
 config SECURITY_ROOTPLUG
 	tristate "Root Plug Support"
-	depends on USB && SECURITY!=n
+	depends on USB && SECURITY
 	help
 	  This is a sample LSM module that should only be used as such.
 	  It prevents any programs running with egid == 0 if a specific

