Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030457AbVIIWnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030457AbVIIWnS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 18:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030469AbVIIWlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 18:41:47 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:17741 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S1030456AbVIIWkY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 18:40:24 -0400
Cc: Sam Ravnborg <sam@mars (none)>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 4/12] kbuild: m68k,parisc,ppc,ppc64,s390,xtensa use generic asm-offsets.h support
In-Reply-To: <11263057062389-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Sat, 10 Sep 2005 00:41:46 +0200
Message-Id: <11263057063978-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Delete obsoleted parts form arch makefiles and rename to asm-offsets.h

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 arch/m68k/Makefile                      |    9 ---------
 arch/m68k/fpsp040/skeleton.S            |    2 +-
 arch/m68k/ifpsp060/iskeleton.S          |    2 +-
 arch/m68k/kernel/entry.S                |    2 +-
 arch/m68k/kernel/head.S                 |    2 +-
 arch/m68k/math-emu/fp_emu.h             |    2 +-
 arch/parisc/Makefile                    |   10 +---------
 arch/parisc/hpux/gate.S                 |    2 +-
 arch/parisc/hpux/wrappers.S             |    2 +-
 arch/parisc/kernel/entry.S              |    2 +-
 arch/parisc/kernel/head.S               |    2 +-
 arch/parisc/kernel/process.c            |    2 +-
 arch/parisc/kernel/ptrace.c             |    2 +-
 arch/parisc/kernel/signal.c             |    2 +-
 arch/parisc/kernel/syscall.S            |    2 +-
 arch/parisc/lib/fixup.S                 |    2 +-
 arch/ppc/Makefile                       |   12 ++----------
 arch/ppc/kernel/cpu_setup_6xx.S         |    2 +-
 arch/ppc/kernel/cpu_setup_power4.S      |    2 +-
 arch/ppc/kernel/entry.S                 |    2 +-
 arch/ppc/kernel/fpu.S                   |    2 +-
 arch/ppc/kernel/head.S                  |    2 +-
 arch/ppc/kernel/head_44x.S              |    2 +-
 arch/ppc/kernel/head_4xx.S              |    2 +-
 arch/ppc/kernel/head_8xx.S              |    2 +-
 arch/ppc/kernel/head_fsl_booke.S        |    2 +-
 arch/ppc/kernel/idle_6xx.S              |    2 +-
 arch/ppc/kernel/idle_power4.S           |    2 +-
 arch/ppc/kernel/misc.S                  |    2 +-
 arch/ppc/kernel/swsusp.S                |    2 +-
 arch/ppc/mm/hashtable.S                 |    2 +-
 arch/ppc/platforms/pmac_sleep.S         |    2 +-
 arch/ppc64/Makefile                     |    9 ---------
 arch/ppc64/kernel/cpu_setup_power4.S    |    2 +-
 arch/ppc64/kernel/entry.S               |    2 +-
 arch/ppc64/kernel/head.S                |    2 +-
 arch/ppc64/kernel/idle_power4.S         |    2 +-
 arch/ppc64/kernel/misc.S                |    2 +-
 arch/ppc64/kernel/vdso32/cacheflush.S   |    2 +-
 arch/ppc64/kernel/vdso32/datapage.S     |    2 +-
 arch/ppc64/kernel/vdso32/gettimeofday.S |    2 +-
 arch/ppc64/kernel/vdso64/cacheflush.S   |    2 +-
 arch/ppc64/kernel/vdso64/datapage.S     |    2 +-
 arch/ppc64/kernel/vdso64/gettimeofday.S |    2 +-
 arch/ppc64/mm/hash_low.S                |    2 +-
 arch/ppc64/mm/slb_low.S                 |    2 +-
 arch/s390/Makefile                      |   10 ----------
 arch/s390/kernel/entry.S                |    2 +-
 arch/s390/kernel/entry64.S              |    2 +-
 arch/s390/kernel/head.S                 |    2 +-
 arch/s390/kernel/head64.S               |    2 +-
 arch/s390/lib/uaccess.S                 |    2 +-
 arch/s390/lib/uaccess64.S               |    2 +-
 arch/xtensa/Makefile                    |   10 ++--------
 arch/xtensa/kernel/align.S              |    2 +-
 arch/xtensa/kernel/entry.S              |    2 +-
 arch/xtensa/kernel/process.c            |    2 +-
 arch/xtensa/kernel/vectors.S            |    2 +-
 include/asm-ia64/ptrace.h               |    2 +-
 include/asm-ia64/thread_info.h          |    2 +-
 include/asm-parisc/assembly.h           |    2 +-
 include/asm-xtensa/ptrace.h             |    2 +-
 include/asm-xtensa/uaccess.h            |    2 +-
 63 files changed, 62 insertions(+), 112 deletions(-)

