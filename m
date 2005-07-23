Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262061AbVGWWMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbVGWWMK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 18:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbVGWWJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 18:09:41 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:27908 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261318AbVGWWJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 18:09:01 -0400
Date: Sun, 24 Jul 2005 00:08:54 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [2.6 patch] merge some from Rusty's trivial patches
Message-ID: <20050723220854.GP3160@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the most trivial from Rusty's trivial patches:
- spelling fixes
- remove duplicate includes

I don't see a reason why they shouldn't be merged now.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 Documentation/mono.txt               |    2 +-
 Documentation/pci.txt                |    2 +-
 Documentation/sysrq.txt              |    2 +-
 arch/ppc/kernel/cpu_setup_6xx.S      |    1 -
 arch/ppc/kernel/cpu_setup_power4.S   |    1 -
 arch/ppc/kernel/dma-mapping.c        |    2 +-
 arch/ppc64/kernel/cpu_setup_power4.S |    1 -
 drivers/ide/ide-io.c                 |    6 +++---
 drivers/md/md.c                      |    4 ++--
 drivers/parisc/lasi.c                |    1 -
 drivers/scsi/ibmmca.c                |    1 -
 ipc/mqueue.c                         |    2 +-
 12 files changed, 10 insertions(+), 15 deletions(-)

--- linux-2.6.12-rc6-git6/Documentation/mono.txt	2005-02-04 18:45:51.000000000 +1100
+++ .31090.trivial/Documentation/mono.txt	2005-06-14 09:39:28.007622592 +1000
@@ -30,7 +30,7 @@ other program after you have done the fo
    Read the file 'binfmt_misc.txt' in this directory to know
    more about the configuration process.
 
-3) Add the following enries to /etc/rc.local or similar script
+3) Add the following entries to /etc/rc.local or similar script
    to be run at system startup:
 
 # Insert BINFMT_MISC module into the kernel
--- linux-2.6.12-rc6-git6/Documentation/pci.txt	2005-06-10 09:16:18.000000000 +1000
+++ .31090.trivial/Documentation/pci.txt	2005-06-14 09:39:28.076612104 +1000
@@ -84,7 +84,7 @@ Each entry consists of:
 
 Most drivers don't need to use the driver_data field.  Best practice
 for use of driver_data is to use it as an index into a static list of
-equivalant device types, not to use it as a pointer.
+equivalent device types, not to use it as a pointer.
 
 Have a table entry {PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID}
 to have probe() called for every PCI device known to the system.
--- linux-2.6.12-rc6-git6/Documentation/sysrq.txt	2005-06-10 09:16:19.000000000 +1000
+++ .31090.trivial/Documentation/sysrq.txt	2005-06-14 09:39:28.145601616 +1000
@@ -166,7 +166,7 @@ the header 'include/linux/sysrq.h', this
 Next, you must create a sysrq_key_op struct, and populate it with A) the key
 handler function you will use, B) a help_msg string, that will print when SysRQ
 prints help, and C) an action_msg string, that will print right before your
-handler is called. Your handler must conform to the protoype in 'sysrq.h'.
+handler is called. Your handler must conform to the prototype in 'sysrq.h'.
 
 After the sysrq_key_op is created, you can call the macro 
 register_sysrq_key(int key, struct sysrq_key_op *op_p) that is defined in
--- linux-2.6.12-rc6-git6/arch/ppc/kernel/cpu_setup_6xx.S	2005-06-10 09:16:30.000000000 +1000
+++ .31090.trivial/arch/ppc/kernel/cpu_setup_6xx.S	2005-06-14 09:39:28.307576992 +1000
@@ -14,7 +14,6 @@
 #include <asm/page.h>
 #include <asm/ppc_asm.h>
 #include <asm/cputable.h>
-#include <asm/ppc_asm.h>
 #include <asm/offsets.h>
 #include <asm/cache.h>
 
--- linux-2.6.12-rc6-git6/arch/ppc/kernel/cpu_setup_power4.S	2005-02-04 18:48:44.000000000 +1100
+++ .31090.trivial/arch/ppc/kernel/cpu_setup_power4.S	2005-06-14 09:39:28.376566504 +1000
@@ -14,7 +14,6 @@
 #include <asm/page.h>
 #include <asm/ppc_asm.h>
 #include <asm/cputable.h>
-#include <asm/ppc_asm.h>
 #include <asm/offsets.h>
 #include <asm/cache.h>
 
--- linux-2.6.12-rc6-git6/arch/ppc/kernel/dma-mapping.c	2005-06-10 09:16:30.000000000 +1000
+++ .31090.trivial/arch/ppc/kernel/dma-mapping.c	2005-06-14 09:39:27.794654968 +1000
@@ -393,7 +393,7 @@ EXPORT_SYMBOL(__dma_sync);
  * __dma_sync_page() implementation for systems using highmem.
  * In this case, each page of a buffer must be kmapped/kunmapped
  * in order to have a virtual address for __dma_sync(). This must
