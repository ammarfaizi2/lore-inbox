Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316431AbSFDFHm>; Tue, 4 Jun 2002 01:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316423AbSFDFHl>; Tue, 4 Jun 2002 01:07:41 -0400
Received: from mail315.mail.bellsouth.net ([205.152.58.175]:29359 "EHLO
	imf15bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S316431AbSFDFHj>; Tue, 4 Jun 2002 01:07:39 -0400
Message-ID: <3CFC4B11.21A7CE1A@bellsouth.net>
Date: Tue, 04 Jun 2002 01:07:29 -0400
From: Albert Cranford <ac9410@bellsouth.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        "linux-i2c@tk.uni-linz.ac.at" <linux-i2c@tk.uni-linz.ac.at>
Subject: [patch] 2.5.20 i2c-elektor fix
Content-Type: multipart/mixed;
 boundary="------------6A7150676B8DC4158CBB4CB5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6A7150676B8DC4158CBB4CB5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello Linus,
The attached patch fixes i2c-elektor.c exit function.
Albert
-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net
--------------6A7150676B8DC4158CBB4CB5
Content-Type: text/plain; charset=us-ascii;
 name="47-i2c-4-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="47-i2c-4-patch"

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

--------------6A7150676B8DC4158CBB4CB5--

