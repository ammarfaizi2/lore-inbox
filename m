Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030235AbWBYNV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030235AbWBYNV3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 08:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030232AbWBYNV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 08:21:29 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:48389 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030235AbWBYNV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 08:21:27 -0500
Date: Sat, 25 Feb 2006 14:21:26 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Alessandro Zummo <a.zummo@towertech.it>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       Russell King <rmk@arm.linux.org.uk>
Subject: [-mm patch] drivers/rtc/: make some structs static
Message-ID: <20060225132126.GN3674@stusta.de>
References: <20060224031002.0f7ff92a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060224031002.0f7ff92a.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2006 at 03:10:02AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.16-rc4-mm1:
>...
> +rtc-subsystem-class.patch
> +rtc-subsystem-arm-cleanup.patch
> +rtc-subsystem-i2c-cleanup.patch
> +rtc-subsystem-sysfs-interface.patch
> +rtc-subsystem-proc-interface.patch
> +rtc-subsystem-dev-interface.patch
> +rtc-subsystem-x1205-driver.patch
> +rtc-subsystem-test-device-driver.patch
> +rtc-subsystem-ds1672-driver.patch
> +rtc-subsystem-pcf8563-driver.patch
> +rtc-subsystem-rs5c372-driver.patch
> 
>  rtc subsystem rework.   These patches are being updated.
>...


This patch makes some needlessly global structs static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/rtc/rtc-dev.c   |    2 +-
 drivers/rtc/rtc-proc.c  |    2 +-
 drivers/rtc/rtc-sysfs.c |    2 +-
 drivers/rtc/rtc-test.c  |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.16-rc4-mm2-full/drivers/rtc/rtc-dev.c.old	2006-02-25 04:52:13.000000000 +0100
+++ linux-2.6.16-rc4-mm2-full/drivers/rtc/rtc-dev.c	2006-02-25 04:52:28.000000000 +0100
@@ -330,7 +330,7 @@
 
 /* interface registration */
 
-struct class_interface rtc_dev_interface = {
+static struct class_interface rtc_dev_interface = {
 	.add = &rtc_dev_add_device,
 	.remove = &rtc_dev_remove_device,
 };
--- linux-2.6.16-rc4-mm2-full/drivers/rtc/rtc-proc.c.old	2006-02-25 04:52:32.000000000 +0100
+++ linux-2.6.16-rc4-mm2-full/drivers/rtc/rtc-proc.c	2006-02-25 04:52:40.000000000 +0100
@@ -135,7 +135,7 @@
 	mutex_unlock(&rtc_lock);
 }
 
-struct class_interface rtc_proc_interface = {
+static struct class_interface rtc_proc_interface = {
 	.add = &rtc_proc_add_device,
 	.remove = &rtc_proc_remove_device,
 };
--- linux-2.6.16-rc4-mm2-full/drivers/rtc/rtc-sysfs.c.old	2006-02-25 04:52:49.000000000 +0100
+++ linux-2.6.16-rc4-mm2-full/drivers/rtc/rtc-sysfs.c	2006-02-25 04:52:58.000000000 +0100
@@ -97,7 +97,7 @@
 
 /* interface registration */
 
-struct class_interface rtc_sysfs_interface = {
+static struct class_interface rtc_sysfs_interface = {
 	.add = &rtc_sysfs_add_device,
 	.remove = &rtc_sysfs_remove_device,
 };
--- linux-2.6.16-rc4-mm2-full/drivers/rtc/rtc-test.c.old	2006-02-25 04:53:20.000000000 +0100
+++ linux-2.6.16-rc4-mm2-full/drivers/rtc/rtc-test.c	2006-02-25 04:53:28.000000000 +0100
@@ -14,7 +14,7 @@
 #include <linux/rtc.h>
 #include <linux/platform_device.h>
 
-struct platform_device *test0 = NULL, *test1 = NULL;
+static struct platform_device *test0 = NULL, *test1 = NULL;
 
 
 static int test_rtc_read_alarm(struct device *dev,

