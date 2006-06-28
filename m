Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751421AbWF1Qyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbWF1Qyk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 12:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbWF1Qyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 12:54:39 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:34052 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751421AbWF1Qye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 12:54:34 -0400
Date: Wed, 28 Jun 2006 18:54:33 +0200
From: Adrian Bunk <bunk@stusta.de>
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [2.6 patch] poper prototype for arch/i386/pci/pcbios.c:pcibios_sort()
Message-ID: <20060628165433.GN13915@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a proper prototype for pcibios_sort() in 
arch/i386/pci/pci.h.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/i386/pci/common.c |    4 ----
 arch/i386/pci/pci.h    |    2 ++
 2 files changed, 2 insertions(+), 4 deletions(-)

--- linux-2.6.17-mm2-full/arch/i386/pci/pci.h.old	2006-06-27 03:37:27.000000000 +0200
+++ linux-2.6.17-mm2-full/arch/i386/pci/pci.h	2006-06-27 03:37:43.000000000 +0200
@@ -85,3 +85,5 @@
 extern void pci_pcbios_init(void);
 extern void pci_mmcfg_init(void);
 
+void pcibios_sort(void);
+
--- linux-2.6.17-mm2-full/arch/i386/pci/common.c.old	2006-06-27 03:38:00.000000000 +0200
+++ linux-2.6.17-mm2-full/arch/i386/pci/common.c	2006-06-27 03:38:11.000000000 +0200
@@ -17,10 +17,6 @@
 
 #include "pci.h"
 
-#ifdef CONFIG_PCI_BIOS
-extern  void pcibios_sort(void);
-#endif
-
 unsigned int pci_probe = PCI_PROBE_BIOS | PCI_PROBE_CONF1 | PCI_PROBE_CONF2 |
 				PCI_PROBE_MMCONF;
 

