Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267770AbUHPQmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267770AbUHPQmX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 12:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267783AbUHPQmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 12:42:23 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:46547 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S267770AbUHPQmU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 12:42:20 -0400
Date: Mon, 16 Aug 2004 18:42:39 +0200
From: Cornelia Huck <kernel@cornelia-huck.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Patch 2.6] Add pci dependencies to drivers/media/dvb/ttpci/Kconfig
Message-Id: <20040816184239.42c27406@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The drivers under drivers/media/dvb/ttpci depend on pci (especially since
they select VIDEO_SAA7146, which depends on pci).

Signed-off-by: Cornelia Huck <kernel@cornelia-huck.de>

diff -u -r1.5 Kconfig
--- drivers/media/dvb/ttpci/Kconfig	4 Feb 2004 16:49:25 -0000	1.5
+++ drivers/media/dvb/ttpci/Kconfig	16 Aug 2004 15:25:39 -0000
@@ -1,6 +1,6 @@
 config DVB_AV7110
 	tristate "AV7110 cards"
-	depends on DVB_CORE
+	depends on DVB_CORE && PCI
 	select FW_LOADER
 	select VIDEO_DEV
 	select VIDEO_SAA7146_VV
@@ -45,7 +45,7 @@
 
 config DVB_BUDGET
 	tristate "Budget cards"
-	depends on DVB_CORE
+	depends on DVB_CORE && PCI
 	select VIDEO_SAA7146
 	help
 	  Support for simple SAA7146 based DVB cards
@@ -59,7 +59,7 @@
 
 config DVB_BUDGET_CI
 	tristate "Budget cards with onboard CI connector"
-	depends on DVB_CORE
+	depends on DVB_CORE && PCI
 	select VIDEO_SAA7146
 	help
 	  Support for simple SAA7146 based DVB cards
@@ -76,7 +76,7 @@
 
 config DVB_BUDGET_AV
 	tristate "Budget cards with analog video inputs"
-	depends on DVB_CORE
+	depends on DVB_CORE && PCI
 	select VIDEO_DEV
 	select VIDEO_SAA7146_VV
 	help