- * not sleep so kmap_atmomic()/kunmap_atomic() are used.
+ * not sleep so kmap_atomic()/kunmap_atomic() are used.
  *
  * Note: yes, it is possible and correct to have a buffer extend
  * beyond the first page.
--- linux-2.6.12-rc6-git6/arch/ppc64/kernel/cpu_setup_power4.S	2005-02-04 18:49:52.000000000 +1100
+++ .31090.trivial/arch/ppc64/kernel/cpu_setup_power4.S	2005-06-14 09:39:28.236587784 +1000
@@ -14,7 +14,6 @@
 #include <asm/page.h>
 #include <asm/ppc_asm.h>
 #include <asm/cputable.h>
-#include <asm/ppc_asm.h>
 #include <asm/offsets.h>
 #include <asm/cache.h>
 
--- linux-2.6.12-rc6-git6/drivers/ide/ide-io.c	2005-06-10 09:16:55.000000000 +1000
+++ .31090.trivial/drivers/ide/ide-io.c	2005-06-14 09:39:27.867643872 +1000
@@ -560,7 +560,7 @@ ide_startstop_t __ide_abort(ide_drive_t 
 EXPORT_SYMBOL_GPL(__ide_abort);
 
 /**
- *	ide_abort	-	abort pending IDE operatins
+ *	ide_abort	-	abort pending IDE operations
  *	@drive: drive the error occurred on
  *	@msg: message to report
  *
@@ -623,7 +623,7 @@ static void ide_cmd (ide_drive_t *drive,
  *	@drive: drive the completion interrupt occurred on
  *
  *	drive_cmd_intr() is invoked on completion of a special DRIVE_CMD.
- *	We do any necessary daya reading and then wait for the drive to
+ *	We do any necessary data reading and then wait for the drive to
  *	go non busy. At that point we may read the error data and complete
  *	the request
  */
@@ -773,7 +773,7 @@ EXPORT_SYMBOL_GPL(ide_init_sg_cmd);
 
 /**
  *	execute_drive_command	-	issue special drive command
- *	@drive: the drive to issue th command on
+ *	@drive: the drive to issue the command on
  *	@rq: the request structure holding the command
  *
  *	execute_drive_cmd() issues a special drive command,  usually 
--- linux-2.6.12-rc6-git6/drivers/md/md.c	2005-06-10 09:16:59.000000000 +1000
+++ .31090.trivial/drivers/md/md.c	2005-06-14 09:39:27.679672448 +1000
@@ -67,7 +67,7 @@ static DEFINE_SPINLOCK(pers_lock);
  * Current RAID-1,4,5 parallel reconstruction 'guaranteed speed limit'
  * is 1000 KB/sec, so the extra system load does not show up that much.
  * Increase it if you want to have more _guaranteed_ speed. Note that
- * the RAID driver will use the maximum available bandwith if the IO
+ * the RAID driver will use the maximum available bandwidth if the IO
  * subsystem is idle. There is also an 'absolute maximum' reconstruction
  * speed limit - in case reconstruction slows down your system despite
  * idle IO detection.
@@ -3322,7 +3322,7 @@ static void md_do_sync(mddev_t *mddev)
 	printk(KERN_INFO "md: syncing RAID array %s\n", mdname(mddev));
 	printk(KERN_INFO "md: minimum _guaranteed_ reconstruction speed:"
 		" %d KB/sec/disc.\n", sysctl_speed_limit_min);
-	printk(KERN_INFO "md: using maximum available idle IO bandwith "
+	printk(KERN_INFO "md: using maximum available idle IO bandwidth "
 	       "(but not more than %d KB/sec) for reconstruction.\n",
 	       sysctl_speed_limit_max);
 
--- linux-2.6.12-rc6-git6/drivers/parisc/lasi.c	2005-06-10 09:17:10.000000000 +1000
+++ .31090.trivial/drivers/parisc/lasi.c	2005-06-14 09:39:28.452554952 +1000
@@ -20,7 +20,6 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/pm.h>
-#include <linux/slab.h>
 #include <linux/types.h>
 
 #include <asm/io.h>
--- linux-2.6.12-rc6-git6/drivers/scsi/ibmmca.c	2005-05-25 13:49:00.000000000 +1000
+++ .31090.trivial/drivers/scsi/ibmmca.c	2005-06-14 09:39:28.529543248 +1000
@@ -36,7 +36,6 @@
 #include <linux/proc_fs.h>
 #include <linux/stat.h>
 #include <linux/mca.h>
-#include <linux/string.h>
 #include <linux/spinlock.h>
 #include <linux/init.h>
 #include <linux/mca-legacy.h>
--- linux-2.6.12-rc6-git6/ipc/mqueue.c	2005-06-10 09:17:44.000000000 +1000
+++ .31090.trivial/ipc/mqueue.c	2005-06-14 09:39:27.937633232 +1000
@@ -69,7 +69,7 @@ struct mqueue_inode_info {
 
 	struct sigevent notify;
 	pid_t notify_owner;
- 	struct user_struct *user;	/* user who created, for accouting */
+	struct user_struct *user;	/* user who created, for accounting */
 	struct sock *notify_sock;
 	struct sk_buff *notify_cookie;
 

