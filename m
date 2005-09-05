Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932689AbVIEVpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932689AbVIEVpH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 17:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932656AbVIEVnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 17:43:50 -0400
Received: from smtp4.brturbo.com.br ([200.199.201.180]:19538 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S932673AbVIEVnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 17:43:40 -0400
Date: Mon, 05 Sep 2005 18:26:15 -0300
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: video4linux-list@redhat.com, akpm@osdl.org
Subject: [PATCH 06/24] V4L: Syncs tveeprom tuners list with the list from
 ivtv
Message-ID: <431cb7f7.1+3Bdkx3AX2qCrIQ%mchehab@brturbo.com.br>
User-Agent: nail 11.25 7/29/05
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_431cb7f7.BJiDXIqK3Q0FdlscWFRqqORQkSezvYJBgryo3S86fd1nrFrd"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--=_431cb7f7.BJiDXIqK3Q0FdlscWFRqqORQkSezvYJBgryo3S86fd1nrFrd
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

.

--=_431cb7f7.BJiDXIqK3Q0FdlscWFRqqORQkSezvYJBgryo3S86fd1nrFrd
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="v4l-06-patch.diff"

- Syncs tveeprom tuners list with the list from ivtv.
- Fixes the incorrect reporting of the radio presence.

Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

 linux/drivers/media/video/tveeprom.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff -u /tmp/dst.32029 linux/drivers/media/video/tveeprom.c
--- /tmp/dst.32029	2005-09-05 11:42:43.000000000 -0300
+++ linux/drivers/media/video/tveeprom.c	2005-09-05 11:42:43.000000000 -0300
@@ -152,7 +152,7 @@
 	{ TUNER_MICROTUNE_4049FM5, "Microtune 4049 FM5"},
 	{ TUNER_ABSENT,        "LG TPI8NSR11F"},
 	{ TUNER_ABSENT,        "Microtune 4049 FM5 Alt I2C"},
-	{ TUNER_ABSENT,        "Philips FQ1216ME MK3"},
+	{ TUNER_PHILIPS_FM1216ME_MK3, "Philips FQ1216ME MK3"},
 	{ TUNER_ABSENT,        "Philips FI1236 MK3"},
 	{ TUNER_PHILIPS_FM1216ME_MK3, "Philips FM1216 ME MK3"},
 	{ TUNER_PHILIPS_FM1236_MK3, "Philips FM1236 MK3"},
@@ -167,7 +167,7 @@
 	{ TUNER_ABSENT,        "Temic 4106FH5"},
 	{ TUNER_ABSENT,        "Philips FQ1216LMP MK3"},
 	{ TUNER_LG_NTSC_TAPE,  "LG TAPE H001F MK3"},
-	{ TUNER_ABSENT,        "LG TAPE H701F MK3"},
+	{ TUNER_LG_NTSC_TAPE,  "LG TAPE H701F MK3"},
 	/* 70-79 */
 	{ TUNER_ABSENT,        "LG TALN H200T"},
 	{ TUNER_ABSENT,        "LG TALN H250T"},
@@ -199,6 +199,13 @@
 	{ TUNER_ABSENT,        "Philips FQ1236 MK5"},
 	{ TUNER_ABSENT,        "Unspecified"},
 	{ TUNER_LG_PAL_TAPE,   "LG PAL (TAPE Series)"},
+        { TUNER_ABSENT,        "Unspecified"},
+        { TUNER_TCL_2002N,     "TCL 2002N 5H"},
+	/* 100-103 */
+	{ TUNER_ABSENT,        "Unspecified"},
+        { TUNER_ABSENT,        "Unspecified"},
+        { TUNER_ABSENT,        "Unspecified"},
+        { TUNER_PHILIPS_FM1236_MK3, "TCL MFNM05 4"},
 };
 
 static char *sndtype[] = {
@@ -484,6 +491,7 @@
 		eeprom_props[1] = eeprom.tuner_formats;
 		eeprom_props[2] = eeprom.model;
 		eeprom_props[3] = eeprom.revision;
+		eeprom_props[4] = eeprom.has_radio;
 		break;
 	default:
 		return -EINVAL;

--=_431cb7f7.BJiDXIqK3Q0FdlscWFRqqORQkSezvYJBgryo3S86fd1nrFrd--
