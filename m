Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264939AbTBOTMO>; Sat, 15 Feb 2003 14:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264950AbTBOTMO>; Sat, 15 Feb 2003 14:12:14 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:54032 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264939AbTBOTMG>; Sat, 15 Feb 2003 14:12:06 -0500
Subject: PATCH: remove bogowarning
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Date: Sat, 15 Feb 2003 19:22:18 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18k7tC-0007IK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No lilo since about 1997 has stomped the EBDA

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/arch/i386/kernel/mpparse.c linux-2.5.61-ac1/arch/i386/kernel/mpparse.c
--- linux-2.5.61/arch/i386/kernel/mpparse.c	2003-02-10 18:38:16.000000000 +0000
+++ linux-2.5.61-ac1/arch/i386/kernel/mpparse.c	2003-02-14 22:47:48.000000000 +0000
@@ -752,8 +755,6 @@
 	address = *(unsigned short *)phys_to_virt(0x40E);
 	address <<= 4;
 	smp_scan_config(address, 0x400);
-	if (smp_found_config)
-		printk(KERN_WARNING "WARNING: MP table in the EBDA can be UNSAFE, contact linux-smp@vger.kernel.org if you experience SMP problems!\n");
 }
 
 
