Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263727AbTDGWmm (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 18:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263729AbTDGWmm (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 18:42:42 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:35968
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263727AbTDGWmk (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 18:42:40 -0400
Date: Tue, 8 Apr 2003 01:01:30 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080001.h3801UFS008904@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fix the mode for bios call in x86-32 as well as -64
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Andi Kleen)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/arch/i386/boot/setup.S linux-2.5.67-ac1/arch/i386/boot/setup.S
--- linux-2.5.67/arch/i386/boot/setup.S	2003-04-08 00:37:34.000000000 +0100
+++ linux-2.5.67-ac1/arch/i386/boot/setup.S	2003-04-03 16:46:29.000000000 +0100
@@ -213,7 +213,7 @@
 # Part of above routine, this one just prints ascii al
 prtchr:	pushw	%ax
 	pushw	%cx
-	xorb	%bh, %bh
+	movw	$7,%bx
 	movw	$0x01, %cx
 	movb	$0x0e, %ah
 	int	$0x10
