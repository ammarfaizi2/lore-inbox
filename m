Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278980AbRJZTif>; Fri, 26 Oct 2001 15:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279017AbRJZTi0>; Fri, 26 Oct 2001 15:38:26 -0400
Received: from kaa.perlsupport.com ([205.245.149.25]:21002 "EHLO
	kaa.perlsupport.com") by vger.kernel.org with ESMTP
	id <S278980AbRJZTiQ>; Fri, 26 Oct 2001 15:38:16 -0400
Date: Fri, 26 Oct 2001 12:38:09 -0700
From: Chip Salzenberg <chip@pobox.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.13: Let modules register PCI devs
Message-ID: <20011026123809.A17022@perlsupport.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Howdy.  This little patch allows loaded modules to register and
unregister entries in /proc/bus/pci without invoking hotplug
processing.  (This is valuable for the independently maintained
pcmcia code, at least.)
-- 
Chip Salzenberg               - a.k.a. -              <chip@pobox.com>
 "We have no fuel on board, plus or minus 8 kilograms."  -- NEAR tech

--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=pci-proc-export-1


Index: linux/drivers/pci/pci.c
--- linux/drivers/pci/pci.c.old	Wed Oct 24 19:16:12 2001
+++ linux/drivers/pci/pci.c	Thu Oct 25 21:53:13 2001
@@ -2087,2 +2087,6 @@
 EXPORT_SYMBOL (pci_pool_free);
 
+/* Interface to /proc/bus */
+
+EXPORT_SYMBOL(pci_proc_attach_device);
+EXPORT_SYMBOL(pci_proc_detach_device);

--cNdxnHkX5QqsyA0e--
