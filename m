Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262919AbTIAPKI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 11:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262962AbTIAPKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 11:10:08 -0400
Received: from m206.net81-67-10.noos.fr ([81.67.10.206]:59106 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP id S262919AbTIAPKC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 11:10:02 -0400
Date: Mon, 1 Sep 2003 17:09:59 +0200
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 2.4.23-pre2/2.6.0-test4] reenable CAPTURE button in sonypi
Message-ID: <20030901150959.GA27269@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Linus Torvalds <torvalds@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This attached patch reenables the CAPTURE button events in the sonypi
driver, which were lost with the latest patch...

The same patch should apply cleanly on both 2.4 and 2.6 kernels.

Marcelo, Linus, please apply.

Stelian.

===== drivers/char/sonypi.h 1.18 vs edited =====
--- 1.18/drivers/char/sonypi.h	Tue Aug 26 13:52:33 2003
+++ edited/drivers/char/sonypi.h	Mon Sep  1 10:37:24 2003
@@ -323,7 +323,7 @@
 	{ SONYPI_DEVICE_MODEL_TYPE2, 0, 0xffffffff, sonypi_releaseev },
 	{ SONYPI_DEVICE_MODEL_TYPE2, 0x38, SONYPI_LID_MASK, sonypi_lidev },
 	{ SONYPI_DEVICE_MODEL_TYPE2, 0x11, SONYPI_JOGGER_MASK, sonypi_joggerev },
-	{ SONYPI_DEVICE_MODEL_TYPE2, 0x08, SONYPI_CAPTURE_MASK, sonypi_captureev },
+	{ SONYPI_DEVICE_MODEL_TYPE2, 0x61, SONYPI_CAPTURE_MASK, sonypi_captureev },
 	{ SONYPI_DEVICE_MODEL_TYPE2, 0x21, SONYPI_FNKEY_MASK, sonypi_fnkeyev },
 	{ SONYPI_DEVICE_MODEL_TYPE2, 0x31, SONYPI_BLUETOOTH_MASK, sonypi_blueev },
 	{ SONYPI_DEVICE_MODEL_TYPE2, 0x08, SONYPI_PKEY_MASK, sonypi_pkeyev },
-- 
Stelian Pop <stelian@popies.net>
