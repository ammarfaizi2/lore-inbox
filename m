Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264682AbTGKUHe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 16:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264679AbTGKRvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 13:51:08 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:63875
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264666AbTGKRup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 13:50:45 -0400
Date: Fri, 11 Jul 2003 19:04:33 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307111804.h6BI4X3A017206@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: Remove bogus printk in microcode.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.75/arch/i386/kernel/microcode.c linux-2.5.75-ac1/arch/i386/kernel/microcode.c
--- linux-2.5.75/arch/i386/kernel/microcode.c	2003-07-10 21:06:04.000000000 +0100
+++ linux-2.5.75-ac1/arch/i386/kernel/microcode.c	2003-07-11 14:29:05.000000000 +0100
@@ -380,7 +380,6 @@
 			return -ENODATA;
 
 		default:
-			printk(KERN_ERR "microcode: unknown ioctl cmd=%d\n", cmd);
 			return -EINVAL;
 	}
 	return -EINVAL;
