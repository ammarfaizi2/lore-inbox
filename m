Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288414AbSANAUq>; Sun, 13 Jan 2002 19:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288420AbSANAUj>; Sun, 13 Jan 2002 19:20:39 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:27124 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S288414AbSANAUY>; Sun, 13 Jan 2002 19:20:24 -0500
Date: Sun, 13 Jan 2002 19:20:21 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC][PATCH] cleanup file.h and INIT_TASK a bit
Message-ID: <20020113192021.B32700@redhat.com>
In-Reply-To: <20020113185947.A32700@redhat.com> <3C4222C9.768F2C76@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C4222C9.768F2C76@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sun, Jan 13, 2002 at 07:14:01PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 13, 2002 at 07:14:01PM -0500, Jeff Garzik wrote:
> I don't see a patch attached to your message...

Doh!  Here it is... (also on kernel.org)
		-ben

:r ~/patches/v2.5.2-pre11-file_init.diff
diff -urN v2.5.2-pre11/arch/arm/kernel/init_task.c v2.5.2-pre11-file.h/arch/arm/kernel/init_task.c
--- v2.5.2-pre11/arch/arm/kernel/init_task.c	Sun Jan 13 02:32:32 2002
+++ v2.5.2-pre11-file.h/arch/arm/kernel/init_task.c	Sun Jan 13 18:35:29 2002
@@ -5,6 +5,7 @@
 #include <linux/fs.h>
 #include <linux/sched.h>
 #include <linux/init.h>
+#include <linux/init_task.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
diff -urN v2.5.2-pre11/arch/i386/kernel/init_task.c v2.5.2-pre11-file.h/arch/i386/kernel/init_task.c
--- v2.5.2-pre11/arch/i386/kernel/init_task.c	Mon Sep 17 18:29:09 2001
+++ v2.5.2-pre11-file.h/arch/i386/kernel/init_task.c	Sun Jan 13 18:35:38 2002
@@ -1,6 +1,7 @@
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/init.h>
+#include <linux/init_task.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
diff -urN v2.5.2-pre11/arch/ia64/kernel/init_task.c v2.5.2-pre11-file.h/arch/ia64/kernel/init_task.c
--- v2.5.2-pre11/arch/ia64/kernel/init_task.c	Mon Sep 17 18:29:09 2001
+++ v2.5.2-pre11-file.h/arch/ia64/kernel/init_task.c	Sun Jan 13 18:35:47 2002
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
+#include <linux/init_task.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
diff -urN v2.5.2-pre11/arch/mips/kernel/init_task.c v2.5.2-pre11-file.h/arch/mips/kernel/init_task.c
--- v2.5.2-pre11/arch/mips/kernel/init_task.c	Mon Sep 17 18:29:09 2001
+++ v2.5.2-pre11-file.h/arch/mips/kernel/init_task.c	Sun Jan 13 18:35:51 2002
@@ -1,5 +1,6 @@
 #include <linux/mm.h>
 #include <linux/sched.h>
+#include <linux/init_task.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
diff -urN v2.5.2-pre11/arch/mips64/kernel/init_task.c v2.5.2-pre11-file.h/arch/mips64/kernel/init_task.c
--- v2.5.2-pre11/arch/mips64/kernel/init_task.c	Mon Sep 17 18:29:09 2001
+++ v2.5.2-pre11-file.h/arch/mips64/kernel/init_task.c	Sun Jan 13 18:35:54 2002
@@ -1,5 +1,6 @@
 #include <linux/mm.h>
 #include <linux/sched.h>
+#include <linux/init_task.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
diff -urN v2.5.2-pre11/arch/parisc/kernel/init_task.c v2.5.2-pre11-file.h/arch/parisc/kernel/init_task.c
--- v2.5.2-pre11/arch/parisc/kernel/init_task.c	Mon Sep 17 18:29:09 2001
+++ v2.5.2-pre11-file.h/arch/parisc/kernel/init_task.c	Sun Jan 13 18:37:28 2002
@@ -1,6 +1,7 @@
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/init.h>
+#include <linux/init_task.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
diff -urN v2.5.2-pre11/arch/s390/kernel/init_task.c v2.5.2-pre11-file.h/arch/s390/kernel/init_task.c
--- v2.5.2-pre11/arch/s390/kernel/init_task.c	Fri Nov  9 16:58:02 2001
+++ v2.5.2-pre11-file.h/arch/s390/kernel/init_task.c	Sun Jan 13 18:37:35 2002
@@ -8,6 +8,7 @@
 
 #include <linux/mm.h>
 #include <linux/sched.h>
