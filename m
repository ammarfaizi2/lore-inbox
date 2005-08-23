Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbVHWVnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbVHWVnr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbVHWVnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:43:46 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6326 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932422AbVHWVnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:43:43 -0400
To: torvalds@osdl.org
Subject: [PATCH] (24/43) Kconfig fix (emac dependencient)
Cc: linux-kernel@vger.kernel.org, mporter@kernel.crashing.org
Message-Id: <E1E7gbW-0007CI-SL@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Tue, 23 Aug 2005 22:46:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

emac doesn't build modular; ibm_emac_debug doesn't build at all (missing
headers).

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc6-git13-44x-PM/drivers/net/Kconfig RC13-rc6-git13-emac/drivers/net/Kconfig
--- RC13-rc6-git13-44x-PM/drivers/net/Kconfig	2005-08-21 13:16:55.000000000 -0400
+++ RC13-rc6-git13-emac/drivers/net/Kconfig	2005-08-21 13:17:06.000000000 -0400
@@ -1145,7 +1145,7 @@
 	  be called ibmveth.
 
 config IBM_EMAC
-	tristate "IBM PPC4xx EMAC driver support"
+	bool "IBM PPC4xx EMAC driver support"
 	depends on 4xx
 	select CRC32
 	---help---
@@ -1154,7 +1154,7 @@
 
 config IBM_EMAC_ERRMSG
 	bool "Verbose error messages"
-	depends on IBM_EMAC
+	depends on IBM_EMAC && BROKEN
 
 config IBM_EMAC_RXB
 	int "Number of receive buffers"
