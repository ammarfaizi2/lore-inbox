Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbWDBOP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbWDBOP7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 10:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWDBOP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 10:15:59 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:39945 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932345AbWDBOP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 10:15:58 -0400
Date: Sun, 2 Apr 2006 16:15:55 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: please pull from the trivial tree
Message-ID: <20060402141555.GF11800@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bunk/trivial.git


This tree contains the following:


Adrian Bunk:
      help text: SOFTWARE_SUSPEND doesn't need ACPI
      fix a typo in the AIC7XXX_DEBUG_MASK help text
      fix the email address of Wendy Xiong
      typos: s/ducument/document/

Anders Larsen:
      MTD: remove obsolete Kconfig options

Cal Peake:
      BFP->BPF in Documentation/networking/tuntap.txt

Eric Sesterhenn:
      BUG_ON() Conversion in md/dm-target.c
      BUG_ON() Conversion in md/raid1.c
      BUG_ON() Conversion in fs/direct-io.c
      BUG_ON() Conversion in fs/exec.c
      BUG_ON() Conversion in fs/hfsplus/
      BUG_ON() Conversion in fs/jffs2/
      BUG_ON() Conversion in fs/smbfs/
      BUG_ON() Conversion in fs/sysfs/
      BUG_ON() Conversion in ipc/util.c
      BUG_ON() Conversion in kernel/printk.c
      BUG_ON() Conversion in mm/mmap.c
      BUG_ON() Conversion in mm/swap_state.c
      BUG_ON() Conversion in mm/vmalloc.c
      BUG_ON() Conversion in drivers/s390/block/dasd_erp.c
      BUG_ON() Conversion in drivers/s390/char/tape_block.c
      BUG_ON() Conversion in md/raid5.c
      BUG_ON() Conversion in md/raid6main.c
      BUG_ON() Conversion in md/raid10.c
      BUG_ON() Conversion in fs/dquot.c
      BUG_ON() Conversion in fs/fcntl.c
      BUG_ON() Conversion in fs/inode.c
      BUG_ON() Conversion in fs/sysv/
      BUG_ON() Conversion in fs/udf/
      BUG_ON() Conversion in fs/freevxfs/
      BUG_ON() Conversion in ipc/shm.c
      BUG_ON() Conversion in kernel/ptrace.c
      BUG_ON() Conversion in kernel/signal.c
      BUG_ON() Conversion in kernel/signal.c
      BUG_ON() Conversion in mm/highmem.c
      BUG_ON() Conversion in mm/slab.c
      BUG_ON() Conversion in drivers/s390/net/lcs.c
      BUG_ON() Conversion in drivers/net/

Horms:
      Documentation: Reorder documentation of nomca and nomce
      Documentation: Make fujitsu/frv/kernel-ABI.txt 80 columns wide
      kexec: grammar fix for crash_save_this_cpu()

Kalin KOZHUHAROV:
      Fix comments: s/granuality/granularity/

Martin Waitz:
      Documentation: fix minor kernel-doc warnings

Michael Hayes:
      Fix minor documentation typo

Stefan Richter:
      Doc/kernel-parameters.txt: delete false version information and history
      Doc/kernel-parameters.txt: mention modinfo and sysfs
      Doc/kernel-parameters.txt: slightly reword sentence about restrictions

Uwe Zeisberger:
      fix typo "Suposse" -> "Suppose"


 Documentation/DocBook/Makefile           |    2 
 Documentation/DocBook/kernel-api.tmpl    |    1 
 Documentation/acpi-hotkey.txt            |    2 
 Documentation/fujitsu/frv/kernel-ABI.txt |  196 +++++++++++++----------
 Documentation/kernel-parameters.txt      |   34 +--
 Documentation/networking/packet_mmap.txt |    2 
 Documentation/networking/tuntap.txt      |    2 
 arch/i386/kernel/crash.c                 |    2 
 block/ll_rw_blk.c                        |    2 
 drivers/md/dm-target.c                   |    3 
 drivers/md/raid1.c                       |    6 
 drivers/md/raid10.c                      |    6 
 drivers/md/raid5.c                       |   34 +--
 drivers/md/raid6main.c                   |   29 +--
 drivers/mtd/chips/Kconfig                |   21 --
 drivers/net/8139cp.c                     |   12 -
 drivers/net/arcnet/arcnet.c              |    3 
 drivers/net/b44.c                        |    3 
 drivers/net/chelsio/sge.c                |    3 
 drivers/net/e1000/e1000_main.c           |    3 
 drivers/net/eql.c                        |    3 
 drivers/net/irda/sa1100_ir.c             |    3 
 drivers/net/ne2k-pci.c                   |    4 
 drivers/net/ns83820.c                    |    3 
 drivers/net/starfire.c                   |    3 
 drivers/net/tg3.c                        |   15 -
 drivers/net/tokenring/abyss.c            |    3 
 drivers/net/tokenring/madgemc.c          |    3 
 drivers/net/wireless/ipw2200.c           |    9 -
 drivers/net/yellowfin.c                  |    3 
 drivers/s390/block/dasd_erp.c            |    8 
 drivers/s390/char/sclp_rw.c              |    2 
 drivers/s390/char/tape_block.c           |   13 -
 drivers/s390/net/lcs.c                   |   13 -
 drivers/scsi/aic7xxx/Kconfig.aic7xxx     |    2 
 drivers/serial/jsm/jsm.h                 |    2 
 drivers/serial/jsm/jsm_driver.c          |    2 
 drivers/serial/jsm/jsm_neo.c             |    2 
 fs/direct-io.c                           |    3 
 fs/dquot.c                               |    6 
 fs/exec.c                                |    2 
 fs/fcntl.c                               |    3 
 fs/freevxfs/vxfs_olt.c                   |    9 -
 fs/hfsplus/bnode.c                       |    6 
 fs/hfsplus/btree.c                       |    3 
 fs/inode.c                               |   15 -
 fs/jffs2/background.c                    |    3 
 fs/smbfs/file.c                          |    6 
 fs/sysfs/dir.c                           |    2 
 fs/sysfs/inode.c                         |    3 
 fs/sysv/dir.c                            |    6 
 fs/udf/inode.c                           |    6 
 include/linux/fs.h                       |    2 
 include/linux/hrtimer.h                  |    2 
 ipc/shm.c                                |   15 -
 ipc/util.c                               |    6 
 kernel/power/Kconfig                     |    2 
 kernel/printk.c                          |    6 
 kernel/ptrace.c                          |    3 
 kernel/signal.c                          |    6 
 kernel/time.c                            |    8 
 kernel/timer.c                           |    3 
 mm/highmem.c                             |   15 -
 mm/mmap.c                                |    9 -
 mm/page-writeback.c                      |    2 
 mm/slab.c                                |   18 --
 mm/swap_state.c                          |    3 
 mm/vmalloc.c                             |    3 
 68 files changed, 264 insertions(+), 371 deletions(-)


diff --git a/Documentation/DocBook/Makefile b/Documentation/DocBook/Makefile
index 7d87dd7..5a2882d 100644
--- a/Documentation/DocBook/Makefile
+++ b/Documentation/DocBook/Makefile
@@ -2,7 +2,7 @@
 # This makefile is used to generate the kernel documentation,
 # primarily based on in-line comments in various source files.
 # See Documentation/kernel-doc-nano-HOWTO.txt for instruction in how
-# to ducument the SRC - and how to read it.
+# to document the SRC - and how to read it.
 # To add a new book the only step required is to add the book to the
 # list of DOCBOOKS.
 
diff --git a/Documentation/DocBook/kernel-api.tmpl b/Documentation/DocBook/kernel-api.tmpl
index 8c9c670..ca02e04 100644
--- a/Documentation/DocBook/kernel-api.tmpl
+++ b/Documentation/DocBook/kernel-api.tmpl
@@ -322,7 +322,6 @@ X!Earch/i386/kernel/mca.c
   <chapter id="sysfs">
      <title>The Filesystem for Exporting Kernel Objects</title>
 !Efs/sysfs/file.c
-!Efs/sysfs/dir.c
 !Efs/sysfs/symlink.c
 !Efs/sysfs/bin.c
   </chapter>
diff --git a/Documentation/acpi-hotkey.txt b/Documentation/acpi-hotkey.txt
index 744f1ae..38040fa 100644
--- a/Documentation/acpi-hotkey.txt
+++ b/Documentation/acpi-hotkey.txt
@@ -30,7 +30,7 @@ specific hotkey(event))
 echo "event_num:event_type:event_argument" > 
 	/proc/acpi/hotkey/action.
 The result of the execution of this aml method is 
-attached to /proc/acpi/hotkey/poll_method, which is dnyamically
+attached to /proc/acpi/hotkey/poll_method, which is dynamically
 created.  Please use command "cat /proc/acpi/hotkey/polling_method" 
 to retrieve it.
 
diff --git a/Documentation/fujitsu/frv/kernel-ABI.txt b/Documentation/fujitsu/frv/kernel-ABI.txt
index 0ed9b0a..8b0a5fc 100644
--- a/Documentation/fujitsu/frv/kernel-ABI.txt
+++ b/Documentation/fujitsu/frv/kernel-ABI.txt
@@ -1,17 +1,19 @@
-				 =================================
-				 INTERNAL KERNEL ABI FOR FR-V ARCH
-				 =================================
-
-The internal FRV kernel ABI is not quite the same as the userspace ABI. A number of the registers
-are used for special purposed, and the ABI is not consistent between modules vs core, and MMU vs
-no-MMU.
-
-This partly stems from the fact that FRV CPUs do not have a separate supervisor stack pointer, and
-most of them do not have any scratch registers, thus requiring at least one general purpose
-register to be clobbered in such an event. Also, within the kernel core, it is possible to simply
-jump or call directly between functions using a relative offset. This cannot be extended to modules
-for the displacement is likely to be too far. Thus in modules the address of a function to call
-must be calculated in a register and then used, requiring two extra instructions.
+			=================================
+			INTERNAL KERNEL ABI FOR FR-V ARCH
+			=================================
+
+The internal FRV kernel ABI is not quite the same as the userspace ABI. A
+number of the registers are used for special purposed, and the ABI is not
+consistent between modules vs core, and MMU vs no-MMU.
+
+This partly stems from the fact that FRV CPUs do not have a separate
+supervisor stack pointer, and most of them do not have any scratch
+registers, thus requiring at least one general purpose register to be
+clobbered in such an event. Also, within the kernel core, it is possible to
+simply jump or call directly between functions using a relative offset.
+This cannot be extended to modules for the displacement is likely to be too
+far. Thus in modules the address of a function to call must be calculated
+in a register and then used, requiring two extra instructions.
 
 This document has the following sections:
 
@@ -39,7 +41,8 @@ When a system call is made, the followin
 CPU OPERATING MODES
 ===================
 