+#include <linux/init_task.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
diff -urN v2.5.2-pre11/arch/s390x/kernel/init_task.c v2.5.2-pre11-file.h/arch/s390x/kernel/init_task.c
--- v2.5.2-pre11/arch/s390x/kernel/init_task.c	Fri Nov  9 16:58:02 2001
+++ v2.5.2-pre11-file.h/arch/s390x/kernel/init_task.c	Sun Jan 13 18:37:39 2002
@@ -8,6 +8,7 @@
 
 #include <linux/mm.h>
 #include <linux/sched.h>
+#include <linux/init_task.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
diff -urN v2.5.2-pre11/arch/sh/kernel/init_task.c v2.5.2-pre11-file.h/arch/sh/kernel/init_task.c
--- v2.5.2-pre11/arch/sh/kernel/init_task.c	Wed Jan  2 19:32:34 2002
+++ v2.5.2-pre11-file.h/arch/sh/kernel/init_task.c	Sun Jan 13 18:37:42 2002
@@ -1,6 +1,7 @@
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/init.h>
+#include <linux/init_task.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
diff -urN v2.5.2-pre11/arch/sparc/kernel/init_task.c v2.5.2-pre11-file.h/arch/sparc/kernel/init_task.c
--- v2.5.2-pre11/arch/sparc/kernel/init_task.c	Mon Sep 17 18:29:09 2001
+++ v2.5.2-pre11-file.h/arch/sparc/kernel/init_task.c	Sun Jan 13 18:37:46 2002
@@ -1,5 +1,6 @@
 #include <linux/mm.h>
 #include <linux/sched.h>
+#include <linux/init_task.h>
 
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
diff -urN v2.5.2-pre11/arch/sparc64/kernel/init_task.c v2.5.2-pre11-file.h/arch/sparc64/kernel/init_task.c
--- v2.5.2-pre11/arch/sparc64/kernel/init_task.c	Thu Sep 20 17:11:57 2001
+++ v2.5.2-pre11-file.h/arch/sparc64/kernel/init_task.c	Sun Jan 13 18:37:49 2002
@@ -1,5 +1,6 @@
 #include <linux/mm.h>
 #include <linux/sched.h>
+#include <linux/init_task.h>
 
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
diff -urN v2.5.2-pre11/drivers/usb/storage/usb.c v2.5.2-pre11-file.h/drivers/usb/storage/usb.c
--- v2.5.2-pre11/drivers/usb/storage/usb.c	Sun Jan 13 02:32:34 2002
+++ v2.5.2-pre11-file.h/drivers/usb/storage/usb.c	Sun Jan 13 18:26:02 2002
@@ -314,9 +314,6 @@
 	 * This thread doesn't need any user-level access,
 	 * so get rid of all our resources..
 	 */
-	exit_files(current);
-	current->files = init_task.files;
-	atomic_inc(&current->files->count);
 	daemonize();
 
 	/* set our name for identification purposes */
diff -urN v2.5.2-pre11/fs/fcntl.c v2.5.2-pre11-file.h/fs/fcntl.c
--- v2.5.2-pre11/fs/fcntl.c	Mon Sep 17 16:16:30 2001
+++ v2.5.2-pre11-file.h/fs/fcntl.c	Sun Jan 13 18:00:38 2002
@@ -20,6 +20,28 @@
 extern int fcntl_setlease(unsigned int fd, struct file *filp, long arg);
 extern int fcntl_getlease(struct file *filp);
 
