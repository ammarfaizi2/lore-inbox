Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161077AbWBNPWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161077AbWBNPWr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 10:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161085AbWBNPWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 10:22:46 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:15364 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161078AbWBNPWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 10:22:23 -0500
Date: Tue, 14 Feb 2006 16:22:22 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] show MCP menu only on ARCH_SA1100
Message-ID: <20060214152222.GJ10701@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On architectures like i386, the "Multimedia Capabilities Port drivers" 
menu is visible, but it can't be visited since it contains nothing 
usable for !ARCH_SA1100.

This patch therefore shows this menu only on ARCH_SA1100.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 3 Feb 2006
- 25 Jan 2006

--- linux-2.6.16-rc1-mm2-full/drivers/mfd/Kconfig.old	2006-01-25 03:27:58.000000000 +0100
+++ linux-2.6.16-rc1-mm2-full/drivers/mfd/Kconfig	2006-01-25 03:28:47.000000000 +0100
@@ -3,6 +3,7 @@
 #
 
 menu "Multimedia Capabilities Port drivers"
+	depends on ARCH_SA1100
 
 config MCP
 	tristate

