Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbWCaKGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWCaKGA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 05:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbWCaKF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 05:05:27 -0500
Received: from 213-140-6-124.ip.fastwebnet.it ([213.140.6.124]:17965 "EHLO
	linux") by vger.kernel.org with ESMTP id S932089AbWCaKEt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 05:04:49 -0500
Message-Id: <20060331100425.001583000@towertech.it>
References: <20060331100423.175139000@towertech.it>
User-Agent: quilt/0.43-1
Date: Fri, 31 Mar 2006 12:04:33 +0200
From: Alessandro Zummo <a.zummo@towertech.it>
To: linux-kernel@vger.kernel.org
Cc: akpm@zip.com.au, akpm@osdl.org, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Subject: [PATCH 10/10] RTC subsystem, VR41XX cleanup
Content-Disposition: inline; filename=rtc-subsys-drv-vr41xx-kconfig.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Cleaned up kconfig entry for the rtc-vr41xx.

Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>
CC: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
---
 drivers/rtc/Kconfig |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- linux-rtc.orig/drivers/rtc/Kconfig	2006-03-31 11:39:15.000000000 +0200
+++ linux-rtc/drivers/rtc/Kconfig	2006-03-31 11:49:09.000000000 +0200
@@ -148,8 +148,14 @@ config RTC_DRV_SA1100
 	  module will be called rtc-sa1100.
 
 config RTC_DRV_VR41XX
-	tristate "NEC VR4100 series RTC"
+	tristate "NEC VR41XX"
 	depends on RTC_CLASS && CPU_VR41XX
+	help
+	  If you say Y here you will get access to the real time clock
+	  built into your NEC VR41XX CPU.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called rtc-vr41xx.
 
 config RTC_DRV_TEST
 	tristate "Test driver/device"

--
