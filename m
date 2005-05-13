Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262228AbVEMDxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbVEMDxD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 23:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262229AbVEMDxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 23:53:03 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:25869 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262228AbVEMDxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 23:53:00 -0400
Date: Fri, 13 May 2005 05:52:57 +0200
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] make MII no longer user visible
Message-ID: <20050513035257.GC3603@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MII is a classical example of a helper option no user should ever see.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc4-mm1-full/drivers/net/Kconfig.old	2005-05-13 05:47:58.000000000 +0200
+++ linux-2.6.12-rc4-mm1-full/drivers/net/Kconfig	2005-05-13 05:48:27.000000000 +0200
@@ -165,12 +165,8 @@
 	  the questions about Ethernet network cards. If unsure, say N.
 
 config MII
-	tristate "Generic Media Independent Interface device support"
+	tristate
 	depends on NET_ETHERNET
-	help
-	  Most ethernet controllers have MII transceiver either as an external
-	  or internal device.  It is safe to say Y or M here even if your
-	  ethernet card lack MII.
 
 source "drivers/net/arm/Kconfig"
 

