Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269101AbUJTA0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269101AbUJTA0O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 20:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269883AbUJTAZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 20:25:33 -0400
Received: from mail.kroah.org ([69.55.234.183]:20404 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268092AbUJTATh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 20:19:37 -0400
Subject: Re: [PATCH] I2C update for 2.6.9
In-Reply-To: <1098231506495@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 19 Oct 2004 17:18:26 -0700
Message-Id: <10982315063820@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2073, 2004/10/19 15:21:33-07:00, khali@linux-fr.org

[PATCH] I2C: Update Kconfig for AMD bus drivers

This updates the AMD entries i2c/busses/Kconfig in two ways:
* Add missing PCI dependancy.
* Reword the help so that users know exactly what is supported by each
  driver.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/busses/Kconfig |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)


diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	2004-10-19 16:53:53 -07:00
+++ b/drivers/i2c/busses/Kconfig	2004-10-19 16:53:53 -07:00
@@ -40,21 +40,23 @@
 	  will be called i2c-ali15x3.
 
 config I2C_AMD756
-	tristate "AMD 756/766"
-	depends on I2C && EXPERIMENTAL
+	tristate "AMD 756/766/768/8111 and nVidia nForce"
+	depends on I2C && PCI && EXPERIMENTAL
 	help
 	  If you say yes to this option, support will be included for the AMD
-	  756/766/768 mainboard I2C interfaces.
+	  756/766/768 mainboard I2C interfaces.  The driver also includes
+	  support for the first (SMBus 1.0) I2C interface of the AMD 8111 and
+	  the nVidia nForce I2C interface.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-amd756.
 
 config I2C_AMD8111
 	tristate "AMD 8111"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C && PCI && EXPERIMENTAL
 	help
-	  If you say yes to this option, support will be included for the AMD
-	  8111 mainboard I2C interfaces.
+	  If you say yes to this option, support will be included for the
+	  second (SMBus 2.0) AMD 8111 mainboard I2C interface.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-amd8111.

