Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946022AbWBCWgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946022AbWBCWgt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 17:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946020AbWBCWgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 17:36:49 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:52494 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1946018AbWBCWgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 17:36:33 -0500
Date: Fri, 3 Feb 2006 23:36:31 +0100
From: Adrian Bunk <bunk@stusta.de>
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] show MCP menu only on ARCH_SA1100
Message-ID: <20060203223631.GW4408@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On architectures like i386, the "Multimedia Capabilities Port drivers" 
menu is visible, but it can't be visited since it contains nothing 
usable for !ARCH_SA1100.

This patch therefore shows this menu only on ARCH_SA1100.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 25 Jan 2006

--- linux-2.6.16-rc1-mm2-full/drivers/mfd/Kconfig.old	2006-01-25 03:27:58.000000000 +0100
+++ linux-2.6.16-rc1-mm2-full/drivers/mfd/Kconfig	2006-01-25 03:28:47.000000000 +0100
@@ -3,6 +3,7 @@
 #
 
 menu "Multimedia Capabilities Port drivers"
+	depends on ARCH_SA1100
 
 config MCP
 	tristate

