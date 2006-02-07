Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965125AbWBGPln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965125AbWBGPln (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 10:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbWBGPlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 10:41:40 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:26818 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751132AbWBGPl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 10:41:29 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 01/16] Kconfig: DVB_USB_CXUSB depends on DVB_LGDT330X and
	DVB_MT352
Date: Tue, 07 Feb 2006 13:33:29 -0200
Message-id: <20060207153329.PS28867800001@infradead.org>
In-Reply-To: <20060207153248.PS50860900000@infradead.org>
References: <20060207153248.PS50860900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Krufky <mkrufky@linuxtv.org>

- rename DVB_USB_CXUSB one-liner description to:
  Conexant USB2.0 hybrid reference design support.
- with the addition of bluebird support to dvb-usb-cxusb,
  it now depends on lgdt330x and mt352 modules.

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/dvb/dvb-usb/Kconfig |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

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

