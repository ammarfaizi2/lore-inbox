Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262069AbUKDB7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbUKDB7Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 20:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbUKDB7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 20:59:04 -0500
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:56723
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S262044AbUKDBzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 20:55:13 -0500
Subject: [patch 05/20] Uml: cleanup header names
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, cw@f00f.org,
       blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Thu, 04 Nov 2004 00:17:25 +0100
Message-Id: <20041103231726.1E6E1363AA@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rename headers with the same name to avoid specifying the complete path for
including them.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/um/include/mode.h                       |    4 
 vanilla-linux-2.6.9-paolo/arch/um/include/mode_kern.h                  |    4 
 vanilla-linux-2.6.9-paolo/arch/um/include/um_mmu.h                     |    4 
 vanilla-linux-2.6.9-paolo/arch/um/include/um_uaccess.h                 |    4 
 vanilla-linux-2.6.9-paolo/arch/um/kernel/skas/exec_kern.c              |    2 
 vanilla-linux-2.6.9-paolo/arch/um/kernel/skas/include/mmu-skas.h       |   27 +++
 vanilla-linux-2.6.9-paolo/arch/um/kernel/skas/include/mode-skas.h      |   37 +++++
 vanilla-linux-2.6.9-paolo/arch/um/kernel/skas/include/mode_kern-skas.h |   53 +++++++
 vanilla-linux-2.6.9-paolo/arch/um/kernel/skas/include/uaccess-skas.h   |   40 +++++
 vanilla-linux-2.6.9-paolo/arch/um/kernel/tt/include/mmu-tt.h           |   23 +++
 vanilla-linux-2.6.9-paolo/arch/um/kernel/tt/include/mode-tt.h          |   38 +++++
 vanilla-linux-2.6.9-paolo/arch/um/kernel/tt/include/mode_kern-tt.h     |   53 +++++++
 vanilla-linux-2.6.9-paolo/arch/um/kernel/tt/include/uaccess-tt.h       |   71 ++++++++++
 vanilla-linux-2.6.9/arch/um/kernel/skas/include/mmu.h                  |   27 ---
 vanilla-linux-2.6.9/arch/um/kernel/skas/include/mode.h                 |   37 -----
 vanilla-linux-2.6.9/arch/um/kernel/skas/include/mode_kern.h            |   53 -------
 vanilla-linux-2.6.9/arch/um/kernel/skas/include/uaccess.h              |   40 -----
 vanilla-linux-2.6.9/arch/um/kernel/tt/include/mmu.h                    |   23 ---
 vanilla-linux-2.6.9/arch/um/kernel/tt/include/mode.h                   |   38 -----
 vanilla-linux-2.6.9/arch/um/kernel/tt/include/mode_kern.h              |   53 -------
 vanilla-linux-2.6.9/arch/um/kernel/tt/include/uaccess.h                |   71 ----------
 21 files changed, 351 insertions(+), 351 deletions(-)

diff -puN arch/um/include/mode.h~uml-Rename-Mode-Headers arch/um/include/mode.h
--- vanilla-linux-2.6.9/arch/um/include/mode.h~uml-Rename-Mode-Headers	2004-11-03 23:44:57.832768200 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/include/mode.h	2004-11-03 23:44:57.855764704 +0100
@@ -9,11 +9,11 @@
 #include "uml-config.h"
 
 #ifdef UML_CONFIG_MODE_TT
-#include "../kernel/tt/include/mode.h"
+#include "mode-tt.h"
 #endif
 
 #ifdef UML_CONFIG_MODE_SKAS
-#include "../kernel/skas/include/mode.h"
+#include "mode-skas.h"
 #endif
 
 #endif
diff -puN arch/um/include/mode_kern.h~uml-Rename-Mode-Headers arch/um/include/mode_kern.h
--- vanilla-linux-2.6.9/arch/um/include/mode_kern.h~uml-Rename-Mode-Headers	2004-11-03 23:44:57.834767896 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/include/mode_kern.h	2004-11-03 23:44:57.855764704 +0100
@@ -9,11 +9,11 @@
 #include "linux/config.h"
 
 #ifdef CONFIG_MODE_TT
