Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263471AbUCTQiZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 11:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263472AbUCTQiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 11:38:24 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:61194 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263471AbUCTQiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 11:38:00 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1-aa1
Date: Sat, 20 Mar 2004 17:36:45 +0100
User-Agent: KMail/1.6.1
Cc: Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@redhat.com>
References: <20040318164253.GO2246@dualathlon.random> <Pine.LNX.4.44.0403181144290.16728-100000@chimarrao.boston.redhat.com> <20040320163132.GV9009@dualathlon.random>
In-Reply-To: <20040320163132.GV9009@dualathlon.random>
X-Operating-System: Linux 2.6.4-wolk2.1 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_dMHXAbrJYUp+3je"
Message-Id: <200403201736.45804@WOLK>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_dMHXAbrJYUp+3je
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday 20 March 2004 17:31, Andrea Arcangeli wrote:

Hi Andrea,

> > It's in the RHEL3 kernel, a patch named linux-2.4.21-mlock.patch.
> could somebody submit it to me too? ;) otherwise I'll have to search for
> some big rpm.

there you go.

ciao, Marc

--Boundary-00=_dMHXAbrJYUp+3je
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="linux-2.4.21-mlock.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="linux-2.4.21-mlock.patch"

diff -urNp linux-1040/include/asm-alpha/resource.h linux-1050/include/asm-alpha/resource.h
--- linux-1040/include/asm-alpha/resource.h	2000-09-27 16:39:23.000000000 -0400
+++ linux-1050/include/asm-alpha/resource.h	
@@ -39,7 +39,7 @@
     {INR_OPEN, INR_OPEN},			/* RLIMIT_NOFILE */	\
     {LONG_MAX, LONG_MAX},			/* RLIMIT_AS */		\
     {LONG_MAX, LONG_MAX},			/* RLIMIT_NPROC */	\
-    {LONG_MAX, LONG_MAX},			/* RLIMIT_MEMLOCK */	\
+    {PAGE_SIZE,PAGE_SIZE},			/* RLIMIT_MEMLOCK */	\
     {LONG_MAX, LONG_MAX},                       /* RLIMIT_LOCKS */      \
 }
 
diff -urNp linux-1040/include/asm-arm/resource.h linux-1050/include/asm-arm/resource.h
--- linux-1040/include/asm-arm/resource.h	2000-09-22 17:21:19.000000000 -0400
+++ linux-1050/include/asm-arm/resource.h	
@@ -37,7 +37,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ 0,             0             },	\
 	{ INR_OPEN,      INR_OPEN      },	\
-	{ RLIM_INFINITY, RLIM_INFINITY },	\
+	{ PAGE_SIZE,     PAGE_SIZE     },	\
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 }
diff -urNp linux-1040/include/asm-cris/resource.h linux-1050/include/asm-cris/resource.h
--- linux-1040/include/asm-cris/resource.h	2001-02-08 19:32:44.000000000 -0500
+++ linux-1050/include/asm-cris/resource.h	
@@ -37,7 +37,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },               \
+	{     PAGE_SIZE,     PAGE_SIZE },		\
         { RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 }
diff -urNp linux-1040/include/asm-i386/resource.h linux-1050/include/asm-i386/resource.h
--- linux-1040/include/asm-i386/resource.h	2000-09-22 17:21:19.000000000 -0400
+++ linux-1050/include/asm-i386/resource.h	
@@ -37,7 +37,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{     PAGE_SIZE,     PAGE_SIZE },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
         { RLIM_INFINITY, RLIM_INFINITY },		\
 }
diff -urNp linux-1040/include/asm-ia64/resource.h linux-1050/include/asm-ia64/resource.h
--- linux-1040/include/asm-ia64/resource.h	2000-09-22 17:21:19.000000000 -0400
+++ linux-1050/include/asm-ia64/resource.h	
@@ -40,7 +40,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{     PAGE_SIZE,     PAGE_SIZE },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 }
diff -urNp linux-1040/include/asm-m68k/resource.h linux-1050/include/asm-m68k/resource.h
--- linux-1040/include/asm-m68k/resource.h	
+++ linux-1050/include/asm-m68k/resource.h	
@@ -37,7 +37,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{     PAGE_SIZE,     PAGE_SIZE },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
         { RLIM_INFINITY, RLIM_INFINITY },		\
 }
diff -urNp linux-1040/include/asm-mips/resource.h linux-1050/include/asm-mips/resource.h
--- linux-1040/include/asm-mips/resource.h	2001-07-02 16:56:40.000000000 -0400
+++ linux-1050/include/asm-mips/resource.h	
@@ -44,7 +44,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ 0,             0             },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{     PAGE_SIZE,     PAGE_SIZE },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 }
 
