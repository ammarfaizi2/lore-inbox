Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263731AbTDGWrN (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 18:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263743AbTDGWrN (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 18:47:13 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:39296
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263731AbTDGWrG (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 18:47:06 -0400
Date: Tue, 8 Apr 2003 01:06:00 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080006.h38060AH008929@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: parisc - syscalls return long purity ...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/arch/parisc/kernel/sys_parisc32.c linux-2.5.67-ac1/arch/parisc/kernel/sys_parisc32.c
--- linux-2.5.67/arch/parisc/kernel/sys_parisc32.c	2003-03-26 19:59:49.000000000 +0000
+++ linux-2.5.67-ac1/arch/parisc/kernel/sys_parisc32.c	2003-04-03 23:27:34.000000000 +0100
@@ -1592,7 +1592,7 @@
 	return sys_semctl (semid, semnum, cmd, arg);
 }
 
-extern int sys_lookup_dcookie(u64 cookie64, char *buf, size_t len);
+extern long sys_lookup_dcookie(u64 cookie64, char *buf, size_t len);
 
 long sys32_lookup_dcookie(u32 cookie_high, u32 cookie_low, char *buf,
 			  size_t len)
