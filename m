Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266275AbUHNXBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266275AbUHNXBk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 19:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266137AbUHNXBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 19:01:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:62145 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266275AbUHNXA5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 19:00:57 -0400
Date: Sat, 14 Aug 2004 16:00:55 -0700
From: Chris Wright <chrisw@osdl.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: bunk@fs.tum.de, linux-kernel@vger.kernel.org
Subject: [PATCH] small simplification for two SECURITY dependencies
Message-ID: <20040814160055.B1924@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd suggest the patch below to let the SECURITY_CAPABILITIES and 
SECURITY_ROOTPLUG dependencies look a bit more simple.

Signed-off-by: Adrian Bunk <bunk@fs.tum.de>
Signed-off-by: Chris Wright <chrisw@osdl.org>

===== security/Kconfig 1.7 vs edited =====
--- 1.7/security/Kconfig	2003-07-17 02:38:01 -07:00
+++ edited/security/Kconfig	2004-08-13 11:32:20 -07:00
@@ -26,14 +26,14 @@
 
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
