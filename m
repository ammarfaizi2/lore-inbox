Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267204AbTBLOMS>; Wed, 12 Feb 2003 09:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267162AbTBLOL1>; Wed, 12 Feb 2003 09:11:27 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:50048 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S267176AbTBLOKN>; Wed, 12 Feb 2003 09:10:13 -0500
Date: Wed, 12 Feb 2003 23:18:55 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCHSET] PC-9800 subarch. support for 2.5.60 (34/34) rtc-update
Message-ID: <20030212141855.GI1551@yuzuki.cinet.co.jp>
References: <20030212131737.GA1551@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030212131737.GA1551@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patchset to support NEC PC-9800 subarchitecture
against 2.5.60 (34/34).

Updates include/asm-i386/upd4990a.h in 2.5.50-ac1.

- Osamu Tomita

diff -Nru linux-2.5.50-ac1/include/asm-i386/upd4990a.h linux98-2.5.54/include/asm-i386/upd4990a.h
--- linux-2.5.50-ac1/include/asm-i386/upd4990a.h	2003-01-04 10:47:57.000000000 +0900
+++ linux98-2.5.54/include/asm-i386/upd4990a.h	2003-01-04 13:51:27.000000000 +0900
@@ -13,10 +13,6 @@
 #ifndef _ASM_I386_uPD4990A_H
 #define _ASM_I386_uPD4990A_H
 
-#include <linux/config.h>
-
-#ifdef CONFIG_PC9800
-
 #include <asm/io.h>
 
 #define UPD4990A_IO		(0x0020)
@@ -53,6 +49,4 @@
 /* Caller should ignore all bits except bit0 */
 #define UPD4990A_READ_DATA()	inb(UPD4990A_IO_DATAOUT)
 
-#endif /* CONFIG_PC9800 */
-
 #endif
