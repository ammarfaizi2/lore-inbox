Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQKQK0D>; Fri, 17 Nov 2000 05:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131487AbQKQKZy>; Fri, 17 Nov 2000 05:25:54 -0500
Received: from [213.128.193.82] ([213.128.193.82]:2827 "EHLO
	mail.ixcelerator.com") by vger.kernel.org with ESMTP
	id <S129183AbQKQKZj>; Fri, 17 Nov 2000 05:25:39 -0500
Date: Fri, 17 Nov 2000 12:54:41 +0300
From: Oleg Drokin <green@ixcelerator.com>
To: jerdfelt@valinux.com
Cc: linux-kernel@vger.kernel.org
Subject: hardcoded HZ in hub.c
Message-ID: <20001117125441.A28208@iXcelerator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

    hub.c in 2.4.0-test10 and above contains hardcoded HZ value,
    which is wrong. Here is the patch:


--- drivers/usb/hub.c.orig	Fri Nov 17 12:51:34 2000
+++ drivers/usb/hub.c	Fri Nov 17 12:51:59 2000
@@ -813,7 +813,7 @@
 	ret = kill_proc(khubd_pid, SIGTERM, 1);
 	if (!ret) {
 		/* Wait 10 seconds */
-		int count = 10 * 100;
+		int count = 10 * HZ;
 
 		while (khubd_running && --count) {
 			current->state = TASK_INTERRUPTIBLE;

Bye,
    Oleg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