0013a85454c281faaf064ccb576e373a2881aac8
diff --git a/arch/m68k/Makefile b/arch/m68k/Makefile
--- a/arch/m68k/Makefile
+++ b/arch/m68k/Makefile
@@ -113,14 +113,5 @@ else
 	bzip2 -1c vmlinux >vmlinux.bz2
 endif
 
-prepare: include/asm-$(ARCH)/offsets.h
-CLEAN_FILES += include/asm-$(ARCH)/offsets.h
-
-arch/$(ARCH)/kernel/asm-offsets.s: include/asm include/linux/version.h \
-				   include/config/MARKER
-
-include/asm-$(ARCH)/offsets.h: arch/$(ARCH)/kernel/asm-offsets.s
-	$(call filechk,gen-asm-offsets)
-
 archclean:
 	rm -f vmlinux.gz vmlinux.bz2
diff --git a/arch/m68k/fpsp040/skeleton.S b/arch/m68k/fpsp040/skeleton.S
--- a/arch/m68k/fpsp040/skeleton.S
+++ b/arch/m68k/fpsp040/skeleton.S
@@ -40,7 +40,7 @@
 
 #include <linux/linkage.h>
 #include <asm/entry.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 
 |SKELETON	idnt    2,1 | Motorola 040 Floating Point Software Package
 
diff --git a/arch/m68k/ifpsp060/iskeleton.S b/arch/m68k/ifpsp060/iskeleton.S
--- a/arch/m68k/ifpsp060/iskeleton.S
+++ b/arch/m68k/ifpsp060/iskeleton.S
@@ -36,7 +36,7 @@
 
 #include <linux/linkage.h>
 #include <asm/entry.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 
 
 |################################
diff --git a/arch/m68k/kernel/entry.S b/arch/m68k/kernel/entry.S
--- a/arch/m68k/kernel/entry.S
+++ b/arch/m68k/kernel/entry.S
@@ -42,7 +42,7 @@
 #include <asm/traps.h>
 #include <asm/unistd.h>
 
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 
 .globl system_call, buserr, trap
 .globl resume, ret_from_exception
diff --git a/arch/m68k/kernel/head.S b/arch/m68k/kernel/head.S
--- a/arch/m68k/kernel/head.S
+++ b/arch/m68k/kernel/head.S
@@ -263,7 +263,7 @@
 #include <asm/entry.h>
 #include <asm/pgtable.h>
 #include <asm/page.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 
 #ifdef CONFIG_MAC
 
diff --git a/arch/m68k/math-emu/fp_emu.h b/arch/m68k/math-emu/fp_emu.h
--- a/arch/m68k/math-emu/fp_emu.h
+++ b/arch/m68k/math-emu/fp_emu.h
@@ -39,7 +39,7 @@
 #define _FP_EMU_H
 
 #ifdef __ASSEMBLY__
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 #endif
 #include <asm/math-emu.h>
 
diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
--- a/arch/parisc/Makefile
+++ b/arch/parisc/Makefile
@@ -100,15 +100,7 @@ kernel_install: vmlinux
 
 install: kernel_install modules_install
 
-prepare: include/asm-parisc/offsets.h
-
-arch/parisc/kernel/asm-offsets.s: include/asm include/linux/version.h \
-				   include/config/MARKER
-
-include/asm-parisc/offsets.h: arch/parisc/kernel/asm-offsets.s
-	$(call filechk,gen-asm-offsets)
-
-CLEAN_FILES	+= lifimage include/asm-parisc/offsets.h
+CLEAN_FILES	+= lifimage
 MRPROPER_FILES	+= palo.conf
 
 define archhelp
diff --git a/arch/parisc/hpux/gate.S b/arch/parisc/hpux/gate.S
--- a/arch/parisc/hpux/gate.S
+++ b/arch/parisc/hpux/gate.S
@@ -9,7 +9,7 @@
  */
 
 #include <asm/assembly.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 #include <asm/unistd.h>
 #include <asm/errno.h>
 
