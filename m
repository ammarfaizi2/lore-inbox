Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbWB0PdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbWB0PdH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 10:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964777AbWB0Pci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 10:32:38 -0500
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:21446 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1751470AbWB0PcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 10:32:18 -0500
Subject: [Patch 3/4] Move the base kernel to 2Mb to align with TLB
	boundaries
From: Arjan van de Ven <arjan@linux.intel.com>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, ak@suse.de
In-Reply-To: <1141053825.2992.125.camel@laptopd505.fenrus.org>
References: <1141053825.2992.125.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 27 Feb 2006 16:31:37 +0100
Message-Id: <1141054297.2992.140.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As suggested by Andi (and Alan), move the default kernel location
from 1Mb to 2Mb, to align to the start of a TLB entry.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

---
 arch/x86_64/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-reorder2/arch/x86_64/Kconfig
===================================================================
--- linux-reorder2.orig/arch/x86_64/Kconfig
+++ linux-reorder2/arch/x86_64/Kconfig
@@ -429,10 +429,10 @@ config CRASH_DUMP
 config PHYSICAL_START
 	hex "Physical address where the kernel is loaded" if (EMBEDDED || CRASH_DUMP)
 	default "0x1000000" if CRASH_DUMP
-	default "0x100000"
+	default "0x200000"
 	help
 	  This gives the physical address where the kernel is loaded. Normally
-	  for regular kernels this value is 0x100000 (1MB). But in the case
+	  for regular kernels this value is 0x200000 (2MB). But in the case
 	  of kexec on panic the fail safe kernel needs to run at a different
 	  address than the panic-ed kernel. This option is used to set the load
 	  address for kernels used to capture crash dump on being kexec'ed

