Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270577AbTGNL6i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 07:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270578AbTGNL6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 07:58:38 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:33668
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S270577AbTGNL6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 07:58:36 -0400
Date: Mon, 14 Jul 2003 13:12:29 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307141212.h6ECCTQW030824@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, marcelo@conectiva.com
Subject: PATCH: fix compile warning
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.22-pre5/arch/i386/boot/bootsect.S linux.22-pre5-ac1/arch/i386/boot/bootsect.S
--- linux.22-pre5/arch/i386/boot/bootsect.S	2003-07-14 12:26:59.000000000 +0100
+++ linux.22-pre5-ac1/arch/i386/boot/bootsect.S	2003-07-07 15:53:06.000000000 +0100
@@ -234,7 +234,8 @@
 die:	jne	die			# %es must be at 64kB boundary
 	xorw	%bx, %bx		# %bx is starting address within segment
 rp_read:
-#ifdef __BIG_KERNEL__			# look in setup.S for bootsect_kludge
+#ifdef __BIG_KERNEL__
+					# look in setup.S for bootsect_kludge
 	bootsect_kludge = 0x220		# 0x200 + 0x20 which is the size of the
 	lcall	bootsect_kludge		# bootsector + bootsect_kludge offset
 #else
