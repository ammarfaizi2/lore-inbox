Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315445AbSFTTeW>; Thu, 20 Jun 2002 15:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315449AbSFTTdt>; Thu, 20 Jun 2002 15:33:49 -0400
Received: from mail301.mail.bellsouth.net ([205.152.58.161]:10852 "EHLO
	imf01bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S315445AbSFTTda>; Thu, 20 Jun 2002 15:33:30 -0400
Message-ID: <3D122E01.2ABCE38A@bellsouth.net>
Date: Thu, 20 Jun 2002 15:33:21 -0400
From: Albert Cranford <ac9410@bellsouth.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.23 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] 2.5.23 i2c updates 4/4
Content-Type: multipart/mixed;
 boundary="------------394211CFF3BD057BBF5EA930"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------394211CFF3BD057BBF5EA930
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello Linus,
Please apply patch 4/4 for i2c updates against 2.5.23
Thanks,
Albert

http://personal.atl.bellsouth.net/mia/a/c/ac9410/albert/albert.html
-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net
--------------394211CFF3BD057BBF5EA930
Content-Type: text/plain; charset=us-ascii;
 name="2.5.23-i2c-4-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.5.23-i2c-4-patch"

# i2c-elektor.c:Adding call to pcf_isa_init to i2c_pcfisa_init causes:
# i2c-elektor.o: In function `i2c_pcfisa_init':
# i2c-elektor.o(.text.init+0x95): undefined reference to `local symbol
# i2c-elektor.c: fix by removing __exit for inline compiling.
--- linux/drivers/i2c/i2c-elektor.c.orig	2002-05-14 23:14:40.000000000 -0400
+++ linux/drivers/i2c/i2c-elektor.c	2002-05-16 09:38:09.000000000 -0400
@@ -160,7 +160,7 @@
 }
 
 
-static void __exit pcf_isa_exit(void)
+static void pcf_isa_exit(void)
 {
 	if (irq > 0) {
 		disable_irq(irq);

--------------394211CFF3BD057BBF5EA930--

