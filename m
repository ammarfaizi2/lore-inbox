Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280191AbRKXVrB>; Sat, 24 Nov 2001 16:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280289AbRKXVqv>; Sat, 24 Nov 2001 16:46:51 -0500
Received: from maila.telia.com ([194.22.194.231]:5884 "EHLO maila.telia.com")
	by vger.kernel.org with ESMTP id <S280191AbRKXVqf>;
	Sat, 24 Nov 2001 16:46:35 -0500
Message-Id: <200111242146.fAOLkXa10682@d1o849.telia.com>
Content-Type: text/plain; charset=US-ASCII
From: Jakob Kemi <jakob.kemi@telia.com>
To: marcelo@conectiva.com.br
Subject: Typo in md.c
Date: Sat, 24 Nov 2001 22:45:50 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I just noticed while browsing md.c (2.4.16-pre1) that there seems to be a typo
in the code. Shouldn't detetected_devices be of type kdev_t rather than int?
All (well, both) references to detected_devices assume kdev_t.

        / Jakob Kemi

--- md.c.orig	Sat Nov 24 22:02:04 2001
+++ md.c	Sat Nov 24 22:36:51 2001
@@ -3700,7 +3700,7 @@
  * Searches all registered partitions for autorun RAID arrays
  * at boot time.
  */
-static int detected_devices[128];
+static kdev_t detected_devices[128];
 static int dev_cnt;

 void md_autodetect_dev(kdev_t dev)
