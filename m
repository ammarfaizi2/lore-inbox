Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263770AbUFBRvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263770AbUFBRvz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 13:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263756AbUFBRvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 13:51:55 -0400
Received: from fmr05.intel.com ([134.134.136.6]:17890 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S263770AbUFBRvR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 13:51:17 -0400
Date: Wed, 2 Jun 2004 12:40:16 -0700
From: Matt Tolentino <metolent@snoqualmie.dp.intel.com>
Message-Id: <200406021940.i52JeG56002489@snoqualmie.dp.intel.com>
To: akpm@osdl.org
Subject: kill off efi_dir in efi.h
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The /proc support for efi 'stuff' isn't used/needed anymore,
yet the efi_dir declaration remains.  This removes it...

Please apply,

matt

diff -urN linux-2.6.7-rc2/include/linux/efi.h linux-2.6.7-rc2-m/include/linux/efi.h
--- linux-2.6.7-rc2/include/linux/efi.h	2004-05-29 23:26:43.000000000 -0700
+++ linux-2.6.7-rc2-m/include/linux/efi.h	2004-06-02 02:39:34.794675000 -0700
@@ -370,11 +370,4 @@
 	u16 length;
 } __attribute ((packed));
 
-/*
- * efi_dir is allocated in arch/ia64/kernel/efi.c.
- */
-#ifdef CONFIG_PROC_FS
-extern struct proc_dir_entry *efi_dir;
-#endif
-
 #endif /* _LINUX_EFI_H */
