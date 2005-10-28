Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965106AbVJ1GbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965106AbVJ1GbF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 02:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965111AbVJ1GbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 02:31:05 -0400
Received: from mail.kroah.org ([69.55.234.183]:17130 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965106AbVJ1GbD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 02:31:03 -0400
Cc: rdunlap@xenotime.net
Subject: [PATCH] kernel-doc: drivers/base fixes
In-Reply-To: <11304810272122@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 27 Oct 2005 23:30:27 -0700
Message-Id: <11304810272893@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] kernel-doc: drivers/base fixes

driver/base: add missing function parameters; eliminate all warnings.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 75b22ab1ec06a56ab4362a2e512ef6bd1d0f6f0d
tree f829459dbc67240683120abfa1c67a81cc4e4044
parent afe631e665d991c18e3e636b1c2455a891758760
author Randy Dunlap <rdunlap@xenotime.net> Sun, 23 Oct 2005 11:59:14 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:48:09 -0700

 drivers/base/core.c   |    4 ++--
 drivers/base/driver.c |    3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index ac4b5fd..8615b42 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -407,11 +407,11 @@ static struct device * next_device(struc
 
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
diff --git a/drivers/base/driver.c b/drivers/base/driver.c
index ef3fe51..161f3a3 100644
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
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