diff --git a/arch/parisc/hpux/wrappers.S b/arch/parisc/hpux/wrappers.S
--- a/arch/parisc/hpux/wrappers.S
+++ b/arch/parisc/hpux/wrappers.S
@@ -24,7 +24,7 @@
 #warning PA64 support needs more work...did first cut
 #endif
 
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 #include <asm/assembly.h>
 #include <asm/signal.h>
 
diff --git a/arch/parisc/kernel/entry.S b/arch/parisc/kernel/entry.S
--- a/arch/parisc/kernel/entry.S
+++ b/arch/parisc/kernel/entry.S
@@ -23,7 +23,7 @@
  */
 
 #include <linux/config.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 
 /* we have the following possibilities to act on an interruption:
  *  - handle in assembly and use shadowed registers only
diff --git a/arch/parisc/kernel/head.S b/arch/parisc/kernel/head.S
--- a/arch/parisc/kernel/head.S
+++ b/arch/parisc/kernel/head.S
@@ -14,7 +14,7 @@
 
 #include <linux/autoconf.h>	/* for CONFIG_SMP */
 
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 #include <asm/psw.h>
 #include <asm/pdc.h>
 	
diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -47,7 +47,7 @@
 #include <linux/kallsyms.h>
 
 #include <asm/io.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 #include <asm/pdc.h>
 #include <asm/pdc_chassis.h>
 #include <asm/pgalloc.h>
diff --git a/arch/parisc/kernel/ptrace.c b/arch/parisc/kernel/ptrace.c
--- a/arch/parisc/kernel/ptrace.c
+++ b/arch/parisc/kernel/ptrace.c
@@ -23,7 +23,7 @@
 #include <asm/pgtable.h>
 #include <asm/system.h>
 #include <asm/processor.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 
 /* PSW bits we allow the debugger to modify */
 #define USER_PSW_BITS	(PSW_N | PSW_V | PSW_CB)
diff --git a/arch/parisc/kernel/signal.c b/arch/parisc/kernel/signal.c
--- a/arch/parisc/kernel/signal.c
+++ b/arch/parisc/kernel/signal.c
@@ -32,7 +32,7 @@
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
 #include <asm/cacheflush.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 
 #ifdef CONFIG_COMPAT
 #include <linux/compat.h>
diff --git a/arch/parisc/kernel/syscall.S b/arch/parisc/kernel/syscall.S
--- a/arch/parisc/kernel/syscall.S
+++ b/arch/parisc/kernel/syscall.S
@@ -7,7 +7,7 @@
  * sorry about the wall, puffin..
  */
 
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 #include <asm/unistd.h>
 #include <asm/errno.h>
 #include <asm/psw.h>
diff --git a/arch/parisc/lib/fixup.S b/arch/parisc/lib/fixup.S
--- a/arch/parisc/lib/fixup.S
+++ b/arch/parisc/lib/fixup.S
@@ -20,7 +20,7 @@
  * Fixup routines for kernel exception handling.
  */
 #include <linux/config.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 #include <asm/assembly.h>
 #include <asm/errno.h>
 
diff --git a/arch/ppc/Makefile b/arch/ppc/Makefile
--- a/arch/ppc/Makefile
+++ b/arch/ppc/Makefile
@@ -105,13 +105,7 @@ archclean:
 	$(Q)$(MAKE) $(clean)=arch/ppc/boot
 	$(Q)rm -rf include3
 
-prepare: include/asm-$(ARCH)/offsets.h checkbin
-
-arch/$(ARCH)/kernel/asm-offsets.s: include/asm include/linux/version.h \
-				   include/config/MARKER
-
-include/asm-$(ARCH)/offsets.h: arch/$(ARCH)/kernel/asm-offsets.s
-	$(call filechk,gen-asm-offsets)
+prepare: checkbin
 
 # Temporary hack until we have migrated to asm-powerpc
 include/asm: include3/asm
@@ -143,7 +137,5 @@ checkbin:
 		false ; \
 	fi
 
-CLEAN_FILES +=	include/asm-$(ARCH)/offsets.h \
-		arch/$(ARCH)/kernel/asm-offsets.s \
-		$(TOUT)
+CLEAN_FILES += $(TOUT)
 