+void set_close_on_exec(unsigned int fd, int flag)
+{
+	struct files_struct *files = current->files;
+	write_lock(&files->file_lock);
+	if (flag)
+		FD_SET(fd, files->close_on_exec);
+	else
+		FD_CLR(fd, files->close_on_exec);
+	write_unlock(&files->file_lock);
+}
+
+static inline int get_close_on_exec(unsigned int fd)
+{
+	struct files_struct *files = current->files;
+	int res;
+	read_lock(&files->file_lock);
+	res = FD_ISSET(fd, files->close_on_exec);
+	read_unlock(&files->file_lock);
+	return res;
+}
+
+
 /* Expand files.  Return <0 on error; 0 nothing done; 1 files expanded,
  * we may have blocked. 
  *
diff -urN v2.5.2-pre11/fs/file.c v2.5.2-pre11-file.h/fs/file.c
--- v2.5.2-pre11/fs/file.c	Fri Feb  9 14:29:44 2001
+++ v2.5.2-pre11-file.h/fs/file.c	Sun Jan 13 18:22:10 2002
@@ -11,6 +11,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+#include <linux/file.h>
 
 #include <asm/bitops.h>
 
diff -urN v2.5.2-pre11/fs/proc/array.c v2.5.2-pre11-file.h/fs/proc/array.c
--- v2.5.2-pre11/fs/proc/array.c	Sun Jan 13 02:32:34 2002
+++ v2.5.2-pre11-file.h/fs/proc/array.c	Sun Jan 13 18:19:37 2002
@@ -70,6 +70,7 @@
 #include <linux/smp.h>
 #include <linux/signal.h>
 #include <linux/highmem.h>
+#include <linux/file.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
diff -urN v2.5.2-pre11/include/linux/file.h v2.5.2-pre11-file.h/include/linux/file.h
--- v2.5.2-pre11/include/linux/file.h	Sun Jan 13 02:32:35 2002
+++ v2.5.2-pre11-file.h/include/linux/file.h	Sun Jan 13 18:20:09 2002
@@ -5,31 +5,39 @@
 #ifndef __LINUX_FILE_H
 #define __LINUX_FILE_H
 
-#include <linux/sched.h>
+#ifndef _LINUX_POSIX_TYPES_H	/* __FD_CLR */
+#include <linux/posix_types.h>
+#endif
+#ifndef __LINUX_COMPILER_H	/* unlikely */
+#include <linux/compiler.h>
+#endif
+
+/*
+ * The default fd array needs to be at least BITS_PER_LONG,
+ * as this is the granularity returned by copy_fdset().
+ */
+#define NR_OPEN_DEFAULT BITS_PER_LONG
+
+/*
+ * Open file table structure
+ */
+struct files_struct {
+        atomic_t count;
+        rwlock_t file_lock;     /* Protects all the below members.  Nests inside tsk->alloc_lock */
+        int max_fds;
+        int max_fdset;
+        int next_fd;
+        struct file ** fd;      /* current fd array */
+        fd_set *close_on_exec;
+        fd_set *open_fds;
+        fd_set close_on_exec_init;
+        fd_set open_fds_init;
+        struct file * fd_array[NR_OPEN_DEFAULT];
+};
 
 extern void FASTCALL(fput(struct file *));
 extern struct file * FASTCALL(fget(unsigned int fd));
