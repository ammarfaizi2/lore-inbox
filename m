Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262011AbVFVUN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbVFVUN3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 16:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbVFVUMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 16:12:36 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:14019 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S262025AbVFVUKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 16:10:18 -0400
Date: Wed, 22 Jun 2005 15:10:02 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32: Fix building MPC8555 CDS
Message-ID: <Pine.LNX.4.61.0506221509250.3138@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In adding support for MPC8548 w/o PCI support, broke building MPC8555 CDS
by trying to remove a loop variable that was used when PCI is enabled.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 3136970402c782e9a1fd5c39ddc88d05e7b7b086
tree fc975ccebd712d1898871cdbcde10b6faeba4603
parent 957e37cba892cf088b9326ca2aff0de88fc1e9b0
author Kumar K. Gala <kumar.gala@freescale.com> Wed, 22 Jun 2005 16:48:57 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Wed, 22 Jun 2005 16:48:57 -0500

 arch/ppc/platforms/85xx/mpc85xx_cds_common.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
--- a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
+++ b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
@@ -149,6 +149,7 @@ void __init
 mpc85xx_cds_init_IRQ(void)
 {
 	bd_t *binfo = (bd_t *) __res;
+	int i;
 
 	/* Determine the Physical Address of the OpenPIC regs */
 	phys_addr_t OpenPIC_PAddr = binfo->bi_immr_base + MPC85xx_OPENPIC_OFFSET;
/
