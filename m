Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293735AbSCFRnN>; Wed, 6 Mar 2002 12:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293734AbSCFRnE>; Wed, 6 Mar 2002 12:43:04 -0500
Received: from tolkor.sgi.com ([192.48.180.13]:57325 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S293716AbSCFRmu>;
	Wed, 6 Mar 2002 12:42:50 -0500
Subject: [PATCH] 2.4,2.5: fix pci compile without procfs support
From: Eric Sandeen <sandeen@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: mj@ucw.cz, torvalds@transmeta.com, marcelo@conectiva.com.br
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 06 Mar 2002 11:41:51 -0600
Message-Id: <1015436512.2043.12.camel@stout.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pci_proc_* is only there if CONFIG_PROC_FS is defined...

(this should apply to both 2.4 and 2.5 trees)

-Eric

--- /usr/tmp/TmpDir.9804-0/linux/drivers/pci/pci.c_1.48	Wed Mar  6 11:32:23 2002
+++ linux/drivers/pci/pci.c	Tue Mar  5 00:04:33 2002
@@ -1996,11 +1996,13 @@
 EXPORT_SYMBOL(pci_add_new_bus);
 EXPORT_SYMBOL(pci_do_scan_bus);
 EXPORT_SYMBOL(pci_scan_slot);
+#ifdef CONFIG_PROC_FS
 EXPORT_SYMBOL(pci_proc_attach_device);
 EXPORT_SYMBOL(pci_proc_detach_device);
 EXPORT_SYMBOL(pci_proc_attach_bus);
 EXPORT_SYMBOL(pci_proc_detach_bus);
 #endif
+#endif
 
 EXPORT_SYMBOL(pci_set_power_state);
 EXPORT_SYMBOL(pci_save_state);

-- 
Eric Sandeen      XFS for Linux     http://oss.sgi.com/projects/xfs
sandeen@sgi.com   SGI, Inc.

