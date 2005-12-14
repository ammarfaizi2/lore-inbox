Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030312AbVLNDQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030312AbVLNDQJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 22:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030329AbVLNDQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 22:16:09 -0500
Received: from smtp4.brturbo.com.br ([200.199.201.180]:22590 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S1030312AbVLNDQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 22:16:08 -0500
Message-Id: <20051214031500.283238000@localhost>
References: <20051214031344.031534000@localhost>
Date: Wed, 14 Dec 2005 01:13:48 -0200
From: mchehab@brturbo.com
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, video4linux-list@redhat.com,
       linux-dvb-maintainer@linuxtv.org, js@linuxtv.org
Subject: [patch-mm 4/6] V4L/DVB (3160): Updates to the tveeprom eeprom
	checking
Content-Disposition: inline; filename=v4l_dvb_3160_updates_to_the_tveeprom_eeprom_checking.patch
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Toth <stoth@hauppauge.com>

Updates to the tveeprom eeprom checking

Signed-of-by: Steven Toth <stoth@hauppauge.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

 drivers/media/video/tveeprom.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- git.orig/drivers/media/video/tveeprom.c
+++ git/drivers/media/video/tveeprom.c
@@ -387,7 +387,7 @@ void tveeprom_hauppauge_analog(struct i2
 	if ((eeprom_data[0] == 0x1a) && (eeprom_data[1] == 0xeb) &&
 			(eeprom_data[2] == 0x67) && (eeprom_data[3] == 0x95))
 		start=0xa0; /* Generic em28xx offset */
-	else if (((eeprom_data[0] & 0xf0) == 0x10) &&
+	else if (((eeprom_data[0] & 0xe1) == 0x01) &&
 					(eeprom_data[1] == 0x00) &&
 					(eeprom_data[2] == 0x00) &&
 					(eeprom_data[8] == 0x84))

--