diff --git a/arch/ppc/kernel/cpu_setup_6xx.S b/arch/ppc/kernel/cpu_setup_6xx.S
--- a/arch/ppc/kernel/cpu_setup_6xx.S
+++ b/arch/ppc/kernel/cpu_setup_6xx.S
@@ -15,7 +15,7 @@
 #include <asm/ppc_asm.h>
 #include <asm/cputable.h>
 #include <asm/ppc_asm.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 #include <asm/cache.h>
 
 _GLOBAL(__setup_cpu_601)
diff --git a/arch/ppc/kernel/cpu_setup_power4.S b/arch/ppc/kernel/cpu_setup_power4.S
--- a/arch/ppc/kernel/cpu_setup_power4.S
+++ b/arch/ppc/kernel/cpu_setup_power4.S
@@ -15,7 +15,7 @@
 #include <asm/ppc_asm.h>
 #include <asm/cputable.h>
 #include <asm/ppc_asm.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 #include <asm/cache.h>
 
 _GLOBAL(__970_cpu_preinit)
diff --git a/arch/ppc/kernel/entry.S b/arch/ppc/kernel/entry.S
--- a/arch/ppc/kernel/entry.S
+++ b/arch/ppc/kernel/entry.S
@@ -29,7 +29,7 @@
 #include <asm/cputable.h>
 #include <asm/thread_info.h>
 #include <asm/ppc_asm.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 #include <asm/unistd.h>
 
 #undef SHOW_SYSCALLS
diff --git a/arch/ppc/kernel/fpu.S b/arch/ppc/kernel/fpu.S
--- a/arch/ppc/kernel/fpu.S
+++ b/arch/ppc/kernel/fpu.S
@@ -18,7 +18,7 @@
 #include <asm/cache.h>
 #include <asm/thread_info.h>
 #include <asm/ppc_asm.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 
 /*
  * This task wants to use the FPU now.
diff --git a/arch/ppc/kernel/head.S b/arch/ppc/kernel/head.S
--- a/arch/ppc/kernel/head.S
+++ b/arch/ppc/kernel/head.S
@@ -31,7 +31,7 @@
 #include <asm/cache.h>
 #include <asm/thread_info.h>
 #include <asm/ppc_asm.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 
 #ifdef CONFIG_APUS
 #include <asm/amigappc.h>
diff --git a/arch/ppc/kernel/head_44x.S b/arch/ppc/kernel/head_44x.S
--- a/arch/ppc/kernel/head_44x.S
+++ b/arch/ppc/kernel/head_44x.S
@@ -40,7 +40,7 @@
 #include <asm/cputable.h>
 #include <asm/thread_info.h>
 #include <asm/ppc_asm.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 #include "head_booke.h"
 
 
diff --git a/arch/ppc/kernel/head_4xx.S b/arch/ppc/kernel/head_4xx.S
--- a/arch/ppc/kernel/head_4xx.S
+++ b/arch/ppc/kernel/head_4xx.S
@@ -40,7 +40,7 @@
 #include <asm/cputable.h>
 #include <asm/thread_info.h>
 #include <asm/ppc_asm.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 
 /* As with the other PowerPC ports, it is expected that when code
  * execution begins here, the following registers contain valid, yet
diff --git a/arch/ppc/kernel/head_8xx.S b/arch/ppc/kernel/head_8xx.S
--- a/arch/ppc/kernel/head_8xx.S
+++ b/arch/ppc/kernel/head_8xx.S
@@ -30,7 +30,7 @@
 #include <asm/cputable.h>
 #include <asm/thread_info.h>
 #include <asm/ppc_asm.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 
 /* Macro to make the code more readable. */
 #ifdef CONFIG_8xx_CPU6
