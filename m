Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266512AbSLOMzc>; Sun, 15 Dec 2002 07:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266489AbSLOMzc>; Sun, 15 Dec 2002 07:55:32 -0500
Received: from gateway.cinet.co.jp ([210.166.75.129]:47425 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S266512AbSLOMzb>; Sun, 15 Dec 2002 07:55:31 -0500
Message-ID: <3DFC7D0C.B9855F0A@cinet.co.jp>
Date: Sun, 15 Dec 2002 22:01:00 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.50-ac1-pc98smp i686)
X-Accept-Language: ja
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCHSET] PC-9800 addtional for 2.5.50-ac1 (17/21)
References: <3DFC50E9.656B96D0@cinet.co.jp>
Content-Type: multipart/mixed;
 boundary="------------C4390409803FF10A9433D612"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------C4390409803FF10A9433D612
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit

NEC PC-9800 subarchitecture support patch for 2.5.50-ac1 (17/21)
This is patch for IRQ number differences in pcmcia driver.

diffstat:
 drivers/pcmcia/i82365.c |    4 ++++
 1 files changed, 4 insertions(+)

Regards,
Osamu Tomita
--------------C4390409803FF10A9433D612
Content-Type: text/plain; charset=iso-2022-jp;
 name="pcmcia.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcmcia.patch"

diff -Nru linux-2.5.50-ac1/drivers/pcmcia/i82365.c linux98-2.5.50-ac1/drivers/pcmcia/i82365.c
--- linux-2.5.50-ac1/drivers/pcmcia/i82365.c	2002-11-28 07:36:18.000000000 +0900
+++ linux98-2.5.50-ac1/drivers/pcmcia/i82365.c	2002-12-12 16:40:13.000000000 +0900
@@ -187,7 +187,11 @@
 };
 
 /* Default ISA interrupt mask */
+#ifndef CONFIG_PC9800
 #define I365_MASK	0xdeb8	/* irq 15,14,12,11,10,9,7,5,4,3 */
+#else
+#define I365_MASK	0xd668	/* irq 15,14,12,10,9,6,5,3 */
+#endif
 
 #ifdef CONFIG_ISA
 static int grab_irq;

--------------C4390409803FF10A9433D612--