diff -urNp linux-1040/include/asm-mips64/resource.h linux-1050/include/asm-mips64/resource.h
--- linux-1040/include/asm-mips64/resource.h	2001-09-09 13:43:02.000000000 -0400
+++ linux-1050/include/asm-mips64/resource.h	
@@ -45,7 +45,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ 0,             0             },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ PAGE_SIZE,     PAGE_SIZE     },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 }
 
diff -urNp linux-1040/include/asm-parisc/resource.h linux-1050/include/asm-parisc/resource.h
--- linux-1040/include/asm-parisc/resource.h	2000-12-05 15:29:39.000000000 -0500
+++ linux-1050/include/asm-parisc/resource.h	
@@ -37,7 +37,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{     PAGE_SIZE,     PAGE_SIZE },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 }
diff -urNp linux-1040/include/asm-ppc/resource.h linux-1050/include/asm-ppc/resource.h
--- linux-1040/include/asm-ppc/resource.h	
+++ linux-1050/include/asm-ppc/resource.h	
@@ -34,7 +34,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{     PAGE_SIZE,     PAGE_SIZE },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 }
diff -urNp linux-1040/include/asm-ppc64/mman.h linux-1050/include/asm-ppc64/mman.h
--- linux-1040/include/asm-ppc64/mman.h	
+++ linux-1050/include/asm-ppc64/mman.h	
@@ -20,6 +20,7 @@
 #define MAP_ANONYMOUS	0x20		/* don't use a file */
 #define MAP_RENAME      MAP_ANONYMOUS   /* In SunOS terminology */
 #define MAP_NORESERVE   0x40            /* don't reserve swap pages */
+#define MAP_LOCKED	0x80
 
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
diff -urNp linux-1040/include/asm-ppc64/resource.h linux-1050/include/asm-ppc64/resource.h
--- linux-1040/include/asm-ppc64/resource.h	
+++ linux-1050/include/asm-ppc64/resource.h	
@@ -43,7 +43,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{     PAGE_SIZE,     PAGE_SIZE },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 }
diff -urNp linux-1040/include/asm-s390/resource.h linux-1050/include/asm-s390/resource.h
--- linux-1040/include/asm-s390/resource.h	2001-02-13 17:13:44.000000000 -0500
+++ linux-1050/include/asm-s390/resource.h	
@@ -45,7 +45,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{ INR_OPEN, INR_OPEN },                         \
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{     PAGE_SIZE,     PAGE_SIZE },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 }
diff -urNp linux-1040/include/asm-s390x/resource.h linux-1050/include/asm-s390x/resource.h
--- linux-1040/include/asm-s390x/resource.h	2001-02-13 17:13:44.000000000 -0500
+++ linux-1050/include/asm-s390x/resource.h	
@@ -45,7 +45,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{        0,        0 },                  	\
 	{ INR_OPEN, INR_OPEN },                         \
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{     PAGE_SIZE,     PAGE_SIZE },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 }
diff -urNp linux-1040/include/asm-sh/resource.h linux-1050/include/asm-sh/resource.h
--- linux-1040/include/asm-sh/resource.h	2000-09-22 17:21:21.000000000 -0400
+++ linux-1050/include/asm-sh/resource.h	
@@ -37,7 +37,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{     PAGE_SIZE,     PAGE_SIZE },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 }
diff -urNp linux-1040/include/asm-sparc/resource.h linux-1050/include/asm-sparc/resource.h
--- linux-1040/include/asm-sparc/resource.h	2000-10-10 13:33:52.000000000 -0400
+++ linux-1050/include/asm-sparc/resource.h	
@@ -42,7 +42,7 @@
     {       0, RLIM_INFINITY},		\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {INR_OPEN, INR_OPEN}, {0, 0},	\
-    {RLIM_INFINITY, RLIM_INFINITY},	\
+    {PAGE_SIZE,     PAGE_SIZE },	\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {RLIM_INFINITY, RLIM_INFINITY}	\
 }
diff -urNp linux-1040/include/asm-sparc64/resource.h linux-1050/include/asm-sparc64/resource.h
--- linux-1040/include/asm-sparc64/resource.h	2000-10-10 13:33:52.000000000 -0400
+++ linux-1050/include/asm-sparc64/resource.h	
@@ -41,7 +41,7 @@
     {       0, RLIM_INFINITY},		\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {INR_OPEN, INR_OPEN}, {0, 0},	\
-    {RLIM_INFINITY, RLIM_INFINITY},	\
+    {PAGE_SIZE,     PAGE_SIZE },	\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {RLIM_INFINITY, RLIM_INFINITY}	\
 }
