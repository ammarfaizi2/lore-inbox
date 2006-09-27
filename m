Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965427AbWI0Hf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965427AbWI0Hf6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 03:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965428AbWI0Hf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 03:35:58 -0400
Received: from havoc.gtf.org ([69.61.125.42]:1208 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S965427AbWI0Hf5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 03:35:57 -0400
Date: Wed, 27 Sep 2006 03:35:51 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>, ak@suse.de
Subject: [PATCH] PCI domains Kconfig entry
Message-ID: <20060927073551.GA6088@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There is obviously a missing patch...

With this patch, my Marvell SATA on the second root PCI bus of my 
HP xw9300 workstation works.  Without the PCI domain support, the
Marvell SATA is completely invisible to the kernel.


diff --git a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
index efe249e..3816775 100644
--- a/arch/x86_64/Kconfig
+++ b/arch/x86_64/Kconfig
@@ -622,6 +622,10 @@ config PCI_MMCONFIG
 	bool "Support mmconfig PCI config space access"
 	depends on PCI && ACPI
 
+config PCI_DOMAINS
+	bool "PCI domain support"
+	depends on PCI
+
 source "drivers/pci/pcie/Kconfig"
 
 source "drivers/pci/Kconfig"
