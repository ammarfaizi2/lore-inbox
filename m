Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267625AbUI1HjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267625AbUI1HjS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 03:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267624AbUI1HjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 03:39:08 -0400
Received: from ns.sysgo.de ([213.68.67.98]:59799 "EHLO mailgate.sysgo.de")
	by vger.kernel.org with ESMTP id S267618AbUI1HjC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 03:39:02 -0400
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: linuxppc-embedded@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH][PPC32] Fix PFC1_EPS and PFC1_EPS_SHIFT definitions for IBM440GX
Date: Tue, 28 Sep 2004 09:38:55 +0200
User-Agent: KMail/1.7
Cc: Matt Porter <mporter@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409280938.55734.g.jaeger@sysgo.com>
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.16; AVE: 6.27.0.12; VDF: 6.27.0.74; host: mailgate.sysgo.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

while writing some BSP code for a 440GX custom board, I noticed, that
the DCRN_SDR_PFC1_EPS and DCRN_SDR_PFC1_EPS_SHIFT definitions are wrong and
therefore the functions ibm440gx_get_eth_grp() and ibm440gx_set_eth_grp() 
won't 
work correctly.
This patch will fix this, please apply.

TIA,
  Gerhard

PPC440GX: Fix DCRN_SDR_PFC1_EPS and DCRN_SDR_PFC1_EPS_SHIFT definitions

Signed-off-by: Gerhard Jaeger <gjaeger@sysgo.com>

--- linux-2.6.9-rc2/include/asm-ppc/ibm44x.h.orig       2004-09-22 
16:41:30.000000000 +0200
+++ linux-2.6.9-rc2/include/asm-ppc/ibm44x.h    2004-09-28 09:08:11.000000000 
+0200
@@ -94,8 +94,8 @@
 #define DCRN_SDR_CONFIG_DATA   0xf
 #define DCRN_SDR_PFC0          0x4100
 #define DCRN_SDR_PFC1          0x4101
-#define DCRN_SDR_PFC1_EPS      0x1c000000
-#define DCRN_SDR_PFC1_EPS_SHIFT        26
+#define DCRN_SDR_PFC1_EPS      0x1c00000
+#define DCRN_SDR_PFC1_EPS_SHIFT        22
 #define DCRN_SDR_PFC1_RMII     0x02000000
 #define DCRN_SDR_MFR           0x4300
 #define DCRN_SDR_MFR_TAH0      0x80000000      /* TAHOE0 Enable */
	
-- 
Gerhard Jaeger <gjaeger@sysgo.com>            
SYSGO AG                      Embedded and Real-Time Software
www.sysgo.com | www.elinos.com | www.osek.de | www.imerva.com

