Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266733AbUHCQwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266733AbUHCQwa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 12:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266731AbUHCQwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 12:52:30 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:16289 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S266737AbUHCQwZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 12:52:25 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] add missing watchdog COMPATIBLE_IOCTLs
Date: Tue, 3 Aug 2004 18:51:38 +0200
User-Agent: KMail/1.6.2
Cc: akpm@osdl.org, Wim Van Sebroeck <wim@iguana.be>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408031851.40923.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The watchdog ioctl interface is defined correctly for 32 bit emulation,
although WIOC_GETSUPPORT was not marked as such, for an unclear reason.
WDIOC_SETTIMEOUT and WDIOC_GETTIMEOUT were added in may 2002 to the
code but never to the ioctl list. This adds all three definitions.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff -u -r1.15 compat_ioctl.h
--- ./include/linux/compat_ioctl.h	16 Jun 2004 14:34:50 -0000	1.15
+++ ./include/linux/compat_ioctl.h	3 Aug 2004 15:47:03 -0000
@@ -593,12 +593,14 @@
 COMPATIBLE_IOCTL(ATMMPC_CTRL)
 COMPATIBLE_IOCTL(ATMMPC_DATA)
 /* Big W */
-/* WIOC_GETSUPPORT not yet implemented -E */
+COMPATIBLE_IOCTL(WDIOC_GETSUPPORT)
 COMPATIBLE_IOCTL(WDIOC_GETSTATUS)
 COMPATIBLE_IOCTL(WDIOC_GETBOOTSTATUS)
 COMPATIBLE_IOCTL(WDIOC_GETTEMP)
 COMPATIBLE_IOCTL(WDIOC_SETOPTIONS)
 COMPATIBLE_IOCTL(WDIOC_KEEPALIVE)
+COMPATIBLE_IOCTL(WDIOC_SETTIMEOUT)
+COMPATIBLE_IOCTL(WDIOC_GETTIMEOUT)
 /* Big R */
 COMPATIBLE_IOCTL(RNDGETENTCNT)
 COMPATIBLE_IOCTL(RNDADDTOENTCNT)
