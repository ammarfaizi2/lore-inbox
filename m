Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261550AbUL0Aum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261550AbUL0Aum (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 19:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbUL0Atk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 19:49:40 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:40346 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261577AbUL0Ary (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 19:47:54 -0500
Subject: PATCH: 2.6.10 - Fix microcode text
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104104639.16545.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 26 Dec 2004 23:44:00 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Red Hat got some confused customers due to this message. The confused
user case is when they update the BIOS and all of a sudden we have "no
suitable data" yet we did before. We (Arjan van de Ven) thus changed it
to "No new microcode" which is much much clearer.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.10/arch/i386/kernel/microcode.c linux-2.6.10/arch/i386/kernel/microcode.c
--- linux.vanilla-2.6.10/arch/i386/kernel/microcode.c	2004-12-25 21:15:32.000000000 +0000
+++ linux-2.6.10/arch/i386/kernel/microcode.c	2004-12-26 17:30:43.000000000 +0000
@@ -364,7 +364,7 @@
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu_num;
 
 	if (uci->mc == NULL) {
-		printk(KERN_INFO "microcode: No suitable data for CPU%d\n", cpu_num);
+		printk(KERN_INFO "microcode: No new microcode data for CPU%d\n", cpu_num);
 		return;
 	}
 

