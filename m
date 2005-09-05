Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932588AbVIEVab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932588AbVIEVab (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 17:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932593AbVIEV3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 17:29:13 -0400
Received: from smtp4.brturbo.com.br ([200.199.201.180]:37967 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S932588AbVIEV3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 17:29:08 -0400
Date: Mon, 05 Sep 2005 18:26:15 -0300
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: video4linux-list@redhat.com, akpm@osdl.org
Subject: [PATCH 09/24] V4L: Add saa713x card #66: Yuan TUN-900 (saa7135)
Message-ID: <431cb7f7.pKzsKHf6CPGeyUvc%mchehab@brturbo.com.br>
User-Agent: nail 11.25 7/29/05
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_431cb7f7.Fyz4J8zugs9aHKB4iPcoB2OA+pv0Fznm4v0l+MwcFbY3HT8l"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--=_431cb7f7.Fyz4J8zugs9aHKB4iPcoB2OA+pv0Fznm4v0l+MwcFbY3HT8l
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

.

--=_431cb7f7.Fyz4J8zugs9aHKB4iPcoB2OA+pv0Fznm4v0l+MwcFbY3HT8l
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="v4l-09-patch.diff"

- Add saa713x card #66: Yuan TUN-900 (saa7135)

Signed-off-by: De Greef Sebastien <sebdg@hotmail.com>
Signed-off-by: Michael Krufky <mkrufky@m1k.net>

 linux/Documentation/video4linux/CARDLIST.saa7134  |    1 
 linux/drivers/media/video/saa7134/saa7134-cards.c |   41 ++++++++++++++
 linux/drivers/media/video/saa7134/saa7134.h       |    1 
 3 files changed, 43 insertions(+)

diff -u /tmp/dst.32335 linux/drivers/media/video/saa7134/saa7134.h
--- /tmp/dst.32335	2005-09-05 11:42:48.000000000 -0300
+++ linux/drivers/media/video/saa7134/saa7134.h	2005-09-05 11:42:48.000000000 -0300
@@ -186,6 +186,7 @@
 #define SAA7134_BOARD_KWORLD_XPERT 63
 #define SAA7134_BOARD_FLYTV_DIGIMATRIX 64
 #define SAA7134_BOARD_KWORLD_TERMINATOR 65
+#define SAA7134_BOARD_YUAN_TUN900 66
 
 #define SAA7134_MAXBOARDS 8
 #define SAA7134_INPUT_MAX 8
diff -u /tmp/dst.32335 linux/drivers/media/video/saa7134/saa7134-cards.c
--- /tmp/dst.32335	2005-09-05 11:42:48.000000000 -0300
+++ linux/drivers/media/video/saa7134/saa7134-cards.c	2005-09-05 11:42:48.000000000 -0300
@@ -2068,6 +2068,47 @@
 			.gpio = 0x0200000,
 		},
 	},
+	[SAA7134_BOARD_YUAN_TUN900] = {
+		/* FIXME:
+		 * S-Video and composite sources untested.
+		 * Radio not working.
+		 * Remote control not yet implemented.
+		 * From : codemaster@webgeeks.be */
+		.name           = "Yuan TUN-900 (saa7135)",
+		.audio_clock    = 0x00187de7,
+		.tuner_type     = TUNER_PHILIPS_TDA8290,
+		.radio_type     = UNSET,
+		.tuner_addr= ADDR_UNSET,
+		.radio_addr= ADDR_UNSET,
+		.gpiomask       = 0x00010003,
+		.inputs         = {{
+			.name = name_tv,
+			.vmux = 1,
+			.amux = TV,
+			.tv   = 1,
+			.gpio = 0x01,
+		},{
+			.name = name_comp1,
+			.vmux = 0,
+			.amux = LINE2,
+			.gpio = 0x02,
+		},{
+			.name = name_svideo,
+			.vmux = 6,
+			.amux = LINE2,
+			.gpio = 0x02,
+		}},
+		.radio = {
+			.name = name_radio,
+			.amux = LINE1,
+			.gpio = 0x00010003,
+		},
+		.mute = {
+			.name = name_mute,
+			.amux = TV,
+			.gpio = 0x01,
+		},
+	},
 };
 
 
diff -u /tmp/dst.32335 linux/Documentation/video4linux/CARDLIST.saa7134
--- /tmp/dst.32335	2005-09-05 11:42:49.000000000 -0300
+++ linux/Documentation/video4linux/CARDLIST.saa7134	2005-09-05 11:42:49.000000000 -0300
@@ -64,3 +64,4 @@
  63 -> Kworld Xpert TV PVR7134
  64 -> FlyTV mini Asus Digimatrix               [1043:0210,1043:0210]
  65 -> V-Stream Studio TV Terminator
+ 66 -> Yuan TUN-900 (saa7135)

--=_431cb7f7.Fyz4J8zugs9aHKB4iPcoB2OA+pv0Fznm4v0l+MwcFbY3HT8l--
