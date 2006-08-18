Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751585AbWHRXTm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585AbWHRXTm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 19:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751586AbWHRXTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 19:19:42 -0400
Received: from qbiz-online.de ([212.227.64.43]:42112 "EHLO qbiz-online.de")
	by vger.kernel.org with ESMTP id S1751583AbWHRXTl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 19:19:41 -0400
Message-ID: <44E64B05.3050205@christian-merkle.de>
Date: Sat, 19 Aug 2006 01:19:33 +0200
From: Christian Merkle <mail@christian-merkle.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060731 Thunderbird/1.5.0.5 Mnenhy/0.7.4.0
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: torvalds@osdl.org, sylvain.meyer@worldonline.fr
Subject: [PATCH] intelfb: update doc and Kconfig (supported devices)
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to drivers/video/intelfb/intelfb.h, the intelfb driver
supportes the following devices:
830M/845G/852GM/855GM/865G/915G/915GM/945G/945GM. So the description in
drivers/video/Kconfig and the documentation in
Documentation/fb/intelfb.txt is outdated.

Signed-off-by: Christian Merkle <mail@christian-merkle.de>
---

--- linux-2.6.18-rc4-org/Documentation/fb/intelfb.txt   2006-08-19
00:03:11.000000000 +0200
+++ linux-2.6.18-rc4-patched/Documentation/fb/intelfb.txt      
2006-08-19 00:31:39.000000000 +0200
@@ -11,7 +11,10 @@ graphics devices.  These would include:
        Intel 855GM
        Intel 865G
        Intel 915G
-
+       Intel 915GM
+       Intel 945G
+       Intel 945GM
+
 B.  List of available options

    a. "video=intelfb"
diff -uprN linux-2.6.18-rc4-org/drivers/video/Kconfig
linux-2.6.18-rc4-patched/drivers/video/Kconfig
--- linux-2.6.18-rc4-org/drivers/video/Kconfig  2006-08-19
00:03:11.000000000 +0200
+++ linux-2.6.18-rc4-patched/drivers/video/Kconfig      2006-08-19
00:35:50.000000000 +0200
@@ -825,7 +825,7 @@ config FB_I810_I2C
        help

 config FB_INTEL
-       tristate "Intel 830M/845G/852GM/855GM/865G support (EXPERIMENTAL)"
+       tristate "Intel 830/845/852/855/865/915/945 support (EXPERIMENTAL)"
        depends on FB && EXPERIMENTAL && PCI && X86
        select AGP
        select AGP_INTEL
@@ -835,11 +835,15 @@ config FB_INTEL
        select FB_CFB_IMAGEBLIT
        help
          This driver supports the on-board graphics built in to the Intel
-          830M/845G/852GM/855GM/865G chipsets.
+          830M/845G/852GM/855GM/865G/915G/915GM/945G/945GM chipsets.
           Say Y if you have and plan to use such a board.

           To compile this driver as a module, choose M here: the
          module will be called intelfb.
+
+          For more information, please read
+          <file:Documentation/fb/intelfb.txt>
+

 config FB_INTEL_DEBUG
         bool "Intel driver Debug Messages"

