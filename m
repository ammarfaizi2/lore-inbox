Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262110AbVGVQUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbVGVQUG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 12:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbVGVQUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 12:20:06 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:39679 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S262111AbVGVQTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 12:19:34 -0400
Date: Fri, 22 Jul 2005 11:19:28 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
       Thomas.Downing@ipc.com
Subject: [PATCH] ppc32: Fix building of PQ2FADS with PCI enabled
Message-ID: <Pine.LNX.4.61.0507221118440.25550@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compilation fails for arch/ppc/syslib/m82xx_pci.c in version
2.6.12.3 when CONFIG_PQ2FADS=y.  The following patch fixes the
problems, which are just typographical.

Signed-off-by: Thomas Downing <Thomas.Downing@ipc.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 4bc715f73b35eea5c58a9124f31b05f1fbb3b6c4
tree fb2f9683a7260795ef5ff2d7488f7d19de1b5ffa
parent 9ec8020999ffebb9524ca88e86c15923bf744b55
author Kumar K. Gala <kumar.gala@freescale.com> Fri, 22 Jul 2005 10:40:33 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Fri, 22 Jul 2005 10:40:33 -0500

 arch/ppc/syslib/m82xx_pci.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/ppc/syslib/m82xx_pci.c b/arch/ppc/syslib/m82xx_pci.c
--- a/arch/ppc/syslib/m82xx_pci.c
+++ b/arch/ppc/syslib/m82xx_pci.c
@@ -238,9 +238,9 @@ pq2ads_setup_pci(struct pci_controller *
 	 * Setting required to enable IRQ1-IRQ7 (SIUMCR [DPPC]),
 	 * and local bus for PCI (SIUMCR [LBPC]).
 	 */
-	immap->im_siu_conf.siu_82xx.sc_siumcr = (immap->im_siu_conf.sc_siumcr &
-				~(SIUMCR_L2PC11 | SIUMCR_LBPC11 | SIUMCR_CS10PC11 | SIUMCR_APPC11) |
-				SIUMCR_BBD | SIUMCR_LBPC01 | SIUMCR_DPPC11 | SIUMCR_APPC10;
+	immap->im_siu_conf.siu_82xx.sc_siumcr = (immap->im_siu_conf.siu_82xx.sc_siumcr &
+				~(SIUMCR_L2CPC11 | SIUMCR_LBPC11 | SIUMCR_CS10PC11 | SIUMCR_APPC11) |
+				SIUMCR_BBD | SIUMCR_LBPC01 | SIUMCR_DPPC11 | SIUMCR_APPC10);
 #endif
 	/* Enable PCI  */
 	immap->im_pci.pci_gcr = cpu_to_le32(PCIGCR_PCI_BUS_EN);
