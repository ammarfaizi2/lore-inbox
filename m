Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030196AbWBTMoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbWBTMoT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 07:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030197AbWBTMoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 07:44:19 -0500
Received: from mipsfw.mips-uk.com ([194.74.144.146]:21785 "EHLO
	bacchus.dhis.org") by vger.kernel.org with ESMTP id S1030196AbWBTMoS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 07:44:18 -0500
Date: Mon, 20 Feb 2006 12:41:55 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, ysato@users.sourceforge.jp
Subject: [H8/300] CONFIG_CONFIG_ doesn't fly.
Message-ID: <20060220124155.GA10763@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All actual uses of the symbol refer to CONFIG_SH_STANDARD_BIOS so this
option could never be activated on H8/300.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/h8300/Kconfig.debug |    2 +-
 arch/h8300/defconfig     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/h8300/Kconfig.debug b/arch/h8300/Kconfig.debug
index 55034d0..e0e9bcb 100644
--- a/arch/h8300/Kconfig.debug
+++ b/arch/h8300/Kconfig.debug
@@ -34,7 +34,7 @@ config GDB_DEBUG
 	help
 	  gdb stub exception support
 
-config CONFIG_SH_STANDARD_BIOS
+config SH_STANDARD_BIOS
 	bool "Use gdb protocol serial console"
 	depends on (!H8300H_SIM && !H8S_SIM)
 	help
diff --git a/arch/h8300/defconfig b/arch/h8300/defconfig
index 9d9b491..8f1ec32 100644
--- a/arch/h8300/defconfig
+++ b/arch/h8300/defconfig
@@ -328,7 +328,7 @@ CONFIG_FULLDEBUG=y
 CONFIG_NO_KERNEL_MSG=y
 # CONFIG_SYSCALL_PRINT is not set
 # CONFIG_GDB_DEBUG is not set
-# CONFIG_CONFIG_SH_STANDARD_BIOS is not set
+# CONFIG_SH_STANDARD_BIOS is not set
 # CONFIG_DEFAULT_CMDLINE is not set
 # CONFIG_BLKDEV_RESERVE is not set
 
