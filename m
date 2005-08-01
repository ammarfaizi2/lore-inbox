Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbVHAVMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVHAVMt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 17:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVHAUej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 16:34:39 -0400
Received: from fmr19.intel.com ([134.134.136.18]:65228 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261239AbVHAUdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 16:33:19 -0400
Message-Id: <20050801203010.952356000@araj-em64t>
References: <20050801202017.043754000@araj-em64t>
Date: Mon, 01 Aug 2005 13:20:18 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ashok Raj <ashok.raj@intel.com>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       zwane@arm.linux.org.uk
Subject: [patch 1/8] x86_64: Reintroduce clustered_apic_check() for x86_64.
Content-Disposition: inline; filename=do_clustered_apic_check
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Auto selection of bigsmp patch removed this check from a shared common file
in arch/i386/kernel/acpi/boot.c. We still need to call this to determine 
the right genapic code for x86_64. 

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
-----------------------------------------------------------
 arch/x86_64/kernel/setup.c |    1 +
 1 files changed, 1 insertion(+)

Index: linux-2.6.13-rc4-mm1/arch/x86_64/kernel/setup.c
===================================================================
--- linux-2.6.13-rc4-mm1.orig/arch/x86_64/kernel/setup.c
+++ linux-2.6.13-rc4-mm1/arch/x86_64/kernel/setup.c
@@ -663,6 +663,7 @@ void __init setup_arch(char **cmdline_p)
 	 * Read APIC and some other early information from ACPI tables.
 	 */
 	acpi_boot_init();
+	clustered_apic_check();
 #endif
 
 #ifdef CONFIG_X86_LOCAL_APIC

--

