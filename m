Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbVBHUDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbVBHUDk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 15:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbVBHUDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 15:03:40 -0500
Received: from galileo.bork.org ([134.117.69.57]:45447 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S261648AbVBHUDi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 15:03:38 -0500
Date: Tue, 8 Feb 2005 15:03:38 -0500
From: Martin Hicks <mort@wildopensource.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix ACPI_BOOT for ia64 (2.6.11-rc3-mm1)
Message-ID: <20050208200338.GF11310@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,

One of your patches in 2.6.11-rc3-mm1 breaks ACPI_BOOT for ia64.  It
removes the dependence on CONFIG_ACPI and makes it exclusively depend on
X86_HT, which is wrong.

Signed-off-by: Martin Hicks <mort@wildopensource.com>

Index: linux-2.6.11-rc3-mm1/drivers/acpi/Kconfig
===================================================================
--- linux-2.6.11-rc3-mm1.orig/drivers/acpi/Kconfig	2005-02-07 12:31:54.000000000 -0800
+++ linux-2.6.11-rc3-mm1/drivers/acpi/Kconfig	2005-02-08 11:57:04.000000000 -0800
@@ -42,7 +42,7 @@
 
 config ACPI_BOOT
 	bool
-	depends on X86_HT
+	depends on X86_HT || IA64
 	default y
 
 if ACPI
