Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286413AbSBKCdD>; Sun, 10 Feb 2002 21:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286447AbSBKCcy>; Sun, 10 Feb 2002 21:32:54 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:2574 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S286411AbSBKCcp>; Sun, 10 Feb 2002 21:32:45 -0500
Message-ID: <3C672D4B.E0467ACA@delusion.de>
Date: Mon, 11 Feb 2002 03:32:43 +0100
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.3 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.4-pre6 compile fix for i386/kernel/signal.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

The attached patch fixes a compiler warning in signal.c due to a missing
prototype:

signal.c: In function `do_signal':
signal.c:681: warning: implicit declaration of function `do_coredump'

If binfmts.h should not be included, the prototype should be declared extern.

Regards,
Udo.

--- linux-2.5.4-pre-vanilla/arch/i386/kernel/signal.c   Mon Feb 11 03:04:25 2002
+++ linux-2.5.4-pre/arch/i386/kernel/signal.c   Mon Feb 11 03:19:47 2002
@@ -20,6 +20,7 @@
 #include <linux/stddef.h>
 #include <linux/tty.h>
 #include <linux/personality.h>
+#include <linux/binfmts.h>
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
 #include <asm/i387.h>
