Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262128AbSJZMfl>; Sat, 26 Oct 2002 08:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262119AbSJZMef>; Sat, 26 Oct 2002 08:34:35 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:7329 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S262122AbSJZMeb>;
	Sat, 26 Oct 2002 08:34:31 -0400
Date: Sat, 26 Oct 2002 13:42:28 +0100
Message-Id: <200210261242.g9QCgSRe030274@noodles.internal>
To: linux-kernel@vger.kernel.org
Cc: alan@redhat.com
From: davej@codemonkey.org.uk
Subject: [PATCH] silence MTRR debugging.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove debugging noise.

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/kernel/cpu/mtrr/generic.c linux-2.5/arch/i386/kernel/cpu/mtrr/generic.c
--- bk-linus/arch/i386/kernel/cpu/mtrr/generic.c	2002-10-20 20:21:25.000000000 -0100
+++ linux-2.5/arch/i386/kernel/cpu/mtrr/generic.c	2002-10-25 15:39:27.000000000 -0100
@@ -312,8 +312,6 @@ static void generic_set_mtrr(unsigned in
 {
 	prepare_set();
 
-	printk("MTRR: setting reg %x\n",reg);
-
 	if (size == 0) {
 		/* The invalid bit is kept in the mask, so we simply clear the
 		   relevant mask register to disable a range. */