-The FR-V CPU has three basic operating modes. In order of increasing capability:
+The FR-V CPU has three basic operating modes. In order of increasing
+capability:
 
   (1) User mode.
 
@@ -47,42 +50,46 @@ The FR-V CPU has three basic operating m
 
   (2) Kernel mode.
 
-      Normal kernel mode. There are many additional control registers available that may be
-      accessed in this mode, in addition to all the stuff available to user mode. This has two
-      submodes:
+      Normal kernel mode. There are many additional control registers
+      available that may be accessed in this mode, in addition to all the
+      stuff available to user mode. This has two submodes:
 
       (a) Exceptions enabled (PSR.T == 1).
 
-      	  Exceptions will invoke the appropriate normal kernel mode handler. On entry to the
-      	  handler, the PSR.T bit will be cleared.
+	  Exceptions will invoke the appropriate normal kernel mode
+	  handler. On entry to the handler, the PSR.T bit will be cleared.
 
       (b) Exceptions disabled (PSR.T == 0).
 
-      	  No exceptions or interrupts may happen. Any mandatory exceptions will cause the CPU to
-      	  halt unless the CPU is told to jump into debug mode instead.
+	  No exceptions or interrupts may happen. Any mandatory exceptions
+	  will cause the CPU to halt unless the CPU is told to jump into
+	  debug mode instead.
 
   (3) Debug mode.
 
-      No exceptions may happen in this mode. Memory protection and management exceptions will be
-      flagged for later consideration, but the exception handler won't be invoked. Debugging traps
-      such as hardware breakpoints and watchpoints will be ignored. This mode is entered only by
-      debugging events obtained from the other two modes.
+      No exceptions may happen in this mode. Memory protection and
+      management exceptions will be flagged for later consideration, but
+      the exception handler won't be invoked. Debugging traps such as
+      hardware breakpoints and watchpoints will be ignored. This mode is
+      entered only by debugging events obtained from the other two modes.
 
-      All kernel mode registers may be accessed, plus a few extra debugging specific registers.
+      All kernel mode registers may be accessed, plus a few extra debugging
+      specific registers.
 
 
 =================================
 INTERNAL KERNEL-MODE REGISTER ABI
 =================================
 
-There are a number of permanent register assignments that are set up by entry.S in the exception
-prologue. Note that there is a complete set of exception prologues for each of user->kernel
-transition and kernel->kernel transition. There are also user->debug and kernel->debug mode
-transition prologues.
+There are a number of permanent register assignments that are set up by
+entry.S in the exception prologue. Note that there is a complete set of
+exception prologues for each of user->kernel transition and kernel->kernel
+transition. There are also user->debug and kernel->debug mode transition
+prologues.
 
 
 	REGISTER	FLAVOUR	USE
-	===============	=======	====================================================
+	===============	=======	==============================================
 	GR1			Supervisor stack pointer
 	GR15			Current thread info pointer
 	GR16			GP-Rel base register for small data
@@ -92,10 +99,12 @@ transition prologues.
 	GR31		NOMMU	Destroyed by debug mode entry
 	GR31		MMU	Destroyed by TLB miss kernel mode entry
 	CCR.ICC2		Virtual interrupt disablement tracking
-	CCCR.CC3		Cleared by exception prologue (atomic op emulation)
+	CCCR.CC3		Cleared by exception prologue 
+				(atomic op emulation)
 	SCR0		MMU	See mmu-layout.txt.
 	SCR1		MMU	See mmu-layout.txt.
-	SCR2		MMU	Save for EAR0 (destroyed by icache insns in debug mode)
+	SCR2		MMU	Save for EAR0 (destroyed by icache insns 
+					       in debug mode)
 	SCR3		MMU	Save for GR31 during debug exceptions
 	DAMR/IAMR	NOMMU	Fixed memory protection layout.
 	DAMR/IAMR	MMU	See mmu-layout.txt.
@@ -104,18 +113,21 @@ transition prologues.
 Certain registers are also used or modified across function calls:
 
 	REGISTER	CALL				RETURN
-	===============	===============================	===============================
+	===============	===============================	======================
 	GR0		Fixed Zero			-
 	GR2		Function call frame pointer
 	GR3		Special				Preserved
 	GR3-GR7		-				Clobbered
-	GR8		Function call arg #1		Return value (or clobbered)
-	GR9		Function call arg #2		Return value MSW (or clobbered)
+	GR8		Function call arg #1		Return value 
+							(or clobbered)
+	GR9		Function call arg #2		Return value MSW 
+							(or clobbered)
 	GR10-GR13	Function call arg #3-#6		Clobbered
 	GR14		-				Clobbered
 	GR15-GR16	Special				Preserved
 	GR17-GR27	-				Preserved
-	GR28-GR31	Special				Only accessed explicitly
+	GR28-GR31	Special				Only accessed 
+							explicitly
 	LR		Return address after CALL	Clobbered
 	CCR/CCCR	-				Mostly Clobbered
 
@@ -124,46 +136,53 @@ Certain registers are also used or modif
 INTERNAL DEBUG-MODE REGISTER ABI
 ================================
 
-This is the same as the kernel-mode register ABI for functions calls. The difference is that in
-debug-mode there's a different stack and a different exception frame. Almost all the global
-registers from kernel-mode (including the stack pointer) may be changed.
+This is the same as the kernel-mode register ABI for functions calls. The
+difference is that in debug-mode there's a different stack and a different
+exception frame. Almost all the global registers from kernel-mode
+(including the stack pointer) may be changed.
 
 	REGISTER	FLAVOUR	USE
-	===============	=======	====================================================
+	===============	=======	==============================================
 	GR1			Debug stack pointer
 	GR16			GP-Rel base register for small data
-	GR31			Current debug exception frame pointer (__debug_frame)
+	GR31			Current debug exception frame pointer 
+				(__debug_frame)
 	SCR3		MMU	Saved value of GR31
 
 
-Note that debug mode is able to interfere with the kernel's emulated atomic ops, so it must be
-exceedingly careful not to do any that would interact with the main kernel in this regard. Hence
-the debug mode code (gdbstub) is almost completely self-contained. The only external code used is
-the sprintf family of functions.
-
-Futhermore, break.S is so complicated because single-step mode does not switch off on entry to an
-exception. That means unless manually disabled, single-stepping will blithely go on stepping into
-things like interrupts. See gdbstub.txt for more information.
+Note that debug mode is able to interfere with the kernel's emulated atomic
+ops, so it must be exceedingly careful not to do any that would interact
+with the main kernel in this regard. Hence the debug mode code (gdbstub) is
+almost completely self-contained. The only external code used is the
+sprintf family of functions.
+
+Futhermore, break.S is so complicated because single-step mode does not
+switch off on entry to an exception. That means unless manually disabled,
+single-stepping will blithely go on stepping into things like interrupts.
+See gdbstub.txt for more information.
 
 
 ==========================
 VIRTUAL INTERRUPT HANDLING
 ==========================
 
-Because accesses to the PSR is so slow, and to disable interrupts we have to access it twice (once
-to read and once to write), we don't actually disable interrupts at all if we don't have to. What
-we do instead is use the ICC2 condition code flags to note virtual disablement, such that if we
-then do take an interrupt, we note the flag, really disable interrupts, set another flag and resume
-execution at the point the interrupt happened. Setting condition flags as a side effect of an
-arithmetic or logical instruction is really fast. This use of the ICC2 only occurs within the
+Because accesses to the PSR is so slow, and to disable interrupts we have
+to access it twice (once to read and once to write), we don't actually
+disable interrupts at all if we don't have to. What we do instead is use
+the ICC2 condition code flags to note virtual disablement, such that if we
+then do take an interrupt, we note the flag, really disable interrupts, set
+another flag and resume execution at the point the interrupt happened.
+Setting condition flags as a side effect of an arithmetic or logical
+instruction is really fast. This use of the ICC2 only occurs within the
 kernel - it does not affect userspace.
 
 The flags we use are:
 
  (*) CCR.ICC2.Z [Zero flag]
 
-     Set to virtually disable interrupts, clear when interrupts are virtually enabled. Can be
-     modified by logical instructions without affecting the Carry flag.
+     Set to virtually disable interrupts, clear when interrupts are
+     virtually enabled. Can be modified by logical instructions without
+     affecting the Carry flag.
 
  (*) CCR.ICC2.C [Carry flag]
 
@@ -176,8 +195,9 @@ What happens is this:
 
 	ICC2.Z is 0, ICC2.C is 1.
 
- (2) An interrupt occurs. The exception prologue examines ICC2.Z and determines that nothing needs
-     doing. This is done simply with an unlikely BEQ instruction.
+ (2) An interrupt occurs. The exception prologue examines ICC2.Z and
+     determines that nothing needs doing. This is done simply with an
+     unlikely BEQ instruction.
 
  (3) The interrupts are disabled (local_irq_disable)
 
@@ -187,48 +207,56 @@ What happens is this:
 
 	ICC2.Z would be set to 0.
 
-     A TIHI #2 instruction (trap #2 if condition HI - Z==0 && C==0) would be used to trap if
-     interrupts were now virtually enabled, but physically disabled - which they're not, so the
-     trap isn't taken. The kernel would then be back to state (1).
-
- (5) An interrupt occurs. The exception prologue examines ICC2.Z and determines that the interrupt
-     shouldn't actually have happened. It jumps aside, and there disabled interrupts by setting
-     PSR.PIL to 14 and then it clears ICC2.C.
+     A TIHI #2 instruction (trap #2 if condition HI - Z==0 && C==0) would
+     be used to trap if interrupts were now virtually enabled, but
+     physically disabled - which they're not, so the trap isn't taken. The
+     kernel would then be back to state (1).
+
+ (5) An interrupt occurs. The exception prologue examines ICC2.Z and
+     determines that the interrupt shouldn't actually have happened. It
+     jumps aside, and there disabled interrupts by setting PSR.PIL to 14
+     and then it clears ICC2.C.
 
  (6) If interrupts were then saved and disabled again (local_irq_save):
 
-	ICC2.Z would be shifted into the save variable and masked off (giving a 1).
+	ICC2.Z would be shifted into the save variable and masked off 
+	(giving a 1).
 
-	ICC2.Z would then be set to 1 (thus unchanged), and ICC2.C would be unaffected (ie: 0).
+	ICC2.Z would then be set to 1 (thus unchanged), and ICC2.C would be
+	unaffected (ie: 0).
 
  (7) If interrupts were then restored from state (6) (local_irq_restore):
 
-	ICC2.Z would be set to indicate the result of XOR'ing the saved value (ie: 1) with 1, which
-	gives a result of 0 - thus leaving ICC2.Z set.
+	ICC2.Z would be set to indicate the result of XOR'ing the saved
+	value (ie: 1) with 1, which gives a result of 0 - thus leaving
+	ICC2.Z set.
 
 	ICC2.C would remain unaffected (ie: 0).
 