diff --git a/arch/ppc/kernel/head_fsl_booke.S b/arch/ppc/kernel/head_fsl_booke.S
--- a/arch/ppc/kernel/head_fsl_booke.S
+++ b/arch/ppc/kernel/head_fsl_booke.S
@@ -41,7 +41,7 @@
 #include <asm/cputable.h>
 #include <asm/thread_info.h>
 #include <asm/ppc_asm.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 #include "head_booke.h"
 
 /* As with the other PowerPC ports, it is expected that when code
diff --git a/arch/ppc/kernel/idle_6xx.S b/arch/ppc/kernel/idle_6xx.S
--- a/arch/ppc/kernel/idle_6xx.S
+++ b/arch/ppc/kernel/idle_6xx.S
@@ -20,7 +20,7 @@
 #include <asm/cputable.h>
 #include <asm/thread_info.h>
 #include <asm/ppc_asm.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 
 #undef DEBUG
 
diff --git a/arch/ppc/kernel/idle_power4.S b/arch/ppc/kernel/idle_power4.S
--- a/arch/ppc/kernel/idle_power4.S
+++ b/arch/ppc/kernel/idle_power4.S
@@ -20,7 +20,7 @@
 #include <asm/cputable.h>
 #include <asm/thread_info.h>
 #include <asm/ppc_asm.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 
 #undef DEBUG
 
diff --git a/arch/ppc/kernel/misc.S b/arch/ppc/kernel/misc.S
--- a/arch/ppc/kernel/misc.S
+++ b/arch/ppc/kernel/misc.S
@@ -23,7 +23,7 @@
 #include <asm/mmu.h>
 #include <asm/ppc_asm.h>
 #include <asm/thread_info.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 
 	.text
 
diff --git a/arch/ppc/kernel/swsusp.S b/arch/ppc/kernel/swsusp.S
--- a/arch/ppc/kernel/swsusp.S
+++ b/arch/ppc/kernel/swsusp.S
@@ -5,7 +5,7 @@
 #include <asm/cputable.h>
 #include <asm/thread_info.h>
 #include <asm/ppc_asm.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 
 
 /*
diff --git a/arch/ppc/mm/hashtable.S b/arch/ppc/mm/hashtable.S
--- a/arch/ppc/mm/hashtable.S
+++ b/arch/ppc/mm/hashtable.S
@@ -30,7 +30,7 @@
 #include <asm/cputable.h>
 #include <asm/ppc_asm.h>
 #include <asm/thread_info.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 
 #ifdef CONFIG_SMP
 	.comm	mmu_hash_lock,4
diff --git a/arch/ppc/platforms/pmac_sleep.S b/arch/ppc/platforms/pmac_sleep.S
--- a/arch/ppc/platforms/pmac_sleep.S
+++ b/arch/ppc/platforms/pmac_sleep.S
@@ -17,7 +17,7 @@
 #include <asm/cputable.h>
 #include <asm/cache.h>
 #include <asm/thread_info.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 
 #define MAGIC	0x4c617273	/* 'Lars' */
 
diff --git a/arch/ppc64/Makefile b/arch/ppc64/Makefile
--- a/arch/ppc64/Makefile
+++ b/arch/ppc64/Makefile
@@ -116,13 +116,6 @@ archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
 	$(Q)rm -rf include3
 
-prepare: include/asm-ppc64/offsets.h
-
-arch/ppc64/kernel/asm-offsets.s: include/asm include/linux/version.h \
-				   include/config/MARKER
-
-include/asm-ppc64/offsets.h: arch/ppc64/kernel/asm-offsets.s
-	$(call filechk,gen-asm-offsets)
 
 # Temporary hack until we have migrated to asm-powerpc
 include/asm: include3/asm
@@ -136,5 +129,3 @@ define archhelp
   echo  '		   sourced from arch/$(ARCH)/boot/ramdisk.image.gz'
   echo  '		   (arch/$(ARCH)/boot/zImage.initrd)'
 endef
-
-CLEAN_FILES += include/asm-ppc64/offsets.h
diff --git a/arch/ppc64/kernel/cpu_setup_power4.S b/arch/ppc64/kernel/cpu_setup_power4.S
--- a/arch/ppc64/kernel/cpu_setup_power4.S
+++ b/arch/ppc64/kernel/cpu_setup_power4.S
@@ -15,7 +15,7 @@
 #include <asm/ppc_asm.h>
 #include <asm/cputable.h>
 #include <asm/ppc_asm.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 #include <asm/cache.h>
 
 _GLOBAL(__970_cpu_preinit)
diff --git a/arch/ppc64/kernel/entry.S b/arch/ppc64/kernel/entry.S
--- a/arch/ppc64/kernel/entry.S
+++ b/arch/ppc64/kernel/entry.S
@@ -28,7 +28,7 @@
 #include <asm/mmu.h>
 #include <asm/thread_info.h>
 #include <asm/ppc_asm.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 #include <asm/cputable.h>
 
 #ifdef CONFIG_PPC_ISERIES
