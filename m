Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277803AbRJ1ITf>; Sun, 28 Oct 2001 03:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277798AbRJ1ITP>; Sun, 28 Oct 2001 03:19:15 -0500
Received: from jalon.able.es ([212.97.163.2]:1011 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S277782AbRJ1ITM>;
	Sun, 28 Oct 2001 03:19:12 -0500
Date: Sun, 28 Oct 2001 09:19:41 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Alan Cox <laughing@shared-source.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: i2c CONFIG bug in 2.4.13
Message-ID: <20011028091941.A10819@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I"C has a bug in config options. An option is misnamed in 2.4.13, so I
suppose it applies both to -pre3 and -ac3. Patch follows:

--- linux-2.4.13-ac3/drivers/i2c/i2c-core.c.orig	Sun Oct 28 09:11:07 2001
+++ linux-2.4.13-ac3/drivers/i2c/i2c-core.c	Sun Oct 28 09:11:23 2001
@@ -1284,7 +1284,7 @@
 #ifdef CONFIG_I2C_ALGOBIT
 	extern int i2c_algo_bit_init(void);
 #endif
-#ifdef CONFIG_I2C_CONFIG_I2C_PHILIPSPAR
+#ifdef CONFIG_I2C_PHILIPSPAR
 	extern int i2c_bitlp_init(void);
 #endif
 #ifdef CONFIG_I2C_ELV



-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.14-pre3-beo #2 SMP Sun Oct 28 01:07:36 CEST 2001 i686