diff -urNp linux-1040/include/asm-x86_64/resource.h linux-1050/include/asm-x86_64/resource.h
--- linux-1040/include/asm-x86_64/resource.h	
+++ linux-1050/include/asm-x86_64/resource.h	
@@ -37,7 +37,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{     PAGE_SIZE,     PAGE_SIZE },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
         { RLIM_INFINITY, RLIM_INFINITY },		\
 }
diff -urNp linux-1040/include/linux/mm.h linux-1050/include/linux/mm.h
--- linux-1040/include/linux/mm.h	
+++ linux-1050/include/linux/mm.h	
@@ -597,7 +597,7 @@ extern void clear_page_tables(struct mm_
 extern int fail_writepage(struct page *);
 struct page * shmem_nopage(struct vm_area_struct * vma, unsigned long address, int unused);
 struct file *shmem_file_setup(char * name, loff_t size);
-extern void shmem_lock(struct file * file, int lock);
+extern int shmem_lock(struct file * file, int lock);
 extern int shmem_zero_setup(struct vm_area_struct *);
 
 extern void zap_page_range(struct mm_struct *mm, unsigned long address, unsigned long size);
@@ -701,6 +701,17 @@ static inline int can_vma_merge(struct v
 		return 0;
 }
 
+/* mlock can just return an instant EPERM if the caller has no
+   permission to do any memory locking. */
+static inline int can_do_mlock(void)
+{
+	if (capable(CAP_IPC_LOCK))
+		return 1;
+	if (current->rlim[RLIMIT_MEMLOCK].rlim_cur != 0)
+		return 1;
+	return 0;
+}
+
 struct zone_t;
 /* filemap.c */
 extern void remove_inode_page(struct page *);
diff -urNp linux-1040/ipc/shm.c linux-1050/ipc/shm.c
--- linux-1040/ipc/shm.c	
+++ linux-1050/ipc/shm.c	
@@ -457,12 +457,9 @@ asmlinkage long sys_shmctl (int shmid, i
 	case SHM_LOCK:
 	case SHM_UNLOCK:
 	{
-/* Allow superuser to lock segment in memory */
-/* Should the pages be faulted in here or leave it to user? */
-/* need to determine interaction with current->swappable */
-		if (!capable(CAP_IPC_LOCK))
+		/* Allow superuser to lock segment in memory */
+		if (!can_do_mlock())
 			return -EPERM;
-
 		shp = shm_lock(shmid);
 		if(shp==NULL)
 			return -EINVAL;
@@ -470,8 +467,9 @@ asmlinkage long sys_shmctl (int shmid, i
 		if(err)
 			goto out_unlock;
 		if(cmd==SHM_LOCK) {
-			shmem_lock(shp->shm_file, 1);
-			shp->shm_flags |= SHM_LOCKED;
+			err = shmem_lock(shp->shm_file, 1);
+			if (!err)
+				shp->shm_flags |= SHM_LOCKED;
 		} else {
 			shmem_lock(shp->shm_file, 0);
 			shp->shm_flags &= ~SHM_LOCKED;
diff -urNp linux-1040/mm/mlock.c linux-1050/mm/mlock.c
--- linux-1040/mm/mlock.c	
+++ linux-1050/mm/mlock.c	
@@ -151,7 +151,7 @@ static int do_mlock(unsigned long start,
 	struct vm_area_struct * vma, * next;
 	int error;
 
-	if (on && !capable(CAP_IPC_LOCK))
+	if (on && !can_do_mlock())
 		return -EPERM;
 	len = PAGE_ALIGN(len);
 	end = start + len;
@@ -210,12 +210,12 @@ asmlinkage long sys_mlock(unsigned long 
 	lock_limit >>= PAGE_SHIFT;
 
 	/* check against resource limits */
-	if (locked > lock_limit)
+	if (locked > lock_limit && !capable(CAP_IPC_LOCK))
 		goto out;
 
-	/* we may lock at most half of physical memory... */
+	/* we may lock at most 90% of physical memory... */
 	/* (this check is pretty bogus, but doesn't hurt) */
-	if (locked > num_physpages/2)
+	if (locked > num_physpages/10*9)
 		goto out;
 
 	error = do_mlock(start, len, 1);
@@ -245,7 +245,7 @@ static int do_mlockall(int flags)
 	unsigned int def_flags;
 	struct vm_area_struct * vma;
 
-	if (!capable(CAP_IPC_LOCK))
+	if (!can_do_mlock())
 		return -EPERM;
 
 	def_flags = 0;
@@ -282,12 +282,12 @@ asmlinkage long sys_mlockall(int flags)
 	lock_limit >>= PAGE_SHIFT;
 
 	ret = -ENOMEM;
-	if (current->mm->total_vm > lock_limit)
+	if (current->mm->total_vm > lock_limit && !capable(CAP_IPC_LOCK))
 		goto out;
 
-	/* we may lock at most half of physical memory... */
+	/* we may lock at most 90% of physical memory... */
 	/* (this check is pretty bogus, but doesn't hurt) */
-	if (current->mm->total_vm > num_physpages/2)
+	if (current->mm->total_vm > num_physpages/10*9)
 		goto out;
 
 	ret = do_mlockall(flags);
diff -urNp linux-1040/mm/mmap.c linux-1050/mm/mmap.c
--- linux-1040/mm/mmap.c	
+++ linux-1050/mm/mmap.c	
@@ -518,11 +518,16 @@ unsigned long do_mmap_pgoff(struct file 
 	 */
 	vm_flags = calc_vm_flags(prot,flags) | mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
 
+	if (flags & MAP_LOCKED)
+		vm_flags |= VM_LOCKED;
+
 	/* mlock MCL_FUTURE? */
 	if (vm_flags & VM_LOCKED) {
-		unsigned long locked = mm->locked_vm << PAGE_SHIFT;
+		unsigned long locked, lock_limit;
+		locked = mm->locked_vm << PAGE_SHIFT;
+		lock_limit = current->rlim[RLIMIT_MEMLOCK].rlim_cur;
 		locked += len;
-		if (locked > current->rlim[RLIMIT_MEMLOCK].rlim_cur)
+		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
 			return -EAGAIN;
 	}
 
@@ -1261,9 +1266,11 @@ unsigned long do_brk(unsigned long addr,
 	 * mlock MCL_FUTURE?
 	 */
 	if (mm->def_flags & VM_LOCKED) {
-		unsigned long locked = mm->locked_vm << PAGE_SHIFT;
+		unsigned long locked, lock_limit;
+		locked = mm->locked_vm << PAGE_SHIFT;
+		lock_limit = current->rlim[RLIMIT_MEMLOCK].rlim_cur;
 		locked += len;
-		if (locked > current->rlim[RLIMIT_MEMLOCK].rlim_cur)
+		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
 			return -EAGAIN;
 	}
 
diff -urNp linux-1040/mm/mremap.c linux-1050/mm/mremap.c
--- linux-1040/mm/mremap.c	
+++ linux-1050/mm/mremap.c	
@@ -345,10 +345,12 @@ unsigned long do_mremap(unsigned long ad
 			goto out;
 	}
 	if (vma->vm_flags & VM_LOCKED) {
-		unsigned long locked = current->mm->locked_vm << PAGE_SHIFT;
+		unsigned long locked, lock_limit;
+		locked = current->mm->locked_vm << PAGE_SHIFT;
+		lock_limit = current->rlim[RLIMIT_MEMLOCK].rlim_cur;
 		locked += new_len - old_len;
 		ret = -EAGAIN;
-		if (locked > current->rlim[RLIMIT_MEMLOCK].rlim_cur)
+		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
 			goto out;
 	}
 	ret = -ENOMEM;
diff -urNp linux-1040/mm/shmem.c linux-1050/mm/shmem.c
--- linux-1040/mm/shmem.c	
+++ linux-1050/mm/shmem.c	
@@ -709,14 +709,35 @@ struct page * shmem_nopage(struct vm_are
 	return(page);
 }
 
-void shmem_lock(struct file * file, int lock)
+int shmem_lock(struct file * file, int lock)
 {
 	struct inode * inode = file->f_dentry->d_inode;
 	struct shmem_inode_info * info = SHMEM_I(inode);
+	struct mm_struct *mm = current->mm;
+	unsigned long lock_limit, locked;
+	int retval = -ENOMEM;
 
 	spin_lock(&info->lock);
+	if (lock && !info->locked) {
+		locked = inode->i_size >> PAGE_SHIFT;
+		locked += mm->locked_vm;
+		lock_limit = current->rlim[RLIMIT_MEMLOCK].rlim_cur;
+		lock_limit >>= PAGE_SHIFT;
+		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
+			goto out_nomem;
+		if (locked > num_physpages/10*9)
+			goto out_nomem;
+		mm->locked_vm = locked;
+	}
+	if (!lock && info->locked && mm) {
+		locked = inode->i_size >> PAGE_SHIFT;
+		mm->locked_vm -= locked;
+	}
 	info->locked = lock;
+	retval = 0;
+out_nomem:
 	spin_unlock(&info->lock);
+	return retval;
 }
 
 static int shmem_mmap(struct file * file, struct vm_area_struct * vma)

--Boundary-00=_dMHXAbrJYUp+3je--
