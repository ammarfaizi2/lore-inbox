Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261684AbSJHTOx>; Tue, 8 Oct 2002 15:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261421AbSJHTOC>; Tue, 8 Oct 2002 15:14:02 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29712 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261429AbSJHTLl>; Tue, 8 Oct 2002 15:11:41 -0400
Subject: PATCH: trivial sound static/cast fixes
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 8 Oct 2002 20:08:51 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17yzit-0004vb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/sound/oss/maestro3.c linux.2.5.41-ac1/sound/oss/maestro3.c
--- linux.2.5.41/sound/oss/maestro3.c	2002-10-07 22:12:31.000000000 +0100
+++ linux.2.5.41-ac1/sound/oss/maestro3.c	2002-10-07 23:24:44.000000000 +0100
@@ -192,8 +192,8 @@
     int max;
 };
 
-int external_amp = 1;
-int gpio_pin = -1;
+static int external_amp = 1;
+static int gpio_pin = -1;
 
 struct m3_state {
     unsigned int magic;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/sound/oss/opl3sa2.c linux.2.5.41-ac1/sound/oss/opl3sa2.c
--- linux.2.5.41/sound/oss/opl3sa2.c	2002-10-02 21:33:42.000000000 +0100
+++ linux.2.5.41-ac1/sound/oss/opl3sa2.c	2002-10-06 22:15:33.000000000 +0100
@@ -978,7 +978,7 @@
 
 static int opl3sa2_pm_callback(struct pm_dev *pdev, pm_request_t rqst, void *data)
 {
-	unsigned char mode = (unsigned  char)data;
+	unsigned long mode = (unsigned  long)data;
 
 	switch (rqst) {
 		case PM_SUSPEND:
