Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263191AbVCDXnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263191AbVCDXnl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263385AbVCDXbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:31:32 -0500
Received: from mail.kroah.org ([69.55.234.183]:33442 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263178AbVCDUyw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:52 -0500
Cc: macro@linux-mips.org
Subject: [PATCH] I2C: Enable I2C_PIIX4 for 64-bit platforms
In-Reply-To: <11099685961542@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:36:36 -0800
Message-Id: <11099685963312@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2103, 2005/03/02 12:18:19-08:00, macro@linux-mips.org

[PATCH] I2C: Enable I2C_PIIX4 for 64-bit platforms

 Is there any specific reason for the PIIX4 SMBus driver to be disabled on
64-bit platforms?  If not, then please apply the following change.  The
MIPS Technologies Malta development board has the 82371EB chip and
supports 64-bit configurations.  I've verified the driver to work
correctly using 64-bit kernels for both endiannesses.

Signed-off-by: Maciej W. Rozycki <macro@mips.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/busses/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	2005-03-04 12:24:09 -08:00
+++ b/drivers/i2c/busses/Kconfig	2005-03-04 12:24:09 -08:00
@@ -287,7 +287,7 @@
 
 config I2C_PIIX4
 	tristate "Intel PIIX4"
-	depends on I2C && PCI && EXPERIMENTAL && !64BIT
+	depends on I2C && PCI && EXPERIMENTAL
 	help
 	  If you say yes to this option, support will be included for the Intel
 	  PIIX4 family of mainboard I2C interfaces.  Specifically, the following

