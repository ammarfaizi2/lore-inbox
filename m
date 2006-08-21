Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbWHUWA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbWHUWA3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 18:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWHUWA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 18:00:29 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:48524 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1751219AbWHUWA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 18:00:28 -0400
Date: Mon, 21 Aug 2006 23:59:53 +0200
From: Martin Samuelsson <sam@home.se>
To: mchehab@infradead.org, "Ronald S. Bultje" <rbultje@ronald.bitfreak.net>
Cc: v4l-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org,
       Adrian Bunk <bunk@stusta.de>
Subject: [patch] drivers/media/video/bt866.c: array overflows
Message-Id: <20060821235953.9737a404.sam@home.se>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.20; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This extends reg in the bt866 struct from 128 to 256 bytes, which will prevent a number of array overflows later in the code.

Signed-off-by: Martin Samuelsson <sam@home.se>

---

 bt866.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- /usr/src/linux-2.6.18-rc4/drivers/media/video/bt866.c       2006-08-21 22:59:16.000000000 +0200
+++ /usr/src/linux-2.6.18-rc4-avs6eyes/drivers/media/video/bt866.c      2006-08-21 21:51:14.000000000 +0200
@@ -65,7 +65,7 @@
 struct bt866 {
        struct i2c_client *i2c;
        int addr;
-       unsigned char reg[128];
+       unsigned char reg[256];
 
        int norm;
        int enable;
