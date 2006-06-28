Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751471AbWF1Q4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbWF1Q4z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 12:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbWF1Q41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 12:56:27 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:46852 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751464AbWF1Qza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 12:55:30 -0400
Date: Wed, 28 Jun 2006 18:55:30 +0200
From: Adrian Bunk <bunk@stusta.de>
To: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] AGP_AMD64 must depend on PCI
Message-ID: <20060628165529.GI13915@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following compile error:

<--  snip  -->

...
  CC      arch/i386/kernel/../../x86_64/kernel/k8.o
arch/i386/kernel/../../x86_64/kernel/k8.c: In function ‘next_k8_northbridge’:
arch/i386/kernel/../../x86_64/kernel/k8.c:34: error: implicit declaration of function ‘pci_match_id’

<--  snip  -->

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-mm3-full/drivers/char/agp/Kconfig.old	2006-06-28 12:56:20.000000000 +0200
+++ linux-2.6.17-mm3-full/drivers/char/agp/Kconfig	2006-06-28 12:56:55.000000000 +0200
@@ -56,7 +56,7 @@
 
 config AGP_AMD64
 	tristate "AMD Opteron/Athlon64 on-CPU GART support" if !IOMMU
-	depends on AGP && X86
+	depends on AGP && PCI && X86
 	default y if IOMMU
 	help
 	  This option gives you AGP support for the GLX component of

