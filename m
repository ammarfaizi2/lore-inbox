Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbVALC6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbVALC6A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 21:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262804AbVALC6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 21:58:00 -0500
Received: from fmr17.intel.com ([134.134.136.16]:27312 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261264AbVALC54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 21:57:56 -0500
Subject: [PATCH]change 'struct device' -> platform_data to firmware_data
From: Li Shaohua <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Greg <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1105498626.26324.14.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 12 Jan 2005 10:57:06 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
struct device->platform_data is designed for ACPI, BIOS or other
platform specific data, but some drivers misused the field which makes
adding ACPI handle in device core impossible. Greg suggested me changing
the name of the filed and so it breaks all such drivers, and then fix
them. I'll try to fix some, but it would be great if the driver authors
could do it.

Thanks,
Shaohua

---

 2.5-root/include/linux/device.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN include/linux/device.h~platform_data include/linux/device.h
--- 2.5/include/linux/device.h~platform_data	2005-01-12 10:41:35.446722944 +0800
+++ 2.5-root/include/linux/device.h	2005-01-12 10:42:37.762249544 +0800
@@ -265,7 +265,7 @@ struct device {
 	struct device_driver *driver;	/* which driver has allocated this
 					   device */
 	void		*driver_data;	/* data private to the driver */
-	void		*platform_data;	/* Platform specific data (e.g. ACPI,
+	void		*firmware_data;	/* Platform specific data (e.g. ACPI,
 					   BIOS data relevant to device) */
 	struct dev_pm_info	power;
 
_


