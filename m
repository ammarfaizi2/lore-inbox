Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280956AbRKLTVE>; Mon, 12 Nov 2001 14:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280949AbRKLTU5>; Mon, 12 Nov 2001 14:20:57 -0500
Received: from [195.63.194.11] ([195.63.194.11]:46601 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S280952AbRKLTUw>; Mon, 12 Nov 2001 14:20:52 -0500
Message-ID: <3BF02D72.CB8D1A41@evision-ventures.com>
Date: Mon, 12 Nov 2001 21:13:38 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
CC: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: BUG BUG hunt the bugs!!! patch-2.4.15-pre5
In-Reply-To: <Pine.LNX.4.33.0111120838110.15242-100000@penguin.transmeta.com> <3BF01A14.26A5F78@evision-ventures.com> <3BF02B94.5E10B132@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo out there!

Same symptom from patch-2.4.15-pre4:

diff -u --recursive --new-file v2.4.14/linux/net/irda/irda_device.c
linux/net/irda/irda_device.c
--- v2.4.14/linux/net/irda/irda_device.c	Sun Sep 23 11:41:02 2001
+++ linux/net/irda/irda_device.c	Sun Nov 11 10:20:21 2001
 
bla bla bla...

@@ -124,6 +127,12 @@
 #ifdef CONFIG_WINBOND_FIR
 	w83977af_init();
 #endif
+#ifdef CONFIG_SA1100_FIR
+	sa1100_irda_init();
+#endif
+#ifdef CONFIG_SA1100_FIR
+	sa1100_irda_init();
+#endif
 #ifdef CONFIG_NSC_FIR
 	nsc_ircc_init();
 #endif
@@ -151,6 +160,12 @@
 #ifdef CONFIG_OLD_BELKIN
  	old_belkin_init();
 #endif
+#ifdef CONFIG_EP7211_IR
+ 	ep7211_ir_init();
+#endif
+#ifdef CONFIG_EP7211_IR
+ 	ep7211_ir_init();
+#endif
 	return 0;

You see the initialization done twice!
