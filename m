Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422822AbWA1Dfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422822AbWA1Dfc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 22:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422778AbWA1Dfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 22:35:31 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:170 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S965013AbWA1Df2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 22:35:28 -0500
Date: Sat, 28 Jan 2006 12:34:41 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: akpm@osdl.org, Andy Whitcroft <apw@shadowen.org>,
       Bob Picco <bob.picco@hp.com>, Paul Jackson <pj@sgi.com>
Subject: [PATCH 002/003]Fix unify mapping from pxm to node id. 
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       linux-ia64@vger.kernel.org, tony.luck@intel.com, ak@suse.de,
       len.brown@intel.com, discuss@x86-64.org
In-Reply-To: <20060126074846.1a6dd300.pj@sgi.com>
References: <20060123165644.C147.Y-GOTO@jp.fujitsu.com> <20060126074846.1a6dd300.pj@sgi.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.057
Message-Id: <20060128122934.CF53.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.21.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Enable ACPI_NUMA for x86 machines with SRAT's.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

 arch/i386/Kconfig    |    1 +
 drivers/acpi/Kconfig |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)
diff -upN reference/arch/i386/Kconfig current/arch/i386/Kconfig
--- reference/arch/i386/Kconfig
+++ current/arch/i386/Kconfig
@@ -139,6 +139,7 @@ config ACPI_SRAT
 	bool
 	default y
 	depends on NUMA && (X86_SUMMIT || X86_GENERICARCH)
+	select ACPI_NUMA
 
 config X86_SUMMIT_NUMA
 	bool
diff -upN reference/drivers/acpi/Kconfig current/drivers/acpi/Kconfig
--- reference/drivers/acpi/Kconfig
+++ current/drivers/acpi/Kconfig
@@ -162,7 +162,7 @@ config ACPI_THERMAL
 config ACPI_NUMA
 	bool "NUMA support"
 	depends on NUMA
-	depends on (IA64 || X86_64)
+	depends on (X86_32 || IA64 || X86_64)
 	default y if IA64_GENERIC || IA64_SGI_SN2
 
 config ACPI_ASUS

-- 
Yasunori Goto 