- 
-static inline int get_close_on_exec(unsigned int fd)
-{
-	struct files_struct *files = current->files;
-	int res;
-	read_lock(&files->file_lock);
-	res = FD_ISSET(fd, files->close_on_exec);
-	read_unlock(&files->file_lock);
-	return res;
-}
-
-static inline void set_close_on_exec(unsigned int fd, int flag)
-{
-	struct files_struct *files = current->files;
-	write_lock(&files->file_lock);
-	if (flag)
-		FD_SET(fd, files->close_on_exec);
-	else
-		FD_CLR(fd, files->close_on_exec);
-	write_unlock(&files->file_lock);
-}
+extern void FASTCALL(set_close_on_exec(unsigned int fd, int flag));
 
 static inline struct file * fcheck_files(struct files_struct *files, unsigned int fd)
 {
@@ -43,15 +51,7 @@
 /*
  * Check whether the specified fd has an open file.
  */
-static inline struct file * fcheck(unsigned int fd)
-{
-	struct file * file = NULL;
-	struct files_struct *files = current->files;
-
-	if (fd < files->max_fds)
-		file = files->fd[fd];
-	return file;
-}
+#define fcheck(fd)	fcheck_files(current->files, fd)
 
 extern void put_filp(struct file *);
 
@@ -59,19 +59,18 @@
 
 static inline void __put_unused_fd(struct files_struct *files, unsigned int fd)
 {
-	FD_CLR(fd, files->open_fds);
+	__FD_CLR(fd, files->open_fds);
 	if (fd < files->next_fd)
 		files->next_fd = fd;
 }
 
-static inline void put_unused_fd(unsigned int fd)
+static inline void put_unused_fd_files(struct files_struct *files, unsigned int fd)
 {
-	struct files_struct *files = current->files;
-
 	write_lock(&files->file_lock);
 	__put_unused_fd(files, fd);
 	write_unlock(&files->file_lock);
 }
+#define put_unused_fd(fd) put_unused_fd_files(current->files, fd)
 
 /*
  * Install a file pointer in the fd array.  
@@ -86,16 +85,16 @@
  * will follow.
  */
 
-static inline void fd_install(unsigned int fd, struct file * file)
+static inline void fd_install_files(struct files_struct *files, 
+				    unsigned int fd, struct file * file)
 {
-	struct files_struct *files = current->files;
-	
 	write_lock(&files->file_lock);
-	if (files->fd[fd])
+	if (unlikely(files->fd[fd] != NULL))
 		BUG();
 	files->fd[fd] = file;
 	write_unlock(&files->file_lock);
 }
+#define fd_install(fd, file)	fd_install_files(current->files, fd, file)
 
 void put_files_struct(struct files_struct *fs);
 
diff -urN v2.5.2-pre11/include/linux/init_task.h v2.5.2-pre11-file.h/include/linux/init_task.h
--- v2.5.2-pre11/include/linux/init_task.h	Wed Dec 31 19:00:00 1969
+++ v2.5.2-pre11-file.h/include/linux/init_task.h	Sun Jan 13 18:46:28 2002
@@ -0,0 +1,88 @@
+#ifndef _LINUX__INIT_TASK_H
+#define _LINUX__INIT_TASK_H
+
+#ifndef __LINUX_FILE_H
+#include <linux/file.h>
+#endif
+
+#define INIT_FILES \
+{ 							\
+	count:		ATOMIC_INIT(1), 		\
+	file_lock:	RW_LOCK_UNLOCKED, 		\
+	max_fds:	NR_OPEN_DEFAULT, 		\
+	max_fdset:	__FD_SETSIZE, 			\
+	next_fd:	0, 				\
+	fd:		&init_files.fd_array[0], 	\
+	close_on_exec:	&init_files.close_on_exec_init, \
+	open_fds:	&init_files.open_fds_init, 	\
+	close_on_exec_init: { { 0, } }, 		\
+	open_fds_init:	{ { 0, } }, 			\
+	fd_array:	{ NULL, } 			\
+}
+
+#define INIT_MM(name) \
+{			 				\
+	mm_rb:		RB_ROOT,			\
+	pgd:		swapper_pg_dir, 		\
+	mm_users:	ATOMIC_INIT(2), 		\
+	mm_count:	ATOMIC_INIT(1), 		\
+	mmap_sem:	__RWSEM_INITIALIZER(name.mmap_sem), \
+	page_table_lock: SPIN_LOCK_UNLOCKED, 		\
+	mmlist:		LIST_HEAD_INIT(name.mmlist),	\
+}
+
+#define INIT_SIGNALS {	\
+	count:		ATOMIC_INIT(1), 		\
+	action:		{ {{0,}}, }, 			\
+	siglock:	SPIN_LOCK_UNLOCKED 		\
+}
+
+/*
+ *  INIT_TASK is used to set up the first task table, touch at
+ * your own risk!. Base=0, limit=0x1fffff (=2MB)
+ */
+#define INIT_TASK(tsk)	\
+{									\
+    state:		0,						\
+    flags:		0,						\
+    sigpending:		0,						\
+    addr_limit:		KERNEL_DS,					\
+    exec_domain:	&default_exec_domain,				\
+    lock_depth:		-1,						\
+    __nice:		DEF_USER_NICE,					\
+    policy:		SCHED_OTHER,					\
+    cpus_allowed:	-1,						\
+    mm:			NULL,						\
+    active_mm:		&init_mm,					\
+    run_list:		LIST_HEAD_INIT(tsk.run_list),			\
+    time_slice:		PRIO_TO_TIMESLICE(DEF_PRIO),			\
+    next_task:		&tsk,						\
+    prev_task:		&tsk,						\
+    p_opptr:		&tsk,						\
+    p_pptr:		&tsk,						\
+    thread_group:	LIST_HEAD_INIT(tsk.thread_group),		\
+    wait_chldexit:	__WAIT_QUEUE_HEAD_INITIALIZER(tsk.wait_chldexit),\
+    real_timer:		{						\
+	function:		it_real_fn				\
+    },									\
+    cap_effective:	CAP_INIT_EFF_SET,				\
+    cap_inheritable:	CAP_INIT_INH_SET,				\
+    cap_permitted:	CAP_FULL_SET,					\
+    keep_capabilities:	0,						\
+    rlim:		INIT_RLIMITS,					\
+    user:		INIT_USER,					\
+    comm:		"swapper",					\
+    thread:		INIT_THREAD,					\
+    fs:			&init_fs,					\
+    files:		&init_files,					\
+    sigmask_lock:	SPIN_LOCK_UNLOCKED,				\
+    sig:		&init_signals,					\
+    pending:		{ NULL, &tsk.pending.head, {{0}}},		\
+    blocked:		{{0}},						\
+    alloc_lock:		SPIN_LOCK_UNLOCKED,				\
+    journal_info:	NULL,						\
+}
+
+
+
+#endif
diff -urN v2.5.2-pre11/include/linux/sched.h v2.5.2-pre11-file.h/include/linux/sched.h
--- v2.5.2-pre11/include/linux/sched.h	Sun Jan 13 02:32:35 2002
+++ v2.5.2-pre11-file.h/include/linux/sched.h	Sun Jan 13 18:43:14 2002
@@ -156,44 +156,7 @@
 extern int start_context_thread(void);
 extern int current_is_keventd(void);
 
