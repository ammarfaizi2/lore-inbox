Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267488AbTGOMMq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 08:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267451AbTGOMM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 08:12:28 -0400
Received: from mail.convergence.de ([212.84.236.4]:36768 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S267488AbTGOMGI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 08:06:08 -0400
Subject: [PATCH 10/17] Various kconfig and Makefile updates
In-Reply-To: <10582716562915@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Tue, 15 Jul 2003 14:20:57 +0200
Message-Id: <1058271657827@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold (LinuxTV.org CVS maintainer) 
	<hunold@convergence.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -uNrwB --new-file linux-2.6.0-test1.work/drivers/media/dvb/Kconfig linux-2.6.0-test1.patch/drivers/media/dvb/Kconfig
--- linux-2.6.0-test1.work/drivers/media/dvb/Kconfig	2003-07-15 09:42:37.000000000 +0200
+++ linux-2.6.0-test1.patch/drivers/media/dvb/Kconfig	2003-07-15 09:46:20.000000000 +0200
@@ -33,9 +33,19 @@
 source "drivers/media/dvb/frontends/Kconfig"
 
 comment "Supported SAA7146 based PCI Adapters"
-	depends on DVB
+	depends on DVB && PCI
 
 source "drivers/media/dvb/ttpci/Kconfig"
 
+comment "Supported USB Adapters"
+	depends on DVB && USB
+
+source "drivers/media/dvb/ttusb-budget/Kconfig"
+source "drivers/media/dvb/ttusb-dec/Kconfig"
+
+comment "Supported FlexCopII (B2C2) Adapters"
+	depends on DVB && PCI
+source "drivers/media/dvb/b2c2/Kconfig"
+
 endmenu
 
diff -uNrwB --new-file linux-2.6.0-test1.work/drivers/media/dvb/Makefile linux-2.6.0-test1.patch/drivers/media/dvb/Makefile
--- linux-2.6.0-test1.work/drivers/media/dvb/Makefile	2003-07-15 09:42:37.000000000 +0200
+++ linux-2.6.0-test1.patch/drivers/media/dvb/Makefile	2003-07-15 09:45:41.000000000 +0200
@@ -2,4 +2,5 @@
 # Makefile for the kernel multimedia device drivers.
 #
 
-obj-y        := dvb-core/ frontends/ ttpci/ # ttusb-budget/
+obj-y        := dvb-core/ frontends/ ttpci/ ttusb-dec/ ttusb-budget/ b2c2/
+

