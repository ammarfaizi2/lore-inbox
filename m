Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317463AbSFRQBl>; Tue, 18 Jun 2002 12:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317465AbSFRQBk>; Tue, 18 Jun 2002 12:01:40 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:6836 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S317463AbSFRQBi>; Tue, 18 Jun 2002 12:01:38 -0400
Date: Tue, 18 Jun 2002 18:01:24 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linus Torvalds <torvalds@transmeta.com>, mochel@osdl.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5] export pci_bus_type to modules.
Message-ID: <20020618160124.GA9978@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Linus Torvalds <torvalds@transmeta.com>, mochel@osdl.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The attached patch (against the BK head, which wasn't yet updated to 
2.5.22 btw) exports the pci_bus_type symbol to modules, needed by
(at least) the recent changes in pcmcia/cardbus.c.

Stelian.

===== drivers/pci/pci-driver.c 1.14 vs edited =====
--- 1.14/drivers/pci/pci-driver.c	Sun Jun  9 01:07:49 2002
+++ edited/drivers/pci/pci-driver.c	Tue Jun 18 17:53:41 2002
@@ -210,3 +210,4 @@
 EXPORT_SYMBOL(pci_register_driver);
 EXPORT_SYMBOL(pci_unregister_driver);
 EXPORT_SYMBOL(pci_dev_driver);
+EXPORT_SYMBOL(pci_bus_type);

-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