-/*
- * The default fd array needs to be at least BITS_PER_LONG,
- * as this is the granularity returned by copy_fdset().
- */
-#define NR_OPEN_DEFAULT BITS_PER_LONG
-
 struct namespace;
-/*
- * Open file table structure
- */
-struct files_struct {
-	atomic_t count;
-	rwlock_t file_lock;	/* Protects all the below members.  Nests inside tsk->alloc_lock */
-	int max_fds;
-	int max_fdset;
-	int next_fd;
-	struct file ** fd;	/* current fd array */
-	fd_set *close_on_exec;
-	fd_set *open_fds;
-	fd_set close_on_exec_init;
-	fd_set open_fds_init;
-	struct file * fd_array[NR_OPEN_DEFAULT];
-};
-
-#define INIT_FILES \
-{ 							\
-	count:		ATOMIC_INIT(1), 		\
-	file_lock:	RW_LOCK_UNLOCKED, 		\
-	max_fds:	NR_OPEN_DEFAULT, 		\
-	max_fdset:	__FD_SETSIZE, 			\
-	next_fd:	0, 				\
-	fd:		&init_files.fd_array[0], 	\
-	close_on_exec:	&init_files.close_on_exec_init, \
-	open_fds:	&init_files.open_fds_init, 	\
-	close_on_exec_init: { { 0, } }, 		\
-	open_fds_init:	{ { 0, } }, 			\
-	fd_array:	{ NULL, } 			\
-}
 
 /* Maximum number of active map areas.. This is a random (large) number */
 #define MAX_MAP_COUNT	(65536)
@@ -230,17 +193,6 @@
 
 extern int mmlist_nr;
 
-#define INIT_MM(name) \
-{			 				\
-	mm_rb:		RB_ROOT,			\
-	pgd:		swapper_pg_dir, 		\
-	mm_users:	ATOMIC_INIT(2), 		\
-	mm_count:	ATOMIC_INIT(1), 		\
-	mmap_sem:	__RWSEM_INITIALIZER(name.mmap_sem), \
-	page_table_lock: SPIN_LOCK_UNLOCKED, 		\
-	mmlist:		LIST_HEAD_INIT(name.mmlist),	\
-}
-
 struct signal_struct {
 	atomic_t		count;
 	struct k_sigaction	action[_NSIG];
@@ -248,12 +200,6 @@
 };
 
 
