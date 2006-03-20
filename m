Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965304AbWCTP0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965304AbWCTP0l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965303AbWCTP02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:26:28 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:35256 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964837AbWCTP0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:26:12 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 054/141] V4L/DVB (3299): Kconfig: DVB_USB_CXUSB depends on
	DVB_LGDT330X and DVB_MT352
Date: Mon, 20 Mar 2006 12:08:46 -0300
Message-id: <20060320150845.PS983675000054@infradead.org>
In-Reply-To: <20060320150819.PS760228000000@infradead.org>
References: <20060320150819.PS760228000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Krufky <mkrufky@linuxtv.org>
Date: 1139301933 -0200

- rename DVB_USB_CXUSB one-liner description to:
  Conexant USB2.0 hybrid reference design support.
- with the addition of bluebird support to dvb-usb-cxusb,
  it now depends on lgdt330x and mt352 modules.

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/dvb/dvb-usb/Kconfig b/drivers/media/dvb/dvb-usb/Kconfig
diff --git a/drivers/media/dvb/dvb-usb/Kconfig b/drivers/media/dvb/dvb-usb/Kconfig
index 90a69d3..d3df120 100644
--- a/drivers/media/dvb/dvb-usb/Kconfig
+++ b/drivers/media/dvb/dvb-usb/Kconfig
@@ -83,12 +83,18 @@ config DVB_USB_UMT_010
 	  Say Y here to support the HanfTek UMT-010 USB2.0 stick-sized DVB-T receiver.
 
 config DVB_USB_CXUSB
-	tristate "Medion MD95700 hybrid USB2.0 (Conexant) support"
+	tristate "Conexant USB2.0 hybrid reference design support"
 	depends on DVB_USB
 	select DVB_CX22702
+	select DVB_LGDT330X
+	select DVB_MT352
 	help
-	  Say Y here to support the Medion MD95700 hybrid USB2.0 device. Currently
-	  only the DVB-T part is supported.
+	  Say Y here to support the Conexant USB2.0 hybrid reference design.
+	  Currently, only DVB and ATSC modes are supported, analog mode
+	  shall be added in the future. Devices that require this module:
+
+	  Medion MD95700 hybrid USB2.0 device.
+	  DViCO FusionHDTV (Bluebird) USB2.0 devices
 
 config DVB_USB_DIGITV
 	tristate "Nebula Electronics uDigiTV DVB-T USB2.0 support"

