Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754580AbWKMMYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754580AbWKMMYs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 07:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754569AbWKMMYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 07:24:13 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:23505 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1754566AbWKMMXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 07:23:53 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 3/8] V4L/DVB (4804): Fix missing i2c dependency for saa7110
Date: Mon, 13 Nov 2006 10:18:43 -0200
Message-id: <20061113121843.PS8452170003@infradead.org>
In-Reply-To: <20061113121504.PS7687690000@infradead.org>
References: <20061113121504.PS7687690000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Mauro Carvalho Chehab <mchehab@infradead.org>

drivers/media/video/saa7110.c:112: undefined reference to `i2c_master_send'
drivers/built-in.o: In function `saa7110_read':
drivers/media/video/saa7110.c:130: undefined reference to `i2c_smbus_read_byte'
drivers/media/video/saa7110.c:130: undefined reference to `i2c_smbus_read_byte'

Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/media/video/Kconfig b/drivers/media/video/Kconfig
index fbe5b61..bf26755 100644
--- a/drivers/media/video/Kconfig
+++ b/drivers/media/video/Kconfig
@@ -186,7 +186,7 @@ config VIDEO_KS0127
 
 config VIDEO_SAA7110
 	tristate "Philips SAA7110 video decoder"
-	depends on VIDEO_V4L1
+	depends on VIDEO_V4L1 && I2C
 	---help---
 	  Support for the Philips SAA7110 video decoders.
 

