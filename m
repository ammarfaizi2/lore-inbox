Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261489AbUJZVco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbUJZVco (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 17:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261483AbUJZVcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 17:32:42 -0400
Received: from fmr03.intel.com ([143.183.121.5]:13778 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S261489AbUJZVb3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 17:31:29 -0400
Date: Tue, 26 Oct 2004 14:28:26 -0700
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: akpm@osdl.org
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH] Add p4-clockmod driver in x86-64
Message-ID: <20041026142826.A24417@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add links for p4-clockmod driver in x86-64 cpufreq. 

Signed-off-by:: "Venkatesh Pallipadi" <venkatesh.pallipadi@intel.com>
 
--- linux-2.6.9/arch/x86_64/kernel/cpufreq/Makefile.org	2004-10-25 16:00:03.000000000 -0700
+++ linux-2.6.9/arch/x86_64/kernel/cpufreq/Makefile	2004-10-25 16:10:30.000000000 -0700
@@ -7,7 +7,11 @@ SRCDIR := ../../../i386/kernel/cpu/cpufr
 obj-$(CONFIG_X86_POWERNOW_K8) += powernow-k8.o
 obj-$(CONFIG_X86_SPEEDSTEP_CENTRINO) += speedstep-centrino.o
 obj-$(CONFIG_X86_ACPI_CPUFREQ) += acpi.o
+obj-$(CONFIG_X86_P4_CLOCKMOD) += p4-clockmod.o
+obj-$(CONFIG_X86_SPEEDSTEP_LIB) += speedstep-lib.o
 
 powernow-k8-objs := ${SRCDIR}/powernow-k8.o
 speedstep-centrino-objs := ${SRCDIR}/speedstep-centrino.o
 acpi-objs := ${SRCDIR}/acpi.o
+p4-clockmod-objs := ${SRCDIR}/p4-clockmod.o
+speedstep-lib-objs := ${SRCDIR}/speedstep-lib.o
--- linux-2.6.9/arch/x86_64/kernel/cpufreq/Kconfig.org	2004-10-25 16:00:08.000000000 -0700
+++ linux-2.6.9/arch/x86_64/kernel/cpufreq/Kconfig	2004-10-25 16:09:29.000000000 -0700
@@ -94,5 +94,23 @@ config X86_ACPI_CPUFREQ_PROC_INTF
 
 	  If in doubt, say N.
 
+config X86_P4_CLOCKMOD
+	tristate "Intel Pentium 4 clock modulation"
+	depends on CPU_FREQ_TABLE
+	help
+	  This adds the CPUFreq driver for Intel Pentium 4 / XEON
+	  processors.
+
+	  For details, take a look at <file:Documentation/cpu-freq/>.
+
+	  If in doubt, say N.
+
+
+config X86_SPEEDSTEP_LIB
+        tristate
+        depends on (X86_P4_CLOCKMOD)
+        default (X86_P4_CLOCKMOD)
+
+
 endmenu
 
