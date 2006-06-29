Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbWF2Pmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWF2Pmb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 11:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbWF2Pmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 11:42:31 -0400
Received: from [141.84.69.5] ([141.84.69.5]:31758 "HELO mailout.stusta.mhn.de")
	by vger.kernel.org with SMTP id S1750810AbWF2Pma (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 11:42:30 -0400
Date: Thu, 29 Jun 2006 17:41:48 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Samuel.Ortiz@nokia.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, ralf@linux-mips.org,
       linux-mips@linux-mips.org, Jean-Luc Leger <reiga@dspnet.fr.eu.org>
Subject: [2.6 patch] fix the AU1000_FIR dependencies
Message-ID: <20060629154148.GA19712@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the AU1000_FIR dependencies.

Spotted by Jean-Luc Leger.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 15 Apr 2006

--- linux-2.6.17-rc1-mm2-full/drivers/net/irda/Kconfig.old	2006-04-15 16:17:36.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/drivers/net/irda/Kconfig	2006-04-15 16:18:06.000000000 +0200
@@ -350,7 +350,7 @@
 
 config AU1000_FIR
 	tristate "Alchemy Au1000 SIR/FIR"
-	depends on MIPS_AU1000 && IRDA
+	depends on SOC_AU1000 && IRDA
 
 config SMC_IRCC_FIR
 	tristate "SMSC IrCC (EXPERIMENTAL)"

