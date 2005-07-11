Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261686AbVGKNTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbVGKNTr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 09:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbVGKNTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 09:19:46 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:65285 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S261676AbVGKNTe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 09:19:34 -0400
Date: Mon, 11 Jul 2005 09:19:03 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Lennert Buytenhek <buytenh+lkml@liacs.nl>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       "David S. Miller" <davem@davemloft.net>, rmk+lkml@arm.linux.org.uk,
       matthew@wil.cx, grundler@parisc-linux.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org,
       linux-kernel@vger.kernel.org, greg@kroah.com, ambx1@neo.rr.com,
       byjac@matfyz.cz, herbertb@cs.vu.nl
Subject: [patch 2.6.13-rc2] PCI: Add symbol exports for pci_restore_bars
Message-ID: <20050711131859.GC23093@tuxdriver.com>
Mail-Followup-To: Lennert Buytenhek <buytenh+lkml@liacs.nl>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	"David S. Miller" <davem@davemloft.net>, rmk+lkml@arm.linux.org.uk,
	matthew@wil.cx, grundler@parisc-linux.org,
	linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org,
	linux-kernel@vger.kernel.org, greg@kroah.com, ambx1@neo.rr.com,
	byjac@matfyz.cz, herbertb@cs.vu.nl
References: <20050708095104.A612@den.park.msu.ru> <20050707.233530.85417983.davem@davemloft.net> <20050708110358.A8491@jurassic.park.msu.ru> <20050708.003333.28789082.davem@davemloft.net> <20050708122043.A8779@jurassic.park.msu.ru> <20050708183452.GB13445@tuxdriver.com> <20050711144844.A16143@tin.liacs.nl> <20050711131518.GB23093@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050711131518.GB23093@tuxdriver.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Globalize and add EXPORT_SYMBOL for pci_restore_bars.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---
Some have expressed interest in making general use of the the
pci_restore_bars function.

 drivers/pci/pci.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -228,7 +228,7 @@ pci_find_parent_resource(const struct pc
  * Restore the BAR values for a given device, so as to make it
  * accessible by its driver.
  */
-static void
+void
 pci_restore_bars(struct pci_dev *dev)
 {
 	int i, numres;
@@ -833,6 +833,7 @@ struct pci_dev *isa_bridge;
 EXPORT_SYMBOL(isa_bridge);
 #endif
 
+EXPORT_SYMBOL(pci_restore_bars);
 EXPORT_SYMBOL(pci_enable_device_bars);
 EXPORT_SYMBOL(pci_enable_device);
 EXPORT_SYMBOL(pci_disable_device);
-- 
John W. Linville
linville@tuxdriver.com
