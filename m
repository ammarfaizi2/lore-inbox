Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317035AbSFAUA0>; Sat, 1 Jun 2002 16:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317034AbSFAUAZ>; Sat, 1 Jun 2002 16:00:25 -0400
Received: from p508872AA.dip.t-dialin.net ([80.136.114.170]:20155 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317035AbSFAT7y>; Sat, 1 Jun 2002 15:59:54 -0400
Date: Sat, 1 Jun 2002 13:58:37 -0600 (MDT)
From: Lightweight patch manager <patch@luckynet.dynu.com>
X-X-Sender: patch@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Kernel Build -- Daniel Phillips <phillips@bonn-fries.net>,
        Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        Keith Owens <kaos@ocs.com.au>, Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][2.5] kbuild-2.5 8/12: i386 dependant stuff
Message-ID: <Pine.LNX.4.44.0206011357581.4854-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kbuild-2.5 - the i386 dependant stuff

You will need this patch for kbuild-2.5 on i386 compatible boxes.
You will need most other kbuild-2.5 patches, too!

This patch is also available from
<URL:ftp://luckynet.dynu.com/pub/linux/kbuild-2.5/many-files/kbuild-2.5-arch-i386.patch>

diff -Nur kbuild-2.5/arch/i386/asm-offsets.c kbuild-2.5/arch/i386/asm-offsets.c
--- kbuild-2.5/arch/i386/asm-offsets.c Fri May 31 15:55:14 2002
+++ kbuild-2.5/arch/i386/asm-offsets.c Fri May 31 15:55:14 2002 +0000 thunder (thunder-2.5/arch/i386/asm-offsets.c 1.1 0644)
@@ -0,0 +1,96 @@
+/*
+ * Generate definitions needed by assembly language modules.
+ * This code generates raw asm output which is post-processed to extract
+ * and format the required data.
+ */
+
+#include <linux/types.h>
+#include <linux/stddef.h>
+#include <linux/sched.h>
+
+/* Use marker if you need to separate the values later */
+
+#define DEFINE(sym, val, marker) \
+  asm volatile("\n-> " #sym " %0 " #val " " #marker : : "i" (val))
+
+#define BLANK() asm volatile("\n->" : : )
+
+int
+main(void)
+{
+  DEFINE(state,        offsetof(struct task_struct, state),);
+  DEFINE(flags,        offsetof(struct task_struct, flags),);
+  DEFINE(sigpending,   offsetof(struct task_struct, sigpending),);
+  DEFINE(addr_limit,   offsetof(struct task_struct, addr_limit),);
+  DEFINE(exec_domain,  offsetof(struct task_struct, exec_domain),);
+  DEFINE(need_resched, offsetof(struct task_struct, need_resched),);
+  DEFINE(tsk_ptrace,   offsetof(struct task_struct, ptrace),);
+  DEFINE(processor,    offsetof(struct task_struct, processor),);
+  BLANK();
+  DEFINE(ENOSYS,       ENOSYS,);
+  return 0;
+}
+/*
+ * Generate definitions needed by assembly language modules.
+ * This code generates raw asm output which is post-processed to extract
+ * and format the required data.
+ */
+
+#include <linux/types.h>
+#include <linux/stddef.h>
+#include <linux/sched.h>
+
+/* Use marker if you need to separate the values later */
+
+#define DEFINE(sym, val, marker) \
+  asm volatile("\n-> " #sym " %0 " #val " " #marker : : "i" (val))
+
+#define BLANK() asm volatile("\n->" : : )
+
+int
+main(void)
+{
+  DEFINE(state,        offsetof(struct task_struct, state),);
+  DEFINE(flags,        offsetof(struct task_struct, flags),);
+  DEFINE(sigpending,   offsetof(struct task_struct, sigpending),);
+  DEFINE(addr_limit,   offsetof(struct task_struct, addr_limit),);
+  DEFINE(exec_domain,  offsetof(struct task_struct, exec_domain),);
+  DEFINE(need_resched, offsetof(struct task_struct, need_resched),);
+  DEFINE(tsk_ptrace,   offsetof(struct task_struct, ptrace),);
+  DEFINE(processor,    offsetof(struct task_struct, processor),);
+  BLANK();
+  DEFINE(ENOSYS,       ENOSYS,);
+  return 0;
+}
+/*
+ * Generate definitions needed by assembly language modules.
+ * This code generates raw asm output which is post-processed to extract
+ * and format the required data.
+ */
+
+#include <linux/types.h>
+#include <linux/stddef.h>
+#include <linux/sched.h>
+
+/* Use marker if you need to separate the values later */
+
+#define DEFINE(sym, val, marker) \
+  asm volatile("\n-> " #sym " %0 " #val " " #marker : : "i" (val))
+
+#define BLANK() asm volatile("\n->" : : )
+
+int
+main(void)
+{
+  DEFINE(state,        offsetof(struct task_struct, state),);
+  DEFINE(flags,        offsetof(struct task_struct, flags),);
+  DEFINE(sigpending,   offsetof(struct task_struct, sigpending),);
+  DEFINE(addr_limit,   offsetof(struct task_struct, addr_limit),);
+  DEFINE(exec_domain,  offsetof(struct task_struct, exec_domain),);
+  DEFINE(need_resched, offsetof(struct task_struct, need_resched),);
+  DEFINE(tsk_ptrace,   offsetof(struct task_struct, ptrace),);
+  DEFINE(processor,    offsetof(struct task_struct, processor),);
+  BLANK();
+  DEFINE(ENOSYS,       ENOSYS,);
+  return 0;
+}
diff -Nur kbuild-2.5/arch/i386/boot/bbootsect.S kbuild-2.5/arch/i386/boot/bbootsect.S
--- kbuild-2.5/arch/i386/boot/bbootsect.S Fri May 31 15:55:14 2002
+++ kbuild-2.5/arch/i386/boot/bbootsect.S Fri May 31 15:55:14 2002 +0000 thunder (thunder-2.5/arch/i386/boot/bbootsect.S 1.1 0644)
@@ -0,0 +1,6 @@
+#define __BIG_KERNEL__
+#include "bootsect.S"
+#define __BIG_KERNEL__
+#include "bootsect.S"
+#define __BIG_KERNEL__
+#include "bootsect.S"
diff -Nur kbuild-2.5/arch/i386/boot/bsetup.S kbuild-2.5/arch/i386/boot/bsetup.S
--- kbuild-2.5/arch/i386/boot/bsetup.S Fri May 31 15:55:14 2002
+++ kbuild-2.5/arch/i386/boot/bsetup.S Fri May 31 15:55:14 2002 +0000 thunder (thunder-2.5/arch/i386/boot/bsetup.S 1.1 0644)
@@ -0,0 +1,6 @@
+#define __BIG_KERNEL__
+#include "setup.S"
+#define __BIG_KERNEL__
+#include "setup.S"
+#define __BIG_KERNEL__
+#include "setup.S"
diff -Nur kbuild-2.5/arch/i386/boot/config.install-2.5 kbuild-2.5/arch/i386/boot/config.install-2.5
--- kbuild-2.5/arch/i386/boot/config.install-2.5 Fri May 31 15:55:14 2002
+++ kbuild-2.5/arch/i386/boot/config.install-2.5 Fri May 31 15:55:14 2002 +0000 thunder (thunder-2.5/arch/i386/boot/config.install-2.5 1.1 0644)
@@ -0,0 +1,129 @@
+mainmenu_name "ix86 Installation"
+
+choice 'Format to compile kernel in' \
+	"vmlinux	CONFIG_VMLINUX \
+	 vmlinuz	CONFIG_VMLINUZ \
+	 bzImage	CONFIG_BZIMAGE \
+	 zImage		CONFIG_ZIMAGE" bzImage
+
+bool 'Use a prefix on install paths' CONFIG_INSTALL_PREFIX
+if [ "$CONFIG_INSTALL_PREFIX" = "y" ]; then
+  string '  Prefix for install paths' CONFIG_INSTALL_PREFIX_NAME ""
+fi
+string 'Where to install the kernel' CONFIG_INSTALL_KERNEL_NAME "/lib/modules/KERNELRELEASE/KERNELBASENAME"
+bool 'Install System.map' CONFIG_INSTALL_SYSTEM_MAP
+if [ "$CONFIG_INSTALL_SYSTEM_MAP" = "y" ]; then
+  string '  Where to install System.map' CONFIG_INSTALL_SYSTEM_MAP_NAME "/lib/modules/KERNELRELEASE/System.map"
+fi
+bool 'Install .config' CONFIG_INSTALL_CONFIG
+if [ "$CONFIG_INSTALL_CONFIG" = "y" ]; then
+  string '  Where to install .config' CONFIG_INSTALL_CONFIG_NAME "/lib/modules/KERNELRELEASE/.config"
+fi
+if [ "$CONFIG_VMLINUX" != "y" ]; then
+  bool '  Install vmlinux for debugging' CONFIG_INSTALL_VMLINUX
+  if [ "$CONFIG_INSTALL_VMLINUX" = "y" ]; then
+    string '    Where to install vmlinux' CONFIG_INSTALL_VMLINUX_NAME "/lib/modules/KERNELRELEASE/vmlinux"
+  fi
+fi
+bool 'Run a post-install script or command' CONFIG_INSTALL_SCRIPT
+if [ "$CONFIG_INSTALL_SCRIPT" = "y" ]; then
+  string '  Post-install script or command name' CONFIG_INSTALL_SCRIPT_NAME ""
+fi
+
+# FIXME: These critical config options should be in arch/$(ARCH)/config.in.  For
+# coexistence of kbuild 2.4 and 2.5 it is easier to put them here, move them
+# later.  KAO
+
+define_string CONFIG_KBUILD_CRITICAL_ARCH_X86 "CONFIG_M386 CONFIG_M486 \
+	CONFIG_M586 CONFIG_M586TSC CONFIG_M586MMX CONFIG_M686 \
+	CONFIG_MPENTIUMIII CONFIG_MPENTIUM4 \
+	CONFIG_MK6 CONFIG_MK7 \
+	CONFIG_MCRUSOE \
+	CONFIG_MWINCHIPC6 CONFIG_MWINCHIP2 CONFIG_MWINCHIP3D \
+	CONFIG_MCYRIXIII"
+mainmenu_name "ix86 Installation"
+
+choice 'Format to compile kernel in' \
+	"vmlinux	CONFIG_VMLINUX \
+	 vmlinuz	CONFIG_VMLINUZ \
+	 bzImage	CONFIG_BZIMAGE \
+	 zImage		CONFIG_ZIMAGE" bzImage
+
+bool 'Use a prefix on install paths' CONFIG_INSTALL_PREFIX
+if [ "$CONFIG_INSTALL_PREFIX" = "y" ]; then
+  string '  Prefix for install paths' CONFIG_INSTALL_PREFIX_NAME ""
+fi
+string 'Where to install the kernel' CONFIG_INSTALL_KERNEL_NAME "/lib/modules/KERNELRELEASE/KERNELBASENAME"
+bool 'Install System.map' CONFIG_INSTALL_SYSTEM_MAP
+if [ "$CONFIG_INSTALL_SYSTEM_MAP" = "y" ]; then
+  string '  Where to install System.map' CONFIG_INSTALL_SYSTEM_MAP_NAME "/lib/modules/KERNELRELEASE/System.map"
+fi
+bool 'Install .config' CONFIG_INSTALL_CONFIG
+if [ "$CONFIG_INSTALL_CONFIG" = "y" ]; then
+  string '  Where to install .config' CONFIG_INSTALL_CONFIG_NAME "/lib/modules/KERNELRELEASE/.config"
+fi
+if [ "$CONFIG_VMLINUX" != "y" ]; then
+  bool '  Install vmlinux for debugging' CONFIG_INSTALL_VMLINUX
+  if [ "$CONFIG_INSTALL_VMLINUX" = "y" ]; then
+    string '    Where to install vmlinux' CONFIG_INSTALL_VMLINUX_NAME "/lib/modules/KERNELRELEASE/vmlinux"
+  fi
+fi
+bool 'Run a post-install script or command' CONFIG_INSTALL_SCRIPT
+if [ "$CONFIG_INSTALL_SCRIPT" = "y" ]; then
+  string '  Post-install script or command name' CONFIG_INSTALL_SCRIPT_NAME ""
+fi
+
+# FIXME: These critical config options should be in arch/$(ARCH)/config.in.  For
+# coexistence of kbuild 2.4 and 2.5 it is easier to put them here, move them
+# later.  KAO
+
+define_string CONFIG_KBUILD_CRITICAL_ARCH_X86 "CONFIG_M386 CONFIG_M486 \
+	CONFIG_M586 CONFIG_M586TSC CONFIG_M586MMX CONFIG_M686 \
+	CONFIG_MPENTIUMIII CONFIG_MPENTIUM4 \
+	CONFIG_MK6 CONFIG_MK7 \
+	CONFIG_MCRUSOE \
+	CONFIG_MWINCHIPC6 CONFIG_MWINCHIP2 CONFIG_MWINCHIP3D \
+	CONFIG_MCYRIXIII"
+mainmenu_name "ix86 Installation"
+
+choice 'Format to compile kernel in' \
+	"vmlinux	CONFIG_VMLINUX \
+	 vmlinuz	CONFIG_VMLINUZ \
+	 bzImage	CONFIG_BZIMAGE \
+	 zImage		CONFIG_ZIMAGE" bzImage
+
+bool 'Use a prefix on install paths' CONFIG_INSTALL_PREFIX
+if [ "$CONFIG_INSTALL_PREFIX" = "y" ]; then
+  string '  Prefix for install paths' CONFIG_INSTALL_PREFIX_NAME ""
+fi
+string 'Where to install the kernel' CONFIG_INSTALL_KERNEL_NAME "/lib/modules/KERNELRELEASE/KERNELBASENAME"
+bool 'Install System.map' CONFIG_INSTALL_SYSTEM_MAP
+if [ "$CONFIG_INSTALL_SYSTEM_MAP" = "y" ]; then
+  string '  Where to install System.map' CONFIG_INSTALL_SYSTEM_MAP_NAME "/lib/modules/KERNELRELEASE/System.map"
+fi
+bool 'Install .config' CONFIG_INSTALL_CONFIG
+if [ "$CONFIG_INSTALL_CONFIG" = "y" ]; then
+  string '  Where to install .config' CONFIG_INSTALL_CONFIG_NAME "/lib/modules/KERNELRELEASE/.config"
+fi
+if [ "$CONFIG_VMLINUX" != "y" ]; then
+  bool '  Install vmlinux for debugging' CONFIG_INSTALL_VMLINUX
+  if [ "$CONFIG_INSTALL_VMLINUX" = "y" ]; then
+    string '    Where to install vmlinux' CONFIG_INSTALL_VMLINUX_NAME "/lib/modules/KERNELRELEASE/vmlinux"
+  fi
+fi
+bool 'Run a post-install script or command' CONFIG_INSTALL_SCRIPT
+if [ "$CONFIG_INSTALL_SCRIPT" = "y" ]; then
+  string '  Post-install script or command name' CONFIG_INSTALL_SCRIPT_NAME ""
+fi
+
+# FIXME: These critical config options should be in arch/$(ARCH)/config.in.  For
+# coexistence of kbuild 2.4 and 2.5 it is easier to put them here, move them
+# later.  KAO
+
+define_string CONFIG_KBUILD_CRITICAL_ARCH_X86 "CONFIG_M386 CONFIG_M486 \
+	CONFIG_M586 CONFIG_M586TSC CONFIG_M586MMX CONFIG_M686 \
+	CONFIG_MPENTIUMIII CONFIG_MPENTIUM4 \
+	CONFIG_MK6 CONFIG_MK7 \
+	CONFIG_MCRUSOE \
+	CONFIG_MWINCHIPC6 CONFIG_MWINCHIP2 CONFIG_MWINCHIP3D \
+	CONFIG_MCYRIXIII"
diff -Nur kbuild-2.5/arch/i386/boot/rules-2.5.cml kbuild-2.5/arch/i386/boot/rules-2.5.cml
--- kbuild-2.5/arch/i386/boot/rules-2.5.cml Fri May 31 15:55:14 2002
+++ kbuild-2.5/arch/i386/boot/rules-2.5.cml Fri May 31 15:55:14 2002 +0000 thunder (thunder-2.5/arch/i386/boot/rules-2.5.cml 1.1 0644)
@@ -0,0 +1,99 @@
+symbols
+kernel_format_x86	'The format used for the installed kernel' text
+All kernel builds create vmlinux as an ELF object.  vmlinux may not be
+suitable for loading, either because your bootloader cannot handle ELF
+or the object is too large.  This option selects the format for the
+installed kernel.  If unsure, use bzImage.
+.
+VMLINUX_X86 'vmlinux' like VMLINUX_help
+VMLINUZ_X86 'vmlinuz' like VMLINUZ_help
+BZIMAGE_X86 'bzimage' like BZIMAGE_help
+ZIMAGE_X86  'zimage'  like ZIMAGE_help
+
+private VMLINUX_X86 VMLINUZ_X86 BZIMAGE_X86 ZIMAGE_X86
+
+choices kernel_format_x86 # The format that the kernel is to be compiled in
+	VMLINUX_X86 VMLINUZ_X86 BZIMAGE_X86 ZIMAGE_X86 default BZIMAGE_X86
+
+# FIXME: These critical config options should be in arch/$(ARCH)/rules.cml.  For
+# coexistence of kbuild 2.4 and 2.5 it is easier to put them here, move them
+# later.  KAO
+
+derive KBUILD_CRITICAL_ARCH_X86 from "CONFIG_M386 CONFIG_M486 \
+	CONFIG_M586 CONFIG_M586TSC CONFIG_M586MMX CONFIG_M686 \
+	CONFIG_MPENTIUMIII CONFIG_MPENTIUM4 \
+	CONFIG_MK6 CONFIG_MK7 \
+	CONFIG_MCRUSOE \
+	CONFIG_MWINCHIPC6 CONFIG_MWINCHIP2 CONFIG_MWINCHIP3D \
+	CONFIG_MCYRIXIII"
+
+menu installation
+	kernel_format_x86
+
+unless X86 suppress kernel_format_x86
+symbols
+kernel_format_x86	'The format used for the installed kernel' text
+All kernel builds create vmlinux as an ELF object.  vmlinux may not be
+suitable for loading, either because your bootloader cannot handle ELF
+or the object is too large.  This option selects the format for the
+installed kernel.  If unsure, use bzImage.
+.
+VMLINUX_X86 'vmlinux' like VMLINUX_help
+VMLINUZ_X86 'vmlinuz' like VMLINUZ_help
+BZIMAGE_X86 'bzimage' like BZIMAGE_help
+ZIMAGE_X86  'zimage'  like ZIMAGE_help
+
+private VMLINUX_X86 VMLINUZ_X86 BZIMAGE_X86 ZIMAGE_X86
+
+choices kernel_format_x86 # The format that the kernel is to be compiled in
+	VMLINUX_X86 VMLINUZ_X86 BZIMAGE_X86 ZIMAGE_X86 default BZIMAGE_X86
+
+# FIXME: These critical config options should be in arch/$(ARCH)/rules.cml.  For
+# coexistence of kbuild 2.4 and 2.5 it is easier to put them here, move them
+# later.  KAO
+
+derive KBUILD_CRITICAL_ARCH_X86 from "CONFIG_M386 CONFIG_M486 \
+	CONFIG_M586 CONFIG_M586TSC CONFIG_M586MMX CONFIG_M686 \
+	CONFIG_MPENTIUMIII CONFIG_MPENTIUM4 \
+	CONFIG_MK6 CONFIG_MK7 \
+	CONFIG_MCRUSOE \
+	CONFIG_MWINCHIPC6 CONFIG_MWINCHIP2 CONFIG_MWINCHIP3D \
+	CONFIG_MCYRIXIII"
+
+menu installation
+	kernel_format_x86
+
+unless X86 suppress kernel_format_x86
+symbols
+kernel_format_x86	'The format used for the installed kernel' text
+All kernel builds create vmlinux as an ELF object.  vmlinux may not be
+suitable for loading, either because your bootloader cannot handle ELF
+or the object is too large.  This option selects the format for the
+installed kernel.  If unsure, use bzImage.
+.
+VMLINUX_X86 'vmlinux' like VMLINUX_help
+VMLINUZ_X86 'vmlinuz' like VMLINUZ_help
+BZIMAGE_X86 'bzimage' like BZIMAGE_help
+ZIMAGE_X86  'zimage'  like ZIMAGE_help
+
+private VMLINUX_X86 VMLINUZ_X86 BZIMAGE_X86 ZIMAGE_X86
+
+choices kernel_format_x86 # The format that the kernel is to be compiled in
+	VMLINUX_X86 VMLINUZ_X86 BZIMAGE_X86 ZIMAGE_X86 default BZIMAGE_X86
+
+# FIXME: These critical config options should be in arch/$(ARCH)/rules.cml.  For
+# coexistence of kbuild 2.4 and 2.5 it is easier to put them here, move them
+# later.  KAO
+
+derive KBUILD_CRITICAL_ARCH_X86 from "CONFIG_M386 CONFIG_M486 \
+	CONFIG_M586 CONFIG_M586TSC CONFIG_M586MMX CONFIG_M686 \
+	CONFIG_MPENTIUMIII CONFIG_MPENTIUM4 \
+	CONFIG_MK6 CONFIG_MK7 \
+	CONFIG_MCRUSOE \
+	CONFIG_MWINCHIPC6 CONFIG_MWINCHIP2 CONFIG_MWINCHIP3D \
+	CONFIG_MCYRIXIII"
+
+menu installation
+	kernel_format_x86
+
+unless X86 suppress kernel_format_x86
diff -Nur kbuild-2.5/arch/i386/vmlinux.lds.S kbuild-2.5/arch/i386/vmlinux.lds.S
--- kbuild-2.5/arch/i386/vmlinux.lds.S Fri May 31 15:55:14 2002
+++ kbuild-2.5/arch/i386/vmlinux.lds.S Fri May 31 15:55:14 2002 +0000 thunder (thunder-2.5/arch/i386/vmlinux.lds.S 1.1 0644)
@@ -0,0 +1,294 @@
+/* ld script to make i386 Linux kernel
+ * Written by Martin Mares <mj@atrey.karlin.mff.cuni.cz>;
+ */
+OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
+OUTPUT_ARCH(i386)
+ENTRY(_start)
+SECTIONS
+{
+  . = 0xC0000000 + 0x100000;
+  _text = .;			/* Text and read-only data */
+  .text : {
+	*(.text)
+	*(.fixup)
+	*(.gnu.warning)
+	} = 0x9090
+
+  _etext = .;			/* End of text section */
+
+  .rodata : { *(.rodata) *(.rodata.*) }
+  .kstrtab : { *(.kstrtab) }
+
+  . = ALIGN(16);		/* Exception table */
+  __start___ex_table = .;
+  __ex_table : { *(__ex_table) }
+  __stop___ex_table = .;
+
+  __start___ksymtab = .;	/* Kernel symbol table */
+  __ksymtab : { *(__ksymtab) }
+  __stop___ksymtab = .;
+
+  __start___kallsyms = .;	/* All kernel symbols */
+  __kallsyms : { *(__kallsyms) }
+  __stop___kallsyms = .;
+
+  .data : {			/* Data */
+	*(.data)
+	CONSTRUCTORS
+	}
+
+  _edata = .;			/* End of data section */
+
+  . = ALIGN(8192);		/* init_task */
+  .data.init_task : { *(.data.init_task) }
+
+  . = ALIGN(4096);		/* Init code and data */
+  __init_begin = .;
+  .text.init : { *(.text.init) }
+  .data.init : { *(.data.init) }
+  . = ALIGN(16);
+  __setup_start = .;
+  .setup.init : { *(.setup.init) }
+  __setup_end = .;
+  __initcall_start = .;
+  .initcall.init : {
+	*(.initcall1.init) 
+	*(.initcall2.init) 
+	*(.initcall3.init) 
+	*(.initcall4.init) 
+	*(.initcall5.init) 
+	*(.initcall6.init) 
+	*(.initcall7.init)
+  }
+  __initcall_end = .;
+  . = ALIGN(32);
+  __per_cpu_start = .;
+  .data.percpu  : { *(.data.percpu) }
+  __per_cpu_end = .;
+  . = ALIGN(4096);
+  __init_end = .;
+
+  . = ALIGN(4096);
+  .data.page_aligned : { *(.data.idt) }
+
+  . = ALIGN(32);
+  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
+
+  __bss_start = .;		/* BSS */
+  .bss : {
+	*(.bss)
+	}
+  _end = . ;
+
+  /* Sections to be discarded */
+  /DISCARD/ : {
+	*(.text.exit)
+	*(.data.exit)
+	*(.exitcall.exit)
+	}
+
+  /* Stabs debugging sections.  */
+  .stab 0 : { *(.stab) }
+  .stabstr 0 : { *(.stabstr) }
+  .stab.excl 0 : { *(.stab.excl) }
+  .stab.exclstr 0 : { *(.stab.exclstr) }
+  .stab.index 0 : { *(.stab.index) }
+  .stab.indexstr 0 : { *(.stab.indexstr) }
+  .comment 0 : { *(.comment) }
+}
+/* ld script to make i386 Linux kernel
+ * Written by Martin Mares <mj@atrey.karlin.mff.cuni.cz>;
+ */
+OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
+OUTPUT_ARCH(i386)
+ENTRY(_start)
+SECTIONS
+{
+  . = 0xC0000000 + 0x100000;
+  _text = .;			/* Text and read-only data */
+  .text : {
+	*(.text)
+	*(.fixup)
+	*(.gnu.warning)
+	} = 0x9090
+
+  _etext = .;			/* End of text section */
+
+  .rodata : { *(.rodata) *(.rodata.*) }
+  .kstrtab : { *(.kstrtab) }
+
+  . = ALIGN(16);		/* Exception table */
+  __start___ex_table = .;
+  __ex_table : { *(__ex_table) }
+  __stop___ex_table = .;
+
+  __start___ksymtab = .;	/* Kernel symbol table */
+  __ksymtab : { *(__ksymtab) }
+  __stop___ksymtab = .;
+
+  __start___kallsyms = .;	/* All kernel symbols */
+  __kallsyms : { *(__kallsyms) }
+  __stop___kallsyms = .;
+
+  .data : {			/* Data */
+	*(.data)
+	CONSTRUCTORS
+	}
+
+  _edata = .;			/* End of data section */
+
+  . = ALIGN(8192);		/* init_task */
+  .data.init_task : { *(.data.init_task) }
+
+  . = ALIGN(4096);		/* Init code and data */
+  __init_begin = .;
+  .text.init : { *(.text.init) }
+  .data.init : { *(.data.init) }
+  . = ALIGN(16);
+  __setup_start = .;
+  .setup.init : { *(.setup.init) }
+  __setup_end = .;
+  __initcall_start = .;
+  .initcall.init : {
+	*(.initcall1.init) 
+	*(.initcall2.init) 
+	*(.initcall3.init) 
+	*(.initcall4.init) 
+	*(.initcall5.init) 
+	*(.initcall6.init) 
+	*(.initcall7.init)
+  }
+  __initcall_end = .;
+  . = ALIGN(32);
+  __per_cpu_start = .;
+  .data.percpu  : { *(.data.percpu) }
+  __per_cpu_end = .;
+  . = ALIGN(4096);
+  __init_end = .;
+
+  . = ALIGN(4096);
+  .data.page_aligned : { *(.data.idt) }
+
+  . = ALIGN(32);
+  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
+
+  __bss_start = .;		/* BSS */
+  .bss : {
+	*(.bss)
+	}
+  _end = . ;
+
+  /* Sections to be discarded */
+  /DISCARD/ : {
+	*(.text.exit)
+	*(.data.exit)
+	*(.exitcall.exit)
+	}
+
+  /* Stabs debugging sections.  */
+  .stab 0 : { *(.stab) }
+  .stabstr 0 : { *(.stabstr) }
+  .stab.excl 0 : { *(.stab.excl) }
+  .stab.exclstr 0 : { *(.stab.exclstr) }
+  .stab.index 0 : { *(.stab.index) }
+  .stab.indexstr 0 : { *(.stab.indexstr) }
+  .comment 0 : { *(.comment) }
+}
+/* ld script to make i386 Linux kernel
+ * Written by Martin Mares <mj@atrey.karlin.mff.cuni.cz>;
+ */
+OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
+OUTPUT_ARCH(i386)
+ENTRY(_start)
+SECTIONS
+{
+  . = 0xC0000000 + 0x100000;
+  _text = .;			/* Text and read-only data */
+  .text : {
+	*(.text)
+	*(.fixup)
+	*(.gnu.warning)
+	} = 0x9090
+
+  _etext = .;			/* End of text section */
+
+  .rodata : { *(.rodata) *(.rodata.*) }
+  .kstrtab : { *(.kstrtab) }
+
+  . = ALIGN(16);		/* Exception table */
+  __start___ex_table = .;
+  __ex_table : { *(__ex_table) }
+  __stop___ex_table = .;
+
+  __start___ksymtab = .;	/* Kernel symbol table */
+  __ksymtab : { *(__ksymtab) }
+  __stop___ksymtab = .;
+
+  __start___kallsyms = .;	/* All kernel symbols */
+  __kallsyms : { *(__kallsyms) }
+  __stop___kallsyms = .;
+
+  .data : {			/* Data */
+	*(.data)
+	CONSTRUCTORS
+	}
+
+  _edata = .;			/* End of data section */
+
+  . = ALIGN(8192);		/* init_task */
+  .data.init_task : { *(.data.init_task) }
+
+  . = ALIGN(4096);		/* Init code and data */
+  __init_begin = .;
+  .text.init : { *(.text.init) }
+  .data.init : { *(.data.init) }
+  . = ALIGN(16);
+  __setup_start = .;
+  .setup.init : { *(.setup.init) }
+  __setup_end = .;
+  __initcall_start = .;
+  .initcall.init : {
+	*(.initcall1.init) 
+	*(.initcall2.init) 
+	*(.initcall3.init) 
+	*(.initcall4.init) 
+	*(.initcall5.init) 
+	*(.initcall6.init) 
+	*(.initcall7.init)
+  }
+  __initcall_end = .;
+  . = ALIGN(32);
+  __per_cpu_start = .;
+  .data.percpu  : { *(.data.percpu) }
+  __per_cpu_end = .;
+  . = ALIGN(4096);
+  __init_end = .;
+
+  . = ALIGN(4096);
+  .data.page_aligned : { *(.data.idt) }
+
+  . = ALIGN(32);
+  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
+
+  __bss_start = .;		/* BSS */
+  .bss : {
+	*(.bss)
+	}
+  _end = . ;
+
+  /* Sections to be discarded */
+  /DISCARD/ : {
+	*(.text.exit)
+	*(.data.exit)
+	*(.exitcall.exit)
+	}
+
+  /* Stabs debugging sections.  */
+  .stab 0 : { *(.stab) }
+  .stabstr 0 : { *(.stabstr) }
+  .stab.excl 0 : { *(.stab.excl) }
+  .stab.exclstr 0 : { *(.stab.exclstr) }
+  .stab.index 0 : { *(.stab.index) }
+  .stab.indexstr 0 : { *(.stab.indexstr) }
+  .comment 0 : { *(.comment) }
+}

