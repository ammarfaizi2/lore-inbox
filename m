Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbTICKpM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 06:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbTICKpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 06:45:12 -0400
Received: from webhosting.rdsbv.ro ([213.157.185.164]:17873 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id S261823AbTICKpI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 06:45:08 -0400
Date: Wed, 3 Sep 2003 13:45:06 +0300 (EEST)
From: Catalin BOIE <util@deuroconsult.ro>
X-X-Sender: util@hosting.rdsbv.ro
To: linux-kernel@vger.kernel.org
cc: linux-acpi@vger.kernel.org
Subject: [PATCH] Re: 2.6.0test4mm5 - compile problem (acpi)
Message-ID: <Pine.LNX.4.56.0309030947120.19875@hosting.rdsbv.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.56.0309031344221.26055@hosting.rdsbv.ro>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

  CC      drivers/acpi/pci_link.o
drivers/acpi/pci_link.c: In function `acpi_pci_link_try_get_current':
drivers/acpi/pci_link.c:290: error: `_dbg' undeclared (first use in this
function)
drivers/acpi/pci_link.c:290: error: (Each undeclared identifier is
reported only once
drivers/acpi/pci_link.c:290: error: for each function it appears in.)
make[2]: *** [drivers/acpi/pci_link.o] Error 1
make[1]: *** [drivers/acpi] Error 2
make: *** [drivers] Error 2


Patch:
diff -ur acpi.ok/pci_link.c acpi/pci_link.c
--- acpi.ok/pci_link.c  2003-09-03 09:28:42.000000000 +0300
+++ acpi/pci_link.c     2003-09-03 13:42:28.000000000 +0300
@@ -285,6 +285,8 @@
 {
        int result;

+       ACPI_FUNCTION_TRACE("acpi_pci_link_try_get_current");
+
        result = acpi_pci_link_get_current(link);
        if (result && link->irq.active) {
                return_VALUE(result);


---
Catalin(ux) BOIE
catab@deuroconsult.ro
