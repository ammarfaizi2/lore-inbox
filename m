Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130599AbQLREqE>; Sun, 17 Dec 2000 23:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131413AbQLREpy>; Sun, 17 Dec 2000 23:45:54 -0500
Received: from cx518206-b.irvn1.occa.home.com ([24.21.107.123]:2820 "EHLO
	pobox.com") by vger.kernel.org with ESMTP id <S130599AbQLREpm>;
	Sun, 17 Dec 2000 23:45:42 -0500
From: "Barry K. Nathan" <barryn@pobox.com>
Message-Id: <200012180415.UAA00809@pobox.com>
Subject: [PATCH] 2.4.0test13-pre3 apm.o unresolved symbols
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Sun, 17 Dec 2000 20:15:18 -0800 (PST)
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Reply-To: barryn@pobox.com
In-Reply-To: <E147oJK-0004nf-00@the-village.bc.nu> from "Alan Cox" at Dec 18, 2000 12:37:47 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Linus Torvalds added to the cc list because there's now a patch to fix
the problem.)

Alan Cox wrote:
> pm.o should be listed as a symbol exporting object in kernel/Makefile

Ok, here's a patch that does this. Tested for both the in-kernel and
module cases.

-Barry K. Nathan <barryn@pobox.com>

diff -ruN linux-2.4.0test13pre3/kernel/Makefile linux-2.4.0test13pre3bkn/kernel/Makefile
--- linux-2.4.0test13pre3/kernel/Makefile	Sun Dec 17 14:17:47 2000
+++ linux-2.4.0test13pre3bkn/kernel/Makefile	Sun Dec 17 17:55:11 2000
@@ -9,7 +9,7 @@
 
 O_TARGET := kernel.o
 
-export-objs = signal.o sys.o kmod.o context.o ksyms.o
+export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o
 
 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o info.o time.o softirq.o resource.o \
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
