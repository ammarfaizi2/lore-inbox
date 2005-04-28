Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261792AbVD1HKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbVD1HKP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 03:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbVD1HCC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 03:02:02 -0400
Received: from adsl-186.flex.com ([206.126.1.185]:16512 "EHLO mail.imodulo.com")
	by vger.kernel.org with ESMTP id S261792AbVD1HAi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 03:00:38 -0400
Date: Thu, 28 Apr 2005 07:00:33 +0000
From: Glen Nakamura <glen@imodulo.com>
To: linux-kernel@vger.kernel.org
Cc: marcelo.tosatti@cyclades.com
Subject: [PATCH 2.4.31-pre1] Fix typo in acpi_boot_init
Message-ID: <20050428070033.GA1731@modulo.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following ChangeSet introduced a typo in acpi_boot_init:

ChangeSet@1.1448.1.123  2005-03-09 11:43:51-03:00  marcelo@cnet
* Early ACPI PCI quirk depends on CONFIG_X86_IO_APIC

CONFIG_X86_IOAPIC should obviously be CONFIG_X86_IO_APIC
as written in the patch description above.

Trivial fix below.

Signed-off-by: Glen Nakamura <glen@imodulo.com>


--- linux-2.4.30.orig/arch/i386/kernel/acpi.c	2005-04-04 01:42:19.000000000 +0000
+++ linux-2.4.30/arch/i386/kernel/acpi.c	2005-04-04 01:42:19.000000000 +0000
@@ -440,7 +440,7 @@ acpi_boot_init (void)
 		return result;
 	}
 
-#ifdef CONFIG_X86_IOAPIC
+#ifdef CONFIG_X86_IO_APIC
 	check_acpi_pci();
 #endif
 	