-     A TIHI #2 instruction would be used to again assay the current state, but this would do
-     nothing as Z==1.
+     A TIHI #2 instruction would be used to again assay the current state,
+     but this would do nothing as Z==1.
 
  (8) If interrupts were then enabled (local_irq_enable):
 
-	ICC2.Z would be cleared. ICC2.C would be left unaffected. Both flags would now be 0.
+	ICC2.Z would be cleared. ICC2.C would be left unaffected. Both
+	flags would now be 0.
 
-     A TIHI #2 instruction again issued to assay the current state would then trap as both Z==0
-     [interrupts virtually enabled] and C==0 [interrupts really disabled] would then be true.
+     A TIHI #2 instruction again issued to assay the current state would
+     then trap as both Z==0 [interrupts virtually enabled] and C==0
+     [interrupts really disabled] would then be true.
 
- (9) The trap #2 handler would simply enable hardware interrupts (set PSR.PIL to 0), set ICC2.C to
-     1 and return.
+ (9) The trap #2 handler would simply enable hardware interrupts 
+     (set PSR.PIL to 0), set ICC2.C to 1 and return.
 
 (10) Immediately upon returning, the pending interrupt would be taken.
 
-(11) The interrupt handler would take the path of actually processing the interrupt (ICC2.Z is
-     clear, BEQ fails as per step (2)).
+(11) The interrupt handler would take the path of actually processing the
+     interrupt (ICC2.Z is clear, BEQ fails as per step (2)).
 
-(12) The interrupt handler would then set ICC2.C to 1 since hardware interrupts are definitely
-     enabled - or else the kernel wouldn't be here.
+(12) The interrupt handler would then set ICC2.C to 1 since hardware
+     interrupts are definitely enabled - or else the kernel wouldn't be here.
 
 (13) On return from the interrupt handler, things would be back to state (1).
 
