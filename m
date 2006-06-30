Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933104AbWF2Xot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933104AbWF2Xot (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 19:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933105AbWF2Xos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 19:44:48 -0400
Received: from smtp2.pp.htv.fi ([213.243.153.35]:7045 "EHLO smtp2.pp.htv.fi")
	by vger.kernel.org with ESMTP id S933104AbWF2Xoq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 19:44:46 -0400
Date: Fri, 30 Jun 2006 09:56:07 +0300
From: Samuel Ortiz <samuel@sortiz.org>
To: Adrian Bunk <bunk@stusta.de>, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Morton <akpm@osdl.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, ralf@linux-mips.org,
       linux-mips@linux-mips.org, Jean-Luc Leger <reiga@dspnet.fr.eu.org>,
       irda-users@lists.sourceforge.net
Subject: [PATCH 2/2] [IrDA] Fix the AU1000 FIR dependencies
Message-ID: <20060630065607.GB4729@sortiz.org>
Reply-To: Samuel Ortiz <samuel@sortiz.org>
References: <20060629154148.GA19712@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060629154148.GA19712@stusta.de>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

AU1000 FIR is broken, it should depend on SOC_AU1000.

Spotted by Jean-Luc Leger.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Samuel Ortiz <samuel@sortiz.org>
---
 drivers/net/irda/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/irda/Kconfig b/drivers/net/irda/Kconfig
index d2ce489..e9e6d99 100644
--- a/drivers/net/irda/Kconfig
+++ b/drivers/net/irda/Kconfig
@@ -350,7 +350,7 @@ config TOSHIBA_FIR
 
 config AU1000_FIR
 	tristate "Alchemy Au1000 SIR/FIR"
-	depends on MIPS_AU1000 && IRDA
+	depends on SOC_AU1000 && IRDA
 
 config SMC_IRCC_FIR
 	tristate "SMSC IrCC (EXPERIMENTAL)"
-- 
1.4.0

