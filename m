Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964899AbVIIOOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbVIIOOU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 10:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964902AbVIIOOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 10:14:20 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:30942 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S964899AbVIIOOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 10:14:20 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: PATCH net-Kconfig-pocket_adapter-ISA-to-PARPORT
Date: Sat, 10 Sep 2005 00:14:05 +1000
Organization: http://bugsplatter.mine.nu/
Message-ID: <n063i1tj2s2nlqkkt9qb0c2effjpu0date@4ax.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,


This patch changes pocket and parallel adaptors to depend on PARPORT 
instead of ISA in order to get the option in newer SuperIO based systems.

Tested on x86 (AMD K7).  Also applies to 2.6.13-git8 cleanly.

Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 Kconfig |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.13-mm2/drivers/net/Kconfig	2005-09-09 23:18:28.000000000 +1000
+++ linux-2.6.13-mm2b/drivers/net/Kconfig	2005-09-09 23:58:46.000000000 +1000
@@ -1647,7 +1647,7 @@
 
 config NET_POCKET
 	bool "Pocket and portable adapters"
-	depends on NET_ETHERNET && ISA
+	depends on NET_ETHERNET && PARPORT
 	---help---
 	  Cute little network (Ethernet) devices which attach to the parallel
 	  port ("pocket adapters"), commonly used with laptops. If you have
@@ -1671,7 +1671,7 @@
 
 config ATP
 	tristate "AT-LAN-TEC/RealTek pocket adapter support"
-	depends on NET_POCKET && ISA && X86
+	depends on NET_POCKET && PARPORT && X86
 	select CRC32
 	---help---
 	  This is a network (Ethernet) device which attaches to your parallel
@@ -1686,7 +1686,7 @@
 
 config DE600
 	tristate "D-Link DE600 pocket adapter support"
-	depends on NET_POCKET && ISA
+	depends on NET_POCKET && PARPORT
 	---help---
 	  This is a network (Ethernet) device which attaches to your parallel
 	  port. Read <file:Documentation/networking/DLINK.txt> as well as the
@@ -1701,7 +1701,7 @@
 
 config DE620
 	tristate "D-Link DE620 pocket adapter support"
-	depends on NET_POCKET && ISA
+	depends on NET_POCKET && PARPORT
 	---help---
 	  This is a network (Ethernet) device which attaches to your parallel
 	  port. Read <file:Documentation/networking/DLINK.txt> as well as the
