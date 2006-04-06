Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWDFKWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWDFKWE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 06:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWDFKWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 06:22:03 -0400
Received: from ozlabs.org ([203.10.76.45]:20899 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932164AbWDFKWB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 06:22:01 -0400
Date: Thu, 6 Apr 2006 20:17:31 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org, gregkh@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix pciehp driver on non ACPI systems
Message-ID: <20060406101731.GA9989@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Wrap some ACPI specific headers. ACPI hasnt taken over the whole world yet.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: kernel/drivers/pci/hotplug/pciehp_hpc.c
===================================================================
--- kernel.orig/drivers/pci/hotplug/pciehp_hpc.c	2006-04-06 05:01:32.000000000 -0500
+++ kernel/drivers/pci/hotplug/pciehp_hpc.c	2006-04-06 05:09:48.501122395 -0500
@@ -38,10 +38,14 @@
 
 #include "../pci.h"
 #include "pciehp.h"
+
+#ifdef CONFIG_ACPI
 #include <acpi/acpi.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/actypes.h>
 #include <linux/pci-acpi.h>
+#endif
+
 #ifdef DEBUG
 #define DBG_K_TRACE_ENTRY      ((unsigned int)0x00000001)	/* On function entry */
 #define DBG_K_TRACE_EXIT       ((unsigned int)0x00000002)	/* On function exit */
