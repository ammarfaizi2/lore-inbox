Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263890AbTDIWTQ (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 18:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263880AbTDIWSF (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 18:18:05 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:47567 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263884AbTDIWRm convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 18:17:42 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10499274992901@kroah.com>
Subject: [PATCH] i2c driver changes for 2.5.67
In-Reply-To: <20030409223117.GA2812@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 9 Apr 2003 15:31:39 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1033.3.1, 2003/04/07 09:31:20-07:00, greg@kroah.com

i2c: fix up CONFIG_I2C_SENSOR configuration logic.

Thanks to Ardrian Bunk for help with this.


 drivers/i2c/chips/Kconfig |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
--- a/drivers/i2c/chips/Kconfig	Wed Apr  9 15:17:08 2003
+++ b/drivers/i2c/chips/Kconfig	Wed Apr  9 15:17:08 2003
@@ -66,7 +66,8 @@
 
 config I2C_SENSOR
 	tristate
-	depends on SENSORS_ADM1021 || SENSORS_LM75 || SENSORS_VIA686A || SENSORS_W83781D
-	default m
+	default y if SENSORS_ADM1021=y || SENSORS_LM75=y || SENSORS_VIA686A=y || SENSORS_W83781D=y
+	default m if SENSORS_ADM1021=m || SENSORS_LM75=m || SENSORS_VIA686A=m || SENSORS_W83781D=m
+	default n
 
 endmenu

