Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267335AbUJIT51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267335AbUJIT51 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 15:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267341AbUJIT50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 15:57:26 -0400
Received: from [145.85.127.2] ([145.85.127.2]:43490 "EHLO mail.il.fontys.nl")
	by vger.kernel.org with ESMTP id S267335AbUJIT5Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 15:57:24 -0400
Message-ID: <64778.217.121.83.210.1097351837.squirrel@217.121.83.210>
Date: Sat, 9 Oct 2004 21:57:17 +0200 (CEST)
Subject: [Patch 1/5] xbox: add 'CONFIG_X86_XBOX' to kernel configuration
From: "Ed Schouten" <ed@il.fontys.nl>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support the Microsoft Xbox, we need to add a config option
'CONFIG_X86_XBOX'.

You can also download this patch at:
http://linux.g-rave.nl/patches/patch-xbox-config_option.diff
---

 Kconfig |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletion(-)

diff -u -r --new-file linux-2.6.9-rc3/arch/i386/Kconfig
linux-2.6.9-rc3-ed0/arch/i386/Kconfig
--- linux-2.6.9-rc3/arch/i386/Kconfig	2004-09-30 05:03:56.000000000 +0200
+++ linux-2.6.9-rc3-ed0/arch/i386/Kconfig	2004-10-09 19:32:33.981610000 +0200
@@ -55,6 +55,18 @@

 	  If unsure, choose "PC-compatible" instead.

+config X86_XBOX
+	bool "Microsoft Xbox"
+	help
+	  This option is needed to make Linux boot on a Microsoft Xbox.
+
+	  If you are not planning on running this kernel on a Microsoft Xbox,
+	  say N here, otherwise the kernel you build will not be bootable.
+
+	  For more information about Xbox Linux, visit:
+
+	  http://www.xbox-linux.org/
+
 config X86_VOYAGER
 	bool "Voyager (NCR)"
 	help
@@ -1206,7 +1218,7 @@

 config X86_BIOS_REBOOT
 	bool
-	depends on !(X86_VISWS || X86_VOYAGER)
+	depends on !(X86_VISWS || X86_VOYAGER || X86_XBOX)
 	default y

 config X86_TRAMPOLINE
