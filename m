Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264878AbSLMPlm>; Fri, 13 Dec 2002 10:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264888AbSLMPlm>; Fri, 13 Dec 2002 10:41:42 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:45483 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S264878AbSLMPli>; Fri, 13 Dec 2002 10:41:38 -0500
Date: Fri, 13 Dec 2002 16:47:53 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk,
       alan@lxorguk.ukuu.org.uk, davej@suse.de
Subject: [PATCH 2.5] cpufreq: move x86 configuration to "Power Management"
Message-ID: <20021213154752.GA16363@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves the Kconfig entries for CPUfreq from "Processor type and
features" to "Power management options".

	Dominik

diff -ruN linux-cpuinfo/arch/i386/Kconfig linux/arch/i386/Kconfig
--- linux-cpuinfo/arch/i386/Kconfig	2002-12-13 15:56:21.000000000 +0100
+++ linux/arch/i386/Kconfig	2002-12-13 16:20:24.000000000 +0100
@@ -465,104 +465,6 @@
 	  Enabling this feature will cause a message to be printed when the P4
 	  enters thermal throttling.
 
-config CPU_FREQ
-	bool "CPU Frequency scaling"
-	help
-	  Clock scaling allows you to change the clock speed of CPUs on the
-	  fly. This is a nice method to save battery power on notebooks,
-	  because the lower the clock speed, the less power the CPU consumes.
-
-	  For more information, take a look at linux/Documentation/cpufreq or
-	  at <http://www.brodo.de/cpufreq/>
-
-	  If in doubt, say N.
-
-config CPU_FREQ_24_API
-	bool "/proc/sys/cpu/ interface (2.4. / OLD)"
-	depends on CPU_FREQ
-	help
-	  This enables the /proc/sys/cpu/ sysctl interface for controlling
-	  CPUFreq, as known from the 2.4.-kernel patches for CPUFreq. 2.5
-	  uses /proc/cpufreq instead. Please note that some drivers do not 
-	  work well with the 2.4. /proc/sys/cpu sysctl interface, so if in
-	  doubt, say N here.
-
-	  For details, take a look at linux/Documentation/cpufreq. 
-
-	  If in doubt, say N.
-
-config X86_POWERNOW_K6
-	tristate "AMD Mobile K6-2/K6-3 PowerNow!"
-	depends on CPU_FREQ
-	help
-	  This adds the CPUFreq driver for mobile AMD K6-2+ and mobile
-	  AMD K6-3+ processors.
-
-	  For details, take a look at linux/Documentation/cpufreq. 
-
-	  If in doubt, say N.
-
-config ELAN_CPUFREQ
-	tristate "AMD Elan"
-	depends on CPU_FREQ && MELAN
-	---help---
-	  This adds the CPUFreq driver for AMD Elan SC400 and SC410
-	  processors.
-
-	  You need to specify the processor maximum speed as boot
-	  parameter: elanfreq=maxspeed (in kHz) or as module
-	  parameter "max_freq".
-
-	  For details, take a look at linux/Documentation/cpufreq. 
-
-	  If in doubt, say N.
-
-config X86_LONGHAUL
-	tristate "VIA Cyrix III Longhaul"
-	depends on CPU_FREQ
-	help
-	  This adds the CPUFreq driver for VIA Samuel/CyrixIII, 
-	  VIA Cyrix Samuel/C3, VIA Cyrix Ezra and VIA Cyrix Ezra-T 
-	  processors.
-
-	  For details, take a look at linux/Documentation/cpufreq. 
-
-	  If in doubt, say N.
-
-config X86_SPEEDSTEP
-	tristate "Intel Speedstep"
-	depends on CPU_FREQ
-	help
-	  This adds the CPUFreq driver for certain mobile Intel Pentium III
-	  (Coppermine), all mobile Intel Pentium III-M (Tulatin) and all
-	  mobile Intel Pentium 4 P4-Ms.
-
-	  For details, take a look at linux/Documentation/cpufreq. 
-
-	  If in doubt, say N.
-
-config X86_P4_CLOCKMOD
-	tristate "Intel Pentium 4 clock modulation"
-	depends on CPU_FREQ
-	help
-	  This adds the CPUFreq driver for Intel Pentium 4 / XEON
-	  processors.
-
-	  For details, take a look at linux/Documentation/cpufreq. 
-
-	  If in doubt, say N.
-
-config X86_LONGRUN
-	tristate "Transmeta LongRun"
-	depends on CPU_FREQ
-	help
-	  This adds the CPUFreq driver for Transmeta Crusoe processors which
-	  support LongRun.
-
-	  For details, take a look at linux/Documentation/cpufreq. 
-
-	  If in doubt, say N.
-
 config TOSHIBA
 	tristate "Toshiba Laptop support"
 	---help---
