Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbVIEVrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbVIEVrK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 17:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932657AbVIEVnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 17:43:45 -0400
Received: from smtp4.brturbo.com.br ([200.199.201.180]:18514 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S932658AbVIEVni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 17:43:38 -0400
Date: Mon, 05 Sep 2005 18:26:16 -0300
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: video4linux-list@redhat.com, akpm@osdl.org
Subject: [PATCH 15/24] V4L: Change LG TDVS H062F from NTSC to ATSC.
Message-ID: <431cb7f8.vnC4mm4yQrceuL1e%mchehab@brturbo.com.br>
User-Agent: nail 11.25 7/29/05
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_431cb7f8.KkcpbpA8HrMj9i3oTzjb8QGbCuSLiSeKd6ORYM/a6OCwMIxh"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--=_431cb7f8.KkcpbpA8HrMj9i3oTzjb8QGbCuSLiSeKd6ORYM/a6OCwMIxh
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

.

--=_431cb7f8.KkcpbpA8HrMj9i3oTzjb8QGbCuSLiSeKd6ORYM/a6OCwMIxh
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="v4l-15-patch.diff"

- Change LG TDVS H062F from NTSC to ATSC.

Signed-off-by: Michael Krufky <mkrufky@m1k.net>

 linux/drivers/media/video/tuner-simple.c |    2 +-
 linux/drivers/media/video/tveeprom.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -u /tmp/dst.485 linux/drivers/media/video/tuner-simple.c
--- /tmp/dst.485	2005-09-05 11:43:00.000000000 -0300
+++ linux/drivers/media/video/tuner-simple.c	2005-09-05 11:43:00.000000000 -0300
@@ -242,7 +242,7 @@
           /* see tea5767.c for details */},
 	{ "Philips FMD1216ME MK3 Hybrid Tuner", Philips, PAL,
 	  16*160.00,16*442.00,0x51,0x52,0x54,0x86,623 },
-	{ "LG TDVS-H062F/TUA6034", LGINNOTEK, NTSC,
+	{ "LG TDVS-H062F/TUA6034", LGINNOTEK, ATSC,
 	  16*160.00,16*455.00,0x01,0x02,0x04,0x8e,732},
 	{ "Ymec TVF66T5-B/DFF", Philips, PAL,
           16*160.25,16*464.25,0x01,0x02,0x08,0x8e,623},
diff -u /tmp/dst.485 linux/drivers/media/video/tveeprom.c
--- /tmp/dst.485	2005-09-05 11:43:01.000000000 -0300
+++ linux/drivers/media/video/tveeprom.c	2005-09-05 11:43:01.000000000 -0300
@@ -455,7 +455,7 @@
 			tvee->has_radio = eeprom_data[i+1];
 			break;
 
-                case 0x0f: 
+                case 0x0f:
                         /* tag 'IRInfo' */
                         tvee->has_ir = eeprom_data[i+1];
                         break;

--=_431cb7f8.KkcpbpA8HrMj9i3oTzjb8QGbCuSLiSeKd6ORYM/a6OCwMIxh--