diff --git a/arch/ppc64/kernel/head.S b/arch/ppc64/kernel/head.S
--- a/arch/ppc64/kernel/head.S
+++ b/arch/ppc64/kernel/head.S
@@ -30,7 +30,7 @@
 #include <asm/mmu.h>
 #include <asm/systemcfg.h>
 #include <asm/ppc_asm.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 #include <asm/bug.h>
 #include <asm/cputable.h>
 #include <asm/setup.h>
diff --git a/arch/ppc64/kernel/idle_power4.S b/arch/ppc64/kernel/idle_power4.S
--- a/arch/ppc64/kernel/idle_power4.S
+++ b/arch/ppc64/kernel/idle_power4.S
@@ -20,7 +20,7 @@
 #include <asm/cputable.h>
 #include <asm/thread_info.h>
 #include <asm/ppc_asm.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 
 #undef DEBUG
 
diff --git a/arch/ppc64/kernel/misc.S b/arch/ppc64/kernel/misc.S
--- a/arch/ppc64/kernel/misc.S
+++ b/arch/ppc64/kernel/misc.S
@@ -26,7 +26,7 @@
 #include <asm/page.h>
 #include <asm/cache.h>
 #include <asm/ppc_asm.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 #include <asm/cputable.h>
 
 	.text
diff --git a/arch/ppc64/kernel/vdso32/cacheflush.S b/arch/ppc64/kernel/vdso32/cacheflush.S
--- a/arch/ppc64/kernel/vdso32/cacheflush.S
+++ b/arch/ppc64/kernel/vdso32/cacheflush.S
@@ -13,7 +13,7 @@
 #include <asm/processor.h>
 #include <asm/ppc_asm.h>
 #include <asm/vdso.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 
 	.text
 
diff --git a/arch/ppc64/kernel/vdso32/datapage.S b/arch/ppc64/kernel/vdso32/datapage.S
--- a/arch/ppc64/kernel/vdso32/datapage.S
+++ b/arch/ppc64/kernel/vdso32/datapage.S
@@ -12,7 +12,7 @@
 #include <linux/config.h>
 #include <asm/processor.h>
 #include <asm/ppc_asm.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 #include <asm/unistd.h>
 #include <asm/vdso.h>
 
diff --git a/arch/ppc64/kernel/vdso32/gettimeofday.S b/arch/ppc64/kernel/vdso32/gettimeofday.S
--- a/arch/ppc64/kernel/vdso32/gettimeofday.S
+++ b/arch/ppc64/kernel/vdso32/gettimeofday.S
@@ -13,7 +13,7 @@
 #include <asm/processor.h>
 #include <asm/ppc_asm.h>
 #include <asm/vdso.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 #include <asm/unistd.h>
 
 	.text
diff --git a/arch/ppc64/kernel/vdso64/cacheflush.S b/arch/ppc64/kernel/vdso64/cacheflush.S
--- a/arch/ppc64/kernel/vdso64/cacheflush.S
+++ b/arch/ppc64/kernel/vdso64/cacheflush.S
@@ -13,7 +13,7 @@
 #include <asm/processor.h>
 #include <asm/ppc_asm.h>
 #include <asm/vdso.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 
 	.text
 
diff --git a/arch/ppc64/kernel/vdso64/datapage.S b/arch/ppc64/kernel/vdso64/datapage.S
--- a/arch/ppc64/kernel/vdso64/datapage.S
+++ b/arch/ppc64/kernel/vdso64/datapage.S
@@ -12,7 +12,7 @@
 #include <linux/config.h>
 #include <asm/processor.h>
 #include <asm/ppc_asm.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 #include <asm/unistd.h>
 #include <asm/vdso.h>
 