-#include "../kernel/tt/include/mode_kern.h"
+#include "mode_kern-tt.h"
 #endif
 
 #ifdef CONFIG_MODE_SKAS
-#include "../kernel/skas/include/mode_kern.h"
+#include "mode_kern-skas.h"
 #endif
 
 #endif
diff -puN arch/um/include/um_mmu.h~uml-Rename-Mode-Headers arch/um/include/um_mmu.h
--- vanilla-linux-2.6.9/arch/um/include/um_mmu.h~uml-Rename-Mode-Headers	2004-11-03 23:44:57.835767744 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/include/um_mmu.h	2004-11-03 23:44:57.855764704 +0100
@@ -10,11 +10,11 @@
 #include "choose-mode.h"
 
 #ifdef CONFIG_MODE_TT
-#include "../kernel/tt/include/mmu.h"
+#include "mmu-tt.h"
 #endif
 
 #ifdef CONFIG_MODE_SKAS
-#include "../kernel/skas/include/mmu.h"
+#include "mmu-skas.h"
 #endif
 
 typedef union {
diff -puN arch/um/include/um_uaccess.h~uml-Rename-Mode-Headers arch/um/include/um_uaccess.h
--- vanilla-linux-2.6.9/arch/um/include/um_uaccess.h~uml-Rename-Mode-Headers	2004-11-03 23:44:57.836767592 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/include/um_uaccess.h	2004-11-03 23:44:57.855764704 +0100
@@ -10,11 +10,11 @@
 #include "choose-mode.h"
 
 #ifdef CONFIG_MODE_TT
-#include "../kernel/tt/include/uaccess.h"
+#include "uaccess-tt.h"
 #endif
 
 #ifdef CONFIG_MODE_SKAS
-#include "../kernel/skas/include/uaccess.h"
+#include "uaccess-skas.h"
 #endif
 
 #define access_ok(type, addr, size) \
diff -puN arch/um/kernel/skas/exec_kern.c~uml-Rename-Mode-Headers arch/um/kernel/skas/exec_kern.c
--- vanilla-linux-2.6.9/arch/um/kernel/skas/exec_kern.c~uml-Rename-Mode-Headers	2004-11-03 23:44:57.838767288 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/skas/exec_kern.c	2004-11-03 23:44:57.856764552 +0100
@@ -12,7 +12,7 @@
 #include "asm/mmu_context.h"
 #include "tlb.h"
 #include "skas.h"
-#include "mmu.h"
+#include "um_mmu.h"
 #include "os.h"
 
 void flush_thread_skas(void)
diff -L arch/um/kernel/skas/include/mmu.h -puN arch/um/kernel/skas/include/mmu.h~uml-Rename-Mode-Headers /dev/null
--- vanilla-linux-2.6.9/arch/um/kernel/skas/include/mmu.h
+++ /dev/null	2004-10-19 20:34:05.000000000 +0200
@@ -1,27 +0,0 @@
-/* 
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __SKAS_MMU_H
-#define __SKAS_MMU_H
-
-#include "linux/list.h"
-#include "linux/spinlock.h"
-
-struct mmu_context_skas {
-	int mm_fd;
-};
-
-#endif
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
diff -puN /dev/null arch/um/kernel/skas/include/mmu-skas.h
--- /dev/null	2004-10-19 20:34:05.000000000 +0200
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/skas/include/mmu-skas.h	2004-11-03 23:44:57.857764400 +0100
@@ -0,0 +1,27 @@
+/*
+ * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#ifndef __SKAS_MMU_H
+#define __SKAS_MMU_H
+
+#include "linux/list.h"
+#include "linux/spinlock.h"
+
+struct mmu_context_skas {
+	int mm_fd;
+};
+
+#endif
+
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * Emacs will notice this stuff at the end of the file and automatically
+ * adjust the settings for this buffer only.  This must remain at the end
+ * of the file.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ */
diff -L arch/um/kernel/skas/include/mode.h -puN arch/um/kernel/skas/include/mode.h~uml-Rename-Mode-Headers /dev/null
--- vanilla-linux-2.6.9/arch/um/kernel/skas/include/mode.h
+++ /dev/null	2004-10-19 20:34:05.000000000 +0200
@@ -1,37 +0,0 @@
-/* 
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __MODE_SKAS_H__
-#define __MODE_SKAS_H__
-
-extern unsigned long exec_regs[];
-extern unsigned long exec_fp_regs[];
-extern unsigned long exec_fpx_regs[];
-extern int have_fpx_regs;
-
-extern void user_time_init_skas(void);
-extern int copy_sc_from_user_skas(int pid, union uml_pt_regs *regs,
-				  void *from_ptr);
-extern int copy_sc_to_user_skas(int pid, void *to_ptr, void *fp,
-				union uml_pt_regs *regs, 
-				unsigned long fault_addr, int fault_type);
-extern void sig_handler_common_skas(int sig, void *sc_ptr);
-extern void halt_skas(void);
-extern void reboot_skas(void);
-extern void kill_off_processes_skas(void);
-extern int is_skas_winch(int pid, int fd, void *data);
-
-#endif
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
diff -L arch/um/kernel/skas/include/mode_kern.h -puN arch/um/kernel/skas/include/mode_kern.h~uml-Rename-Mode-Headers /dev/null
--- vanilla-linux-2.6.9/arch/um/kernel/skas/include/mode_kern.h
+++ /dev/null	2004-10-19 20:34:05.000000000 +0200
@@ -1,53 +0,0 @@
-/* 
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __SKAS_MODE_KERN_H__
-#define __SKAS_MODE_KERN_H__
-
-#include "linux/sched.h"
-#include "asm/page.h"
-#include "asm/ptrace.h"
-
-extern void flush_thread_skas(void);
-extern void *switch_to_skas(void *prev, void *next);
-extern void start_thread_skas(struct pt_regs *regs, unsigned long eip, 
-			      unsigned long esp);
-extern int copy_thread_skas(int nr, unsigned long clone_flags, 
-			    unsigned long sp, unsigned long stack_top, 
-			    struct task_struct *p, struct pt_regs *regs);
-extern void release_thread_skas(struct task_struct *task);
-extern void exit_thread_skas(void);
-extern void initial_thread_cb_skas(void (*proc)(void *), void *arg);
-extern void init_idle_skas(void);
-extern void flush_tlb_kernel_range_skas(unsigned long start, 
-					unsigned long end);
-extern void flush_tlb_kernel_vm_skas(void);
-extern void __flush_tlb_one_skas(unsigned long addr);
-extern void flush_tlb_range_skas(struct vm_area_struct *vma, 
-				 unsigned long start, unsigned long end);
-extern void flush_tlb_mm_skas(struct mm_struct *mm);
-extern void force_flush_all_skas(void);
-extern long execute_syscall_skas(void *r);
-extern void before_mem_skas(unsigned long unused);
-extern unsigned long set_task_sizes_skas(int arg, unsigned long *host_size_out,
-					 unsigned long *task_size_out);
-extern int start_uml_skas(void);
-extern int external_pid_skas(struct task_struct *task);
-extern int thread_pid_skas(struct task_struct *task);
-
-#define kmem_end_skas (host_task_size - 1024 * 1024)
-
-#endif
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
diff -puN /dev/null arch/um/kernel/skas/include/mode_kern-skas.h
--- /dev/null	2004-10-19 20:34:05.000000000 +0200
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/skas/include/mode_kern-skas.h	2004-11-03 23:44:57.857764400 +0100
@@ -0,0 +1,53 @@
+/*
+ * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#ifndef __SKAS_MODE_KERN_H__
+#define __SKAS_MODE_KERN_H__
+
+#include "linux/sched.h"
+#include "asm/page.h"
+#include "asm/ptrace.h"
+
+extern void flush_thread_skas(void);
+extern void *switch_to_skas(void *prev, void *next);
+extern void start_thread_skas(struct pt_regs *regs, unsigned long eip,
+			      unsigned long esp);
+extern int copy_thread_skas(int nr, unsigned long clone_flags,
+			    unsigned long sp, unsigned long stack_top,
+			    struct task_struct *p, struct pt_regs *regs);
+extern void release_thread_skas(struct task_struct *task);
+extern void exit_thread_skas(void);
+extern void initial_thread_cb_skas(void (*proc)(void *), void *arg);
+extern void init_idle_skas(void);
+extern void flush_tlb_kernel_range_skas(unsigned long start,
+					unsigned long end);
+extern void flush_tlb_kernel_vm_skas(void);
+extern void __flush_tlb_one_skas(unsigned long addr);
+extern void flush_tlb_range_skas(struct vm_area_struct *vma,
+				 unsigned long start, unsigned long end);
+extern void flush_tlb_mm_skas(struct mm_struct *mm);
+extern void force_flush_all_skas(void);
+extern long execute_syscall_skas(void *r);
+extern void before_mem_skas(unsigned long unused);
+extern unsigned long set_task_sizes_skas(int arg, unsigned long *host_size_out,
+					 unsigned long *task_size_out);
+extern int start_uml_skas(void);
+extern int external_pid_skas(struct task_struct *task);
+extern int thread_pid_skas(struct task_struct *task);
+
+#define kmem_end_skas (host_task_size - 1024 * 1024)
+
+#endif
+
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * Emacs will notice this stuff at the end of the file and automatically
+ * adjust the settings for this buffer only.  This must remain at the end
+ * of the file.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ */
diff -puN /dev/null arch/um/kernel/skas/include/mode-skas.h
--- /dev/null	2004-10-19 20:34:05.000000000 +0200
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/skas/include/mode-skas.h	2004-11-03 23:44:57.857764400 +0100
@@ -0,0 +1,37 @@
+/*
+ * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#ifndef __MODE_SKAS_H__
+#define __MODE_SKAS_H__
+
+extern unsigned long exec_regs[];
+extern unsigned long exec_fp_regs[];
+extern unsigned long exec_fpx_regs[];
+extern int have_fpx_regs;
+
+extern void user_time_init_skas(void);
+extern int copy_sc_from_user_skas(int pid, union uml_pt_regs *regs,
+				  void *from_ptr);
+extern int copy_sc_to_user_skas(int pid, void *to_ptr, void *fp,
+				union uml_pt_regs *regs,
+				unsigned long fault_addr, int fault_type);
+extern void sig_handler_common_skas(int sig, void *sc_ptr);
+extern void halt_skas(void);
+extern void reboot_skas(void);
+extern void kill_off_processes_skas(void);
+extern int is_skas_winch(int pid, int fd, void *data);
+
+#endif
+
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * Emacs will notice this stuff at the end of the file and automatically
+ * adjust the settings for this buffer only.  This must remain at the end
+ * of the file.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ */
diff -L arch/um/kernel/skas/include/uaccess.h -puN arch/um/kernel/skas/include/uaccess.h~uml-Rename-Mode-Headers /dev/null
--- vanilla-linux-2.6.9/arch/um/kernel/skas/include/uaccess.h
+++ /dev/null	2004-10-19 20:34:05.000000000 +0200
@@ -1,40 +0,0 @@
-/* 
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __SKAS_UACCESS_H
-#define __SKAS_UACCESS_H
-
-#include "asm/errno.h"
-
-#define access_ok_skas(type, addr, size) \
-	((segment_eq(get_fs(), KERNEL_DS)) || \
-	 (((unsigned long) (addr) < TASK_SIZE) && \
-	  ((unsigned long) (addr) + (size) <= TASK_SIZE)))
-
-static inline int verify_area_skas(int type, const void * addr, 
-				   unsigned long size)
-{
-	return(access_ok_skas(type, addr, size) ? 0 : -EFAULT);
-}
-
-extern int copy_from_user_skas(void *to, const void *from, int n);
-extern int copy_to_user_skas(void *to, const void *from, int n);
-extern int strncpy_from_user_skas(char *dst, const char *src, int count);
-extern int __clear_user_skas(void *mem, int len);
-extern int clear_user_skas(void *mem, int len);
-extern int strnlen_user_skas(const void *str, int len);
-
-#endif
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
diff -puN /dev/null arch/um/kernel/skas/include/uaccess-skas.h
--- /dev/null	2004-10-19 20:34:05.000000000 +0200
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/skas/include/uaccess-skas.h	2004-11-03 23:44:57.858764248 +0100
@@ -0,0 +1,40 @@
+/*
+ * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#ifndef __SKAS_UACCESS_H
+#define __SKAS_UACCESS_H
+
+#include "asm/errno.h"
+
+#define access_ok_skas(type, addr, size) \
+	((segment_eq(get_fs(), KERNEL_DS)) || \
+	 (((unsigned long) (addr) < TASK_SIZE) && \
+	  ((unsigned long) (addr) + (size) <= TASK_SIZE)))
+
+static inline int verify_area_skas(int type, const void * addr,
+				   unsigned long size)
+{
+	return(access_ok_skas(type, addr, size) ? 0 : -EFAULT);
+}
+
+extern int copy_from_user_skas(void *to, const void *from, int n);
+extern int copy_to_user_skas(void *to, const void *from, int n);
+extern int strncpy_from_user_skas(char *dst, const char *src, int count);
+extern int __clear_user_skas(void *mem, int len);
+extern int clear_user_skas(void *mem, int len);
+extern int strnlen_user_skas(const void *str, int len);
+
+#endif
+
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * Emacs will notice this stuff at the end of the file and automatically
+ * adjust the settings for this buffer only.  This must remain at the end
+ * of the file.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ */
diff -L arch/um/kernel/tt/include/mmu.h -puN arch/um/kernel/tt/include/mmu.h~uml-Rename-Mode-Headers /dev/null
--- vanilla-linux-2.6.9/arch/um/kernel/tt/include/mmu.h
+++ /dev/null	2004-10-19 20:34:05.000000000 +0200
@@ -1,23 +0,0 @@
-/* 
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __TT_MMU_H
-#define __TT_MMU_H
-
-struct mmu_context_tt {
-};
-
-#endif
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
diff -puN /dev/null arch/um/kernel/tt/include/mmu-tt.h
--- /dev/null	2004-10-19 20:34:05.000000000 +0200
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/tt/include/mmu-tt.h	2004-11-03 23:44:57.858764248 +0100
@@ -0,0 +1,23 @@
+/*
+ * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#ifndef __TT_MMU_H
+#define __TT_MMU_H
+
+struct mmu_context_tt {
+};
+
+#endif
+
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * Emacs will notice this stuff at the end of the file and automatically
+ * adjust the settings for this buffer only.  This must remain at the end
+ * of the file.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ */
diff -L arch/um/kernel/tt/include/mode.h -puN arch/um/kernel/tt/include/mode.h~uml-Rename-Mode-Headers /dev/null
--- vanilla-linux-2.6.9/arch/um/kernel/tt/include/mode.h
+++ /dev/null	2004-10-19 20:34:05.000000000 +0200
@@ -1,38 +0,0 @@
-/* 
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __MODE_TT_H__
-#define __MODE_TT_H__
-
-#include "sysdep/ptrace.h"
-
-enum { OP_NONE, OP_EXEC, OP_FORK, OP_TRACE_ON, OP_REBOOT, OP_HALT, OP_CB };
-
-extern int tracing_pid;
-
-extern int tracer(int (*init_proc)(void *), void *sp);
-extern void user_time_init_tt(void);
-extern int copy_sc_from_user_tt(void *to_ptr, void *from_ptr, void *data);
-extern int copy_sc_to_user_tt(void *to_ptr, void *fp, void *from_ptr, 
-			      void *data);
-extern void sig_handler_common_tt(int sig, void *sc);
-extern void syscall_handler_tt(int sig, union uml_pt_regs *regs);
-extern void reboot_tt(void);
-extern void halt_tt(void);
-extern int is_tracer_winch(int pid, int fd, void *data);
-extern void kill_off_processes_tt(void);
-
-#endif
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
diff -L arch/um/kernel/tt/include/mode_kern.h -puN arch/um/kernel/tt/include/mode_kern.h~uml-Rename-Mode-Headers /dev/null
--- vanilla-linux-2.6.9/arch/um/kernel/tt/include/mode_kern.h
+++ /dev/null	2004-10-19 20:34:05.000000000 +0200
@@ -1,53 +0,0 @@
-/* 
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __TT_MODE_KERN_H__
-#define __TT_MODE_KERN_H__
-
-#include "linux/sched.h"
-#include "asm/page.h"
-#include "asm/ptrace.h"
-#include "asm/uaccess.h"
-
-extern void *switch_to_tt(void *prev, void *next);
-extern void flush_thread_tt(void);
-extern void start_thread_tt(struct pt_regs *regs, unsigned long eip, 
-			   unsigned long esp);
-extern int copy_thread_tt(int nr, unsigned long clone_flags, unsigned long sp,
-			  unsigned long stack_top, struct task_struct *p, 
-			  struct pt_regs *regs);
-extern void release_thread_tt(struct task_struct *task);
-extern void exit_thread_tt(void);
-extern void initial_thread_cb_tt(void (*proc)(void *), void *arg);
-extern void init_idle_tt(void);
-extern void flush_tlb_kernel_range_tt(unsigned long start, unsigned long end);
-extern void flush_tlb_kernel_vm_tt(void);
-extern void __flush_tlb_one_tt(unsigned long addr);
-extern void flush_tlb_range_tt(struct vm_area_struct *vma, 
-			       unsigned long start, unsigned long end);
-extern void flush_tlb_mm_tt(struct mm_struct *mm);
-extern void force_flush_all_tt(void);
-extern long execute_syscall_tt(void *r);
-extern void before_mem_tt(unsigned long brk_start);
-extern unsigned long set_task_sizes_tt(int arg, unsigned long *host_size_out, 
-				       unsigned long *task_size_out);
-extern int start_uml_tt(void);
-extern int external_pid_tt(struct task_struct *task);
-extern int thread_pid_tt(struct task_struct *task);
-
-#define kmem_end_tt (host_task_size - ABOVE_KMEM)
-
-#endif
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
diff -puN /dev/null arch/um/kernel/tt/include/mode_kern-tt.h
--- /dev/null	2004-10-19 20:34:05.000000000 +0200
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/tt/include/mode_kern-tt.h	2004-11-03 23:44:57.859764096 +0100
@@ -0,0 +1,53 @@
+/*
+ * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#ifndef __TT_MODE_KERN_H__
+#define __TT_MODE_KERN_H__
+
+#include "linux/sched.h"
+#include "asm/page.h"
+#include "asm/ptrace.h"
+#include "asm/uaccess.h"
+
+extern void *switch_to_tt(void *prev, void *next);
+extern void flush_thread_tt(void);
+extern void start_thread_tt(struct pt_regs *regs, unsigned long eip,
+			   unsigned long esp);
+extern int copy_thread_tt(int nr, unsigned long clone_flags, unsigned long sp,
+			  unsigned long stack_top, struct task_struct *p,
+			  struct pt_regs *regs);
+extern void release_thread_tt(struct task_struct *task);
+extern void exit_thread_tt(void);
+extern void initial_thread_cb_tt(void (*proc)(void *), void *arg);
+extern void init_idle_tt(void);
+extern void flush_tlb_kernel_range_tt(unsigned long start, unsigned long end);
+extern void flush_tlb_kernel_vm_tt(void);
+extern void __flush_tlb_one_tt(unsigned long addr);
+extern void flush_tlb_range_tt(struct vm_area_struct *vma,
+			       unsigned long start, unsigned long end);
+extern void flush_tlb_mm_tt(struct mm_struct *mm);
+extern void force_flush_all_tt(void);
+extern long execute_syscall_tt(void *r);
+extern void before_mem_tt(unsigned long brk_start);
+extern unsigned long set_task_sizes_tt(int arg, unsigned long *host_size_out,
+				       unsigned long *task_size_out);
+extern int start_uml_tt(void);
+extern int external_pid_tt(struct task_struct *task);
+extern int thread_pid_tt(struct task_struct *task);
+
+#define kmem_end_tt (host_task_size - ABOVE_KMEM)
+
+#endif
+
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * Emacs will notice this stuff at the end of the file and automatically
+ * adjust the settings for this buffer only.  This must remain at the end
+ * of the file.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ */
diff -puN /dev/null arch/um/kernel/tt/include/mode-tt.h
--- /dev/null	2004-10-19 20:34:05.000000000 +0200
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/tt/include/mode-tt.h	2004-11-03 23:44:57.859764096 +0100
@@ -0,0 +1,38 @@
+/*
+ * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#ifndef __MODE_TT_H__
+#define __MODE_TT_H__
+
+#include "sysdep/ptrace.h"
+
+enum { OP_NONE, OP_EXEC, OP_FORK, OP_TRACE_ON, OP_REBOOT, OP_HALT, OP_CB };
+
+extern int tracing_pid;
+
+extern int tracer(int (*init_proc)(void *), void *sp);
+extern void user_time_init_tt(void);
+extern int copy_sc_from_user_tt(void *to_ptr, void *from_ptr, void *data);
+extern int copy_sc_to_user_tt(void *to_ptr, void *fp, void *from_ptr,
+			      void *data);
+extern void sig_handler_common_tt(int sig, void *sc);
+extern void syscall_handler_tt(int sig, union uml_pt_regs *regs);
+extern void reboot_tt(void);
+extern void halt_tt(void);
+extern int is_tracer_winch(int pid, int fd, void *data);
+extern void kill_off_processes_tt(void);
+
+#endif
+
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * Emacs will notice this stuff at the end of the file and automatically
+ * adjust the settings for this buffer only.  This must remain at the end
+ * of the file.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ */
diff -L arch/um/kernel/tt/include/uaccess.h -puN arch/um/kernel/tt/include/uaccess.h~uml-Rename-Mode-Headers /dev/null
--- vanilla-linux-2.6.9/arch/um/kernel/tt/include/uaccess.h
+++ /dev/null	2004-10-19 20:34:05.000000000 +0200
@@ -1,71 +0,0 @@
-/* 
- * Copyright (C) 2000 - 2003 Jeff Dike (jdike@addtoit.com)
- * Licensed under the GPL
- */
-
-#ifndef __TT_UACCESS_H
-#define __TT_UACCESS_H
-
-#include "linux/string.h"
-#include "linux/sched.h"
-#include "asm/processor.h"
-#include "asm/errno.h"
-#include "asm/current.h"
-#include "asm/a.out.h"
-#include "uml_uaccess.h"
-
-#define ABOVE_KMEM (16 * 1024 * 1024)
-
-extern unsigned long end_vm;
-extern unsigned long uml_physmem;
-
-#define under_task_size(addr, size) \
-	(((unsigned long) (addr) < TASK_SIZE) && \
-         (((unsigned long) (addr) + (size)) < TASK_SIZE))
-
-#define is_stack(addr, size) \
-	(((unsigned long) (addr) < STACK_TOP) && \
-	 ((unsigned long) (addr) >= STACK_TOP - ABOVE_KMEM) && \
-	 (((unsigned long) (addr) + (size)) <= STACK_TOP))
-
-#define access_ok_tt(type, addr, size) \
-	((type == VERIFY_READ) || (segment_eq(get_fs(), KERNEL_DS)) || \
-         (((unsigned long) (addr) <= ((unsigned long) (addr) + (size))) && \
-          (under_task_size(addr, size) || is_stack(addr, size))))
-
-static inline int verify_area_tt(int type, const void * addr, 
-				 unsigned long size)
-{
-	return(access_ok_tt(type, addr, size) ? 0 : -EFAULT);
-}
-
-extern unsigned long get_fault_addr(void);
-
-extern int __do_copy_from_user(void *to, const void *from, int n,
-			       void **fault_addr, void **fault_catcher);
-extern int __do_strncpy_from_user(char *dst, const char *src, size_t n,
-				  void **fault_addr, void **fault_catcher);
-extern int __do_clear_user(void *mem, size_t len, void **fault_addr,
-			   void **fault_catcher);
-extern int __do_strnlen_user(const char *str, unsigned long n,
-			     void **fault_addr, void **fault_catcher);
-
-extern int copy_from_user_tt(void *to, const void *from, int n);
-extern int copy_to_user_tt(void *to, const void *from, int n);
-extern int strncpy_from_user_tt(char *dst, const char *src, int count);
-extern int __clear_user_tt(void *mem, int len);
-extern int clear_user_tt(void *mem, int len);
-extern int strnlen_user_tt(const void *str, int len);
-
-#endif
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
diff -puN /dev/null arch/um/kernel/tt/include/uaccess-tt.h
--- /dev/null	2004-10-19 20:34:05.000000000 +0200
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/tt/include/uaccess-tt.h	2004-11-03 23:44:57.860763944 +0100
@@ -0,0 +1,71 @@
+/*
+ * Copyright (C) 2000 - 2003 Jeff Dike (jdike@addtoit.com)
+ * Licensed under the GPL
+ */
+
+#ifndef __TT_UACCESS_H
+#define __TT_UACCESS_H
+
+#include "linux/string.h"
+#include "linux/sched.h"
+#include "asm/processor.h"
+#include "asm/errno.h"
+#include "asm/current.h"
+#include "asm/a.out.h"
+#include "uml_uaccess.h"
+
+#define ABOVE_KMEM (16 * 1024 * 1024)
+
+extern unsigned long end_vm;
+extern unsigned long uml_physmem;
+
+#define under_task_size(addr, size) \
+	(((unsigned long) (addr) < TASK_SIZE) && \
+         (((unsigned long) (addr) + (size)) < TASK_SIZE))
+
+#define is_stack(addr, size) \
+	(((unsigned long) (addr) < STACK_TOP) && \
+	 ((unsigned long) (addr) >= STACK_TOP - ABOVE_KMEM) && \
+	 (((unsigned long) (addr) + (size)) <= STACK_TOP))
+
+#define access_ok_tt(type, addr, size) \
+	((type == VERIFY_READ) || (segment_eq(get_fs(), KERNEL_DS)) || \
+         (((unsigned long) (addr) <= ((unsigned long) (addr) + (size))) && \
+          (under_task_size(addr, size) || is_stack(addr, size))))
+
+static inline int verify_area_tt(int type, const void * addr,
+				 unsigned long size)
+{
+	return(access_ok_tt(type, addr, size) ? 0 : -EFAULT);
+}
+
+extern unsigned long get_fault_addr(void);
+
+extern int __do_copy_from_user(void *to, const void *from, int n,
+			       void **fault_addr, void **fault_catcher);
+extern int __do_strncpy_from_user(char *dst, const char *src, size_t n,
+				  void **fault_addr, void **fault_catcher);
+extern int __do_clear_user(void *mem, size_t len, void **fault_addr,
+			   void **fault_catcher);
+extern int __do_strnlen_user(const char *str, unsigned long n,
+			     void **fault_addr, void **fault_catcher);
+
+extern int copy_from_user_tt(void *to, const void *from, int n);
+extern int copy_to_user_tt(void *to, const void *from, int n);
+extern int strncpy_from_user_tt(char *dst, const char *src, int count);
+extern int __clear_user_tt(void *mem, int len);
+extern int clear_user_tt(void *mem, int len);
+extern int strnlen_user_tt(const void *str, int len);
+
+#endif
+
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * Emacs will notice this stuff at the end of the file and automatically
+ * adjust the settings for this buffer only.  This must remain at the end
+ * of the file.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ */
_
