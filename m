Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbUCLKDi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 05:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbUCLKDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 05:03:35 -0500
Received: from shark.pro-futura.com ([161.58.178.219]:64190 "EHLO
	shark.pro-futura.com") by vger.kernel.org with ESMTP
	id S261612AbUCLKCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 05:02:47 -0500
From: "Tvrtko A. =?iso-8859-2?q?Ur=B9ulin?=" <tvrtko@croadria.com>
Organization: Croadria Internet usluge
To: linux-kernel@vger.kernel.org
Subject: Re: PATCH: modular out of memory additional modules patch for 2.4.25
Date: Fri, 12 Mar 2004 11:06:45 +0100
User-Agent: KMail/1.6.1
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
References: <200403121056.53071.tvrtko@croadria.com>
In-Reply-To: <200403121056.53071.tvrtko@croadria.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_1uYUAMKYKLwM+ej"
Message-Id: <200403121106.45567.tvrtko@croadria.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_1uYUAMKYKLwM+ej
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


These are two additional modules for OOM, oom-panic and oom-parent-kill. 
Details can be found in Configure.help.

--Boundary-00=_1uYUAMKYKLwM+ej
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="moom-2.4.25-modules.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="moom-2.4.25-modules.patch"

diff -Naur linux-2.4.25/arch/alpha/defconfig linux-2.4.25-moom/arch/alpha/defconfig
--- linux-2.4.25/arch/alpha/defconfig	2004-03-12 10:50:38.682091408 +0100
+++ linux-2.4.25-moom/arch/alpha/defconfig	2004-03-12 10:41:38.000000000 +0100
@@ -75,6 +75,8 @@
 # CONFIG_BINFMT_MISC is not set
 # CONFIG_BINFMT_EM86 is not set
 # CONFIG_OOM_KILL is not set
+# CONFIG_OOM_KPPID is not set
+# CONFIG_OOM_PANIC is not set
 
 
 #
diff -Naur linux-2.4.25/arch/arm/defconfig linux-2.4.25-moom/arch/arm/defconfig
--- linux-2.4.25/arch/arm/defconfig	2004-03-12 10:50:38.701088520 +0100
+++ linux-2.4.25-moom/arch/arm/defconfig	2004-03-12 10:41:38.000000000 +0100
@@ -94,6 +94,8 @@
 CONFIG_LEDS_CPU=y
 CONFIG_ALIGNMENT_TRAP=y
 # CONFIG_OOM_KILL is not set
+# CONFIG_OOM_KPPID is not set
+# CONFIG_OOM_PANIC is not set
 
 #
 # Parallel port support
diff -Naur linux-2.4.25/arch/cris/defconfig linux-2.4.25-moom/arch/cris/defconfig
--- linux-2.4.25/arch/cris/defconfig	2004-03-12 10:50:38.718085936 +0100
+++ linux-2.4.25-moom/arch/cris/defconfig	2004-03-12 10:41:38.000000000 +0100
@@ -21,6 +21,8 @@
 # CONFIG_ETRAX_KGDB is not set
 # CONFIG_ETRAX_WATCHDOG is not set
 # CONFIG_OOM_KILL is not set
+# CONFIG_OOM_KPPID is not set
+# CONFIG_OOM_PANIC is not set
 
 #
 # Hardware setup
diff -Naur linux-2.4.25/arch/i386/defconfig linux-2.4.25-moom/arch/i386/defconfig
--- linux-2.4.25/arch/i386/defconfig	2004-03-12 10:50:38.736083200 +0100
+++ linux-2.4.25-moom/arch/i386/defconfig	2004-03-12 10:41:39.000000000 +0100
@@ -84,6 +84,8 @@
 # CONFIG_MCA is not set
 CONFIG_HOTPLUG=y
 # CONFIG_OOM_KILL is not set
+# CONFIG_OOM_KPPID is not set
+# CONFIG_OOM_PANIC is not set
 
 #
 # PCMCIA/CardBus support
diff -Naur linux-2.4.25/arch/ia64/defconfig linux-2.4.25-moom/arch/ia64/defconfig
--- linux-2.4.25/arch/ia64/defconfig	2004-03-12 10:50:38.758079856 +0100
+++ linux-2.4.25-moom/arch/ia64/defconfig	2004-03-12 10:41:39.000000000 +0100
@@ -66,6 +66,8 @@
 CONFIG_ACPI_INTERPRETER=y
 CONFIG_ACPI_KERNEL_CONFIG=y
 # CONFIG_OOM_KILL is not set
+# CONFIG_OOM_KPPID is not set
+# CONFIG_OOM_PANIC is not set
 
 #
 # ACPI Support
diff -Naur linux-2.4.25/arch/m68k/defconfig linux-2.4.25-moom/arch/m68k/defconfig
--- linux-2.4.25/arch/m68k/defconfig	2004-03-12 10:50:38.764078944 +0100
+++ linux-2.4.25-moom/arch/m68k/defconfig	2004-03-12 10:41:39.000000000 +0100
@@ -54,6 +54,8 @@
 # CONFIG_PARPORT is not set
 # CONFIG_PRINTER is not set
 # CONFIG_OOM_KILL is not set
+# CONFIG_OOM_KPPID is not set
+# CONFIG_OOM_PANIC is not set
 
 #
 # Loadable module support
diff -Naur linux-2.4.25/arch/mips/defconfig linux-2.4.25-moom/arch/mips/defconfig
--- linux-2.4.25/arch/mips/defconfig	2004-03-12 10:50:38.778076816 +0100
+++ linux-2.4.25-moom/arch/mips/defconfig	2004-03-12 10:41:39.000000000 +0100
@@ -145,6 +145,8 @@
 # CONFIG_BINFMT_ELF32 is not set
 # CONFIG_BINFMT_MISC is not set
 # CONFIG_OOM_KILL is not set
+# CONFIG_OOM_KPPID is not set
+# CONFIG_OOM_PANIC is not set
 
 #
 # Memory Technology Devices (MTD)
diff -Naur linux-2.4.25/arch/mips64/defconfig linux-2.4.25-moom/arch/mips64/defconfig
--- linux-2.4.25/arch/mips64/defconfig	2004-03-12 10:50:38.787075448 +0100
+++ linux-2.4.25-moom/arch/mips64/defconfig	2004-03-12 10:41:39.000000000 +0100
@@ -143,6 +143,8 @@
 CONFIG_BINFMT_ELF32=y
 # CONFIG_BINFMT_MISC is not set
 # CONFIG_OOM_KILL is not set
+# CONFIG_OOM_KPPID is not set
+# CONFIG_OOM_PANIC is not set
 
 #
 # Memory Technology Devices (MTD)
diff -Naur linux-2.4.25/arch/parisc/defconfig linux-2.4.25-moom/arch/parisc/defconfig
--- linux-2.4.25/arch/parisc/defconfig	2004-03-12 10:50:38.801073320 +0100
+++ linux-2.4.25-moom/arch/parisc/defconfig	2004-03-12 10:41:39.000000000 +0100
@@ -46,6 +46,8 @@
 CONFIG_SUPERIO=y
 CONFIG_PCI_NAMES=y
 # CONFIG_OOM_KILL is not set
+# CONFIG_OOM_KPPID is not set
+# CONFIG_OOM_PANIC is not set
 
 #
 # General setup
diff -Naur linux-2.4.25/arch/ppc/defconfig linux-2.4.25-moom/arch/ppc/defconfig
--- linux-2.4.25/arch/ppc/defconfig	2004-03-12 10:50:38.814071344 +0100
+++ linux-2.4.25-moom/arch/ppc/defconfig	2004-03-12 10:41:39.000000000 +0100
@@ -63,6 +63,8 @@
 CONFIG_PCI_NAMES=y
 CONFIG_HOTPLUG=y
 # CONFIG_OOM_KILL is not set
+# CONFIG_OOM_KPPID is not set
+# CONFIG_OOM_PANIC is not set
 
 #
 # PCMCIA/CardBus support
diff -Naur linux-2.4.25/arch/ppc64/defconfig linux-2.4.25-moom/arch/ppc64/defconfig
--- linux-2.4.25/arch/ppc64/defconfig	2004-03-12 10:50:38.830068912 +0100
+++ linux-2.4.25-moom/arch/ppc64/defconfig	2004-03-12 10:41:39.000000000 +0100
@@ -61,6 +61,8 @@
 CONFIG_PCI_NAMES=y
 # CONFIG_HOTPLUG is not set
 # CONFIG_OOM_KILL is not set
+# CONFIG_OOM_KPPID is not set
+# CONFIG_OOM_PANIC is not set
 
 #
 # Parallel port support
diff -Naur linux-2.4.25/arch/s390/defconfig linux-2.4.25-moom/arch/s390/defconfig
--- linux-2.4.25/arch/s390/defconfig	2004-03-12 10:50:38.834068304 +0100
+++ linux-2.4.25-moom/arch/s390/defconfig	2004-03-12 10:41:39.000000000 +0100
@@ -51,6 +51,8 @@
 CONFIG_PFAULT=y
 # CONFIG_SHARED_KERNEL is not set
 # CONFIG_OOM_KILL is not set
+# CONFIG_OOM_KPPID is not set
+# CONFIG_OOM_PANIC is not set
 
 #
 # Block device drivers
diff -Naur linux-2.4.25/arch/s390x/defconfig linux-2.4.25-moom/arch/s390x/defconfig
--- linux-2.4.25/arch/s390x/defconfig	2004-03-12 10:50:38.843066936 +0100
+++ linux-2.4.25-moom/arch/s390x/defconfig	2004-03-12 10:41:39.000000000 +0100
@@ -52,6 +52,8 @@
 CONFIG_PFAULT=y
 # CONFIG_SHARED_KERNEL is not set
 # CONFIG_OOM_KILL is not set
+# CONFIG_OOM_KPPID is not set
+# CONFIG_OOM_PANIC is not set
 
 #
 # Block device drivers
diff -Naur linux-2.4.25/arch/sh/defconfig linux-2.4.25-moom/arch/sh/defconfig
--- linux-2.4.25/arch/sh/defconfig	2004-03-12 10:50:38.860064352 +0100
+++ linux-2.4.25-moom/arch/sh/defconfig	2004-03-12 10:41:39.000000000 +0100
@@ -50,6 +50,8 @@
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
 # CONFIG_OOM_KILL is not set
+# CONFIG_OOM_KPPID is not set
+# CONFIG_OOM_PANIC is not set
 
 #
 # Parallel port support
diff -Naur linux-2.4.25/arch/sh64/defconfig linux-2.4.25-moom/arch/sh64/defconfig
--- linux-2.4.25/arch/sh64/defconfig	2004-03-12 10:50:38.870062832 +0100
+++ linux-2.4.25-moom/arch/sh64/defconfig	2004-03-12 10:41:39.000000000 +0100
@@ -85,6 +85,8 @@
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
 # CONFIG_OOM_KILL is not set
+# CONFIG_OOM_KPPID is not set
+# CONFIG_OOM_PANIC is not set
 
 #
 # Block devices
diff -Naur linux-2.4.25/arch/sparc/defconfig linux-2.4.25-moom/arch/sparc/defconfig
--- linux-2.4.25/arch/sparc/defconfig	2004-03-12 10:50:38.880061312 +0100
+++ linux-2.4.25-moom/arch/sparc/defconfig	2004-03-12 10:41:39.000000000 +0100
@@ -54,6 +54,8 @@
 CONFIG_BINFMT_MISC=m
 CONFIG_SUNOS_EMUL=y
 # CONFIG_OOM_KILL is not set
+# CONFIG_OOM_KPPID is not set
+# CONFIG_OOM_PANIC is not set
 
 #
 # Parallel port support
diff -Naur linux-2.4.25/arch/sparc64/defconfig linux-2.4.25-moom/arch/sparc64/defconfig
--- linux-2.4.25/arch/sparc64/defconfig	2004-03-12 10:50:38.893059336 +0100
+++ linux-2.4.25-moom/arch/sparc64/defconfig	2004-03-12 10:41:39.000000000 +0100
@@ -60,6 +60,8 @@
 # CONFIG_SUNOS_EMUL is not set
 CONFIG_SOLARIS_EMUL=m
 # CONFIG_OOM_KILL is not set
+# CONFIG_OOM_KPPID is not set
+# CONFIG_OOM_PANIC is not set
 
 #
 # Parallel port support
diff -Naur linux-2.4.25/arch/x86_64/defconfig linux-2.4.25-moom/arch/x86_64/defconfig
--- linux-2.4.25/arch/x86_64/defconfig	2004-03-12 10:50:38.908057056 +0100
+++ linux-2.4.25-moom/arch/x86_64/defconfig	2004-03-12 10:41:39.000000000 +0100
@@ -69,6 +69,8 @@
 CONFIG_PM=y
 CONFIG_IA32_EMULATION=y
 # CONFIG_OOM_KILL is not set
+# CONFIG_OOM_KPPID is not set
+# CONFIG_OOM_PANIC is not set
 
 #
 # ACPI Support
diff -Naur linux-2.4.25/Documentation/Configure.help linux-2.4.25-moom/Documentation/Configure.help
--- linux-2.4.25/Documentation/Configure.help	2004-03-12 10:50:38.942051888 +0100
+++ linux-2.4.25-moom/Documentation/Configure.help	2004-03-12 10:41:38.000000000 +0100
@@ -441,6 +441,29 @@
   
   If unsure, say N.
 
+Panic on out of memory conditions
+CONFIG_OOM_PANIC
+  This option enables panic() to be called when a system is out of
+  memory.  This feature along with /proc/sys/kernel/panic allows a
+  different behavior on out-of-memory conditions when the standard
+  behavior (killing processes in an attempt to recover) does not
+  make sense.
+  
+  If unsure, say N.
+
+Kill parents that keep producing bad children  
+CONFIG_OOM_KPPID
+  This option enables an out-of-memory handler that not only attempts
+  to kill bad processes to free up memory, but also kills parents
+  that repeatedly produce bad children.
+
+  Two tunables, oom_parent_max and oom_parent_expire, will be added
+  and  to /proc/sys/vm/ to control how many children a parent is
+  allowed to have terminated, and how long between terminated children
+  before a parent is forgiven.
+  
+  If unsure, say N.
+
 iSeries Virtual I/O Disk Support
 CONFIG_VIODASD
   If you are running on an iSeries system and you want to use
diff -Naur linux-2.4.25/mm/Config.in linux-2.4.25-moom/mm/Config.in
--- linux-2.4.25/mm/Config.in	2004-03-12 10:50:38.948050976 +0100
+++ linux-2.4.25-moom/mm/Config.in	2004-03-12 10:41:38.000000000 +0100
@@ -2,5 +2,33 @@
 comment 'Out of memory killer'
 
 tristate 'Classic' CONFIG_OOM_KILL
+if [ "$CONFIG_OOM_KILL" = "y" ]; then
+	if [ "$CONFIG_OOM_PANIC" = "y" ]; then
+		define_tristate CONFIG_OOM_PANIC m
+	fi
+	if [ "$CONFIG_OOM_KPPID" = "y" ]; then
+		define_tristate CONFIG_OOM_KPPID m
+	fi
+fi
+
+tristate 'Kill parents' CONFIG_OOM_KPPID
+if [ "$CONFIG_OOM_KPPID" = "y" ]; then
+	if [ "$CONFIG_OOM_PANIC" = "y" ]; then
+		define_tristate CONFIG_OOM_PANIC m
+	fi
+	if [ "$CONFIG_OOM_KILL" = "y" ]; then
+		define_tristate CONFIG_OOM_KILL m
+	fi
+fi
+
+tristate 'Panic' CONFIG_OOM_PANIC
+if [ "$CONFIG_OOM_PANIC" = "y" ]; then
+	if [ "$CONFIG_OOM_KILL" = "y" ]; then
+		define_tristate CONFIG_OOM_KILL m
+	fi
+	if [ "$CONFIG_OOM_KPPID" = "y" ]; then
+		define_tristate CONFIG_OOM_KPPID m
+	fi
+fi
 
 endmenu
diff -Naur linux-2.4.25/mm/Makefile linux-2.4.25-moom/mm/Makefile
--- linux-2.4.25/mm/Makefile	2004-03-12 10:50:38.000000000 +0100
+++ linux-2.4.25-moom/mm/Makefile	2004-03-12 10:41:38.000000000 +0100
@@ -19,5 +19,7 @@
 obj-$(CONFIG_HIGHMEM) += highmem.o
 
 obj-$(CONFIG_OOM_KILL)  += oom_kill.o
+obj-$(CONFIG_OOM_KPPID) += oom_kill_parent.o
+obj-$(CONFIG_OOM_PANIC) += oom_panic.o
 
 include $(TOPDIR)/Rules.make
diff -Naur linux-2.4.25/mm/oom_kill.c linux-2.4.25-moom/mm/oom_kill.c
--- linux-2.4.25/mm/oom_kill.c	2004-03-12 10:50:38.000000000 +0100
+++ linux-2.4.25-moom/mm/oom_kill.c	2004-03-12 10:41:38.000000000 +0100
@@ -15,7 +15,7 @@
  *  kernel subsystems and hints as to where to find out what things do.
  *
  * Modularized by using notifies by --rustyl <rusty@linux.intel.com>
- * Final modularization (C) 2003,2004  Tvrtko A. Ursulin (tvrtko.ursulin@zg.htnet.hr)
+ * Final modularization (C) 2003  Tvrtko A. Ursulin (tvrtko.ursulin@zg.htnet.hr)
  */
 
 #include <linux/kernel.h>
diff -Naur linux-2.4.25/mm/oom_kill_parent.c linux-2.4.25-moom/mm/oom_kill_parent.c
--- linux-2.4.25/mm/oom_kill_parent.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.4.25-moom/mm/oom_kill_parent.c	2004-03-12 10:41:38.000000000 +0100
@@ -0,0 +1,458 @@
+/*
+ *  linux/mm/oom_kill_parent.c
+ * 
+ *  Copyright (C)  1998,2000  Rik van Riel
+ *	Thanks go out to Claus Fischer for some serious inspiration and
+ *	for goading me into coding this file...
+ *
+ *  The routines in this file are used to kill a process when
+ *  we're seriously out of memory. This gets called from kswapd()
+ *  in linux/mm/vmscan.c when we really run out of memory.
+ *
+ *  Since we won't call these routines often (on a well-configured
+ *  machine) this file will double as a 'coding guide' and a signpost
+ *  for newbie kernel hackers. It features several pointers to major
+ *  kernel subsystems and hints as to where to find out what things do.
+ *
+ *  Copyright (C)  2003 Tvrtko A. Ursulin (tvrtko.ursulin@zg.htnet.hr)
+ *  Extended  to keep per parent process statistics and to kill parent processes
+ *  which keep producing bad children.
+ *  Modularized by using notifies by --rustyl <rusty@linux.intel.com>
+ *  Final modularization (C) 2003  Tvrtko A. Ursulin (tvrtko.ursulin@zg.htnet.hr)
+ *
+*/
+
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/sched.h>
+#include <linux/swap.h>
+#include <linux/swapctl.h>
+#include <linux/timex.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/sysctl.h>
+#include <linux/notifier.h>
+#include <linux/oom_notifier.h>
+
+#define OOM_HISTORY_SIZE	32
+
+#define OOM_DEFAULT_VALUE	(10)
+#define OOM_DEFAULT_EXPIRE	(5*60)
+
+static unsigned int oom_parent_max = OOM_DEFAULT_VALUE;
+static unsigned int oom_parent_expire = OOM_DEFAULT_EXPIRE;
+
+static struct ctl_table_header *oom_root_table_header;
+
+static ctl_table oom_table[] = {
+	{1, "oom_parent_max",
+	 &oom_parent_max, sizeof(int), 0644, NULL, &proc_dointvec},
+	{2, "oom_parent_expire",
+	 &oom_parent_expire, sizeof(int), 0644, NULL, &proc_dointvec},
+	{ 0 }
+};
+
+static ctl_table oom_dir_table[] = {
+	{VM_OOM, "oom", NULL, 0, 0555, oom_table},
+	{0}
+};
+
+static ctl_table oom_root_table[] = {
+	{CTL_VM, "vm", NULL, 0, 0555, oom_dir_table},
+	{0}
+};
+
+struct parent_record
+{
+	pid_t				pid;
+	struct task_struct	*task;
+	unsigned long		last_kill;
+	unsigned long		value;
+};
+
+static struct parent_record	blacklist[OOM_HISTORY_SIZE];
+
+/* #define DEBUG */
+
+#ifndef DEBUG
+#define dbg(format, arg...)
+#endif
+
+void oom_kill_task(struct task_struct *p);
+
+static void	process_blacklist(void)
+{
+	struct parent_record	*p;
+	struct task_struct	*task;
+
+	unsigned int	i;
+
+	for ( i = 0; i < OOM_HISTORY_SIZE; i++ ) {
+		p = &blacklist[i];
+		if ( p->pid ) {
+			task = find_task_by_pid(p->pid);
+			if ( task != p->task ) {
+				dbg("Parent %d (%p) removed from list - does not exist",p->pid, p->task);
+				p->pid = 0;
+			}
+			else if ( abs(jiffies - p->last_kill) >= (oom_parent_expire*HZ) ) {
+				dbg("Parent %d (%p) removed from list - expired",p->pid, p->task);
+				p->pid = 0;
+			}
+			else if ( p->value >= oom_parent_max ) {
+				error("Will kill parent process %d (%s)",p->pid,p->task->comm);
+				p->pid = 0;
+				oom_kill_task(p->task);
+			}
+		}
+	}
+}
+
+static struct parent_record	*find_in_blacklist(struct task_struct *task)
+{
+	struct parent_record	*p = NULL;
+	unsigned int i;
+
+	if ( !task )
+		return NULL;
+
+	for ( i = 0; i < OOM_HISTORY_SIZE; i++ ) {
+		p = &blacklist[i];
+		if ( p->pid ) {
+			if ( (task->pid == p->pid) && (task == p->task) )
+				return p;
+		}
+	}
+
+	return NULL;
+}
+
+static struct parent_record	*blacklist_parent(struct task_struct *task)
+{
+	struct parent_record	*p;
+	unsigned int i;
+
+	if ( !task )
+		return NULL;
+
+	for ( i = 0; i < OOM_HISTORY_SIZE; i++ ) {
+		p = &blacklist[i];
+		if ( !p->pid )
+			break;
+	}
+
+	if ( p->pid )
+		return NULL;
+
+	p->pid= task->pid;
+	p->task = task;
+	p->last_kill = jiffies;
+	p->value = 0;
+
+	return p;
+}
+
+/**
+ * int_sqrt - oom_kill.c internal function, rough approximation to sqrt
+ * @x: integer of which to calculate the sqrt
+ *
+ * A very rough approximation to the sqrt() function.
+ */
+static unsigned int int_sqrt(unsigned int x)
+{
+	unsigned int out = x;
+	while (x & ~(unsigned int)1) x >>=2, out >>=1;
+	if (x) out -= out >> 2;
+	return (out ? out : 1);
+}
+
+/**
+ * oom_badness - calculate a numeric value for how bad this task has been
+ * @p: task struct of which task we should calculate
+ *
+ * The formula used is relatively simple and documented inline in the
+ * function. The main rationale is that we want to select a good task
+ * to kill when we run out of memory.
+ *
+ * Good in this context means that:
+ * 1) we lose the minimum amount of work done
+ * 2) we recover a large amount of memory
+ * 3) we don't kill anything innocent of eating tons of memory
+ * 4) we want to kill the minimum amount of processes (one)
+ * 5) we try to kill the process the user expects us to kill, this
+ *    algorithm has been meticulously tuned to meet the priniciple
+ *    of least surprise ... (be careful when you change it)
+ */
+
+static int badness(struct task_struct *p)
+{
+	int points, cpu_time, run_time;
+
+	if (!p->mm)
+		return 0;
+
+	if (p->flags & PF_MEMDIE)
+		return 0;
+
+	/*
+	 * The memory size of the process is the basis for the badness.
+	 */
+	points = p->mm->total_vm;
+
+	/*
+	 * CPU time is in seconds and run time is in minutes. There is no
+	 * particular reason for this other than that it turned out to work
+	 * very well in practice. This is not safe against jiffie wraps
+	 * but we don't care _that_ much...
+	 */
+	cpu_time = (p->times.tms_utime + p->times.tms_stime) >> (SHIFT_HZ + 3);
+	run_time = (jiffies - p->start_time) >> (SHIFT_HZ + 10);
+
+	points /= int_sqrt(cpu_time);
+	points /= int_sqrt(int_sqrt(run_time));
+
+	/*
+	 * Niced processes are most likely less important, so double
+	 * their badness points.
+	 */
+	if (p->nice > 0)
+		points *= 2;
+
+	/*
+	 * Superuser processes are usually more important, so we make it
+	 * less likely that we kill those.
+	 */
+	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_ADMIN) ||
+				p->uid == 0 || p->euid == 0)
+		points /= 4;
+
+	/*
+	 * We don't want to kill a process with direct hardware access.
+	 * Not only could that mess up the hardware, but usually users
+	 * tend to only have this flag set on applications they think
+	 * of as important.
+	 */
+	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO))
+		points /= 4;
+	dbg("Task %d (%s) got %d points",p->pid, p->comm, points);
+	return points;
+}
+
+/*
+ * Simple selection loop. We chose the process with the highest
+ * number of 'points'. We expect the caller will lock the tasklist.
+ *
+ * (not docbooked, we don't want this one cluttering up the manual)
+ */
+static struct task_struct * select_bad_process(void)
+{
+	int maxpoints = 0;
+	struct task_struct *p = NULL;
+	struct task_struct *chosen = NULL;
+
+	for_each_task(p) {
+		if (p->pid) {
+			int points = badness(p);
+			if (points > maxpoints) {
+				chosen = p;
+				maxpoints = points;
+			}
+		}
+	}
+	return chosen;
+}
+
+/**
+ * We must be careful though to never send SIGKILL a process with
+ * CAP_SYS_RAW_IO set, send SIGTERM instead (but it's unlikely that
+ * we select a process with CAP_SYS_RAW_IO set).
+ */
+void oom_kill_task(struct task_struct *p)
+{
+	error("Killed process %d (%s).", p->pid, p->comm);
+
+	/*
+	 * We give our sacrificial lamb high priority and access to
+	 * all the memory it needs. That way it should be able to
+	 * exit() and clear out its resources quickly...
+	 */
+	p->counter = 5 * HZ;
+	p->flags |= PF_MEMALLOC | PF_MEMDIE;
+
+	/* This process has hardware access, be more careful. */
+	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO)) {
+		force_sig(SIGTERM, p);
+	} else {
+		force_sig(SIGKILL, p);
+	}
+}
+
+/**
+ * oom_kill - kill the "best" process when we run out of memory
+ *
+ * If we run out of memory, we have the choice between either
+ * killing a random task (bad), letting the system crash (worse)
+ * OR try to be smart about which process to kill. Note that we
+ * don't have to be perfect here, we just have to be good.
+ */
+static void oom_kill(void)
+{
+	struct task_struct *p, *q;
+	struct parent_record *parent;
+
+	read_lock(&tasklist_lock);
+	p = select_bad_process();
+
+	/* Found nothing?!?! Either we hang forever, or we panic. */
+	if (p == NULL)
+		panic("Out of memory and no killable processes...\n");
+
+	/* Add or update statistics for a parent processs */
+	if ( p->p_opptr->pid > 1 ) {
+		parent = find_in_blacklist(p->p_opptr);
+		if ( !parent ) {
+			dbg("Adding parent (%d) to black list because of %d",p->parent->pid, p->pid);
+			parent = blacklist_parent(p->p_opptr);
+		}
+		else {
+			dbg("Parent (%d) black list value increased to %ld",parent->pid, parent->value);
+			parent->value++;
+			parent->last_kill = jiffies;
+		}
+	}
+
+	/* kill all processes that share the ->mm (i.e. all threads) */
+	for_each_task(q) {
+		if (q->mm == p->mm)
+			oom_kill_task(q);
+	}
+	read_unlock(&tasklist_lock);
+
+	/*
+	 * Make kswapd go out of the way, so "p" has a good chance of
+	 * killing itself before someone else gets the chance to ask
+	 * for more memory.
+	 */
+	yield();
+	return;
+}
+
+/**
+ * out_of_memory - is the system out of memory?
+ */
+void out_of_memory_killer(void)
+{
+	static spinlock_t oom_lock = SPIN_LOCK_UNLOCKED;
+	static unsigned long first, last, count, lastkill;
+	unsigned long now, since;
+
+	/*
+	 * Process kill history...
+	 */
+	process_blacklist();
+
+	/*
+	 * Enough swap space left?  Not OOM.
+	 */
+	if ( get_nr_swap_pages() > 0)
+		return;
+
+	spin_lock(&oom_lock);
+	now = jiffies;
+	since = now - last;
+	last = now;
+
+	/*
+	 * If it's been a long time since last failure,
+	 * we're not oom.
+	 */
+	last = now;
+	if (since > 5*HZ)
+		goto reset;
+
+	/*
+	 * If we haven't tried for at least one second,
+	 * we're not really oom.
+	 */
+	since = now - first;
+	if (since < HZ)
+		goto out_unlock;
+
+	/*
+	 * If we have gotten only a few failures,
+	 * we're not really oom.
+	 */
+	if (++count < 10)
+		goto out_unlock;
+
+	/*
+	 * If we just killed a process, wait a while
+	 * to give that task a chance to exit. This
+	 * avoids killing multiple processes needlessly.
+	 */
+	since = now - lastkill;
+	if (since < HZ*5)
+		goto out_unlock;
+
+	/*
+	 * Ok, really out of memory. Kill something.
+	 */
+	lastkill = now;
+	
+	/* oom_kill() can sleep */
+	spin_unlock(&oom_lock);
+	oom_kill();
+	spin_lock(&oom_lock);
+
+reset:
+	first = now;
+	count = 0;
+
+out_unlock:
+	spin_unlock(&oom_lock);
+}
+
+static int oom_notify(struct notifier_block * s, unsigned long v, void * d)
+{
+	out_of_memory_killer();
+	return 0;
+}
+
+static struct notifier_block oom_nb = {
+	.notifier_call = oom_notify,
+};
+
+static int __init init_oom_kill_parent(void)
+{
+	int err;
+
+	info("Installing oom_kill_parent handler");
+
+	err = register_oom_notifier(&oom_nb);
+	if (err)
+		error("Error installing oom_kill_parent handler!");
+
+	oom_root_table_header = register_sysctl_table(oom_root_table, 1);
+	if (!oom_root_table_header)
+		error("Error installing oom sysctl table!");
+
+	return err;
+}
+
+static void __exit exit_oom_kill_parent(void)
+{
+	if (oom_root_table_header)
+		unregister_sysctl_table(oom_root_table_header);
+
+	unregister_oom_notifier(&oom_nb);
+	info("Unregistered oom_kill_parent handler");
+}
+
+MODULE_LICENSE("GPL");
+MODULE_PARM(oom_parent_max, "i");
+MODULE_PARM_DESC(oom_parent_max, "Maximum number of bad childs parent can produce" );
+MODULE_PARM(oom_parent_expire, "i");
+MODULE_PARM_DESC(oom_parent_expire, "Time period in seconds after which parents past sins are forgotten" );
+
+module_init(init_oom_kill_parent);
+module_exit(exit_oom_kill_parent);
diff -Naur linux-2.4.25/mm/oom_panic.c linux-2.4.25-moom/mm/oom_panic.c
--- linux-2.4.25/mm/oom_panic.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.4.25-moom/mm/oom_panic.c	2004-03-12 10:41:38.000000000 +0100
@@ -0,0 +1,50 @@
+/*
+ * linux/mm/oom_panic.c
+ *
+ * This is a very simple component that will cause the kernel to
+ * panic on out-of-memory conditions.  The behavior of panic can be
+ * further controlled with /proc/sys/kernel/panic.
+ *
+ *       --rustyl <rusty@linux.intel.com>
+ *
+ * Final modularization (C) 2003  Tvrtko A. Ursulin (tvrtko.ursulin@zg.htnet.hr)
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/notifier.h>
+#include <linux/oom_notifier.h>
+
+static int oom_notify(struct notifier_block * s, unsigned long v, void * d)
+{
+	panic("Out-Of-Memory");
+	return 0;
+}
+
+static struct notifier_block oom_nb = {
+	.notifier_call = oom_notify,
+};
+
+static int __init init_oom_panic(void)
+{
+	int err;
+
+	info("Installing oom_panic handler");
+	err = register_oom_notifier(&oom_nb);
+	if (err)
+		error("Error installing oom_panic handler!");
+
+	return err;
+}
+
+static void __exit exit_oom_panic(void)
+{
+	unregister_oom_notifier(&oom_nb);
+}
+
+MODULE_LICENSE("GPL");
+
+module_init(init_oom_panic);
+module_exit(exit_oom_panic);

--Boundary-00=_1uYUAMKYKLwM+ej--
