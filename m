Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130708AbRBQTDL>; Sat, 17 Feb 2001 14:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130805AbRBQTDB>; Sat, 17 Feb 2001 14:03:01 -0500
Received: from [212.150.53.130] ([212.150.53.130]:2830 "EHLO
	marcellos.corky.net") by vger.kernel.org with ESMTP
	id <S130708AbRBQTCv>; Sat, 17 Feb 2001 14:02:51 -0500
Date: Sat, 17 Feb 2001 21:02:46 +0200
From: Marc Esipovich <marc@corky.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] APMD on Linux 2.2.18 and include/linux/mc146818rtc.h
Message-ID: <20010217210245.A16130@marcellos.corky.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I've noticed this when attempting to build APMD, mc146818rtc.h has
a reference to a spinlock_t while asm/spinlock.h is not included.

	Patch follows:

--- linux-2.2.18.orig/include/linux/mc146818rtc.h    Fri Jan 12 19:15:00 2001
+++ linux-2.2.18/include/linux/mc146818rtc.h   Tue Feb 20 01:17:09 2001
@@ -11,6 +11,7 @@
 #ifndef _MC146818RTC_H
 #define _MC146818RTC_H
 #include <asm/io.h>
+#include <asm/spinlock.h>

 #ifndef RTC_PORT
 #define RTC_PORT(x)    (0x70 + (x))


	bye,
		Marc.

--
marc @ corky.net

fingerprint = D1F0 5689 967F B87A 98EB  C64D 256A D6BF 80DE 6D3C

          /"\
          \ /     ASCII Ribbon Campaign
           X      Against HTML Mail
          / \
