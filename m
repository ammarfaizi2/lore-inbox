Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263300AbSJHUke>; Tue, 8 Oct 2002 16:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262690AbSJHTBG>; Tue, 8 Oct 2002 15:01:06 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:16400 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263005AbSJHTAZ>; Tue, 8 Oct 2002 15:00:25 -0400
Subject: PATCH: mpt fusion - remove donothing code
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 8 Oct 2002 19:57:35 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17yzXz-0004sD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/message/fusion/linux_compat.h linux.2.5.41-ac1/drivers/message/fusion/linux_compat.h
--- linux.2.5.41/drivers/message/fusion/linux_compat.h	2002-10-02 21:33:52.000000000 +0100
+++ linux.2.5.41-ac1/drivers/message/fusion/linux_compat.h	2002-10-05 23:56:25.000000000 +0100
@@ -254,8 +254,7 @@
 
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,28)
 #define mptscsih_save_flags(flags) \
-({	local_save_flags(flags); \
-	local_irq_disable(); \
+({	local_irq_save(flags); \
 })
 #else
 #define mptscsih_save_flags(flags) \
