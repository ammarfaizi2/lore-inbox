Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266200AbTBGQu2>; Fri, 7 Feb 2003 11:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266224AbTBGQu2>; Fri, 7 Feb 2003 11:50:28 -0500
Received: from nycsmtp1out.rdc-nyc.rr.com ([24.29.99.222]:25849 "EHLO
	nycsmtp1out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S266200AbTBGQu1>; Fri, 7 Feb 2003 11:50:27 -0500
Date: Fri, 7 Feb 2003 12:09:32 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@master
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com, <trivial@rustcorp.com.au>
Subject: [PATCH] 2.5.59: drivers/usb/serial/whiteheat.c
Message-ID: <Pine.LNX.4.44.0302071207040.6917-100000@master>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
   The following patch addresses buzilla bug # 314, and removes an
offending semicolon. Please review for inclusion.

Regards,
Frank

--- linux/drivers/usb/serial/whiteheat.c.old	2003-01-16 21:22:00.000000000 -0500
+++ linux/drivers/usb/serial/whiteheat.c	2003-02-07 03:03:11.000000000 -0500
@@ -783,7 +783,7 @@
 			if (info->mcr & UART_MCR_RTS)
 				modem_signals |= TIOCM_RTS;
 			
-			if (copy_to_user((unsigned int *)arg, &modem_signals, sizeof(unsigned int)));
+			if (copy_to_user((unsigned int *)arg, &modem_signals, sizeof(unsigned int)))
 				return -EFAULT;
 
 			break;