-#define INIT_SIGNALS {	\
-	count:		ATOMIC_INIT(1), 		\
-	action:		{ {{0,}}, }, 			\
-	siglock:	SPIN_LOCK_UNLOCKED 		\
-}
-
 /*
  * Some day this will be a full-fledged user tracking system..
  */
@@ -505,53 +451,6 @@
  */
 extern struct exec_domain	default_exec_domain;
 
-/*
- *  INIT_TASK is used to set up the first task table, touch at
- * your own risk!. Base=0, limit=0x1fffff (=2MB)
- */
-#define INIT_TASK(tsk)	\
-{									\
-    state:		0,						\
-    flags:		0,						\
-    sigpending:		0,						\
-    addr_limit:		KERNEL_DS,					\
-    exec_domain:	&default_exec_domain,				\
-    lock_depth:		-1,						\
-    __nice:		DEF_USER_NICE,					\
-    policy:		SCHED_OTHER,					\
-    cpus_allowed:	-1,						\
-    mm:			NULL,						\
-    active_mm:		&init_mm,					\
-    run_list:		LIST_HEAD_INIT(tsk.run_list),			\
-    time_slice:		PRIO_TO_TIMESLICE(DEF_PRIO),			\
-    next_task:		&tsk,						\
-    prev_task:		&tsk,						\
-    p_opptr:		&tsk,						\
-    p_pptr:		&tsk,						\
-    thread_group:	LIST_HEAD_INIT(tsk.thread_group),		\
-    wait_chldexit:	__WAIT_QUEUE_HEAD_INITIALIZER(tsk.wait_chldexit),\
-    real_timer:		{						\
-	function:		it_real_fn				\
-    },									\
-    cap_effective:	CAP_INIT_EFF_SET,				\
-    cap_inheritable:	CAP_INIT_INH_SET,				\
-    cap_permitted:	CAP_FULL_SET,					\
-    keep_capabilities:	0,						\
-    rlim:		INIT_RLIMITS,					\
-    user:		INIT_USER,					\
-    comm:		"swapper",					\
-    thread:		INIT_THREAD,					\
-    fs:			&init_fs,					\
-    files:		&init_files,					\
-    sigmask_lock:	SPIN_LOCK_UNLOCKED,				\
-    sig:		&init_signals,					\
-    pending:		{ NULL, &tsk.pending.head, {{0}}},		\
-    blocked:		{{0}},						\
-    alloc_lock:		SPIN_LOCK_UNLOCKED,				\
-    journal_info:	NULL,						\
-}
-
-
 #ifndef INIT_TASK_SIZE
 # define INIT_TASK_SIZE	2048*sizeof(long)
 #endif
diff -urN v2.5.2-pre11/kernel/exit.c v2.5.2-pre11-file.h/kernel/exit.c
--- v2.5.2-pre11/kernel/exit.c	Sun Jan 13 02:32:35 2002
+++ v2.5.2-pre11-file.h/kernel/exit.c	Sun Jan 13 18:10:10 2002
@@ -17,6 +17,7 @@
 #ifdef CONFIG_BSD_PROCESS_ACCT
 #include <linux/acct.h>
 #endif
+#include <linux/file.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
diff -urN v2.5.2-pre11/kernel/fork.c v2.5.2-pre11-file.h/kernel/fork.c
--- v2.5.2-pre11/kernel/fork.c	Sun Jan 13 02:32:35 2002
+++ v2.5.2-pre11-file.h/kernel/fork.c	Sun Jan 13 18:09:35 2002
@@ -21,6 +21,7 @@
 #include <linux/completion.h>
 #include <linux/namespace.h>
 #include <linux/personality.h>
+#include <linux/file.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
diff -urN v2.5.2-pre11/kernel/kmod.c v2.5.2-pre11-file.h/kernel/kmod.c
--- v2.5.2-pre11/kernel/kmod.c	Sun Jan 13 02:32:35 2002
+++ v2.5.2-pre11-file.h/kernel/kmod.c	Sun Jan 13 18:12:59 2002
@@ -27,6 +27,7 @@
 #include <linux/slab.h>
 #include <linux/namespace.h>
 #include <linux/completion.h>
+#include <linux/file.h>
 
 #include <asm/uaccess.h>
 