diff --git a/arch/ppc64/kernel/vdso64/gettimeofday.S b/arch/ppc64/kernel/vdso64/gettimeofday.S
--- a/arch/ppc64/kernel/vdso64/gettimeofday.S
+++ b/arch/ppc64/kernel/vdso64/gettimeofday.S
@@ -14,7 +14,7 @@
 #include <asm/processor.h>
 #include <asm/ppc_asm.h>
 #include <asm/vdso.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 
 	.text
 /*
diff --git a/arch/ppc64/mm/hash_low.S b/arch/ppc64/mm/hash_low.S
--- a/arch/ppc64/mm/hash_low.S
+++ b/arch/ppc64/mm/hash_low.S
@@ -16,7 +16,7 @@
 #include <asm/page.h>
 #include <asm/types.h>
 #include <asm/ppc_asm.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 #include <asm/cputable.h>
 
 	.text
diff --git a/arch/ppc64/mm/slb_low.S b/arch/ppc64/mm/slb_low.S
--- a/arch/ppc64/mm/slb_low.S
+++ b/arch/ppc64/mm/slb_low.S
@@ -21,7 +21,7 @@
 #include <asm/page.h>
 #include <asm/mmu.h>
 #include <asm/ppc_asm.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 #include <asm/cputable.h>
 
 /* void slb_allocate(unsigned long ea);
diff --git a/arch/s390/Makefile b/arch/s390/Makefile
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -100,16 +100,6 @@ image: vmlinux
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
 
-prepare: include/asm-$(ARCH)/offsets.h
-
-arch/$(ARCH)/kernel/asm-offsets.s: include/asm include/linux/version.h \
-				   include/config/MARKER
-
-include/asm-$(ARCH)/offsets.h: arch/$(ARCH)/kernel/asm-offsets.s
-	$(call filechk,gen-asm-offsets)
-
-CLEAN_FILES += include/asm-$(ARCH)/offsets.h
-
 # Don't use tabs in echo arguments
 define archhelp
   echo  '* image           - Kernel image for IPL ($(boot)/image)'
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -18,7 +18,7 @@
 #include <asm/errno.h>
 #include <asm/ptrace.h>
 #include <asm/thread_info.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 #include <asm/unistd.h>
 #include <asm/page.h>
 
diff --git a/arch/s390/kernel/entry64.S b/arch/s390/kernel/entry64.S
--- a/arch/s390/kernel/entry64.S
+++ b/arch/s390/kernel/entry64.S
@@ -18,7 +18,7 @@
 #include <asm/errno.h>
 #include <asm/ptrace.h>
 #include <asm/thread_info.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 #include <asm/unistd.h>
 #include <asm/page.h>
 
diff --git a/arch/s390/kernel/head.S b/arch/s390/kernel/head.S
--- a/arch/s390/kernel/head.S
+++ b/arch/s390/kernel/head.S
@@ -30,7 +30,7 @@
 #include <linux/config.h>
 #include <asm/setup.h>
 #include <asm/lowcore.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 #include <asm/thread_info.h>
 #include <asm/page.h>
 
diff --git a/arch/s390/kernel/head64.S b/arch/s390/kernel/head64.S
--- a/arch/s390/kernel/head64.S
+++ b/arch/s390/kernel/head64.S
@@ -30,7 +30,7 @@
 #include <linux/config.h>
 #include <asm/setup.h>
 #include <asm/lowcore.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 #include <asm/thread_info.h>
 #include <asm/page.h>
 
diff --git a/arch/s390/lib/uaccess.S b/arch/s390/lib/uaccess.S
--- a/arch/s390/lib/uaccess.S
+++ b/arch/s390/lib/uaccess.S
@@ -11,7 +11,7 @@
 
 #include <linux/errno.h>
 #include <asm/lowcore.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 
         .text
         .align 4
diff --git a/arch/s390/lib/uaccess64.S b/arch/s390/lib/uaccess64.S
--- a/arch/s390/lib/uaccess64.S
+++ b/arch/s390/lib/uaccess64.S
@@ -11,7 +11,7 @@
 
 #include <linux/errno.h>
 #include <asm/lowcore.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 
         .text
         .align 4
diff --git a/arch/xtensa/Makefile b/arch/xtensa/Makefile
--- a/arch/xtensa/Makefile
+++ b/arch/xtensa/Makefile
@@ -66,13 +66,7 @@ boot		:= arch/xtensa/boot
 
 archinc		:= include/asm-xtensa
 
-arch/xtensa/kernel/asm-offsets.s: \
-	arch/xtensa/kernel/asm-offsets.c $(archinc)/.platform
-
-include/asm-xtensa/offsets.h: arch/xtensa/kernel/asm-offsets.s
-	$(call filechk,gen-asm-offsets)
-
-prepare: $(archinc)/.platform $(archinc)/offsets.h
+prepare: $(archinc)/.platform
 
 # Update machine cpu and platform symlinks if something which affects
 # them changed.
@@ -94,7 +88,7 @@ bzImage : zImage
 zImage zImage.initrd: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $@
 
-CLEAN_FILES	+= arch/xtensa/vmlinux.lds $(archinc)/offset.h \
+CLEAN_FILES	+= arch/xtensa/vmlinux.lds                      \
 		   $(archinc)/platform $(archinc)/xtensa/config \
 		   $(archinc)/.platform
 
diff --git a/arch/xtensa/kernel/align.S b/arch/xtensa/kernel/align.S
--- a/arch/xtensa/kernel/align.S
+++ b/arch/xtensa/kernel/align.S
@@ -19,7 +19,7 @@
 #include <asm/ptrace.h>
 #include <asm/ptrace.h>
 #include <asm/current.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 #include <asm/pgtable.h>
 #include <asm/processor.h>
 #include <asm/page.h>
diff --git a/arch/xtensa/kernel/entry.S b/arch/xtensa/kernel/entry.S
--- a/arch/xtensa/kernel/entry.S
+++ b/arch/xtensa/kernel/entry.S
@@ -14,7 +14,7 @@
  */
 
 #include <linux/linkage.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 #include <asm/processor.h>
 #include <asm/thread_info.h>
 #include <asm/uaccess.h>
