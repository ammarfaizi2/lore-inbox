Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbWHJTxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWHJTxH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbWHJTvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:51:55 -0400
Received: from mail.suse.de ([195.135.220.2]:24721 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932674AbWHJThU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:37:20 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [120/145] i386/x86-64: Improve Kconfig description of CRASH_DUMP
Message-Id: <20060810193719.52AE513B8E@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:37:19 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

Improve Kconfig description of CONFIG_CRASH_DUMP. Previously
it was too brief to be useful.

Cc: vgoyal@in.ibm.com
Cc: ebiederm@xmission.com

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/Kconfig   |    7 +++++++
 arch/x86_64/Kconfig |    9 ++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

Index: linux/arch/i386/Kconfig
===================================================================
--- linux.orig/arch/i386/Kconfig
+++ linux/arch/i386/Kconfig
@@ -759,6 +759,13 @@ config CRASH_DUMP
 	depends on HIGHMEM
 	help
 	  Generate crash dump after being started by kexec.
+          This should be normally only set in special crash dump kernels
+	  which are loaded in the main kernel with kexec-tools into
+	  a specially reserved region and then later executed after
+	  a crash by kdump/kexec. The crash dump kernel must be compiled
+          to a memory address not used by the main kernel or BIOS using
+          PHYSICAL_START.
+	  For more details see Documentation/kdump/kdump.txt
 
 config PHYSICAL_START
 	hex "Physical address where the kernel is loaded" if (EMBEDDED || CRASH_DUMP)
Index: linux/arch/x86_64/Kconfig
===================================================================
--- linux.orig/arch/x86_64/Kconfig
+++ linux/arch/x86_64/Kconfig
@@ -484,7 +484,14 @@ config CRASH_DUMP
 	bool "kernel crash dumps (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
 	help
-		Generate crash dump after being started by kexec.
+          Generate crash dump after being started by kexec.
+          This should be normally only set in special crash dump kernels
+          which are loaded in the main kernel with kexec-tools into
+          a specially reserved region and then later executed after
+          a crash by kdump/kexec. The crash dump kernel must be compiled
+	  to a memory address not used by the main kernel or BIOS using
+	  PHYSICAL_START.
+          For more details see Documentation/kdump/kdump.txt
 
 config PHYSICAL_START
 	hex "Physical address where the kernel is loaded" if (EMBEDDED || CRASH_DUMP)
