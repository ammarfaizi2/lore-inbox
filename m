Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263151AbVCDXIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263151AbVCDXIH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263275AbVCDWJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 17:09:44 -0500
Received: from mail.kroah.org ([69.55.234.183]:2466 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263158AbVCDUyb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:31 -0500
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: w83627hf needs i2c-isa
In-Reply-To: <11099685971963@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:36:37 -0800
Message-Id: <11099685973684@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2113, 2005/03/02 15:03:48-08:00, khali@linux-fr.org

[PATCH] I2C: w83627hf needs i2c-isa

The w83627hf driver is useless unless i2c-isa is present. All other
drivers in this case do select I2C_ISA through Kconfig, so this one
should as well do.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/chips/Kconfig |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
--- a/drivers/i2c/chips/Kconfig	2005-03-04 12:22:59 -08:00
+++ b/drivers/i2c/chips/Kconfig	2005-03-04 12:22:59 -08:00
@@ -338,6 +338,7 @@
 	tristate "Winbond W83627HF, W83627THF, W83637HF, W83697HF"
 	depends on I2C && EXPERIMENTAL
 	select I2C_SENSOR
+	select I2C_ISA
 	help
 	  If you say yes here you get support for the Winbond W836X7 series
 	  of sensor chips: the W83627HF, W83627THF, W83637HF, and the W83697HF

