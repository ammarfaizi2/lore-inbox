Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129091AbQKGUzR>; Tue, 7 Nov 2000 15:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129111AbQKGUzH>; Tue, 7 Nov 2000 15:55:07 -0500
Received: from chaos.analogic.com ([204.178.40.224]:3968 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129091AbQKGUyv>; Tue, 7 Nov 2000 15:54:51 -0500
Date: Tue, 7 Nov 2000 15:54:39 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Failure to boot initrd FIXED <patch>
Message-ID: <Pine.LNX.3.95.1001107155108.2319A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is really linux-2.4.0-test9. The patch is obviously-correct.
Alan, will you put this into some upcoming patch please.


--- /usr/src/linux-2.4.0/lib/inflate.c.orig	Tue Nov  7 08:52:59 2000
+++ /usr/src/linux-2.4.0/lib/inflate.c	Mon Nov  6 18:01:54 2000
@@ -147,6 +147,7 @@
 STATIC int inflate_dynamic OF((void));
 STATIC int inflate_block OF((int *));
 STATIC int inflate OF((void));
+STATIC void *memzero OF((char *, size_t));
 
 /* The inflate algorithm uses a sliding 32 K byte window on the uncompressed
    stream to find repeated byte strings.  This is implemented here as a



Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
