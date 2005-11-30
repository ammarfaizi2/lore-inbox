Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751473AbVK3RSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbVK3RSv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 12:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbVK3RSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 12:18:51 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:62657 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751467AbVK3RSu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 12:18:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=GWnis54m6UYpq6BUViMP5KTfzicaSvHCgXQA/N1R2I3ozgUgo2QPNyeH2JM5M/fZizrP6M2RdjG0E4AEXq+c4DVZK41BmYJBdI76sQln4et5NG0+DGYHtwRb9mA2sRPDmrp6cgX5lioA+kyvDErWvZhoXe4snSIlKBL8i8T9d68=
Message-ID: <cda58cb80511300918i7df1c60au@mail.gmail.com>
Date: Wed, 30 Nov 2005 18:18:49 +0100
From: Franck <vagabon.xyz@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Subject: [PATCH] Add MIPS dependency for dm9000 driver
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch adds MIPS dependency for dm9000 ethernet
controller. Indeed this controller is used by some embedded platforms
based on MIPS CPUs.

Signed-Off-By: Franck Bui-Huu <franck.bui@gmail.com>
---
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index f15f909..1b00169 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -856,7 +856,7 @@ config SMC9194

 config DM9000
 	tristate "DM9000 support"
-	depends on ARM && NET_ETHERNET
+	depends on (ARM || MIPS) && NET_ETHERNET
 	select CRC32
 	select MII
 	---help---
