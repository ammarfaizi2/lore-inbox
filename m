Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264984AbUFRFDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264984AbUFRFDN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 01:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264986AbUFRFDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 01:03:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:37292 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264984AbUFRFDJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 01:03:09 -0400
Date: Thu, 17 Jun 2004 21:58:12 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: water modem <lundby@ameritech.net>, davej@codemonkey.org.uk
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: [PATCH] undefined reference to `acpi_processor_register_performance
Message-Id: <20040617215812.105c67d0.rddunlap@osdl.org>
In-Reply-To: <40D26DD5.60809@ameritech.net>
References: <40D20080.9040909@ameritech.net>
	<20040617201243.4ebfc9b2.rddunlap@osdl.org>
	<40D26DD5.60809@ameritech.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Several CPU_FREQ options need ACPI_PROCESSOR interfaces
to build.

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>


diffstat:=
 arch/i386/kernel/cpu/cpufreq/Kconfig |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -Naurp ./arch/i386/kernel/cpu/cpufreq/Kconfig~cpu_freqs ./arch/i386/kernel/cpu/cpufreq/Kconfig
--- ./arch/i386/kernel/cpu/cpufreq/Kconfig~cpu_freqs	2004-06-15 22:19:01.000000000 -0700
+++ ./arch/i386/kernel/cpu/cpufreq/Kconfig	2004-06-17 21:52:21.000000000 -0700
@@ -80,7 +80,7 @@ config X86_POWERNOW_K6
 
 config X86_POWERNOW_K7
 	tristate "AMD Mobile Athlon/Duron PowerNow!"
-	depends on CPU_FREQ_TABLE
+	depends on CPU_FREQ_TABLE && ACPI_PROCESSOR
 	help
 	  This adds the CPUFreq driver for mobile AMD K7 mobile processors.
 
@@ -90,7 +90,7 @@ config X86_POWERNOW_K7
 
 config X86_POWERNOW_K8
 	tristate "AMD Opteron/Athlon64 PowerNow!"
-	depends on CPU_FREQ && EXPERIMENTAL
+	depends on CPU_FREQ && ACPI_PROCESSOR && EXPERIMENTAL
 	help
 	  This adds the CPUFreq driver for mobile AMD Opteron/Athlon64 processors.
 
@@ -111,7 +111,7 @@ config X86_GX_SUSPMOD
 
 config X86_SPEEDSTEP_CENTRINO
 	tristate "Intel Enhanced SpeedStep"
-	depends on CPU_FREQ_TABLE
+	depends on CPU_FREQ_TABLE && ACPI_PROCESSOR
 	help
 	  This adds the CPUFreq driver for Enhanced SpeedStep enabled
 	  mobile CPUs.  This means Intel Pentium M (Centrino) CPUs.

