Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261907AbSLJOnM>; Tue, 10 Dec 2002 09:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261950AbSLJOnM>; Tue, 10 Dec 2002 09:43:12 -0500
Received: from d146.dhcp212-198-27.noos.fr ([212.198.27.146]:62431 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP
	id <S261907AbSLJOnK>; Tue, 10 Dec 2002 09:43:10 -0500
Date: Tue, 10 Dec 2002 15:50:49 +0100
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH 2.4.20-BK] export pci symbols for pcmcia modules
Message-ID: <20021210155049.F18849@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two symbols are not exported by the pci code, yet they are used
by (at least) the pcmcia modules.

The attached patch makes it all happy again.

Stelian.

===== drivers/pci/pci.c 1.38 vs edited =====
--- 1.38/drivers/pci/pci.c	Tue Nov 19 14:38:18 2002
+++ edited/drivers/pci/pci.c	Tue Dec 10 13:53:53 2002
@@ -2155,6 +2155,8 @@
 EXPORT_SYMBOL(pci_do_scan_bus);
 EXPORT_SYMBOL(pci_scan_slot);
 EXPORT_SYMBOL(pci_scan_bus);
+EXPORT_SYMBOL(pci_scan_device);
+EXPORT_SYMBOL(pci_read_bridge_bases);
 #ifdef CONFIG_PROC_FS
 EXPORT_SYMBOL(pci_proc_attach_device);
 EXPORT_SYMBOL(pci_proc_detach_device);

-- 
Stelian Pop <stelian@popies.net>
