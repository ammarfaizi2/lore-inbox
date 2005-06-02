Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbVFBKLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbVFBKLc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 06:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbVFBKLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 06:11:32 -0400
Received: from mail.renesas.com ([202.234.163.13]:45286 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S261359AbVFBKLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 06:11:23 -0400
Date: Thu, 02 Jun 2005 19:11:08 +0900 (JST)
Message-Id: <20050602.191108.233680079.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux@dominikbrodowski.net, linux-pcmcia@lists.infradead.org,
       sakugawa@linux-m32r.org, linux-kernel@vger.kernel.org,
       takata@linux-m32r.org
Subject: [PATCH 2.6.12-rc5-mm2] m32r: m32r_cfc.c build fix
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <20050601.205744.102571251.takata.hirokazu@renesas.com>
References: <20050531.221702.1044949015.takata.hirokazu@renesas.com>
	<20050531144504.GA5783@isilmar.linta.de>
	<20050601.205744.102571251.takata.hirokazu@renesas.com>
X-Mailer: Mew version 3.3 on XEmacs 21.4.17 (Jumbo Shrimp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I made a patch to fix a build error of m32r_cfc.c in 2.6.12-rc5-mm2 kernel.
This patch selects CONFIG_NONSTATIC for M32R PCMCIA/CF drivers.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 drivers/pcmcia/Kconfig |    2 ++
 1 files changed, 2 insertions(+)

diff -ruNp a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
--- a/drivers/pcmcia/Kconfig	2005-06-01 15:33:47.000000000 +0900
+++ b/drivers/pcmcia/Kconfig	2005-06-01 22:01:50.000000000 +0900
@@ -198,12 +198,14 @@ config PCMCIA_PROBE
 config M32R_PCC
 	bool "M32R PCMCIA I/F"
 	depends on M32R && CHIP_M32700 && PCMCIA
+	select PCCARD_NONSTATIC
 	help
 	  Say Y here to use the M32R PCMCIA controller.
 
 config M32R_CFC
 	bool "M32R CF I/F Controller"
 	depends on M32R && (PLAT_USRV || PLAT_M32700UT || PLAT_MAPPI2 || PLAT_MAPPI3 || PLAT_OPSPUT)
+	select PCCARD_NONSTATIC
 	help
 	  Say Y here to use the M32R CompactFlash controller.
 
--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
