Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268303AbUIGUHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268303AbUIGUHg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 16:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268289AbUIGT7C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 15:59:02 -0400
Received: from cantor.suse.de ([195.135.220.2]:51606 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268581AbUIGT5T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 15:57:19 -0400
Date: Tue, 7 Sep 2004 21:57:19 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] remove tmpfile for ppc binutils check
Message-ID: <20040907195719.GB14276@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


make distclean does not remove the new tmp file .tmp_gas_check.

Signed-off-by: Olaf Hering <olh@suse.de>

diff -purN linux-2.6.9-rc1-bk14.orig/arch/ppc/Makefile linux-2.6.9-rc1-bk14/arch/ppc/Makefile
--- linux-2.6.9-rc1-bk14.orig/arch/ppc/Makefile	2004-09-07 21:08:39.000000000 +0200
+++ linux-2.6.9-rc1-bk14/arch/ppc/Makefile	2004-09-07 21:50:54.249282101 +0200
@@ -131,4 +131,6 @@ endif
 	@true
 
 CLEAN_FILES +=	include/asm-$(ARCH)/offsets.h \
-		arch/$(ARCH)/kernel/asm-offsets.s
+		arch/$(ARCH)/kernel/asm-offsets.s \
+		$(TOUT)
+		
-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
