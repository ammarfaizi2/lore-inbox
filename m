Return-Path: <linux-kernel-owner+w=401wt.eu-S965170AbWLTX7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965170AbWLTX7g (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 18:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965169AbWLTX7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 18:59:36 -0500
Received: from tomts20.bellnexxia.net ([209.226.175.74]:59220 "EHLO
	tomts20-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965160AbWLTX7f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 18:59:35 -0500
Date: Wed, 20 Dec 2006 18:59:30 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>
Cc: ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Douglas Niehaus <niehaus@eecs.ku.edu>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 2/4] Linux Kernel Markers : kconfig menus
Message-ID: <20061220235930.GC28643@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20061220235216.GA28643@Krystal>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 18:57:59 up 119 days, 21:05,  6 users,  load average: 1.07, 0.98, 0.83
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Markers : kconfig menus

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

--- a/Makefile
+++ b/Makefile
@@ -308,7 +308,8 @@ # Use LINUXINCLUDE when you must referen
 # Needed to be compatible with the O= option
 LINUXINCLUDE    := -Iinclude \
                    $(if $(KBUILD_SRC),-Iinclude2 -I$(srctree)/include) \
-		   -include include/linux/autoconf.h
+		   -include include/linux/autoconf.h \
+		   -include linux/marker.h
 
 CPPFLAGS        := -D__KERNEL__ $(LINUXINCLUDE)
 
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -638,6 +638,12 @@ source "fs/Kconfig"
 
 source "arch/alpha/oprofile/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/alpha/Kconfig.debug"
 
 source "security/Kconfig"
--- a/arch/cris/Kconfig
+++ b/arch/cris/Kconfig
@@ -191,6 +191,12 @@ source "sound/Kconfig"
 
 source "drivers/usb/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/cris/Kconfig.debug"
 
 source "security/Kconfig"
--- a/arch/frv/Kconfig
+++ b/arch/frv/Kconfig
@@ -375,6 +375,12 @@ source "drivers/Kconfig"
 
 source "fs/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/frv/Kconfig.debug"
 
 source "security/Kconfig"
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -205,6 +205,12 @@ endmenu
 
 source "fs/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/h8300/Kconfig.debug"
 
 source "security/Kconfig"
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -1169,6 +1169,9 @@ config KPROBES
 	  a probepoint and specifies the callback.  Kprobes is useful
 	  for kernel debugging, non-intrusive instrumentation and testing.
 	  If in doubt, say "N".
+
+source "kernel/Kconfig.marker"
+
 endmenu
 
 source "arch/i386/Kconfig.debug"
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -564,6 +564,9 @@ config KPROBES
 	  a probepoint and specifies the callback.  Kprobes is useful
 	  for kernel debugging, non-intrusive instrumentation and testing.
 	  If in doubt, say "N".
+
+source "kernel/Kconfig.marker"
+
 endmenu
 
 source "arch/ia64/Kconfig.debug"
--- a/arch/m32r/Kconfig
+++ b/arch/m32r/Kconfig
@@ -394,6 +394,12 @@ source "fs/Kconfig"
 
 source "arch/m32r/oprofile/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/m32r/Kconfig.debug"
 
 source "security/Kconfig"
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -660,6 +660,12 @@ endmenu
 
 source "fs/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/m68k/Kconfig.debug"
 
 source "security/Kconfig"
--- a/arch/m68knommu/Kconfig
+++ b/arch/m68knommu/Kconfig
@@ -669,6 +669,12 @@ source "drivers/Kconfig"
 
 source "fs/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/m68knommu/Kconfig.debug"
 
 source "security/Kconfig"
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -1443,8 +1443,14 @@ source "lib/Kconfig"
 
 source "arch/powerpc/oprofile/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/ppc/Kconfig.debug"
 
 source "security/Kconfig"
 
 source "crypto/Kconfig"
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -1185,6 +1185,9 @@ config KPROBES
 	  a probepoint and specifies the callback.  Kprobes is useful
 	  for kernel debugging, non-intrusive instrumentation and testing.
 	  If in doubt, say "N".
+
+source "kernel/Kconfig.marker"
+
 endmenu
 
 source "arch/powerpc/Kconfig.debug"
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -263,6 +263,12 @@ source "fs/Kconfig"
 
 source "arch/parisc/oprofile/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/parisc/Kconfig.debug"
 
 source "security/Kconfig"
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -968,6 +968,12 @@ source "fs/Kconfig"
 
 source "arch/arm/oprofile/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/arm/Kconfig.debug"
 
 source "security/Kconfig"
--- a/arch/arm26/Kconfig
+++ b/arch/arm26/Kconfig
@@ -240,6 +240,12 @@ source "drivers/misc/Kconfig"
 
 source "drivers/usb/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/arm26/Kconfig.debug"
 
 source "security/Kconfig"
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2068,6 +2068,12 @@ source "fs/Kconfig"
 
 source "arch/mips/oprofile/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/mips/Kconfig.debug"
 
 source "security/Kconfig"
@@ -2075,3 +2081,7 @@ source "security/Kconfig"
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
+
+menu "Instrumentation Support"
+
+endmenu
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -518,6 +518,8 @@ config KPROBES
 	  for kernel debugging, non-intrusive instrumentation and testing.
 	  If in doubt, say "N".
 
+source "kernel/Kconfig.marker"
+
 endmenu
 
 source "arch/s390/Kconfig.debug"
--- a/arch/sh64/Kconfig
+++ b/arch/sh64/Kconfig
@@ -284,6 +284,12 @@ source "fs/Kconfig"
 
 source "arch/sh64/oprofile/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/sh64/Kconfig.debug"
 
 source "security/Kconfig"
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -707,6 +707,12 @@ source "fs/Kconfig"
 
 source "arch/sh/oprofile/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/sh/Kconfig.debug"
 
 source "security/Kconfig"
--- a/arch/sparc64/Kconfig
+++ b/arch/sparc64/Kconfig
@@ -443,6 +443,9 @@ config KPROBES
 	  a probepoint and specifies the callback.  Kprobes is useful
 	  for kernel debugging, non-intrusive instrumentation and testing.
 	  If in doubt, say "N".
+
+source "kernel/Kconfig.marker"
+
 endmenu
 
 source "arch/sparc64/Kconfig.debug"
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -302,6 +302,8 @@ menu "Instrumentation Support"
 
 source "arch/sparc/oprofile/Kconfig"
 
+source "kernel/Kconfig.marker"
+
 endmenu
 
 source "arch/sparc/Kconfig.debug"
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -344,4 +344,10 @@ config INPUT
 	bool
 	default n
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/um/Kconfig.debug"
--- a/arch/v850/Kconfig
+++ b/arch/v850/Kconfig
@@ -332,6 +332,12 @@ source "sound/Kconfig"
 
 source "drivers/usb/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/v850/Kconfig.debug"
 
 source "security/Kconfig"
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -244,6 +244,12 @@ config EMBEDDED_RAMDISK_IMAGE
 	  provide one yourself.
 endmenu
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/xtensa/Kconfig.debug"
 
 source "security/Kconfig"
--- a/arch/x86_64/Kconfig
+++ b/arch/x86_64/Kconfig
@@ -731,6 +731,9 @@ config KPROBES
 	  a probepoint and specifies the callback.  Kprobes is useful
 	  for kernel debugging, non-intrusive instrumentation and testing.
 	  If in doubt, say "N".
+
+source "kernel/Kconfig.marker"
+
 endmenu
 
 source "arch/x86_64/Kconfig.debug"

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
