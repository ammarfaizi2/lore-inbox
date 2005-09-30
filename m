Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030498AbVI3XUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030498AbVI3XUW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 19:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030500AbVI3XUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 19:20:22 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:56021 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1030498AbVI3XUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 19:20:22 -0400
Date: Fri, 30 Sep 2005 16:20:22 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Linus Torvalds <torvalds@osdl.org>, rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [ARM] Fix IXP2000 serial port resource range
Message-ID: <20050930232022.GA5694@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Serial port only needs 32 bytes of resource space but we are currently
asking for 64K.

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>


diff --git a/arch/arm/mach-ixp2000/core.c b/arch/arm/mach-ixp2000/core.c
--- a/arch/arm/mach-ixp2000/core.c
+++ b/arch/arm/mach-ixp2000/core.c
 static struct resource ixp2000_uart_resource = {
 	.start		= IXP2000_UART_PHYS_BASE,
-	.end		= IXP2000_UART_PHYS_BASE + 0xffff,
+	.end		= IXP2000_UART_PHYS_BASE + 0x1f,
 	.flags		= IORESOURCE_MEM,
 };
 

-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

Even a stopped clock gives the right time twice a day.