-This trap (#2) is only available in kernel mode. In user mode it will result in SIGILL.
+This trap (#2) is only available in kernel mode. In user mode it will
+result in SIGILL.
diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index f8cb55c..b3a6187 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1,4 +1,4 @@
-February 2003             Kernel Parameters                     v2.5.59
+                          Kernel Parameters
                           ~~~~~~~~~~~~~~~~~
 
 The following is a consolidated list of the kernel parameters as implemented
@@ -17,9 +17,17 @@ are specified on the kernel command line
 
 	usbcore.blinkenlights=1
 
-The text in square brackets at the beginning of the description states the
-restrictions on the kernel for the said kernel parameter to be valid. The
-restrictions referred to are that the relevant option is valid if:
+This document may not be entirely up to date and comprehensive. The command
+"modinfo -p ${modulename}" shows a current list of all parameters of a loadable
+module. Loadable modules, after being loaded into the running kernel, also
+reveal their parameters in /sys/module/${modulename}/parameters/. Some of these
+parameters may be changed at runtime by the command
+"echo -n ${value} > /sys/module/${modulename}/parameters/${parm}".
+
+The parameters listed below are only valid if certain kernel build options were
+enabled and if respective hardware is present. The text in square brackets at
+the beginning of each description states the restrictions within which a
+parameter is applicable:
 
 	ACPI	ACPI support is enabled.
 	ALSA	ALSA sound support is enabled.
@@ -1046,10 +1054,10 @@ running once the system is up.
 	noltlbs		[PPC] Do not use large page/tlb entries for kernel
 			lowmem mapping on PPC40x.
 
-	nomce		[IA-32] Machine Check Exception
-
 	nomca		[IA-64] Disable machine check abort handling
 
+	nomce		[IA-32] Machine Check Exception
+
 	noresidual	[PPC] Don't use residual data on PReP machines.
 
 	noresume	[SWSUSP] Disables resume and restores original swap
@@ -1682,20 +1690,6 @@ running once the system is up.
 
 
 ______________________________________________________________________
-Changelog:
-
-2000-06-??	Mr. Unknown
-	The last known update (for 2.4.0) - the changelog was not kept before.
-
-2002-11-24	Petr Baudis <pasky@ucw.cz>
-		Randy Dunlap <randy.dunlap@verizon.net>
-	Update for 2.5.49, description for most of the options introduced,
-	references to other documentation (C files, READMEs, ..), added S390,
-	PPC, SPARC, MTD, ALSA and OSS category. Minor corrections and
-	reformatting.
-
-2005-10-19	Randy Dunlap <rdunlap@xenotime.net>
-	Lots of typos, whitespace, some reformatting.
 
 TODO:
 
diff --git a/Documentation/networking/packet_mmap.txt b/Documentation/networking/packet_mmap.txt
index 4fc8e98..aaf99d5 100644
--- a/Documentation/networking/packet_mmap.txt
+++ b/Documentation/networking/packet_mmap.txt
@@ -254,7 +254,7 @@ and, the number of frames be
 
 	<block number> * <block size> / <frame size>
 
-Suposse the following parameters, which apply for 2.6 kernel and an
+Suppose the following parameters, which apply for 2.6 kernel and an
 i386 architecture:
 
 	<size-max> = 131072 bytes
diff --git a/Documentation/networking/tuntap.txt b/Documentation/networking/tuntap.txt
index ec3d109..76750fb 100644
--- a/Documentation/networking/tuntap.txt
+++ b/Documentation/networking/tuntap.txt
@@ -138,7 +138,7 @@ This means that you have to read/write I
 ethernet frames when using tap.
 
 5. What is the difference between BPF and TUN/TAP driver?
-BFP is an advanced packet filter. It can be attached to existing
+BPF is an advanced packet filter. It can be attached to existing
 network interface. It does not provide a virtual network interface.
 A TUN/TAP driver does provide a virtual network interface and it is possible
 to attach BPF to this interface.
diff --git a/arch/i386/kernel/crash.c b/arch/i386/kernel/crash.c
index e3c5fca..2b0cfce 100644
--- a/arch/i386/kernel/crash.c
+++ b/arch/i386/kernel/crash.c
@@ -69,7 +69,7 @@ static void crash_save_this_cpu(struct p
 	 * for the data I pass, and I need tags
 	 * on the data to indicate what information I have
 	 * squirrelled away.  ELF notes happen to provide
-	 * all of that that no need to invent something new.
+	 * all of that, so there is no need to invent something new.
 	 */
 	buf = (u32*)per_cpu_ptr(crash_notes, cpu);
 	if (!buf)
diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index 5b26af8..e112d1a 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -1740,7 +1740,7 @@ EXPORT_SYMBOL(blk_run_queue);
 
 /**
  * blk_cleanup_queue: - release a &request_queue_t when it is no longer needed
- * @q:    the request queue to be released
+ * @kobj:    the kobj belonging of the request queue to be released
  *
  * Description:
  *     blk_cleanup_queue is the pair to blk_init_queue() or
diff --git a/drivers/md/dm-target.c b/drivers/md/dm-target.c
index aecd9e0..64fd8e7 100644
--- a/drivers/md/dm-target.c
+++ b/drivers/md/dm-target.c
@@ -78,8 +78,7 @@ void dm_put_target_type(struct target_ty
 	if (--ti->use == 0)
 		module_put(ti->tt.module);
 
-	if (ti->use < 0)
-		BUG();
+	BUG_ON(ti->use < 0);
 	up_read(&_lock);
 
 	return;
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 9b374c9..6081941 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1558,8 +1558,7 @@ static int init_resync(conf_t *conf)
 	int buffs;
 
 	buffs = RESYNC_WINDOW / RESYNC_BLOCK_SIZE;
-	if (conf->r1buf_pool)
-		BUG();
+	BUG_ON(conf->r1buf_pool);
 	conf->r1buf_pool = mempool_create(buffs, r1buf_pool_alloc, r1buf_pool_free,
 					  conf->poolinfo);
 	if (!conf->r1buf_pool)
@@ -1732,8 +1731,7 @@ static sector_t sync_request(mddev_t *md
 			    !conf->fullsync &&
 			    !test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery))
 				break;
-			if (sync_blocks < (PAGE_SIZE>>9))
-				BUG();
+			BUG_ON(sync_blocks < (PAGE_SIZE>>9));
 			if (len > (sync_blocks<<9))
 				len = sync_blocks<<9;
 		}
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index ab90a6d..617012b 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1117,8 +1117,7 @@ static int end_sync_read(struct bio *bio
 	for (i=0; i<conf->copies; i++)
 		if (r10_bio->devs[i].bio == bio)
 			break;
-	if (i == conf->copies)
-		BUG();
+	BUG_ON(i == conf->copies);
 	update_head_pos(i, r10_bio);
 	d = r10_bio->devs[i].devnum;
 
@@ -1518,8 +1517,7 @@ static int init_resync(conf_t *conf)
 	int buffs;
 
 	buffs = RESYNC_WINDOW / RESYNC_BLOCK_SIZE;
-	if (conf->r10buf_pool)
-		BUG();
+	BUG_ON(conf->r10buf_pool);
 	conf->r10buf_pool = mempool_create(buffs, r10buf_pool_alloc, r10buf_pool_free, conf);
 	if (!conf->r10buf_pool)
 		return -ENOMEM;
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index dae740a..3184360 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -73,10 +73,8 @@ static void print_raid5_conf (raid5_conf
 static void __release_stripe(raid5_conf_t *conf, struct stripe_head *sh)
 {
 	if (atomic_dec_and_test(&sh->count)) {
-		if (!list_empty(&sh->lru))
-			BUG();
-		if (atomic_read(&conf->active_stripes)==0)
-			BUG();
+		BUG_ON(!list_empty(&sh->lru));
+		BUG_ON(atomic_read(&conf->active_stripes)==0);
 		if (test_bit(STRIPE_HANDLE, &sh->state)) {
 			if (test_bit(STRIPE_DELAYED, &sh->state))
 				list_add_tail(&sh->lru, &conf->delayed_list);
@@ -184,10 +182,8 @@ static void init_stripe(struct stripe_he
 	raid5_conf_t *conf = sh->raid_conf;
 	int i;
 
-	if (atomic_read(&sh->count) != 0)
-		BUG();
-	if (test_bit(STRIPE_HANDLE, &sh->state))
-		BUG();
+	BUG_ON(atomic_read(&sh->count) != 0);
+	BUG_ON(test_bit(STRIPE_HANDLE, &sh->state));
 	
 	CHECK_DEVLOCK();
 	PRINTK("init_stripe called, stripe %llu\n", 
@@ -269,8 +265,7 @@ static struct stripe_head *get_active_st
 				init_stripe(sh, sector, pd_idx, disks);
 		} else {
 			if (atomic_read(&sh->count)) {
-				if (!list_empty(&sh->lru))
-					BUG();
+			  BUG_ON(!list_empty(&sh->lru));
 			} else {
 				if (!test_bit(STRIPE_HANDLE, &sh->state))
 					atomic_inc(&conf->active_stripes);
@@ -465,8 +460,7 @@ static int drop_one_stripe(raid5_conf_t 
 	spin_unlock_irq(&conf->device_lock);
 	if (!sh)
 		return 0;
-	if (atomic_read(&sh->count))
-		BUG();
+	BUG_ON(atomic_read(&sh->count));
 	shrink_buffers(sh, conf->pool_size);
 	kmem_cache_free(conf->slab_cache, sh);
 	atomic_dec(&conf->active_stripes);
@@ -882,8 +876,7 @@ static void compute_parity(struct stripe
 	ptr[0] = page_address(sh->dev[pd_idx].page);
 	switch(method) {
 	case READ_MODIFY_WRITE:
-		if (!test_bit(R5_UPTODATE, &sh->dev[pd_idx].flags))
-			BUG();
+		BUG_ON(!test_bit(R5_UPTODATE, &sh->dev[pd_idx].flags));
 		for (i=disks ; i-- ;) {
 			if (i==pd_idx)
 				continue;
@@ -896,7 +889,7 @@ static void compute_parity(struct stripe
 				if (test_and_clear_bit(R5_Overlap, &sh->dev[i].flags))
 					wake_up(&conf->wait_for_overlap);
 
-				if (sh->dev[i].written) BUG();
+				BUG_ON(sh->dev[i].written);
 				sh->dev[i].written = chosen;
 				check_xor();
 			}
@@ -912,7 +905,7 @@ static void compute_parity(struct stripe
 				if (test_and_clear_bit(R5_Overlap, &sh->dev[i].flags))
 					wake_up(&conf->wait_for_overlap);
 
-				if (sh->dev[i].written) BUG();
+				BUG_ON(sh->dev[i].written);
 				sh->dev[i].written = chosen;
 			}
 		break;
@@ -995,8 +988,7 @@ static int add_stripe_bio(struct stripe_
 	if (*bip && (*bip)->bi_sector < bi->bi_sector + ((bi->bi_size)>>9))
 		goto overlap;
 
-	if (*bip && bi->bi_next && (*bip) != bi->bi_next)
-		BUG();
+	BUG_ON(*bip && bi->bi_next && (*bip) != bi->bi_next);
 	if (*bip)
 		bi->bi_next = *bip;
 	*bip = bi;
@@ -1430,8 +1422,7 @@ static void handle_stripe(struct stripe_
 		set_bit(STRIPE_HANDLE, &sh->state);
 		if (failed == 0) {
 			char *pagea;
-			if (uptodate != disks)
-				BUG();
+			BUG_ON(uptodate != disks);
 			compute_parity(sh, CHECK_PARITY);
 			uptodate--;
 			pagea = page_address(sh->dev[sh->pd_idx].page);
@@ -2096,8 +2087,7 @@ static void raid5d (mddev_t *mddev)
 
 		list_del_init(first);
 		atomic_inc(&sh->count);
-		if (atomic_read(&sh->count)!= 1)
-			BUG();
+		BUG_ON(atomic_read(&sh->count)!= 1);
 		spin_unlock_irq(&conf->device_lock);
 		
 		handled++;
diff --git a/drivers/md/raid6main.c b/drivers/md/raid6main.c
index ab64b37..bc69355 100644
--- a/drivers/md/raid6main.c
+++ b/drivers/md/raid6main.c
@@ -91,10 +91,8 @@ static void print_raid6_conf (raid6_conf
 static void __release_stripe(raid6_conf_t *conf, struct stripe_head *sh)
 {
 	if (atomic_dec_and_test(&sh->count)) {
-		if (!list_empty(&sh->lru))
-			BUG();
-		if (atomic_read(&conf->active_stripes)==0)
-			BUG();
+		BUG_ON(!list_empty(&sh->lru));
+		BUG_ON(atomic_read(&conf->active_stripes)==0);
 		if (test_bit(STRIPE_HANDLE, &sh->state)) {
 			if (test_bit(STRIPE_DELAYED, &sh->state))
 				list_add_tail(&sh->lru, &conf->delayed_list);
@@ -202,10 +200,8 @@ static void init_stripe(struct stripe_he
 	raid6_conf_t *conf = sh->raid_conf;
 	int disks = conf->raid_disks, i;
 
-	if (atomic_read(&sh->count) != 0)
-		BUG();
-	if (test_bit(STRIPE_HANDLE, &sh->state))
-		BUG();
+	BUG_ON(atomic_read(&sh->count) != 0);
+	BUG_ON(test_bit(STRIPE_HANDLE, &sh->state));
 
 	CHECK_DEVLOCK();
 	PRINTK("init_stripe called, stripe %llu\n",
@@ -284,13 +280,11 @@ static struct stripe_head *get_active_st
 				init_stripe(sh, sector, pd_idx);
 		} else {
 			if (atomic_read(&sh->count)) {
-				if (!list_empty(&sh->lru))
-					BUG();
+				BUG_ON(!list_empty(&sh->lru));
 			} else {
 				if (!test_bit(STRIPE_HANDLE, &sh->state))
 					atomic_inc(&conf->active_stripes);
-				if (list_empty(&sh->lru))
-					BUG();
+				BUG_ON(list_empty(&sh->lru));
 				list_del_init(&sh->lru);
 			}
 		}
@@ -353,8 +347,7 @@ static int drop_one_stripe(raid6_conf_t 
 	spin_unlock_irq(&conf->device_lock);
 	if (!sh)
 		return 0;
-	if (atomic_read(&sh->count))
-		BUG();
+	BUG_ON(atomic_read(&sh->count));
 	shrink_buffers(sh, conf->raid_disks);
 	kmem_cache_free(conf->slab_cache, sh);
 	atomic_dec(&conf->active_stripes);
@@ -780,7 +773,7 @@ static void compute_parity(struct stripe
 				if (test_and_clear_bit(R5_Overlap, &sh->dev[i].flags))
 					wake_up(&conf->wait_for_overlap);
 
-				if (sh->dev[i].written) BUG();
+				BUG_ON(sh->dev[i].written);
 				sh->dev[i].written = chosen;
 			}
 		break;
@@ -970,8 +963,7 @@ static int add_stripe_bio(struct stripe_
 	if (*bip && (*bip)->bi_sector < bi->bi_sector + ((bi->bi_size)>>9))
 		goto overlap;
 
-	if (*bip && bi->bi_next && (*bip) != bi->bi_next)
-		BUG();
+	BUG_ON(*bip && bi->bi_next && (*bip) != bi->bi_next);
 	if (*bip)
 		bi->bi_next = *bip;
 	*bip = bi;
@@ -1906,8 +1898,7 @@ static void raid6d (mddev_t *mddev)
 
 		list_del_init(first);
 		atomic_inc(&sh->count);
-		if (atomic_read(&sh->count)!= 1)
-			BUG();
+		BUG_ON(atomic_read(&sh->count)!= 1);
 		spin_unlock_irq(&conf->device_lock);
 
 		handled++;
diff --git a/drivers/mtd/chips/Kconfig b/drivers/mtd/chips/Kconfig
index 0f6bb2e..a7ec595 100644
--- a/drivers/mtd/chips/Kconfig
+++ b/drivers/mtd/chips/Kconfig
@@ -200,27 +200,6 @@ config MTD_CFI_AMDSTD
 	  provides support for one of those command sets, used on chips
 	  including the AMD Am29LV320.
 
-config MTD_CFI_AMDSTD_RETRY
-	int "Retry failed commands (erase/program)"
-	depends on MTD_CFI_AMDSTD
-	default "0"
-	help
-	  Some chips, when attached to a shared bus, don't properly filter
-	  bus traffic that is destined to other devices.  This broken
-	  behavior causes erase and program sequences to be aborted when
-	  the sequences are mixed with traffic for other devices.
-
-	  SST49LF040 (and related) chips are know to be broken.
-
-config MTD_CFI_AMDSTD_RETRY_MAX
-	int "Max retries of failed commands (erase/program)"
-	depends on MTD_CFI_AMDSTD_RETRY
-	default "0"
-	help
-	  If you have an SST49LF040 (or related chip) then this value should
-	  be set to at least 1.  This can also be adjusted at driver load
-	  time with the retry_cmd_max module parameter.
-
 config MTD_CFI_STAA
 	tristate "Support for ST (Advanced Architecture) flash chips"
 	depends on MTD_GEN_PROBE
diff --git a/drivers/net/8139cp.c b/drivers/net/8139cp.c
index ce99845..066e22b 100644
--- a/drivers/net/8139cp.c
+++ b/drivers/net/8139cp.c
@@ -539,8 +539,7 @@ rx_status_loop:
 		unsigned buflen;
 
 		skb = cp->rx_skb[rx_tail].skb;
-		if (!skb)
-			BUG();
+		BUG_ON(!skb);
 
 		desc = &cp->rx_ring[rx_tail];
 		status = le32_to_cpu(desc->opts1);
@@ -723,8 +722,7 @@ static void cp_tx (struct cp_private *cp
 			break;
 
 		skb = cp->tx_skb[tx_tail].skb;
-		if (!skb)
-			BUG();
+		BUG_ON(!skb);
 
 		pci_unmap_single(cp->pdev, cp->tx_skb[tx_tail].mapping,
 				 cp->tx_skb[tx_tail].len, PCI_DMA_TODEVICE);
@@ -1550,8 +1548,7 @@ static void cp_get_ethtool_stats (struct
 	tmp_stats[i++] = le16_to_cpu(nic_stats->tx_abort);
 	tmp_stats[i++] = le16_to_cpu(nic_stats->tx_underrun);
 	tmp_stats[i++] = cp->cp_stats.rx_frags;
-	if (i != CP_NUM_STATS)
-		BUG();
+	BUG_ON(i != CP_NUM_STATS);
 
 	pci_free_consistent(cp->pdev, sizeof(*nic_stats), nic_stats, dma);
 }
@@ -1856,8 +1853,7 @@ static void cp_remove_one (struct pci_de
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct cp_private *cp = netdev_priv(dev);
 
-	if (!dev)
-		BUG();
+	BUG_ON(!dev);
 	unregister_netdev(dev);
 	iounmap(cp->regs);
 	if (cp->wol_enabled) pci_set_power_state (pdev, PCI_D0);
diff --git a/drivers/net/arcnet/arcnet.c b/drivers/net/arcnet/arcnet.c
index 64e2caf..fabc060 100644
--- a/drivers/net/arcnet/arcnet.c
+++ b/drivers/net/arcnet/arcnet.c
@@ -765,8 +765,7 @@ irqreturn_t arcnet_interrupt(int irq, vo
 	BUGMSG(D_DURING, "in arcnet_interrupt\n");
 	
 	lp = dev->priv;
-	if (!lp)
-		BUG();
+	BUG_ON(!lp);
 		
 	spin_lock(&lp->lock);
 
diff --git a/drivers/net/b44.c b/drivers/net/b44.c
index 15032f2..c4e12b5 100644
--- a/drivers/net/b44.c
+++ b/drivers/net/b44.c
@@ -608,8 +608,7 @@ static void b44_tx(struct b44 *bp)
 		struct ring_info *rp = &bp->tx_buffers[cons];
 		struct sk_buff *skb = rp->skb;
 
-		if (unlikely(skb == NULL))
-			BUG();
+		BUG_ON(skb == NULL);
 
 		pci_unmap_single(bp->pdev,
 				 pci_unmap_addr(rp, mapping),
diff --git a/drivers/net/chelsio/sge.c b/drivers/net/chelsio/sge.c
index 30ff8ea..4391bf4 100644
--- a/drivers/net/chelsio/sge.c
+++ b/drivers/net/chelsio/sge.c
@@ -1093,8 +1093,7 @@ static int process_responses(struct adap
 		if (likely(e->DataValid)) {
 			struct freelQ *fl = &sge->freelQ[e->FreelistQid];
 
-			if (unlikely(!e->Sop || !e->Eop))
-				BUG();
+			BUG_ON(!e->Sop || !e->Eop);
 			if (unlikely(e->Offload))
 				unexpected_offload(adapter, fl);
 			else
diff --git a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
index 49cd096..add8dc4 100644
--- a/drivers/net/e1000/e1000_main.c
+++ b/drivers/net/e1000/e1000_main.c
@@ -3308,8 +3308,7 @@ e1000_clean(struct net_device *poll_dev,
 
 	while (poll_dev != &adapter->polling_netdev[i]) {
 		i++;
-		if (unlikely(i == adapter->num_rx_queues))
-			BUG();
+		BUG_ON(i == adapter->num_rx_queues);
 	}
 
 	if (likely(adapter->num_tx_queues == 1)) {
diff --git a/drivers/net/eql.c b/drivers/net/eql.c
index aa15691..815436c 100644
--- a/drivers/net/eql.c
+++ b/drivers/net/eql.c
@@ -203,8 +203,7 @@ static int eql_open(struct net_device *d
 	printk(KERN_INFO "%s: remember to turn off Van-Jacobson compression on "
 	       "your slave devices.\n", dev->name);
 
-	if (!list_empty(&eql->queue.all_slaves))
-		BUG();
+	BUG_ON(!list_empty(&eql->queue.all_slaves));
 
 	eql->min_slaves = 1;
 	eql->max_slaves = EQL_DEFAULT_MAX_SLAVES; /* 4 usually... */
diff --git a/drivers/net/irda/sa1100_ir.c b/drivers/net/irda/sa1100_ir.c
index 63d38fb..f530686 100644
--- a/drivers/net/irda/sa1100_ir.c
+++ b/drivers/net/irda/sa1100_ir.c
@@ -695,8 +695,7 @@ static int sa1100_irda_hard_xmit(struct 
 		/*
 		 * We must not be transmitting...
 		 */
-		if (si->txskb)
-			BUG();
+		BUG_ON(si->txskb);
 
 		netif_stop_queue(dev);
 
diff --git a/drivers/net/ne2k-pci.c b/drivers/net/ne2k-pci.c
index d11821d..ced9fdb 100644
--- a/drivers/net/ne2k-pci.c
+++ b/drivers/net/ne2k-pci.c
@@ -645,9 +645,7 @@ static void __devexit ne2k_pci_remove_on
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 
-	if (!dev)
-		BUG();
-
+	BUG_ON(!dev);
 	unregister_netdev(dev);
 	release_region(dev->base_addr, NE_IO_EXTENT);
 	free_netdev(dev);
diff --git a/drivers/net/ns83820.c b/drivers/net/ns83820.c
index 8e9b1a5..706aed7 100644
--- a/drivers/net/ns83820.c
+++ b/drivers/net/ns83820.c
@@ -568,8 +568,7 @@ static inline int ns83820_add_rx_skb(str
 #endif
 
 	sg = dev->rx_info.descs + (next_empty * DESC_SIZE);
-	if (unlikely(NULL != dev->rx_info.skbs[next_empty]))
-		BUG();
+	BUG_ON(NULL != dev->rx_info.skbs[next_empty]);
 	dev->rx_info.skbs[next_empty] = skb;
 
 	dev->rx_info.next_empty = (next_empty + 1) % NR_RX_DESC;
diff --git a/drivers/net/starfire.c b/drivers/net/starfire.c
index 35b1805..45ad036 100644
--- a/drivers/net/starfire.c
+++ b/drivers/net/starfire.c
@@ -2122,8 +2122,7 @@ static void __devexit starfire_remove_on
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct netdev_private *np = netdev_priv(dev);
 
-	if (!dev)
-		BUG();
+	BUG_ON(!dev);
 
 	unregister_netdev(dev);
 
diff --git a/drivers/net/tg3.c b/drivers/net/tg3.c
index 964c096..46f55fb 100644
--- a/drivers/net/tg3.c
+++ b/drivers/net/tg3.c
@@ -2966,9 +2966,7 @@ static void tg3_tx(struct tg3 *tp)
 		struct sk_buff *skb = ri->skb;
 		int i;
 
-		if (unlikely(skb == NULL))
-			BUG();
-
+		BUG_ON(skb == NULL);
 		pci_unmap_single(tp->pdev,
 				 pci_unmap_addr(ri, mapping),
 				 skb_headlen(skb),
@@ -2979,12 +2977,10 @@ static void tg3_tx(struct tg3 *tp)
 		sw_idx = NEXT_TX(sw_idx);
 
 		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
-			if (unlikely(sw_idx == hw_idx))
-				BUG();
+			BUG_ON(sw_idx == hw_idx);
 
 			ri = &tp->tx_buffers[sw_idx];
-			if (unlikely(ri->skb != NULL))
-				BUG();
+			BUG_ON(ri->skb != NULL);
 
 			pci_unmap_page(tp->pdev,
 				       pci_unmap_addr(ri, mapping),
@@ -4935,9 +4931,8 @@ static int tg3_halt_cpu(struct tg3 *tp, 
 {
 	int i;
 
-	if (offset == TX_CPU_BASE &&
-	    (tp->tg3_flags2 & TG3_FLG2_5705_PLUS))
-		BUG();
+	BUG_ON(offset == TX_CPU_BASE &&
+	    (tp->tg3_flags2 & TG3_FLG2_5705_PLUS));
 
 	if (offset == RX_CPU_BASE) {
 		for (i = 0; i < 10000; i++) {
diff --git a/drivers/net/tokenring/abyss.c b/drivers/net/tokenring/abyss.c
index 9345e68..649d8ea 100644
--- a/drivers/net/tokenring/abyss.c
+++ b/drivers/net/tokenring/abyss.c
@@ -438,8 +438,7 @@ static void __devexit abyss_detach (stru
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	
-	if (!dev)
-		BUG();
+	BUG_ON(!dev);
 	unregister_netdev(dev);
 	release_region(dev->base_addr-0x10, ABYSS_IO_EXTENT);
 	free_irq(dev->irq, dev);
diff --git a/drivers/net/tokenring/madgemc.c b/drivers/net/tokenring/madgemc.c
index 3a25d19..19e6f4d 100644
--- a/drivers/net/tokenring/madgemc.c
+++ b/drivers/net/tokenring/madgemc.c
@@ -735,8 +735,7 @@ static int __devexit madgemc_remove(stru
 	struct net_local *tp;
         struct card_info *card;
 
-	if (!dev)
-		BUG();
+	BUG_ON(!dev);
 
 	tp = dev->priv;
 	card = tp->tmspriv;
diff --git a/drivers/net/wireless/ipw2200.c b/drivers/net/wireless/ipw2200.c
index 9dce522..bca89cf 100644
--- a/drivers/net/wireless/ipw2200.c
+++ b/drivers/net/wireless/ipw2200.c
@@ -5573,8 +5573,7 @@ static void ipw_adhoc_create(struct ipw_
 	case IEEE80211_52GHZ_BAND:
 		network->mode = IEEE_A;
 		i = ieee80211_channel_to_index(priv->ieee, priv->channel);
-		if (i == -1)
-			BUG();
+		BUG_ON(i == -1);
 		if (geo->a[i].flags & IEEE80211_CH_PASSIVE_ONLY) {
 			IPW_WARNING("Overriding invalid channel\n");
 			priv->channel = geo->a[0].channel;
@@ -5587,8 +5586,7 @@ static void ipw_adhoc_create(struct ipw_
 		else
 			network->mode = IEEE_B;
 		i = ieee80211_channel_to_index(priv->ieee, priv->channel);
-		if (i == -1)
-			BUG();
+		BUG_ON(i == -1);
 		if (geo->bg[i].flags & IEEE80211_CH_PASSIVE_ONLY) {
 			IPW_WARNING("Overriding invalid channel\n");
 			priv->channel = geo->bg[0].channel;
@@ -6715,8 +6713,7 @@ static int ipw_qos_association(struct ip
 
 	switch (priv->ieee->iw_mode) {
 	case IW_MODE_ADHOC:
-		if (!(network->capability & WLAN_CAPABILITY_IBSS))
-			BUG();
+		BUG_ON(!(network->capability & WLAN_CAPABILITY_IBSS));
 
 		qos_data = &ibss_data;
 		break;
diff --git a/drivers/net/yellowfin.c b/drivers/net/yellowfin.c
index 75d56bf..fd0f43b 100644
--- a/drivers/net/yellowfin.c
+++ b/drivers/net/yellowfin.c
@@ -1441,8 +1441,7 @@ static void __devexit yellowfin_remove_o
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct yellowfin_private *np;
 
-	if (!dev)
-		BUG();
+	BUG_ON(!dev);
 	np = netdev_priv(dev);
 
         pci_free_consistent(pdev, STATUS_TOTAL_SIZE, np->tx_status, 
diff --git a/drivers/s390/block/dasd_erp.c b/drivers/s390/block/dasd_erp.c
index 8fd71ab..b842377 100644
--- a/drivers/s390/block/dasd_erp.c
+++ b/drivers/s390/block/dasd_erp.c
@@ -32,9 +32,8 @@ dasd_alloc_erp_request(char *magic, int 
 	int size;
 
 	/* Sanity checks */
-	if ( magic == NULL || datasize > PAGE_SIZE ||
-	     (cplength*sizeof(struct ccw1)) > PAGE_SIZE)
-		BUG();
+	BUG_ON( magic == NULL || datasize > PAGE_SIZE ||
+	     (cplength*sizeof(struct ccw1)) > PAGE_SIZE);
 
 	size = (sizeof(struct dasd_ccw_req) + 7L) & -8L;
 	if (cplength > 0)
@@ -125,8 +124,7 @@ dasd_default_erp_postaction(struct dasd_
 	struct dasd_device *device;
 	int success;
 
-	if (cqr->refers == NULL || cqr->function == NULL)
-		BUG();
+	BUG_ON(cqr->refers == NULL || cqr->function == NULL);
 
 	device = cqr->device;
 	success = cqr->status == DASD_CQR_DONE;
diff --git a/drivers/s390/char/sclp_rw.c b/drivers/s390/char/sclp_rw.c
index ac10dfb..91e93c7 100644
--- a/drivers/s390/char/sclp_rw.c
+++ b/drivers/s390/char/sclp_rw.c
@@ -24,7 +24,7 @@
 
 /*
  * The room for the SCCB (only for writing) is not equal to a pages size
- * (as it is specified as the maximum size in the the SCLP ducumentation)
+ * (as it is specified as the maximum size in the the SCLP documentation)
  * because of the additional data structure described above.
  */
 #define MAX_SCCB_ROOM (PAGE_SIZE - sizeof(struct sclp_buffer))
diff --git a/drivers/s390/char/tape_block.c b/drivers/s390/char/tape_block.c
index 5ced272..5c65cf3 100644
--- a/drivers/s390/char/tape_block.c
+++ b/drivers/s390/char/tape_block.c
@@ -198,9 +198,7 @@ tapeblock_request_fn(request_queue_t *qu
 
 	device = (struct tape_device *) queue->queuedata;
 	DBF_LH(6, "tapeblock_request_fn(device=%p)\n", device);
-	if (device == NULL)
-		BUG();
-
+	BUG_ON(device == NULL);
 	tapeblock_trigger_requeue(device);
 }
 
@@ -307,8 +305,7 @@ tapeblock_revalidate_disk(struct gendisk
 	int			rc;
 
 	device = (struct tape_device *) disk->private_data;
-	if (!device)
-		BUG();
+	BUG_ON(!device);
 
 	if (!device->blk_data.medium_changed)
 		return 0;
@@ -440,11 +437,9 @@ tapeblock_ioctl(
 
 	rc     = 0;
 	disk   = inode->i_bdev->bd_disk;
-	if (!disk)
-		BUG();
+	BUG_ON(!disk);
 	device = disk->private_data;
-	if (!device)
-		BUG();
+	BUG_ON(!device);
 	minor  = iminor(inode);
 
 	DBF_LH(6, "tapeblock_ioctl(0x%0x)\n", command);
diff --git a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
index edcf05d..5d6b7a5 100644
--- a/drivers/s390/net/lcs.c
+++ b/drivers/s390/net/lcs.c
@@ -675,9 +675,8 @@ lcs_ready_buffer(struct lcs_channel *cha
 	int index, rc;
 
 	LCS_DBF_TEXT(5, trace, "rdybuff");
-	if (buffer->state != BUF_STATE_LOCKED &&
-	    buffer->state != BUF_STATE_PROCESSED)
-		BUG();
+	BUG_ON(buffer->state != BUF_STATE_LOCKED &&
+		buffer->state != BUF_STATE_PROCESSED);
 	spin_lock_irqsave(get_ccwdev_lock(channel->ccwdev), flags);
 	buffer->state = BUF_STATE_READY;
 	index = buffer - channel->iob;
@@ -701,8 +700,7 @@ __lcs_processed_buffer(struct lcs_channe
 	int index, prev, next;
 
 	LCS_DBF_TEXT(5, trace, "prcsbuff");
-	if (buffer->state != BUF_STATE_READY)
-		BUG();
+	BUG_ON(buffer->state != BUF_STATE_READY);
 	buffer->state = BUF_STATE_PROCESSED;
 	index = buffer - channel->iob;
 	prev = (index - 1) & (LCS_NUM_BUFFS - 1);
@@ -734,9 +732,8 @@ lcs_release_buffer(struct lcs_channel *c
 	unsigned long flags;
 
 	LCS_DBF_TEXT(5, trace, "relbuff");
-	if (buffer->state != BUF_STATE_LOCKED &&
-	    buffer->state != BUF_STATE_PROCESSED)
-		BUG();
+	BUG_ON(buffer->state != BUF_STATE_LOCKED &&
+		buffer->state != BUF_STATE_PROCESSED);
 	spin_lock_irqsave(get_ccwdev_lock(channel->ccwdev), flags);
 	buffer->state = BUF_STATE_EMPTY;
 	spin_unlock_irqrestore(get_ccwdev_lock(channel->ccwdev), flags);
diff --git a/drivers/scsi/aic7xxx/Kconfig.aic7xxx b/drivers/scsi/aic7xxx/Kconfig.aic7xxx
index 6c2c395..5517da5 100644
--- a/drivers/scsi/aic7xxx/Kconfig.aic7xxx
+++ b/drivers/scsi/aic7xxx/Kconfig.aic7xxx
@@ -86,7 +86,7 @@ config AIC7XXX_DEBUG_MASK
         default "0"
         help
 	Bit mask of debug options that is only valid if the
-	CONFIG_AIC7XXX_DEBUG_ENBLE option is enabled.  The bits in this mask
+	CONFIG_AIC7XXX_DEBUG_ENABLE option is enabled.  The bits in this mask
 	are defined in the drivers/scsi/aic7xxx/aic7xxx.h - search for the
 	variable ahc_debug in that file to find them.
 
diff --git a/drivers/serial/jsm/jsm.h b/drivers/serial/jsm/jsm.h
index dfc1e86..043f50b 100644
--- a/drivers/serial/jsm/jsm.h
+++ b/drivers/serial/jsm/jsm.h
@@ -20,7 +20,7 @@
  *
  * Contact Information:
  * Scott H Kilau <Scott_Kilau@digi.com>
- * Wendy Xiong   <wendyx@us.ltcfwd.linux.ibm.com>
+ * Wendy Xiong   <wendyx@us.ibm.com>
  *
  ***********************************************************************/
 
diff --git a/drivers/serial/jsm/jsm_driver.c b/drivers/serial/jsm/jsm_driver.c
index b1b66e7..b3e1f71 100644
--- a/drivers/serial/jsm/jsm_driver.c
+++ b/drivers/serial/jsm/jsm_driver.c
@@ -20,7 +20,7 @@
  *
  * Contact Information:
  * Scott H Kilau <Scott_Kilau@digi.com>
- * Wendy Xiong   <wendyx@us.ltcfwd.linux.ibm.com>
+ * Wendy Xiong   <wendyx@us.ibm.com>
  *
  *
  ***********************************************************************/
diff --git a/drivers/serial/jsm/jsm_neo.c b/drivers/serial/jsm/jsm_neo.c
index 87e4e2c..a5fc589 100644
--- a/drivers/serial/jsm/jsm_neo.c
+++ b/drivers/serial/jsm/jsm_neo.c
@@ -20,7 +20,7 @@
  *
  * Contact Information:
  * Scott H Kilau <Scott_Kilau@digi.com>
- * Wendy Xiong   <wendyx@us.ltcfwd.linux.ibm.com>
+ * Wendy Xiong   <wendyx@us.ibm.com>
  *
  ***********************************************************************/
 #include <linux/delay.h>	/* For udelay */
diff --git a/fs/direct-io.c b/fs/direct-io.c
index 910a8ed..b05d1b2 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -929,8 +929,7 @@ do_holes:
 			block_in_page += this_chunk_blocks;
 			dio->blocks_available -= this_chunk_blocks;
 next_block:
-			if (dio->block_in_file > dio->final_block_in_request)
-				BUG();
+			BUG_ON(dio->block_in_file > dio->final_block_in_request);
 			if (dio->block_in_file == dio->final_block_in_request)
 				break;
 		}
diff --git a/fs/dquot.c b/fs/dquot.c
index 6b38869..81d87a4 100644
--- a/fs/dquot.c
+++ b/fs/dquot.c
@@ -590,8 +590,7 @@ we_slept:
 	atomic_dec(&dquot->dq_count);
 #ifdef __DQUOT_PARANOIA
 	/* sanity check */
-	if (!list_empty(&dquot->dq_free))
-		BUG();
+	BUG_ON(!list_empty(&dquot->dq_free));
 #endif
 	put_dquot_last(dquot);
 	spin_unlock(&dq_list_lock);
@@ -666,8 +665,7 @@ we_slept:
 		return NODQUOT;
 	}
 #ifdef __DQUOT_PARANOIA
-	if (!dquot->dq_sb)	/* Has somebody invalidated entry under us? */
-		BUG();
+	BUG_ON(!dquot->dq_sb);	/* Has somebody invalidated entry under us? */
 #endif
 
 	return dquot;
diff --git a/fs/exec.c b/fs/exec.c
index 950ebd4..0291a68 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -561,7 +561,7 @@ static int exec_mmap(struct mm_struct *m
 	arch_pick_mmap_layout(mm);
 	if (old_mm) {
 		up_read(&old_mm->mmap_sem);
-		if (active_mm != old_mm) BUG();
+		BUG_ON(active_mm != old_mm);
 		mmput(old_mm);
 		return 0;
 	}
diff --git a/fs/fcntl.c b/fs/fcntl.c
index 2a24791..d35cbc6 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -453,8 +453,7 @@ static void send_sigio_to_task(struct ta
 			/* Make sure we are called with one of the POLL_*
 			   reasons, otherwise we could leak kernel stack into
 			   userspace.  */
-			if ((reason & __SI_MASK) != __SI_POLL)
-				BUG();
+			BUG_ON((reason & __SI_MASK) != __SI_POLL);
 			if (reason - POLL_IN >= NSIGPOLL)
 				si.si_band  = ~0L;
 			else
diff --git a/fs/freevxfs/vxfs_olt.c b/fs/freevxfs/vxfs_olt.c
index 76a0708..0495008 100644
--- a/fs/freevxfs/vxfs_olt.c
+++ b/fs/freevxfs/vxfs_olt.c
@@ -42,24 +42,21 @@
 static inline void
 vxfs_get_fshead(struct vxfs_oltfshead *fshp, struct vxfs_sb_info *infp)
 {
-	if (infp->vsi_fshino)
-		BUG();
+	BUG_ON(infp->vsi_fshino);
 	infp->vsi_fshino = fshp->olt_fsino[0];
 }
 
 static inline void
 vxfs_get_ilist(struct vxfs_oltilist *ilistp, struct vxfs_sb_info *infp)
 {
-	if (infp->vsi_iext)
-		BUG();
+	BUG_ON(infp->vsi_iext);
 	infp->vsi_iext = ilistp->olt_iext[0]; 
 }
 
 static inline u_long
 vxfs_oblock(struct super_block *sbp, daddr_t block, u_long bsize)
 {
-	if (sbp->s_blocksize % bsize)
-		BUG();
+	BUG_ON(sbp->s_blocksize % bsize);
 	return (block * (sbp->s_blocksize / bsize));
 }
 
diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index 8f07e8f..746abc9 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -466,8 +466,7 @@ void hfs_bnode_unhash(struct hfs_bnode *
 	for (p = &node->tree->node_hash[hfs_bnode_hash(node->this)];
 	     *p && *p != node; p = &(*p)->next_hash)
 		;
-	if (!*p)
-		BUG();
+	BUG_ON(!*p);
 	*p = node->next_hash;
 	node->tree->node_hash_cnt--;
 }
@@ -622,8 +621,7 @@ void hfs_bnode_put(struct hfs_bnode *nod
 
 		dprint(DBG_BNODE_REFS, "put_node(%d:%d): %d\n",
 		       node->tree->cnid, node->this, atomic_read(&node->refcnt));
-		if (!atomic_read(&node->refcnt))
-			BUG();
+		BUG_ON(!atomic_read(&node->refcnt));
 		if (!atomic_dec_and_lock(&node->refcnt, &tree->hash_lock))
 			return;
 		for (i = 0; i < tree->pages_per_bnode; i++) {
diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index a67edfa..effa899 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -269,8 +269,7 @@ void hfs_bmap_free(struct hfs_bnode *nod
 	u8 *data, byte, m;
 
 	dprint(DBG_BNODE_MOD, "btree_free_node: %u\n", node->this);
-	if (!node->this)
-		BUG();
+	BUG_ON(!node->this);
 	tree = node->tree;
 	nidx = node->this;
 	node = hfs_bnode_find(tree, 0);
diff --git a/fs/inode.c b/fs/inode.c
index 32b7c33..3a2446a 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -172,8 +172,7 @@ static struct inode *alloc_inode(struct 
 
 void destroy_inode(struct inode *inode) 
 {
-	if (inode_has_buffers(inode))
-		BUG();
+	BUG_ON(inode_has_buffers(inode));
 	security_inode_free(inode);
 	if (inode->i_sb->s_op->destroy_inode)
 		inode->i_sb->s_op->destroy_inode(inode);
@@ -249,12 +248,9 @@ void clear_inode(struct inode *inode)
 	might_sleep();
 	invalidate_inode_buffers(inode);
        
-	if (inode->i_data.nrpages)
-		BUG();
-	if (!(inode->i_state & I_FREEING))
-		BUG();
-	if (inode->i_state & I_CLEAR)
-		BUG();
+	BUG_ON(inode->i_data.nrpages);
+	BUG_ON(!(inode->i_state & I_FREEING));
+	BUG_ON(inode->i_state & I_CLEAR);
 	wait_on_inode(inode);
 	DQUOT_DROP(inode);
 	if (inode->i_sb && inode->i_sb->s_op->clear_inode)
@@ -1054,8 +1050,7 @@ void generic_delete_inode(struct inode *
 	hlist_del_init(&inode->i_hash);
 	spin_unlock(&inode_lock);
 	wake_up_inode(inode);
-	if (inode->i_state != I_CLEAR)
-		BUG();
+	BUG_ON(inode->i_state != I_CLEAR);
 	destroy_inode(inode);
 }
 
diff --git a/fs/jffs2/background.c b/fs/jffs2/background.c
index 7b77a95..ff2a872 100644
--- a/fs/jffs2/background.c
+++ b/fs/jffs2/background.c
@@ -35,8 +35,7 @@ int jffs2_start_garbage_collect_thread(s
 	pid_t pid;
 	int ret = 0;
 
-	if (c->gc_task)
-		BUG();
+	BUG_ON(c->gc_task);
 
 	init_completion(&c->gc_thread_start);
 	init_completion(&c->gc_thread_exit);
diff --git a/fs/smbfs/file.c b/fs/smbfs/file.c
index c56bd99..ed9a24d 100644
--- a/fs/smbfs/file.c
+++ b/fs/smbfs/file.c
@@ -178,11 +178,9 @@ smb_writepage(struct page *page, struct 
 	unsigned offset = PAGE_CACHE_SIZE;
 	int err;
 
-	if (!mapping)
-		BUG();
+	BUG_ON(!mapping);
 	inode = mapping->host;
-	if (!inode)
-		BUG();
+	BUG_ON(!inode);
 
 	end_index = inode->i_size >> PAGE_CACHE_SHIFT;
 
diff --git a/fs/sysfs/dir.c b/fs/sysfs/dir.c
index f26880a..6cfdc9a 100644
--- a/fs/sysfs/dir.c
+++ b/fs/sysfs/dir.c
@@ -50,7 +50,7 @@ static struct sysfs_dirent * sysfs_new_d
 	return sd;
 }
 
-/**
+/*
  *
  * Return -EEXIST if there is already a sysfs element with the same name for
  * the same parent.
diff --git a/fs/sysfs/inode.c b/fs/sysfs/inode.c
index 4c29ac4..f0b347b 100644
--- a/fs/sysfs/inode.c
+++ b/fs/sysfs/inode.c
@@ -175,8 +175,7 @@ const unsigned char * sysfs_get_name(str
 	struct bin_attribute * bin_attr;
 	struct sysfs_symlink  * sl;
 
-	if (!sd || !sd->s_element)
-		BUG();
+	BUG_ON(!sd || !sd->s_element);
 
 	switch (sd->s_type) {
 		case SYSFS_DIR:
diff --git a/fs/sysv/dir.c b/fs/sysv/dir.c
index 8c66e92..d707434 100644
--- a/fs/sysv/dir.c
+++ b/fs/sysv/dir.c
@@ -253,8 +253,7 @@ int sysv_delete_entry(struct sysv_dir_en
 
 	lock_page(page);
 	err = mapping->a_ops->prepare_write(NULL, page, from, to);
-	if (err)
-		BUG();
+	BUG_ON(err);
 	de->inode = 0;
 	err = dir_commit_chunk(page, from, to);
 	dir_put_page(page);
@@ -353,8 +352,7 @@ void sysv_set_link(struct sysv_dir_entry
 
 	lock_page(page);
 	err = page->mapping->a_ops->prepare_write(NULL, page, from, to);
-	if (err)
-		BUG();
+	BUG_ON(err);
 	de->inode = cpu_to_fs16(SYSV_SB(inode->i_sb), inode->i_ino);
 	err = dir_commit_chunk(page, from, to);
 	dir_put_page(page);
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 81e0e84..2983afd 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -312,12 +312,10 @@ static int udf_get_block(struct inode *i
 	err = 0;
 
 	bh = inode_getblk(inode, block, &err, &phys, &new);
-	if (bh)
-		BUG();
+	BUG_ON(bh);
 	if (err)
 		goto abort;
-	if (!phys)
-		BUG();
+	BUG_ON(!phys);
 
 	if (new)
 		set_buffer_new(bh_result);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4ed7e60..1e9ebab 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -864,7 +864,7 @@ struct super_block {
 	 */
 	struct mutex s_vfs_rename_mutex;	/* Kludge */
 
-	/* Granuality of c/m/atime in ns.
+	/* Granularity of c/m/atime in ns.
 	   Cannot be worse than a second */
 	u32		   s_time_gran;
 };
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index b209392..306acf1 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -80,7 +80,7 @@ struct hrtimer_sleeper {
  * @first:		pointer to the timer node which expires first
  * @resolution:		the resolution of the clock, in nanoseconds
  * @get_time:		function to retrieve the current time of the clock
- * @get_sofirq_time:	function to retrieve the current time from the softirq
+ * @get_softirq_time:	function to retrieve the current time from the softirq
  * @curr_timer:		the timer which is executing a callback right now
  * @softirq_time:	the time when running the hrtimer queue in the softirq
  */
diff --git a/ipc/shm.c b/ipc/shm.c
index f806a2e..6b0c9af 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -91,8 +91,8 @@ static inline int shm_addid(struct shmid
 static inline void shm_inc (int id) {
 	struct shmid_kernel *shp;
 
-	if(!(shp = shm_lock(id)))
-		BUG();
+	shp = shm_lock(id);
+	BUG_ON(!shp);
 	shp->shm_atim = get_seconds();
 	shp->shm_lprid = current->tgid;
 	shp->shm_nattch++;
@@ -142,8 +142,8 @@ static void shm_close (struct vm_area_st
 
 	mutex_lock(&shm_ids.mutex);
 	/* remove from the list of attaches of the shm segment */
-	if(!(shp = shm_lock(id)))
-		BUG();
+	shp = shm_lock(id);
+	BUG_ON(!shp);
 	shp->shm_lprid = current->tgid;
 	shp->shm_dtim = get_seconds();
 	shp->shm_nattch--;
@@ -283,8 +283,7 @@ asmlinkage long sys_shmget (key_t key, s
 		err = -EEXIST;
 	} else {
 		shp = shm_lock(id);
-		if(shp==NULL)
-			BUG();
+		BUG_ON(shp==NULL);
 		if (shp->shm_segsz < size)
 			err = -EINVAL;
 		else if (ipcperms(&shp->shm_perm, shmflg))
@@ -774,8 +773,8 @@ invalid:
 	up_write(&current->mm->mmap_sem);
 
 	mutex_lock(&shm_ids.mutex);
-	if(!(shp = shm_lock(shmid)))
-		BUG();
+	shp = shm_lock(shmid);
+	BUG_ON(!shp);
 	shp->shm_nattch--;
 	if(shp->shm_nattch == 0 &&
 	   shp->shm_perm.mode & SHM_DEST)
diff --git a/ipc/util.c b/ipc/util.c
index 23151ef..5e785a2 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -266,8 +266,7 @@ struct kern_ipc_perm* ipc_rmid(struct ip
 {
 	struct kern_ipc_perm* p;
 	int lid = id % SEQ_MULTIPLIER;
-	if(lid >= ids->entries->size)
-		BUG();
+	BUG_ON(lid >= ids->entries->size);
 
 	/* 
 	 * do not need a rcu_dereference()() here to force ordering
@@ -275,8 +274,7 @@ struct kern_ipc_perm* ipc_rmid(struct ip
 	 */	
 	p = ids->entries->p[lid];
 	ids->entries->p[lid] = NULL;
-	if(p==NULL)
-		BUG();
+	BUG_ON(p==NULL);
 	ids->in_use--;
 
 	if (lid == ids->max_id) {
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 9fd8d4f..ce0dfb8 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -41,7 +41,7 @@ config SOFTWARE_SUSPEND
 	depends on PM && SWAP && (X86 && (!SMP || SUSPEND_SMP)) || ((FRV || PPC32) && !SMP)
 	---help---
 	  Enable the possibility of suspending the machine.
-	  It doesn't need APM.
+	  It doesn't need ACPI or APM.
 	  You may suspend your machine by 'swsusp' or 'shutdown -z <time>' 
 	  (patch for sysvinit needed). 
 
diff --git a/kernel/printk.c b/kernel/printk.c
index 8cc1943..c056f33 100644
--- a/kernel/printk.c
+++ b/kernel/printk.c
@@ -360,8 +360,7 @@ static void call_console_drivers(unsigne
 	unsigned long cur_index, start_print;
 	static int msg_level = -1;
 
-	if (((long)(start - end)) > 0)
-		BUG();
+	BUG_ON(((long)(start - end)) > 0);
 
 	cur_index = start;
 	start_print = start;
@@ -708,8 +707,7 @@ int __init add_preferred_console(char *n
  */
 void acquire_console_sem(void)
 {
-	if (in_interrupt())
-		BUG();
+	BUG_ON(in_interrupt());
 	down(&console_sem);
 	console_locked = 1;
 	console_may_schedule = 1;
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 86a7f6c..0eeb7e6 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -30,8 +30,7 @@
  */
 void __ptrace_link(task_t *child, task_t *new_parent)
 {
-	if (!list_empty(&child->ptrace_list))
-		BUG();
+	BUG_ON(!list_empty(&child->ptrace_list));
 	if (child->parent == new_parent)
 		return;
 	list_add(&child->ptrace_list, &child->parent->ptrace_children);
diff --git a/kernel/signal.c b/kernel/signal.c
index 92025b1..5ccaac5 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -769,8 +769,7 @@ specific_send_sig_info(int sig, struct s
 {
 	int ret = 0;
 
-	if (!irqs_disabled())
-		BUG();
+	BUG_ON(!irqs_disabled());
 	assert_spin_locked(&t->sighand->siglock);
 
 	/* Short-circuit ignored signals.  */
@@ -1384,8 +1383,7 @@ send_group_sigqueue(int sig, struct sigq
 		 * the overrun count.  Other uses should not try to
 		 * send the signal multiple times.
 		 */
-		if (q->info.si_code != SI_TIMER)
-			BUG();
+		BUG_ON(q->info.si_code != SI_TIMER);
 		q->info.si_overrun++;
 		goto out;
 	} 
diff --git a/kernel/time.c b/kernel/time.c
index ff8e701..b00ddc7 100644
--- a/kernel/time.c
+++ b/kernel/time.c
@@ -410,7 +410,7 @@ EXPORT_SYMBOL(current_kernel_time);
  * current_fs_time - Return FS time
  * @sb: Superblock.
  *
- * Return the current time truncated to the time granuality supported by
+ * Return the current time truncated to the time granularity supported by
  * the fs.
  */
 struct timespec current_fs_time(struct super_block *sb)
@@ -421,11 +421,11 @@ struct timespec current_fs_time(struct s
 EXPORT_SYMBOL(current_fs_time);
 
 /**
- * timespec_trunc - Truncate timespec to a granuality
+ * timespec_trunc - Truncate timespec to a granularity
  * @t: Timespec
- * @gran: Granuality in ns.
+ * @gran: Granularity in ns.
  *
- * Truncate a timespec to a granuality. gran must be smaller than a second.
+ * Truncate a timespec to a granularity. gran must be smaller than a second.
  * Always rounds down.
  *
  * This function should be only used for timestamps returned by
diff --git a/kernel/timer.c b/kernel/timer.c
index 6b812c0..c3a874f 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -1479,8 +1479,7 @@ register_time_interpolator(struct time_i
 	unsigned long flags;
 
 	/* Sanity check */
-	if (ti->frequency == 0 || ti->mask == 0)
-		BUG();
+	BUG_ON(ti->frequency == 0 || ti->mask == 0);
 
 	ti->nsec_per_cyc = ((u64)NSEC_PER_SEC << ti->shift) / ti->frequency;
 	spin_lock(&time_interpolator_lock);
diff --git a/mm/highmem.c b/mm/highmem.c
index 55885f6..9b274fd 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -74,8 +74,7 @@ static void flush_all_zero_pkmaps(void)
 		pkmap_count[i] = 0;
 
 		/* sanity check */
-		if (pte_none(pkmap_page_table[i]))
-			BUG();
+		BUG_ON(pte_none(pkmap_page_table[i]));
 
 		/*
 		 * Don't need an atomic fetch-and-clear op here;
@@ -158,8 +157,7 @@ void fastcall *kmap_high(struct page *pa
 	if (!vaddr)
 		vaddr = map_new_virtual(page);
 	pkmap_count[PKMAP_NR(vaddr)]++;
-	if (pkmap_count[PKMAP_NR(vaddr)] < 2)
-		BUG();
+	BUG_ON(pkmap_count[PKMAP_NR(vaddr)] < 2);
 	spin_unlock(&kmap_lock);
 	return (void*) vaddr;
 }
@@ -174,8 +172,7 @@ void fastcall kunmap_high(struct page *p
 
 	spin_lock(&kmap_lock);
 	vaddr = (unsigned long)page_address(page);
-	if (!vaddr)
-		BUG();
+	BUG_ON(!vaddr);
 	nr = PKMAP_NR(vaddr);
 
 	/*
@@ -220,8 +217,7 @@ static __init int init_emergency_pool(vo
 		return 0;
 
 	page_pool = mempool_create_page_pool(POOL_SIZE, 0);
-	if (!page_pool)
-		BUG();
+	BUG_ON(!page_pool);
 	printk("highmem bounce pool size: %d pages\n", POOL_SIZE);
 
 	return 0;
@@ -264,8 +260,7 @@ int init_emergency_isa_pool(void)
 
 	isa_page_pool = mempool_create(ISA_POOL_SIZE, mempool_alloc_pages_isa,
 				       mempool_free_pages, (void *) 0);
-	if (!isa_page_pool)
-		BUG();
+	BUG_ON(!isa_page_pool);
 
 	printk("isa bounce pool size: %d pages\n", ISA_POOL_SIZE);
 	return 0;
diff --git a/mm/mmap.c b/mm/mmap.c
index 4f5b570..e780d19 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -294,8 +294,7 @@ void validate_mm(struct mm_struct *mm)
 	i = browse_rb(&mm->mm_rb);
 	if (i != mm->map_count)
 		printk("map_count %d rb %d\n", mm->map_count, i), bug = 1;
-	if (bug)
-		BUG();
+	BUG_ON(bug);
 }
 #else
 #define validate_mm(mm) do { } while (0)
@@ -432,8 +431,7 @@ __insert_vm_struct(struct mm_struct * mm
 	struct rb_node ** rb_link, * rb_parent;
 
 	__vma = find_vma_prepare(mm, vma->vm_start,&prev, &rb_link, &rb_parent);
-	if (__vma && __vma->vm_start < vma->vm_end)
-		BUG();
+	BUG_ON(__vma && __vma->vm_start < vma->vm_end);
 	__vma_link(mm, vma, prev, rb_link, rb_parent);
 	mm->map_count++;
 }
@@ -813,8 +811,7 @@ try_prev:
 	 * (e.g. stash info in next's anon_vma_node when assigning
 	 * an anon_vma, or when trying vma_merge).  Another time.
 	 */
-	if (find_vma_prev(vma->vm_mm, vma->vm_start, &near) != vma)
-		BUG();
+	BUG_ON(find_vma_prev(vma->vm_mm, vma->vm_start, &near) != vma);
 	if (!near)
 		goto none;
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 893d767..6dcce3a 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -258,7 +258,7 @@ static void balance_dirty_pages(struct a
 /**
  * balance_dirty_pages_ratelimited_nr - balance dirty memory state
  * @mapping: address_space which was dirtied
- * @nr_pages: number of pages which the caller has just dirtied
+ * @nr_pages_dirtied: number of pages which the caller has just dirtied
  *
  * Processes which are dirtying memory should call in here once for each page
  * which was newly dirtied.  The function will periodically check the system's
diff --git a/mm/slab.c b/mm/slab.c
index 4cbf8bb..f055c14 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1297,8 +1297,7 @@ void __init kmem_cache_init(void)
 		if (cache_cache.num)
 			break;
 	}
-	if (!cache_cache.num)
-		BUG();
+	BUG_ON(!cache_cache.num);
 	cache_cache.gfporder = order;
 	cache_cache.colour = left_over / cache_cache.colour_off;
 	cache_cache.slab_size = ALIGN(cache_cache.num * sizeof(kmem_bufctl_t) +
@@ -1974,8 +1973,7 @@ kmem_cache_create (const char *name, siz
 	 * Always checks flags, a caller might be expecting debug support which
 	 * isn't available.
 	 */
-	if (flags & ~CREATE_MASK)
-		BUG();
+	BUG_ON(flags & ~CREATE_MASK);
 
 	/*
 	 * Check that size is in terms of words.  This is needed to avoid
@@ -2206,8 +2204,7 @@ static int __node_shrink(struct kmem_cac
 
 		slabp = list_entry(l3->slabs_free.prev, struct slab, list);
 #if DEBUG
-		if (slabp->inuse)
-			BUG();
+		BUG_ON(slabp->inuse);
 #endif
 		list_del(&slabp->list);
 
@@ -2248,8 +2245,7 @@ static int __cache_shrink(struct kmem_ca
  */
 int kmem_cache_shrink(struct kmem_cache *cachep)
 {
-	if (!cachep || in_interrupt())
-		BUG();
+	BUG_ON(!cachep || in_interrupt());
 
 	return __cache_shrink(cachep);
 }
@@ -2277,8 +2273,7 @@ int kmem_cache_destroy(struct kmem_cache
 	int i;
 	struct kmem_list3 *l3;
 
-	if (!cachep || in_interrupt())
-		BUG();
+	BUG_ON(!cachep || in_interrupt());
 
 	/* Don't let CPUs to come and go */
 	lock_cpu_hotplug();
@@ -2477,8 +2472,7 @@ static int cache_grow(struct kmem_cache 
 	 * Be lazy and only check for valid flags here,  keeping it out of the
 	 * critical path in kmem_cache_alloc().
 	 */
-	if (flags & ~(SLAB_DMA | SLAB_LEVEL_MASK | SLAB_NO_GROW))
-		BUG();
+	BUG_ON(flags & ~(SLAB_DMA | SLAB_LEVEL_MASK | SLAB_NO_GROW));
 	if (flags & SLAB_NO_GROW)
 		return 0;
 
diff --git a/mm/swap_state.c b/mm/swap_state.c
index d7af296..e0e1583 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -148,8 +148,7 @@ int add_to_swap(struct page * page, gfp_
 	swp_entry_t entry;
 	int err;
 
-	if (!PageLocked(page))
-		BUG();
+	BUG_ON(!PageLocked(page));
 
 	for (;;) {
 		entry = get_swap_page();
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 729eb3e..c0504f1 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -321,8 +321,7 @@ void __vunmap(void *addr, int deallocate
 		int i;
 
 		for (i = 0; i < area->nr_pages; i++) {
-			if (unlikely(!area->pages[i]))
-				BUG();
+			BUG_ON(!area->pages[i]);
 			__free_page(area->pages[i]);
 		}
 