@@ -985,6 +887,104 @@
 	  a work-around for a number of buggy BIOSes. Switch this option on if
 	  your computer crashes instead of powering off properly.
 
+config CPU_FREQ
+	bool "CPU Frequency scaling"
+	help
+	  Clock scaling allows you to change the clock speed of CPUs on the
+	  fly. This is a nice method to save battery power on notebooks,
+	  because the lower the clock speed, the less power the CPU consumes.
+
+	  For more information, take a look at linux/Documentation/cpufreq or
+	  at <http://www.brodo.de/cpufreq/>
+
+	  If in doubt, say N.
+
+config CPU_FREQ_24_API
+	bool "/proc/sys/cpu/ interface (2.4. / OLD)"
+	depends on CPU_FREQ
+	help
+	  This enables the /proc/sys/cpu/ sysctl interface for controlling
+	  CPUFreq, as known from the 2.4.-kernel patches for CPUFreq. 2.5
+	  uses /proc/cpufreq instead. Please note that some drivers do not 
+	  work well with the 2.4. /proc/sys/cpu sysctl interface, so if in
+	  doubt, say N here.
+
+	  For details, take a look at linux/Documentation/cpufreq. 
+
+	  If in doubt, say N.
+
+config X86_POWERNOW_K6
+	tristate "AMD Mobile K6-2/K6-3 PowerNow!"
+	depends on CPU_FREQ
+	help
+	  This adds the CPUFreq driver for mobile AMD K6-2+ and mobile
+	  AMD K6-3+ processors.
+
+	  For details, take a look at linux/Documentation/cpufreq. 
+
+	  If in doubt, say N.
+
+config ELAN_CPUFREQ
+	tristate "AMD Elan"
+	depends on CPU_FREQ && MELAN
+	---help---
+	  This adds the CPUFreq driver for AMD Elan SC400 and SC410
+	  processors.
+
+	  You need to specify the processor maximum speed as boot
+	  parameter: elanfreq=maxspeed (in kHz) or as module
+	  parameter "max_freq".
+
+	  For details, take a look at linux/Documentation/cpufreq. 
+
+	  If in doubt, say N.
+
+config X86_LONGHAUL
+	tristate "VIA Cyrix III Longhaul"
+	depends on CPU_FREQ
+	help
+	  This adds the CPUFreq driver for VIA Samuel/CyrixIII, 
+	  VIA Cyrix Samuel/C3, VIA Cyrix Ezra and VIA Cyrix Ezra-T 
+	  processors.
+
+	  For details, take a look at linux/Documentation/cpufreq. 
+
+	  If in doubt, say N.
+
+config X86_SPEEDSTEP
+	tristate "Intel Speedstep"
+	depends on CPU_FREQ
+	help
+	  This adds the CPUFreq driver for certain mobile Intel Pentium III
+	  (Coppermine), all mobile Intel Pentium III-M (Tulatin) and all
+	  mobile Intel Pentium 4 P4-Ms.
+
+	  For details, take a look at linux/Documentation/cpufreq. 
+
+	  If in doubt, say N.
+
+config X86_P4_CLOCKMOD
+	tristate "Intel Pentium 4 clock modulation"
+	depends on CPU_FREQ
+	help
+	  This adds the CPUFreq driver for Intel Pentium 4 / XEON
+	  processors.
+
+	  For details, take a look at linux/Documentation/cpufreq. 
+
+	  If in doubt, say N.
+
+config X86_LONGRUN
+	tristate "Transmeta LongRun"
+	depends on CPU_FREQ
+	help
+	  This adds the CPUFreq driver for Transmeta Crusoe processors which
+	  support LongRun.
+
+	  For details, take a look at linux/Documentation/cpufreq. 
+
+	  If in doubt, say N.
+
 endmenu
 
 
