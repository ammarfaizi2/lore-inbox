Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266643AbSLJHFS>; Tue, 10 Dec 2002 02:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266686AbSLJHFS>; Tue, 10 Dec 2002 02:05:18 -0500
Received: from p0022.as-l043.contactel.cz ([194.108.242.22]:4594 "EHLO
	SnowWhite.janik.cz") by vger.kernel.org with ESMTP
	id <S266643AbSLJHFR> convert rfc822-to-8bit; Tue, 10 Dec 2002 02:05:17 -0500
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: 2.4.20-PATCH: serial.c - allow debug compile 
From: Pavel@Janik.cz (Pavel =?iso-8859-2?q?Jan=EDk?=)
X-Face: $"d&^B_IKlTHX!y2d,3;grhwjOBqOli]LV`6d]58%5'x/kBd7.MO&n3bJ@Zkf&RfBu|^qL+
 ?/Re{MpTqanXS2'~Qp'J2p^M7uM:zp[1Xq#{|C!*'&NvCC[9!|=>#qHqIhroq_S"MH8nSH+d^9*BF:
 iHiAs(t(~b#1.{w.d[=Z
Date: Tue, 10 Dec 2002 08:02:57 +0100
Message-ID: <m3y96ypd9a.fsf@Janik.cz>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.3.50
 (i386-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch allows compilation of serial device driver with debugging
turned on, please apply.

--- linux-2.4.20.orig/drivers/char/serial.c	2002-12-10 07:46:00.000000000 +0100
+++ linux-2.4.20/drivers/char/serial.c	2002-12-10 07:58:48.000000000 +0100
@@ -914,7 +914,7 @@
 		    ((iir & UART_IIR_ID) == UART_IIR_THRI))
 			transmit_chars(info, 0);
 		if (pass_counter++ > RS_ISR_PASS_LIMIT) {
-#if SERIAL_DEBUG_INTR
+#ifdef SERIAL_DEBUG_INTR
 			printk("rs_single loop break.\n");
 #endif
 			break;
@@ -4181,7 +4181,7 @@
    
 #ifdef SERIAL_DEBUG_PCI
 	printk(KERN_DEBUG " Subsystem ID %lx (intel 960)\n",
-	       (unsigned long) board->subdevice);
+	       (unsigned long) dev->subsystem_device);
 #endif
 	/* is firmware started? */
 	pci_read_config_dword(dev, 0x44, (void*) &oldval); 

-- 
Pavel Janík

Doctor, it hurts, where is my problem?
                  -- Hubert Mantel with his crystal-ball
