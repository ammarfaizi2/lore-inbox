Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262244AbTHTUWT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 16:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262245AbTHTUWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 16:22:19 -0400
Received: from pop3.infonegocio.com ([213.4.129.150]:32510 "EHLO
	telesmtp4.mail.isp") by vger.kernel.org with ESMTP id S262244AbTHTUWR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 16:22:17 -0400
Subject: [PATCH] Build Broken for 2.6.0-test3-bk8
From: Emilio =?ISO-8859-1?Q?Jes=FAs?= Gallego Arias 
	<egallego@telefonica.net>
To: agoddard@purdue.edu
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1061410952.568.8.camel@ellugar>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 20 Aug 2003 22:22:32 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the same error, and applied this patch. Don't know if it's the way
to go:

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or
higher.
# This patch includes the following deltas:
#                  ChangeSet    1.1279  -> 1.1280
#       arch/i386/kernel/setup.c        1.92    -> 1.93
#       arch/i386/kernel/acpi/boot.c    1.27    -> 1.28
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/08/20      emilio@ellugar.(none)   1.1280
# - Fix build error due a missing include.
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/acpi/boot.c b/arch/i386/kernel/acpi/boot.c
--- a/arch/i386/kernel/acpi/boot.c      Wed Aug 20 22:18:04 2003
+++ b/arch/i386/kernel/acpi/boot.c      Wed Aug 20 22:18:04 2003
@@ -34,6 +34,7 @@
 #if defined (CONFIG_X86_LOCAL_APIC)
 #include <mach_apic.h>
 #include <mach_mpparse.h>
+#include <asm/io_apic.h>
 #endif
  
 #define PREFIX                 "ACPI: "
diff -Nru a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
--- a/arch/i386/kernel/setup.c  Wed Aug 20 22:18:04 2003
+++ b/arch/i386/kernel/setup.c  Wed Aug 20 22:18:04 2003
@@ -43,6 +43,7 @@
 #include <asm/setup.h>
 #include <asm/arch_hooks.h>
 #include <asm/sections.h>
+#include <asm/io_apic.h>
 #include "setup_arch_pre.h"
 #include "mach_resources.h"


