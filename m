Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966231AbWCTPNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966231AbWCTPNk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966251AbWCTPNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:13:39 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:2531 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965153AbWCTPNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:13:36 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 120/141] V4L/DVB (3392a): XC3028 code removed from -git
	versions
Date: Mon, 20 Mar 2006 12:08:57 -0300
Message-id: <20060320150857.PS096267000120@infradead.org>
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

From: Mauro Carvalho Chehab <mchehab@infradead.org>
Date: 1141009781 -0300

- Current xc3028 support is still experimental, requiring more work to be
  sent to mainstream. It will be kept only at mercurial tree on
  http://linuxtv.org/hg until fixed.

Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/em28xx/em28xx-cards.c b/drivers/media/video/em28xx/em28xx-cards.c
diff --git a/drivers/media/video/em28xx/em28xx-cards.c b/drivers/media/video/em28xx/em28xx-cards.c
index 6666305..4e22fc4 100644
--- a/drivers/media/video/em28xx/em28xx-cards.c
+++ b/drivers/media/video/em28xx/em28xx-cards.c
@@ -154,76 +154,6 @@ struct em28xx_board em28xx_boards[] = {
 			.amux     = 1,
 		}},
 	},
-#ifdef CONFIG_XC3028
-	[EM2880_BOARD_HAUPPAUGE_WINTV_HVR_900] = {
-		.name         = "Hauppauge WinTV HVR 900",
-		.vchannels    = 3,
-		.norm         = VIDEO_MODE_PAL,
-		.tda9887_conf = TDA9887_PRESENT,
-		.tuner_type   = TUNER_XCEIVE_XC3028,
-		.has_tuner    = 1,
-		.decoder      = EM28XX_TVP5150,
-		.input          = {{
-			.type     = EM28XX_VMUX_COMPOSITE1,
-			.vmux     = 2,
-			.amux     = 1,
-		},{
-			.type     = EM28XX_VMUX_TELEVISION,
-			.vmux     = 0,
-			.amux     = 0,
-		},{
-			.type     = EM28XX_VMUX_SVIDEO,
-			.vmux     = 9,
-			.amux     = 1,
-		}},
-	},
-	[EM2880_BOARD_TERRATEC_HYBRID_XS] = {
-		.name         = "Terratec Hybrid XS",
-		.vchannels    = 3,
-		.norm         = VIDEO_MODE_PAL,
-		.tda9887_conf = TDA9887_PRESENT,
-		.has_tuner    = 1,
-		.tuner_type   = TUNER_XCEIVE_XC3028,
-		.decoder      = EM28XX_TVP5150,
-		.input          = {{
-			.type     = EM28XX_VMUX_TELEVISION,
-			.vmux     = 0,
-			.amux     = 0,
-		},{
-			.type     = EM28XX_VMUX_COMPOSITE1,
-			.vmux     = 2,
-			.amux     = 1,
-		},{
-			.type     = EM28XX_VMUX_SVIDEO,
-			.vmux     = 9,
-			.amux     = 1,
-		}},
-	},
-	/* maybe there's a reason behind it why Terratec sells the Hybrid XS as Prodigy XS with a
-	 * different PID, let's keep it separated for now maybe we'll need it lateron */
-	[EM2880_BOARD_TERRATEC_PRODIGY_XS] = {
-		.name         = "Terratec Prodigy XS",
-		.vchannels    = 3,
-		.norm         = VIDEO_MODE_PAL,
-		.tda9887_conf = TDA9887_PRESENT,
-		.has_tuner    = 1,
-		.tuner_type   = TUNER_XCEIVE_XC3028,
-		.decoder      = EM28XX_TVP5150,
-		.input          = {{
-			.type     = EM28XX_VMUX_TELEVISION,
-			.vmux     = 0,
-			.amux     = 0,
-		},{
-			.type     = EM28XX_VMUX_COMPOSITE1,
-			.vmux     = 2,
-			.amux     = 1,
-		},{
-			.type     = EM28XX_VMUX_SVIDEO,
-			.vmux     = 9,
-			.amux     = 1,
-		}},
-	},
-#endif
 	[EM2820_BOARD_MSI_VOX_USB_2] = {
 		.name		= "MSI VOX USB 2.0",
 		.vchannels	= 3,
@@ -342,11 +272,6 @@ struct usb_device_id em28xx_id_table [] 
 	{ USB_DEVICE(0x2304, 0x0208), .driver_info = EM2820_BOARD_PINNACLE_USB_2 },
 	{ USB_DEVICE(0x2040, 0x4200), .driver_info = EM2820_BOARD_HAUPPAUGE_WINTV_USB_2 },
 	{ USB_DEVICE(0x2304, 0x0207), .driver_info = EM2820_BOARD_PINNACLE_DVC_90 },
-#ifdef CONFIG_XC3028
-	{ USB_DEVICE(0x2040, 0x6500), .driver_info = EM2880_BOARD_HAUPPAUGE_WINTV_HVR_900 },
-	{ USB_DEVICE(0x0ccd, 0x0042), .driver_info = EM2880_BOARD_TERRATEC_HYBRID_XS },
-	{ USB_DEVICE(0x0ccd, 0x0047), .driver_info = EM2880_BOARD_TERRATEC_PRODIGY_XS },
-#endif
 	{ },
 };
 
diff --git a/drivers/media/video/tuner-core.c b/drivers/media/video/tuner-core.c
diff --git a/drivers/media/video/tuner-core.c b/drivers/media/video/tuner-core.c
index 3a96cc4..3964244 100644
--- a/drivers/media/video/tuner-core.c
+++ b/drivers/media/video/tuner-core.c
@@ -216,11 +216,6 @@ static void set_type(struct i2c_client *
 		i2c_master_send(c,buffer,4);
 		default_tuner_init(c);
 		break;
-#ifdef CONFIG_XC3028
-	case TUNER_XCEIVE_XC3028:
-		xc3028_init(c);
-		break;
-#endif
 	default:
 		default_tuner_init(c);
 		break;

