Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261756AbVFKR1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbVFKR1f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 13:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbVFKR1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 13:27:35 -0400
Received: from mo00.iij4u.or.jp ([210.130.0.19]:57592 "EHLO mo00.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S261756AbVFKR0G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 13:26:06 -0400
Date: Sun, 12 Jun 2005 02:25:58 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.12-rc6] serial: use "define"
Message-Id: <20050612022558.1d3116b5.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch had updated to use "define".

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -Nru a/drivers/serial/8250.c b/drivers/serial/8250.c
--- a/drivers/serial/8250.c	Tue Jun  7 00:22:29 2005
+++ b/drivers/serial/8250.c	Sun Jun 12 01:47:52 2005
@@ -1645,22 +1645,22 @@
 
 	switch (termios->c_cflag & CSIZE) {
 	case CS5:
-		cval = 0x00;
+		cval = UART_LCR_WLEN5;
 		break;
 	case CS6:
-		cval = 0x01;
+		cval = UART_LCR_WLEN6;
 		break;
 	case CS7:
-		cval = 0x02;
+		cval = UART_LCR_WLEN7;
 		break;
 	default:
 	case CS8:
-		cval = 0x03;
+		cval = UART_LCR_WLEN8;
 		break;
 	}
 
 	if (termios->c_cflag & CSTOPB)
-		cval |= 0x04;
+		cval |= UART_LCR_STOP;
 	if (termios->c_cflag & PARENB)
 		cval |= UART_LCR_PARITY;
 	if (!(termios->c_cflag & PARODD))
diff -Nru a/drivers/serial/au1x00_uart.c b/drivers/serial/au1x00_uart.c
--- a/drivers/serial/au1x00_uart.c	Tue Jun  7 00:22:29 2005
+++ b/drivers/serial/au1x00_uart.c	Sun Jun 12 01:57:55 2005
@@ -773,22 +773,22 @@
 
 	switch (termios->c_cflag & CSIZE) {
 	case CS5:
-		cval = 0x00;
+		cval = UART_LCR_WLEN5;
 		break;
 	case CS6:
-		cval = 0x01;
+		cval = UART_LCR_WLEN6;
 		break;
 	case CS7:
-		cval = 0x02;
+		cval = UART_LCR_WLEN7;
 		break;
 	default:
 	case CS8:
-		cval = 0x03;
+		cval = UART_LCR_WLEN8;
 		break;
 	}
 
 	if (termios->c_cflag & CSTOPB)
-		cval |= 0x04;
+		cval |= UART_LCR_STOP;
 	if (termios->c_cflag & PARENB)
 		cval |= UART_LCR_PARITY;
 	if (!(termios->c_cflag & PARODD))
diff -Nru a/drivers/serial/m32r_sio.c b/drivers/serial/m32r_sio.c
--- a/drivers/serial/m32r_sio.c	Tue Jun  7 00:22:29 2005
+++ b/drivers/serial/m32r_sio.c	Sun Jun 12 02:01:58 2005
@@ -724,22 +724,22 @@
 
 	switch (termios->c_cflag & CSIZE) {
 	case CS5:
-		cval = 0x00;
+		cval = UART_LCR_WLEN5;
 		break;
 	case CS6:
-		cval = 0x01;
+		cval = UART_LCR_WLEN6;
 		break;
 	case CS7:
-		cval = 0x02;
+		cval = UART_LCR_WLEN7;
 		break;
 	default:
 	case CS8:
-		cval = 0x03;
+		cval = UART_LCR_WLEN8;
 		break;
 	}
 
 	if (termios->c_cflag & CSTOPB)
-		cval |= 0x04;
+		cval |= UART_LCR_STOP;
 	if (termios->c_cflag & PARENB)
 		cval |= UART_LCR_PARITY;
 	if (!(termios->c_cflag & PARODD))
diff -Nru a/drivers/serial/pxa.c b/drivers/serial/pxa.c
--- a/drivers/serial/pxa.c	Tue Jun  7 00:22:29 2005
+++ b/drivers/serial/pxa.c	Sun Jun 12 02:04:30 2005
@@ -455,22 +455,22 @@
 
 	switch (termios->c_cflag & CSIZE) {
 	case CS5:
-		cval = 0x00;
+		cval = UART_LCR_WLEN5;
 		break;
 	case CS6:
-		cval = 0x01;
+		cval = UART_LCR_WLEN6;
 		break;
 	case CS7:
-		cval = 0x02;
+		cval = UART_LCR_WLEN7;
 		break;
 	default:
 	case CS8:
-		cval = 0x03;
+		cval = UART_LCR_WLEN8;
 		break;
 	}
 
 	if (termios->c_cflag & CSTOPB)
-		cval |= 0x04;
+		cval |= UART_LCR_STOP;
 	if (termios->c_cflag & PARENB)
 		cval |= UART_LCR_PARITY;
 	if (!(termios->c_cflag & PARODD))
