Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264477AbUATAWB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 19:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265155AbUATAUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 19:20:20 -0500
Received: from mail.kroah.org ([65.200.24.183]:30892 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265162AbUATAAQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 19:00:16 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.1
In-Reply-To: <10745567661358@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 19 Jan 2004 15:59:26 -0800
Message-Id: <10745567661565@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1474.98.25, 2004/01/19 13:10:24-08:00, greg@kroah.com

[PATCH] I2C: only select I2C_ITE if we are a MIPS system


 drivers/i2c/busses/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	Mon Jan 19 15:28:21 2004
+++ b/drivers/i2c/busses/Kconfig	Mon Jan 19 15:28:21 2004
@@ -122,7 +122,7 @@
 
 config I2C_ITE
 	tristate "ITE I2C Adapter"
-	depends on I2C
+	depends on I2C && MIPS_ITE8172
 	select I2C_ALGOITE
 	help
 	  This supports the ITE8172 I2C peripheral found on some MIPS

