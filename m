Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262765AbVFVFnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbVFVFnr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 01:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262759AbVFVFiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 01:38:20 -0400
Received: from mail.kroah.org ([69.55.234.183]:56220 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262820AbVFVFWU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:22:20 -0400
Cc: ladis@linux-mips.org
Subject: [PATCH] ds1337 driver works also with ds1339 chip
In-Reply-To: <11194174622658@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:42 -0700
Message-Id: <11194174624139@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] ds1337 driver works also with ds1339 chip

On Wed, May 04, 2005 at 12:07:11PM +0200, Jean Delvare wrote:
> Additionally, I would welcome an additional patch documenting the fact
> that the ds1337 driver will work fine with the Dallas DS1339 real-time
> clock chip.

Document the fact that ds1337 driver works also with DS1339 real-time
clock chip.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 912b9c0c52b95696165e84d67fdab2af81a2213e
tree a5f560a549354680bd68991e29a15380306650c4
parent 86919833dbeac668762ae7056ead2d35d070f622
author Ladislav Michl <ladis@linux-mips.org> Tue, 10 May 2005 14:08:04 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:51:52 -0700

 drivers/i2c/chips/Kconfig  |    4 ++--
 drivers/i2c/chips/ds1337.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -379,12 +379,12 @@ menu "Other I2C Chip support"
 	depends on I2C
 
 config SENSORS_DS1337
-	tristate "Dallas Semiconductor DS1337 Real Time Clock"
+	tristate "Dallas Semiconductor DS1337 and DS1339 Real Time Clock"
 	depends on I2C && EXPERIMENTAL
 	select I2C_SENSOR
 	help
 	  If you say yes here you get support for Dallas Semiconductor
-	  DS1337 real-time clock chips. 
+	  DS1337 and DS1339 real-time clock chips.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called ds1337.
diff --git a/drivers/i2c/chips/ds1337.c b/drivers/i2c/chips/ds1337.c
--- a/drivers/i2c/chips/ds1337.c
+++ b/drivers/i2c/chips/ds1337.c
@@ -10,7 +10,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  *
- * Driver for Dallas Semiconductor DS1337 real time clock chip
+ * Driver for Dallas Semiconductor DS1337 and DS1339 real time clock chip
  */
 
 #include <linux/config.h>

