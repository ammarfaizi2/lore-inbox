Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312279AbSEANOH>; Wed, 1 May 2002 09:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312296AbSEANOG>; Wed, 1 May 2002 09:14:06 -0400
Received: from 24-168-145-62.nj.rr.com ([24.168.145.62]:4170 "HELO
	larvalstage.com") by vger.kernel.org with SMTP id <S312279AbSEANOF>;
	Wed, 1 May 2002 09:14:05 -0400
Date: Wed, 1 May 2002 09:17:07 -0400 (EDT)
From: John Kim <john@larvalstage.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [PATCH] four compile fixes for 2.5.12
Message-ID: <Pine.LNX.4.44.0205010830330.15016-100000@daria.larvalstage.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pretty boring stuff.  Four compile fixes for 2.5.12.  It makes trivial
changes to following four files.

drivers/char/rocket_int.h
drivers/char/serial_tx3912.h
fs/udf/ecma_167.h
include/asm-arm/arch-pxa/pxa-regs.h

John Kim

---

diff -Naur linux-2.5.12/drivers/char/rocket_int.h linux-2.5.12-new/drivers/char/rocket_int.h
--- linux-2.5.12/drivers/char/rocket_int.h	Tue Apr 30 20:08:48 2002
+++ linux-2.5.12-new/drivers/char/rocket_int.h	Wed May  1 08:47:17 2002
@@ -185,7 +185,7 @@

 /* Old clock prescale definition and baud rates associated with it */

-#define CLOCK_PRESC 0x19  */        /* mod 9 (divide by 10) prescale */
+#define CLOCK_PRESC 0x19            /* mod 9 (divide by 10) prescale */
 #define BRD50             4607
 #define BRD75             3071
 #define BRD110            2094
diff -Naur linux-2.5.12/drivers/char/serial_tx3912.h linux-2.5.12-new/drivers/char/serial_tx3912.h
--- linux-2.5.12/drivers/char/serial_tx3912.h	Tue Apr 30 20:08:49 2002
+++ linux-2.5.12-new/drivers/char/serial_tx3912.h	Wed May  1 08:47:51 2002
@@ -24,7 +24,7 @@
 #define UART_TXOVERRUN_INT  3  /* transmit overrun error          (25, 15) */
 #define UART_EMPTY_INT      2  /* both trans/recv regs empty      (24, 14) */
 #define UART_DMAFULL_INT    1  /* DMA at end of buffer            (23, 13) */
-#define UART_DMAHALF_INT    0  /* DMA halfway through buffer */   (22, 12) */
+#define UART_DMAHALF_INT    0  /* DMA halfway through buffer      (22, 12) */

 #define UARTA_SHIFT        22
 #define UARTB_SHIFT        12
diff -Naur linux-2.5.12/fs/udf/ecma_167.h linux-2.5.12-new/fs/udf/ecma_167.h
--- linux-2.5.12/fs/udf/ecma_167.h	Tue Apr 30 20:08:55 2002
+++ linux-2.5.12-new/fs/udf/ecma_167.h	Wed May  1 08:48:20 2002
@@ -606,7 +606,7 @@
 #define FE_RECORD_FMT_CRLF		0x0A
 #define FE_RECORD_FMT_LFCR		0x0B

-#define Record Display Attributes (ECMA 167r3 4/14.9.8) */
+/* Record Display Attributes (ECMA 167r3 4/14.9.8) */
 #define FE_RECORD_DISPLAY_ATTR_UNDEF	0x00
 #define FE_RECORD_DISPLAY_ATTR_1	0x01
 #define FE_RECORD_DISPLAY_ATTR_2	0x02
diff -Naur linux-2.5.12/include/asm-arm/arch-pxa/pxa-regs.h linux-2.5.12-new/include/asm-arm/arch-pxa/pxa-regs.h
--- linux-2.5.12/include/asm-arm/arch-pxa/pxa-regs.h	Tue Apr 30 20:08:59 2002
+++ linux-2.5.12-new/include/asm-arm/arch-pxa/pxa-regs.h	Wed May  1 08:48:54 2002
@@ -361,7 +361,7 @@
 #define LSR_OE		(1 << 1)	/* Overrun Error */
 #define LSR_DR		(1 << 0)	/* Data Ready */

-#define MCR_LOOP	(1 << 4)	*/
+#define MCR_LOOP	(1 << 4)
 #define MCR_OUT2	(1 << 3)	/* force MSR_DCD in loopback mode */
 #define MCR_OUT1	(1 << 2)	/* force MSR_RI in loopback mode */
 #define MCR_RTS		(1 << 1)	/* Request to Send */

