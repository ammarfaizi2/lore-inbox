Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265520AbTFRUgC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 16:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265482AbTFRUgC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 16:36:02 -0400
Received: from palrel12.hp.com ([156.153.255.237]:30696 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S265520AbTFRUf6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 16:35:58 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16112.53360.599744.11117@napali.hpl.hp.com>
Date: Wed, 18 Jun 2003 13:49:52 -0700
To: torvalds@transmeta.com
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: re-enable the building of 8250_hcdp and 8250_acpi
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds back the ability to configure and build the HCDP and ACPI
support for the 8250 driver (there was some confusion in the earlier
patch due to renaming of files and options).

Thanks,

	--david

diff -Nru a/drivers/serial/Kconfig b/drivers/serial/Kconfig
--- a/drivers/serial/Kconfig	Wed Jun 18 13:32:51 2003
+++ b/drivers/serial/Kconfig	Wed Jun 18 13:32:51 2003
@@ -77,7 +77,7 @@
 	  a module, say M here and read <file:Documentation/modules.txt>.
 	  If unsure, say N.
 
-config SERIAL_HCDP
+config SERIAL_8250_HCDP
 	bool "8250/16550 device discovery support via EFI HCDP table"
 	depends on IA64
 	---help---
diff -Nru a/drivers/serial/Makefile b/drivers/serial/Makefile
--- a/drivers/serial/Makefile	Wed Jun 18 13:32:49 2003
+++ b/drivers/serial/Makefile	Wed Jun 18 13:32:49 2003
@@ -8,7 +8,8 @@
 serial-8250-$(CONFIG_GSC) += 8250_gsc.o
 serial-8250-$(CONFIG_PCI) += 8250_pci.o
 serial-8250-$(CONFIG_PNP) += 8250_pnp.o
-serial-8250-$(CONFIG_SERIAL_HCDP) += 8250_hcdp.o
+serial-8250-$(CONFIG_SERIAL_8250_HCDP) += 8250_hcdp.o
+serial-8250-$(CONFIG_ACPI) += 8250_acpi.o
 
 obj-$(CONFIG_SERIAL_CORE) += core.o
 obj-$(CONFIG_SERIAL_21285) += 21285.o
