Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbWEAXJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbWEAXJY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 19:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWEAXJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 19:09:24 -0400
Received: from xenotime.net ([66.160.160.81]:916 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932308AbWEAXJY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 19:09:24 -0400
Date: Mon, 1 May 2006 16:11:48 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, mhw@wittsend.com
Subject: [PATCH] ip2: fix sections
Message-Id: <20060501161148.0143d99b.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix sections mismatch:
WARNING: drivers/char/ip2/ip2main.o - Section mismatch: reference to .init.text: from .text.cleanup_module after 'cleanup_module' (at offset 0xb0)
WARNING: drivers/char/ip2/ip2main.o - Section mismatch: reference to .init.text: from .text.ip2_loadmain after 'ip2_loadmain' (at offset 0x11b3)

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/char/ip2/ip2main.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2617-rc3.orig/drivers/char/ip2/ip2main.c
+++ linux-2617-rc3/drivers/char/ip2/ip2main.c
@@ -337,7 +337,7 @@ clear_requested_irq( char irq )
 }
 #endif
 
-static int __init
+static int
 have_requested_irq( char irq )
 {
 	// array init to zeros so 0 irq will not be requested as a side effect


---
