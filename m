Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293680AbSF2QaO>; Sat, 29 Jun 2002 12:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313070AbSF2QaN>; Sat, 29 Jun 2002 12:30:13 -0400
Received: from smtp.mujoskar.cz ([217.77.161.140]:63914 "EHLO smtp.mujoskar.cz")
	by vger.kernel.org with ESMTP id <S293680AbSF2QaM>;
	Sat, 29 Jun 2002 12:30:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: torvalds@transmeta.com
Subject: patch against linux-2.4.19-pre10/drivers/video/modedb.c
Date: Sat, 29 Jun 2002 18:30:38 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17OL7R-0000sc-00@notas>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,
this trivial patch adds possibility to have framebuffer console in 1024x768 
and 75 Hz. Now kernel supports only 1024x768 in 76 Hz, which cause blinking 
of console on my monitor. This trivial patch is against 2.4.19-pre10 and only 
adds new modelines for resolution 1.024x768 in 75 Hz. Please apply

Thanks Michal

 --- linux-2.4.19-pre10/drivers/video/modedb.c   Sat Jun 29 15:21:30 2002
+++ linux-2.4.19-pre10/drivers/video/modedb.c   Sat Jun 29 15:26:15 2002
@@ -107,10 +107,6 @@
        NULL, 70, 1024, 768, 13333, 144, 24, 29, 3, 136, 6,
        0, FB_VMODE_NONINTERLACED
     }, {
-        /* 1024x768 @ 75 Hz, 60.020 kHz hsync */
-        NULL, 75, 1024, 768, 12699, 176, 16, 28, 1, 96, 3,
-        0, FB_VMODE_NONINTERLACED
-    }, {
        /* 1280x1024 @ 87 Hz interlaced, 51 kHz hsync */
        NULL, 87, 1280, 1024, 12500, 56, 16, 128, 1, 216, 12,
        0, FB_VMODE_INTERLACED
