Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266932AbSLDQuG>; Wed, 4 Dec 2002 11:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266957AbSLDQuD>; Wed, 4 Dec 2002 11:50:03 -0500
Received: from mserv.bas-net.by ([80.94.160.15]:51723 "HELO mserv.bas-net.by")
	by vger.kernel.org with SMTP id <S266932AbSLDQuA>;
	Wed, 4 Dec 2002 11:50:00 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Andrei Darashenka 
	<adorosh2+sound.VGER.KERNEL.ORG@dream.bas-net.by>
Organization: bas-net.by
To: linux-sound@vger.kernel.org
Subject: 2.5.50 mpu401.h compilation error patches 
Date: Wed, 4 Dec 2002 18:57:14 +0200
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200212041857.14604.adorosh2+sound.VGER.KERNEL.ORG@dream.bas-net.by>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just tried to compile 2.5.50 and found compilation error on mpu401.c

Following patch syncronize mpu401.c and mpu401.h

diff -ur linux-2.5.50/sound/oss/mpu401.h linux-2.5.50-new/sound/oss/mpu401.h
--- linux-2.5.50/sound/oss/mpu401.h     2002-12-04 18:48:07.000000000 +0200
+++ linux-2.5.50-new/sound/oss/mpu401.h 2002-12-04 18:45:50.000000000 +0200
@@ -7,7 +7,7 @@
 
 /*     From mpu401.c */
 int probe_mpu401(struct address_info *hw_config);
-void attach_mpu401(struct address_info * hw_config, struct module *owner);
+int attach_mpu401(struct address_info * hw_config, struct module *owner);
 void unload_mpu401(struct address_info *hw_info);
 
 int intchk_mpu401(void *dev_id);


-- 

Regards,
Andrei

