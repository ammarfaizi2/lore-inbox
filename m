Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753067AbWKCEEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753067AbWKCEEu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 23:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753070AbWKCEEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 23:04:50 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:46027 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1753064AbWKCEEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 23:04:32 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Trent Piepho <xyzzy@speakeasy.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 1/7] V4L/DVB (4752): DVB: Add DVB_FE_CUSTOMISE support for
	MT2060
Date: Fri, 03 Nov 2006 01:02:13 -0300
Message-id: <20061103040213.PS6684720001@infradead.org>
In-Reply-To: <20061103035925.PS9047100000@infradead.org>
References: <20061103035925.PS9047100000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Trent Piepho <xyzzy@speakeasy.org>

Let the MT2060 be customized like most of the other DVB PLLs/front-ends. 
Also, add a missing dependency on I2C.

Signed-off-by: Trent Piepho <xyzzy@speakeasy.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/dvb/dvb-usb/Kconfig    |   12 ++++++------
 drivers/media/dvb/frontends/Kconfig  |    2 ++
 drivers/media/dvb/frontends/mt2060.h |    8 ++++++++
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/media/dvb/dvb-usb/Kconfig b/drivers/media/dvb/dvb-usb/Kconfig
index 2cc5caa..a263b3f 100644
--- a/drivers/media/dvb/dvb-usb/Kconfig
+++ b/drivers/media/dvb/dvb-usb/Kconfig
@@ -26,7 +26,7 @@ config DVB_USB_A800
 	tristate "AVerMedia AverTV DVB-T USB 2.0 (A800)"
 	depends on DVB_USB
 	select DVB_DIB3000MC
-	select DVB_TUNER_MT2060
+	select DVB_TUNER_MT2060 if !DVB_FE_CUSTOMISE
 	help
 	  Say Y here to support the AVerMedia AverTV DVB-T USB 2.0 (A800) receiver.
 
@@ -34,7 +34,7 @@ config DVB_USB_DIBUSB_MB
 	tristate "DiBcom USB DVB-T devices (based on the DiB3000M-B) (see help for device list)"
 	depends on DVB_USB
 	select DVB_DIB3000MB
-	select DVB_TUNER_MT2060
+	select DVB_TUNER_MT2060 if !DVB_FE_CUSTOMISE
 	help
 	  Support for USB 1.1 and 2.0 DVB-T receivers based on reference designs made by
 	  DiBcom (<http://www.dibcom.fr>) equipped with a DiB3000M-B demodulator.
@@ -55,7 +55,7 @@ config DVB_USB_DIBUSB_MC
 	tristate "DiBcom USB DVB-T devices (based on the DiB3000M-C/P) (see help for device list)"
 	depends on DVB_USB
 	select DVB_DIB3000MC
-	select DVB_TUNER_MT2060
+	select DVB_TUNER_MT2060 if !DVB_FE_CUSTOMISE
 	help
 	  Support for USB2.0 DVB-T receivers based on reference designs made by
 	  DiBcom (<http://www.dibcom.fr>) equipped with a DiB3000M-C/P demodulator.
@@ -70,7 +70,7 @@ config DVB_USB_DIB0700
 	tristate "DiBcom DiB0700 USB DVB devices (see help for supported devices)"
 	depends on DVB_USB
 	select DVB_DIB3000MC
-	select DVB_TUNER_MT2060
+	select DVB_TUNER_MT2060 if !DVB_FE_CUSTOMISE
 	help
 	  Support for USB2.0/1.1 DVB receivers based on the DiB0700 USB bridge. The
 	  USB bridge is also present in devices having the DiB7700 DVB-T-USB
@@ -87,7 +87,7 @@ config DVB_USB_UMT_010
 	tristate "HanfTek UMT-010 DVB-T USB2.0 support"
 	depends on DVB_USB
 	select DVB_DIB3000MC
-	select DVB_TUNER_MT2060
+	select DVB_TUNER_MT2060 if !DVB_FE_CUSTOMISE
 	help
 	  Say Y here to support the HanfTek UMT-010 USB2.0 stick-sized DVB-T receiver.
 
@@ -153,7 +153,7 @@ config DVB_USB_NOVA_T_USB2
 	tristate "Hauppauge WinTV-NOVA-T usb2 DVB-T USB2.0 support"
 	depends on DVB_USB
 	select DVB_DIB3000MC
-	select DVB_TUNER_MT2060
+	select DVB_TUNER_MT2060 if !DVB_FE_CUSTOMISE
 	help
 	  Say Y here to support the Hauppauge WinTV-NOVA-T usb2 DVB-T USB2.0 receiver.
 
diff --git a/drivers/media/dvb/frontends/Kconfig b/drivers/media/dvb/frontends/Kconfig
index 080fa25..aebb8d6 100644
--- a/drivers/media/dvb/frontends/Kconfig
+++ b/drivers/media/dvb/frontends/Kconfig
@@ -276,6 +276,8 @@ config DVB_TDA826X
 
 config DVB_TUNER_MT2060
 	tristate "Microtune MT2060 silicon IF tuner"
+	depends on I2C
+	default m if DVB_FE_CUSTOMISE
 	help
 	  A driver for the silicon IF tuner MT2060 from Microtune.
 
diff --git a/drivers/media/dvb/frontends/mt2060.h b/drivers/media/dvb/frontends/mt2060.h
index 34a37c2..0a86eab 100644
--- a/drivers/media/dvb/frontends/mt2060.h
+++ b/drivers/media/dvb/frontends/mt2060.h
@@ -30,6 +30,14 @@ struct mt2060_config {
 	u8 clock_out; /* 0 = off, 1 = CLK/4, 2 = CLK/2, 3 = CLK/1 */
 };
 
+#if defined(CONFIG_DVB_TUNER_MT2060) || (defined(CONFIG_DVB_TUNER_MT2060_MODULE) && defined(MODULE))
 extern struct dvb_frontend * mt2060_attach(struct dvb_frontend *fe, struct i2c_adapter *i2c, struct mt2060_config *cfg, u16 if1);
+#else
+static inline struct dvb_frontend * mt2060_attach(struct dvb_frontend *fe, struct i2c_adapter *i2c, struct mt2060_config *cfg, u16 if1)
+{
+	printk(KERN_WARNING "%s: driver disabled by Kconfig\n", __FUNCTION__);
+	return NULL;
+}
+#endif // CONFIG_DVB_TUNER_MT2060
 
 #endif

