Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131011AbQLYQDS>; Mon, 25 Dec 2000 11:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131150AbQLYQDI>; Mon, 25 Dec 2000 11:03:08 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:26893 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S131011AbQLYQC4>; Mon, 25 Dec 2000 11:02:56 -0500
Date: Mon, 25 Dec 2000 10:31:57 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] CONFIG_MOUSE should not be tristate
Message-ID: <Pine.LNX.4.30.0012251027250.3898-100000@woburn.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

CONFIG_MOUSE only enables further questions. It is never used except
drivers/char/Config.in where it's checked for being "n".

CONFIG_MOUSE=m makes no sence.

The patch is against 2.4.0-test13-pre4.

_______________________
--- linux.orig/drivers/char/Config.in
+++ linux/drivers/char/Config.in
@@ -95,7 +95,7 @@
    fi
 fi

-tristate 'Mouse Support (not serial and bus mice)' CONFIG_MOUSE
+bool 'Mouse Support (not serial and bus mice)' CONFIG_MOUSE
 if [ "$CONFIG_MOUSE" != "n" ]; then
    bool '  PS/2 mouse (aka "auxiliary device") support' CONFIG_PSMOUSE
    tristate '  C&T 82C710 mouse port support (as on TI Travelmate)' CONFIG_82C710_MOUSE
_______________________

Regards,
Pavel Roskin

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
