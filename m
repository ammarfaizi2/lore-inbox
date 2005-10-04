Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965029AbVJDXc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965029AbVJDXc0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 19:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbVJDXcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 19:32:25 -0400
Received: from sccrmhc13.comcast.net ([63.240.76.28]:33468 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S965029AbVJDXcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 19:32:25 -0400
Date: Tue, 4 Oct 2005 16:32:38 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Linus Torvalds <torvalds@osdl.org>, rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [ARM] Fix broken IXP4xx GPIO macro
Message-ID: <20051004233238.GB19552@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Macro ended up backwards during one of cleanups. Found by Alessandro Zummo.

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

diff --git a/include/asm-arm/arch-ixp4xx/platform.h b/include/asm-arm/arch-ixp4xx/platform.h
--- a/include/asm-arm/arch-ixp4xx/platform.h
+++ b/include/asm-arm/arch-ixp4xx/platform.h
@@ -93,7 +93,7 @@ extern struct pci_bus *ixp4xx_scan_bus(i
 
 static inline void gpio_line_config(u8 line, u32 direction)
 {
-	if (direction == IXP4XX_GPIO_OUT)
+	if (direction == IXP4XX_GPIO_IN)
 		*IXP4XX_GPIO_GPOER |= (1 << line);
 	else
 		*IXP4XX_GPIO_GPOER &= ~(1 << line);

-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

Even a stopped clock gives the right time twice a day.
