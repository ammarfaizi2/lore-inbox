Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030247AbWDOOXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030247AbWDOOXT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 10:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030265AbWDOOXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 10:23:18 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:41230 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030251AbWDOOXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 10:23:18 -0400
Date: Sat, 15 Apr 2006 16:23:16 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Samuel.Ortiz@nokia.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ralf@linux-mips.org,
       linux-mips@linux-mips.org, Jean-Luc Leger <reiga@dspnet.fr.eu.org>
Subject: [2.6 patch] fix the AU1000_FIR dependencies
Message-ID: <20060415142316.GH15022@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patrch fixes the AU1000_FIR dependencies.

Spotted by Jean-Luc Leger.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-rc1-mm2-full/drivers/net/irda/Kconfig.old	2006-04-15 16:17:36.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/drivers/net/irda/Kconfig	2006-04-15 16:18:06.000000000 +0200
@@ -350,7 +350,7 @@
 
 config AU1000_FIR
 	tristate "Alchemy Au1000 SIR/FIR"
-	depends on MIPS_AU1000 && IRDA
+	depends on SOC_AU1000 && IRDA
 
 config SMC_IRCC_FIR
 	tristate "SMSC IrCC (EXPERIMENTAL)"

