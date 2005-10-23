Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbVJWTAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbVJWTAN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 15:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbVJWTAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 15:00:13 -0400
Received: from xenotime.net ([66.160.160.81]:49131 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751109AbVJWTAM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 15:00:12 -0400
Date: Sun, 23 Oct 2005 11:59:14 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: gregkh <greg@kroah.com>
Subject: [PATCH] kernel-doc: drivers/base fixes
Message-Id: <20051023115914.51f96ddc.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

driver/base: add missing function parameters; eliminate all warnings.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---

 drivers/base/core.c   |    4 ++--
 drivers/base/driver.c |    3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff -Naurp linux-2614-rc5/drivers/base/driver.c~kdoc_base linux-2614-rc5/drivers/base/driver.c
--- linux-2614-rc5/drivers/base/driver.c~kdoc_base	2005-10-20 18:55:31.000000000 -0700
+++ linux-2614-rc5/drivers/base/driver.c	2005-10-22 22:27:37.000000000 -0700
@@ -28,6 +28,7 @@ static struct device * next_device(struc
 /**
  *	driver_for_each_device - Iterator for devices bound to a driver.
  *	@drv:	Driver we're iterating.
+ *	@start: Device to begin with
  *	@data:	Data to pass to the callback.
  *	@fn:	Function to call for each device.
  *
@@ -57,7 +58,7 @@ EXPORT_SYMBOL_GPL(driver_for_each_device
 
 /**
  * driver_find_device - device iterator for locating a particular device.
- * @driver: The device's driver
+ * @drv: The device's driver
  * @start: Device to begin with
  * @data: Data to pass to match function
  * @match: Callback function to check device
diff -Naurp linux-2614-rc5/drivers/base/core.c~kdoc_base linux-2614-rc5/drivers/base/core.c
--- linux-2614-rc5/drivers/base/core.c~kdoc_base	2005-10-20 18:55:31.000000000 -0700
+++ linux-2614-rc5/drivers/base/core.c	2005-10-22 22:24:58.000000000 -0700
@@ -390,11 +390,11 @@ static struct device * next_device(struc
 
 /**
  *	device_for_each_child - device child iterator.
- *	@dev:	parent struct device.
+ *	@parent: parent struct device.
  *	@data:	data for the callback.
  *	@fn:	function to be called for each device.
  *
- *	Iterate over @dev's child devices, and call @fn for each,
+ *	Iterate over @parent's child devices, and call @fn for each,
  *	passing it @data.
  *
  *	We check the return of @fn each time. If it returns anything


---
