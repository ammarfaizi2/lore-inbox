Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750883AbVICLyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbVICLyq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 07:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbVICLyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 07:54:46 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:50193 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750879AbVICLyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 07:54:45 -0400
Date: Sat, 3 Sep 2005 13:54:30 +0200
From: Adrian Bunk <bunk@stusta.de>
To: "Brown, Len" <len.brown@intel.com>
Cc: Adrian Bunk <bunk@stusta.de>, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [-mm patch] ACPI should depend on, not select PCI
Message-ID: <20050903115430.GK3657@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI should depend on, not select PCI.

The practical differences should be nearly zero except that it avoids 
the illegal configuration PCI=y, X86_VOYAGER=y.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-mm1-full/drivers/acpi/Kconfig.old	2005-09-03 06:08:37.000000000 +0200
+++ linux-2.6.13-mm1-full/drivers/acpi/Kconfig	2005-09-03 06:08:58.000000000 +0200
@@ -10,8 +10,8 @@
 config ACPI
 	bool "ACPI Support"
 	depends on IA64 || X86
+	depends on PCI
 	select PM
-	select PCI
 
 	default y
 	---help---

