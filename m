Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964924AbWD0ETI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964924AbWD0ETI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 00:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964926AbWD0ETI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 00:19:08 -0400
Received: from xenotime.net ([66.160.160.81]:20612 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964924AbWD0ETG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 00:19:06 -0400
Date: Wed, 26 Apr 2006 21:21:31 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: johnpol@2ka.mipt.ru, akpm <akpm@osdl.org>
Subject: [PATCH -mm] W1_CON: add W1 to depends
Message-Id: <20060426212131.1c566d19.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

W1_CON should depend on W1 also.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/w1/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.17-rc1-mm3.orig/drivers/w1/Kconfig
+++ linux-2.6.17-rc1-mm3/drivers/w1/Kconfig
@@ -13,7 +13,7 @@ config W1
 	  will be called wire.ko.
 
 config W1_CON
-	depends on CONNECTOR
+	depends on CONNECTOR && W1
 	bool "Userspace communication over connector"
 	default y
 	--- help ---


---
