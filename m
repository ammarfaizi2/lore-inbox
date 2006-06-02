Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932561AbWFBU2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932561AbWFBU2z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 16:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932563AbWFBU2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 16:28:55 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:8659 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932561AbWFBU2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 16:28:54 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Fri, 2 Jun 2006 22:27:10 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.17-rc5-mm2 17/18] sbp2: provide helptext for
 CONFIG_IEEE1394_SBP2_PHYS_DMA and mark it experimental
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       Jody McIntyre <scjody@modernduck.com>,
       Ben Collins <bcollins@ubuntu.com>
In-Reply-To: <tkrat.96e1b392429fe277@s5r6.in-berlin.de>
Message-ID: <tkrat.df90273c07dd7503@s5r6.in-berlin.de>
References: <tkrat.10011841414bfa88@s5r6.in-berlin.de>
 <tkrat.31172d1c0b7ae8e8@s5r6.in-berlin.de>
 <tkrat.51c50df7e692bbfa@s5r6.in-berlin.de>
 <tkrat.f22d0694697e6d7a@s5r6.in-berlin.de>
 <tkrat.ecb0be3f1632e232@s5r6.in-berlin.de>
 <tkrat.687a0a2c67fa40c6@s5r6.in-berlin.de>
 <tkrat.f35772c971022262@s5r6.in-berlin.de>
 <tkrat.df7a29e56d67dd0a@s5r6.in-berlin.de>
 <tkrat.29d9bcd5406eb937@s5r6.in-berlin.de>
 <tkrat.9a30b61b3f17e5ac@s5r6.in-berlin.de>
 <tkrat.5222feb4e2593ac0@s5r6.in-berlin.de>
 <tkrat.5fcbbb70f827a5c2@s5r6.in-berlin.de>
 <tkrat.39c0a660f27b4e91@s5r6.in-berlin.de>
 <tkrat.4daedad8356d5ae7@s5r6.in-berlin.de>
 <tkrat.8f06b4d6dec62d08@s5r6.in-berlin.de>
 <tkrat.8a65694fd3ed4036@s5r6.in-berlin.de>
 <tkrat.96e1b392429fe277@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (-0.263) AWL,BAYES_20
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It appears I will not get it fixed overnight.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>

Index: linux-2.6.17-rc5-mm2/drivers/ieee1394/Kconfig
===================================================================
--- linux-2.6.17-rc5-mm2.orig/drivers/ieee1394/Kconfig	2006-06-01 20:55:03.000000000 +0200
+++ linux-2.6.17-rc5-mm2/drivers/ieee1394/Kconfig	2006-06-01 20:55:48.000000000 +0200
@@ -128,8 +128,17 @@ config IEEE1394_SBP2
 	  1394 bus.  SBP-2 devices include harddrives and DVD devices.
 
 config IEEE1394_SBP2_PHYS_DMA
-	bool "Enable Phys DMA support for SBP2 (Debug)"
-	depends on IEEE1394 && IEEE1394_SBP2
+	bool "Enable replacement for physical DMA in SBP2"
+	depends on IEEE1394 && IEEE1394_SBP2 && EXPERIMENTAL
+	help
+	  This builds sbp2 for use with non-OHCI host adapters which do not
+	  support physical DMA or for when ohci1394 is run with phys_dma=0.
+	  Physical DMA is data movement without assistence of the drivers'
+	  interrupt handlers.  This option includes the interrupt handlers
+	  that are required in absence of this hardware feature.
+
+	  This option is buggy and currently broken on some architectures.
+	  If unsure, say N.
 
 config IEEE1394_ETH1394
 	tristate "Ethernet over 1394"


