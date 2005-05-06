Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262217AbVEFE0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbVEFE0n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 00:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbVEFE0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 00:26:43 -0400
Received: from ozlabs.org ([203.10.76.45]:34775 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262217AbVEFE0l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 00:26:41 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17018.61989.358715.3023@cargo.ozlabs.ibm.com>
Date: Fri, 6 May 2005 14:27:17 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
CC: anton@samba.org, linux-kernel@vger.kernel.org, olh@suse.de
Subject: [PATCH] ppc64: remove asm/bootinfo.h include
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The defines in bootinfo.h are not used, so the include can be removed.
According to Ben, birecs are not used on ppc64:

  on ppc64, we made the decision of enforcing the presence of an
  OF device-tree and either an OF-like client interface or a kexec
  like flattened tree.
  so if your bootloader want to say things to the kernel,
  it can do so by adding properties to the device-tree


compile-tested with defconfig

Signed-off-by: Olaf Hering <olh@suse.de>
Signed-off-by: Paul Mackerras <paulus@samba.org>
---
Index: linux-2.6.12-rc3-olh/arch/ppc64/boot/main.c
===================================================================
--- linux-2.6.12-rc3-olh.orig/arch/ppc64/boot/main.c
+++ linux-2.6.12-rc3-olh/arch/ppc64/boot/main.c
@@ -14,7 +14,6 @@
 #include <linux/string.h>
 #include <asm/processor.h>
 #include <asm/page.h>
-#include <asm/bootinfo.h>
 
 extern void *finddevice(const char *);
 extern int getprop(void *, const char *, void *, int);
