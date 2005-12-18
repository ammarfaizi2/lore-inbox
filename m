Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965188AbVLRPpt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965188AbVLRPpt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 10:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965182AbVLRPpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 10:45:25 -0500
Received: from smtp3.brturbo.com.br ([200.199.201.164]:27296 "EHLO
	smtp3.brturbo.com.br") by vger.kernel.org with ESMTP
	id S965151AbVLRPpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 10:45:23 -0500
Subject: [PATCH 2/5] - Tuner 100 was absent in tveeprom
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: linux-kernel@vger.kernel.org
Cc: js@linuxtv.org, linux-dvb-maintainer@linuxtv.org,
       video4linux-list@redhat.com
Date: Sun, 18 Dec 2005 13:23:45 -0200
Message-Id: <1134920704.6702.30.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Tuner 100 is the TUNER_PHILIPS_FMD1216ME_MK3, not TUNER_ABSENT. This
was causing the tuner module to be skipped, and rendered boards with this
value in the eeprom (like the HVR1100) unable to tune

Signed-off-by: Ricardo Cerqueira <v4l@cerqueira.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

---

 drivers/media/video/tveeprom.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

d5aaf794494f4592b211cf11951aadb540bf9e93
diff --git a/drivers/media/video/tveeprom.c b/drivers/media/video/tveeprom.c
index cd7cf1b..5ac2353 100644
--- a/drivers/media/video/tveeprom.c
+++ b/drivers/media/video/tveeprom.c
@@ -206,7 +206,7 @@ hauppauge_tuner[] =
 	{ TUNER_ABSENT,        "TCL 2002MI_3H"},
 	{ TUNER_TCL_2002N,     "TCL 2002N 5H"},
 	/* 100-109 */
-	{ TUNER_ABSENT,        "Philips FMD1216ME"},
+	{ TUNER_PHILIPS_FMD1216ME_MK3, "Philips FMD1216ME"},
 	{ TUNER_TEA5767,       "Philips TEA5768HL FM Radio"},
 	{ TUNER_ABSENT,        "Panasonic ENV57H12D5"},
 	{ TUNER_PHILIPS_FM1236_MK3, "TCL MFNM05-4"},
-- 
0.99.9.GIT

