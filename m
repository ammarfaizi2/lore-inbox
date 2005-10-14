Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbVJNKzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbVJNKzm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 06:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbVJNKzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 06:55:42 -0400
Received: from mail.cs.umu.se ([130.239.40.25]:53443 "EHLO mail.cs.umu.se")
	by vger.kernel.org with ESMTP id S1750710AbVJNKzm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 06:55:42 -0400
Date: Fri, 14 Oct 2005 12:55:32 +0200
From: Peter Hagervall <hager@cs.umu.se>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Kconfig fix, (ES7000 dependencies)
Message-ID: <20051014105532.GD8805@peppar.cs.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Targets X86_GENERICARCH and X86_ES7000 fail to build without
CONFIG_ACPI.

Signed-off-by: Peter Hagervall <hager@cs.umu.se>
---

diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -115,14 +115,14 @@ config X86_VISWS
 
 config X86_GENERICARCH
        bool "Generic architecture (Summit, bigsmp, ES7000, default)"
-       depends on SMP
+       depends on SMP && ACPI
        help
           This option compiles in the Summit, bigsmp, ES7000, default subarchitectures.
 	  It is intended for a generic binary kernel.
 
 config X86_ES7000
 	bool "Support for Unisys ES7000 IA32 series"
-	depends on SMP
+	depends on SMP && ACPI
 	help
 	  Support for Unisys ES7000 systems.  Say 'Y' here if this kernel is
 	  supposed to run on an IA32-based Unisys ES7000 system.
