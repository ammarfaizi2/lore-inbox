Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932656AbVIEVpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932656AbVIEVpH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 17:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932682AbVIEVns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 17:43:48 -0400
Received: from smtp4.brturbo.com.br ([200.199.201.180]:20050 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S932676AbVIEVnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 17:43:40 -0400
Date: Mon, 05 Sep 2005 18:26:15 -0300
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: video4linux-list@redhat.com, akpm@osdl.org
Subject: [PATCH 08/24] V4L: Add saa713x card #65 Kworld V-Stream Studio TV Terminator
Message-ID: <431cb7f7.daN5yRaZTttVi0zP%mchehab@brturbo.com.br>
User-Agent: nail 11.25 7/29/05
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_431cb7f7.hRvO44WfGiRfGEG3mLtUA19v5M5HuRuhJs8fSrqsiP30qAT3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--=_431cb7f7.hRvO44WfGiRfGEG3mLtUA19v5M5HuRuhJs8fSrqsiP30qAT3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

.

--=_431cb7f7.hRvO44WfGiRfGEG3mLtUA19v5M5HuRuhJs8fSrqsiP30qAT3
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="v4l-08-patch.diff"

- Add saa713x card #65 Kworld V-Stream Studio TV Terminator

Signed-off-by: James R Webb <jrwebb@qwest.net>
Signed-off-by: Peter Missel <peter.missel@onlinehome.de>
Signed-off-by: Nickolay V. Shmyrev <nshmyrev@yandex.ru>
Signed-off-by: Michael Krufky <mkrufky@m1k.net>

 linux/Documentation/video4linux/CARDLIST.saa7134  |    1 
 linux/drivers/media/video/saa7134/saa7134-cards.c |   33 ++++++++++++++
 linux/drivers/media/video/saa7134/saa7134.h       |    1 
 3 files changed, 35 insertions(+)

diff -u /tmp/dst.32233 linux/drivers/media/video/saa7134/saa7134.h
--- /tmp/dst.32233	2005-09-05 11:42:46.000000000 -0300
+++ linux/drivers/media/video/saa7134/saa7134.h	2005-09-05 11:42:46.000000000 -0300
@@ -185,6 +185,7 @@
 #define SAA7134_BOARD_VIDEOMATE_TV_GOLD_PLUSII 62
 #define SAA7134_BOARD_KWORLD_XPERT 63
 #define SAA7134_BOARD_FLYTV_DIGIMATRIX 64
+#define SAA7134_BOARD_KWORLD_TERMINATOR 65
 
 #define SAA7134_MAXBOARDS 8
 #define SAA7134_INPUT_MAX 8
diff -u /tmp/dst.32233 linux/drivers/media/video/saa7134/saa7134-cards.c
--- /tmp/dst.32233	2005-09-05 11:42:46.000000000 -0300
+++ linux/drivers/media/video/saa7134/saa7134-cards.c	2005-09-05 11:42:46.000000000 -0300
@@ -2035,6 +2035,39 @@
 			.amux = LINE2,
 		},
 	},
+	[SAA7134_BOARD_KWORLD_TERMINATOR] = {
+		/* Kworld V-Stream Studio TV Terminator */
+		/* "James Webb <jrwebb@qwest.net> */
+		.name           = "V-Stream Studio TV Terminator",
+		.audio_clock    = 0x00187de7,
+		.tuner_type     = TUNER_PHILIPS_TDA8290,
+		.radio_type     = UNSET,
+		.tuner_addr     = ADDR_UNSET,
+		.radio_addr     = ADDR_UNSET,
+		.gpiomask       = 1 << 21,
+		.inputs         = {{
+			.name = name_tv,
+			.vmux = 1,
+			.amux = TV,
+			.gpio = 0x0000000,
+			.tv   = 1,
+		},{
+			.name = name_comp1,     /* Composite input */
+			.vmux = 3,
+			.amux = LINE2,
+			.gpio = 0x0000000,
+		},{
+			.name = name_svideo,    /* S-Video input */
+			.vmux = 8,
+			.amux = LINE2,
+			.gpio = 0x0000000,
+		}},
+		.radio = {
+			.name = name_radio,
+			.amux = TV,
+			.gpio = 0x0200000,
+		},
+	},
 };
 
 
diff -u /tmp/dst.32233 linux/Documentation/video4linux/CARDLIST.saa7134
--- /tmp/dst.32233	2005-09-05 11:42:47.000000000 -0300
+++ linux/Documentation/video4linux/CARDLIST.saa7134	2005-09-05 11:42:47.000000000 -0300
@@ -63,3 +63,4 @@
  62 -> Compro VideoMate TV Gold+II
  63 -> Kworld Xpert TV PVR7134
  64 -> FlyTV mini Asus Digimatrix               [1043:0210,1043:0210]
+ 65 -> V-Stream Studio TV Terminator

--=_431cb7f7.hRvO44WfGiRfGEG3mLtUA19v5M5HuRuhJs8fSrqsiP30qAT3--
