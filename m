Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267419AbSKQAOz>; Sat, 16 Nov 2002 19:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267420AbSKQAOz>; Sat, 16 Nov 2002 19:14:55 -0500
Received: from gateway.cinet.co.jp ([210.166.75.129]:26952 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S267419AbSKQAOx>; Sat, 16 Nov 2002 19:14:53 -0500
Message-ID: <3DD6E10B.EF597421@cinet.co.jp>
Date: Sun, 17 Nov 2002 09:21:31 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.47-ac5-pc98smp i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [RFC][PATCH 2.5-ac] Doesn't  boot when compile for i386, i486
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.45-ac1 and 2.5.47-ac[1-5] doesn't boot when compile
 for CPU without TSC.
By following patch, boot and work at this time.
Any problems? Please comment.

--- linux-2.5.47-ac4/arch/i386/Kconfig.orig	Fri Nov 15 12:13:36 2002
+++ linux-2.5.47-ac4/arch/i386/Kconfig	Fri Nov 15 13:18:14 2002
@@ -290,8 +290,10 @@
 	depends on M686 || MPENTIUMIII || MPENTIUMIV || MK7 || MCRUSOE
 	default y
 
-config X86_HAVE_PIT
+config X86_PIT
+	bool
 	depends on M386 || M486 || M586 ||  MGEODE || X86_NUMAQ || VOYAGER || MWINCHIPC6 || MWINCHIP2 || MWINCHIP3D
+	default y
 
 config X86_OOSTORE
 	bool
-- 
Osamu Tomita
tomita@cinet.co.jp
