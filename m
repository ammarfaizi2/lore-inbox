Return-Path: <linux-kernel-owner+w=401wt.eu-S1751800AbXAODtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800AbXAODtK (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 22:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751802AbXAODtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 22:49:10 -0500
Received: from mail.velocitynet.com.au ([203.17.154.25]:52953 "EHLO
	m0.velocity.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800AbXAODtI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 22:49:08 -0500
Message-ID: <45AAF9A9.9080501@iinet.net.au>
Date: Mon, 15 Jan 2007 14:48:57 +1100
From: Ben Nizette <ben.nizette@iinet.net.au>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Haavard Skinnemoen <hskinnemoen@atmel.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH -mm] AVR32: fix build breakage
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove an unwanted remnant of the recent revert of AVR32/AT91 SPI 
patches in -mm.  Without this patch, the AVR32 build of 
2.6.20-rc[34]-mm1 breaks.

Signed-off-by: Ben Nizette <ben.nizette@iinet.net.au>
---
Index: linux-2.6.20-rc3/arch/avr32/mach-at32ap/at32ap7000.c
===================================================================
--- linux-2.6.20-rc3.orig/arch/avr32/mach-at32ap/at32ap7000.c	2007-01-11 
17:29:01.000000000 +1100
+++ linux-2.6.20-rc3/arch/avr32/mach-at32ap/at32ap7000.c	2007-01-11 
17:29:18.000000000 +1100
@@ -895,7 +895,7 @@
  	&macb0_pclk,
  	&macb1_hclk,
  	&macb1_pclk,
-	&atmel_spi0_mck,
+	&atmel_spi0_pclk,
  	&atmel_spi1_pclk,
  	&lcdc0_hclk,
  	&lcdc0_pixclk,
