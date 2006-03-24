Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbWCXQ4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbWCXQ4Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 11:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbWCXQ4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 11:56:16 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:44295 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751137AbWCXQ4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 11:56:15 -0500
Date: Fri, 24 Mar 2006 17:56:13 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] let x86 subarchs select SMP
Message-ID: <20060324165613.GF22727@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The SMP question comes after the subarch question, and it does therefore 
make sense to let the SMP-only subarchs select SMP instead of depending 
on it.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 18 Mar 2006

 arch/i386/Kconfig |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.16-rc6-mm2-full/arch/i386/Kconfig.old	2006-03-18 15:10:30.000000000 +0100
+++ linux-2.6.16-rc6-mm2-full/arch/i386/Kconfig	2006-03-18 15:11:14.000000000 +0100
@@ -95,7 +95,7 @@
 
 config X86_SUMMIT
 	bool "Summit/EXA (IBM x440)"
-	depends on SMP
+	select SMP
 	help
 	  This option is needed for IBM systems that use the Summit/EXA chipset.
 	  In particular, it is needed for the x440.
@@ -104,7 +104,7 @@
 
 config X86_BIGSMP
 	bool "Support for other sub-arch SMP systems with more than 8 CPUs"
-	depends on SMP
+	select SMP
 	help
 	  This option is needed for the systems that have more than 8 CPUs
 	  and if the system is not of any sub-arch type above.
@@ -124,14 +124,14 @@
 
 config X86_GENERICARCH
        bool "Generic architecture (Summit, bigsmp, ES7000, default)"
-       depends on SMP
+       select SMP
        help
           This option compiles in the Summit, bigsmp, ES7000, default subarchitectures.
 	  It is intended for a generic binary kernel.
 
 config X86_ES7000
 	bool "Support for Unisys ES7000 IA32 series"
-	depends on SMP
+	select SMP
 	help
 	  Support for Unisys ES7000 systems.  Say 'Y' here if this kernel is
 	  supposed to run on an IA32-based Unisys ES7000 system.