diff --git a/arch/xtensa/kernel/process.c b/arch/xtensa/kernel/process.c
--- a/arch/xtensa/kernel/process.c
+++ b/arch/xtensa/kernel/process.c
@@ -43,7 +43,7 @@
 #include <asm/mmu.h>
 #include <asm/irq.h>
 #include <asm/atomic.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 #include <asm/coprocessor.h>
 
 extern void ret_from_fork(void);
diff --git a/arch/xtensa/kernel/vectors.S b/arch/xtensa/kernel/vectors.S
--- a/arch/xtensa/kernel/vectors.S
+++ b/arch/xtensa/kernel/vectors.S
@@ -46,7 +46,7 @@
 #include <asm/ptrace.h>
 #include <asm/ptrace.h>
 #include <asm/current.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 #include <asm/pgtable.h>
 #include <asm/processor.h>
 #include <asm/page.h>
diff --git a/include/asm-ia64/ptrace.h b/include/asm-ia64/ptrace.h
--- a/include/asm-ia64/ptrace.h
+++ b/include/asm-ia64/ptrace.h
@@ -57,7 +57,7 @@
 #include <linux/config.h>
 
 #include <asm/fpu.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 
 /*
  * Base-2 logarithm of number of pages to allocate per task structure
diff --git a/include/asm-ia64/thread_info.h b/include/asm-ia64/thread_info.h
--- a/include/asm-ia64/thread_info.h
+++ b/include/asm-ia64/thread_info.h
@@ -5,7 +5,7 @@
 #ifndef _ASM_IA64_THREAD_INFO_H
 #define _ASM_IA64_THREAD_INFO_H
 
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 #include <asm/processor.h>
 #include <asm/ptrace.h>
 
diff --git a/include/asm-parisc/assembly.h b/include/asm-parisc/assembly.h
--- a/include/asm-parisc/assembly.h
+++ b/include/asm-parisc/assembly.h
@@ -63,7 +63,7 @@
 	.level 2.0w
 #endif
 
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 #include <asm/page.h>
 
 #include <asm/asmregs.h>
diff --git a/include/asm-xtensa/ptrace.h b/include/asm-xtensa/ptrace.h
--- a/include/asm-xtensa/ptrace.h
+++ b/include/asm-xtensa/ptrace.h
@@ -127,7 +127,7 @@ extern void show_regs(struct pt_regs *);
 #else	/* __ASSEMBLY__ */
 
 #ifdef __KERNEL__
-# include <asm/offsets.h>
+# include <asm/asm-offsets.h>
 #define PT_REGS_OFFSET	  (KERNEL_STACK_SIZE - PT_USER_SIZE)
 #endif
 
diff --git a/include/asm-xtensa/uaccess.h b/include/asm-xtensa/uaccess.h
--- a/include/asm-xtensa/uaccess.h
+++ b/include/asm-xtensa/uaccess.h
@@ -25,7 +25,7 @@
 
 #define _ASMLANGUAGE
 #include <asm/current.h>
-#include <asm/offsets.h>
+#include <asm/asm-offsets.h>
 #include <asm/processor.h>
 
 /*


