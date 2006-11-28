Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758648AbWK1B3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758648AbWK1B3E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 20:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758640AbWK1B2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 20:28:50 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:57094 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1758638AbWK1B2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 20:28:33 -0500
Date: Tue, 28 Nov 2006 02:28:34 +0100
From: Adrian Bunk <bunk@stusta.de>
To: geert@linux-m68k.org, zippel@linux-m68k.org, gregkh@suse.de,
       David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: [RFC: 2.6 patch] don't export device IDs to userspace
Message-ID: <20061128012834.GT15364@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't see any good reason for exporting device IDs to userspace.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/linux/Kbuild |    2 --
 include/linux/pci.h  |    6 +++---
 2 files changed, 3 insertions(+), 5 deletions(-)

--- linux-2.6.19-rc6-mm1/include/linux/Kbuild.old	2006-11-27 22:19:55.000000000 +0100
+++ linux-2.6.19-rc6-mm1/include/linux/Kbuild	2006-11-27 22:24:53.000000000 +0100
@@ -122,7 +122,6 @@
 header-y += nfs_mount.h
 header-y += oom.h
 header-y += param.h
-header-y += pci_ids.h
 header-y += pci_regs.h
 header-y += personality.h
 header-y += pfkeyv2.h
@@ -165,7 +164,6 @@
 header-y += wireless.h
 header-y += xattr.h
 header-y += x25.h
-header-y += zorro_ids.h
 
 unifdef-y += acct.h
 unifdef-y += adb.h
--- linux-2.6.19-rc6-mm1/include/linux/pci.h.old	2006-11-27 23:11:11.000000000 +0100
+++ linux-2.6.19-rc6-mm1/include/linux/pci.h	2006-11-27 23:11:47.000000000 +0100
@@ -20,9 +20,6 @@
 /* Include the pci register defines */
 #include <linux/pci_regs.h>
 
-/* Include the ID list */
-#include <linux/pci_ids.h>
-
 /*
  * The PCI interface treats multi-function devices as independent
  * devices.  The slot/function address of each device is encoded
@@ -53,6 +50,9 @@
 #include <linux/errno.h>
 #include <linux/device.h>
 
+/* Include the ID list */
+#include <linux/pci_ids.h>
+
 /* File state for mmap()s on /proc/bus/pci/X/Y */
 enum pci_mmap_state {
 	pci_mmap_io,

