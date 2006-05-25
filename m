Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030276AbWEYQ7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030276AbWEYQ7H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 12:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030280AbWEYQ7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 12:59:07 -0400
Received: from xenotime.net ([66.160.160.81]:9151 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030276AbWEYQ7H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 12:59:07 -0400
Date: Thu, 25 May 2006 10:01:38 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: ismail@pardus.org.tr, khali@linux-fr.org, akpm <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org
Subject: [PATCH] scx200_acb: fix section mismatch warning
Message-Id: <20060525100138.cb9e53c5.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix section mismatch warning reported by İsmail Dönmez:
WARNING: drivers/i2c/busses/scx200_acb.o - Section mismatch: reference
to .init.text: from .text after 'scx200_add_cs553x' (at offset 0x528)

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/i2c/busses/scx200_acb.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2617-rc5.orig/drivers/i2c/busses/scx200_acb.c
+++ linux-2617-rc5/drivers/i2c/busses/scx200_acb.c
@@ -491,7 +491,7 @@ static struct pci_device_id divil_pci[] 
 
 #define MSR_LBAR_SMB		0x5140000B
 
-static int scx200_add_cs553x(void)
+static __init int scx200_add_cs553x(void)
 {
 	u32	low, hi;
 	u32	smb_base;


---
