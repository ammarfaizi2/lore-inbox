Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262118AbSJATkD>; Tue, 1 Oct 2002 15:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262236AbSJATkD>; Tue, 1 Oct 2002 15:40:03 -0400
Received: from router.ems.chel.su ([195.54.2.222]:31183 "EHLO mail.ems.ru")
	by vger.kernel.org with ESMTP id <S262118AbSJATkC>;
	Tue, 1 Oct 2002 15:40:02 -0400
Date: Wed, 2 Oct 2002 01:44:19 +0600
From: Aleksey I Zavilohin <villain@villain.home.ems.chel.su>
To: faith@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: compile fix for drm in 2.5.40
Message-ID: <20021001194419.GA30350@villain.home.ems.chel.su>
Mail-Followup-To: faith@redhat.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.4i
Organization: villain
X-Operation-System: Linux 2.4.19
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


please apply

diff -Nru a/drivers/char/drm/gamma_dma.c b/drivers/char/drm/gamma_dma.c
--- a/drivers/char/drm/gamma_dma.c	2002-10-02 01:27:53.000000000 +0600
+++ b/drivers/char/drm/gamma_dma.c	2002-10-02 01:29:49.000000000 +0600
@@ -128,8 +128,7 @@
 		clear_bit(0, &dev->dma_flag);
 
 				/* Dispatch new buffer */
-		queue_task(&dev->tq, &tq_immediate);
-		mark_bh(IMMEDIATE_BH);
+		schedule_task(&dev->tq);
 	}
 }
 
-- 
Kafka's Law:
	In the fight between you and the world, back the world.
		-- Franz Kafka, "RS's 1974 Expectation of Days"
