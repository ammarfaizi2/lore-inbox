Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266064AbTBGQkO>; Fri, 7 Feb 2003 11:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266069AbTBGQkO>; Fri, 7 Feb 2003 11:40:14 -0500
Received: from nycsmtp2out.rdc-nyc.rr.com ([24.29.99.223]:9668 "EHLO
	nycsmtp2out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S266064AbTBGQkN>; Fri, 7 Feb 2003 11:40:13 -0500
Date: Fri, 7 Feb 2003 11:59:18 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@master
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com, <trivial@rustcorp.com.au>
Subject: [PATCH[ 2.5.59 : drivers/input/joydev.c
Message-ID: <Pine.LNX.4.44.0302071157330.6917-100000@master>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
   The following patch addresses buzilla bug # 309, and removes an 
offending semicolon. Please review for inclusion.

Regards,
Frank

--- linux/drivers/input/joydev.c.old	2003-01-16 21:22:09.000000000 -0500
+++ linux/drivers/input/joydev.c	2003-02-07 03:16:17.000000000 -0500
@@ -340,7 +340,7 @@
 		case JSIOCSBTNMAP:
 			if (copy_from_user(joydev->keypam, (__u16 *) arg, sizeof(__u16) * (KEY_MAX - BTN_MISC)))
 				return -EFAULT;
-			for (i = 0; i < joydev->nkey; i++); {
+			for (i = 0; i < joydev->nkey; i++) {
 				if (joydev->keypam[i] > KEY_MAX || joydev->keypam[i] < BTN_MISC) return -EINVAL;
 				joydev->keymap[joydev->keypam[i] - BTN_MISC] = i;
 			}

