Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751231AbWDAKnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbWDAKnZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 05:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWDAKnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 05:43:25 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:19986 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751231AbWDAKnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 05:43:24 -0500
Date: Sat, 1 Apr 2006 12:43:22 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: please pull from the trivial tree
Message-ID: <20060401104322.GF28310@stusta.de>
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

Horms:
      Documentation: Reorder documentation of nomca and nomce
      Documentation: Make fujitsu/frv/kernel-ABI.txt 80 columns wide
      kexec: grammar fix for crash_save_this_cpu()

Kalin KOZHUHAROV:
      Fix comments: s/granuality/granularity/

Michael Hayes:
      Fix minor documentation typo

Stefan Richter:
      Doc/kernel-parameters.txt: delete false version information and history
      Doc/kernel-parameters.txt: mention modinfo and sysfs
      Doc/kernel-parameters.txt: slightly reword sentence about restrictions

Uwe Zeisberger:
      fix typo "Suposse" -> "Suppose"


 Documentation/DocBook/Makefile           |    2 
 Documentation/acpi-hotkey.txt            |    2 
 Documentation/fujitsu/frv/kernel-ABI.txt |  196 +++++++++++++----------
 Documentation/kernel-parameters.txt      |   34 +--
 Documentation/networking/packet_mmap.txt |    2 
 Documentation/networking/tuntap.txt      |    2 
 arch/i386/kernel/crash.c                 |    2 
 drivers/md/dm-target.c                   |    3 
 drivers/md/raid1.c                       |    6 
 drivers/mtd/chips/Kconfig                |   21 --
 drivers/s390/block/dasd_erp.c            |    8 
 drivers/s390/char/sclp_rw.c              |    2 
 drivers/s390/char/tape_block.c           |   13 -
 drivers/scsi/aic7xxx/Kconfig.aic7xxx     |    2 
 drivers/serial/jsm/jsm.h                 |    2 
 drivers/serial/jsm/jsm_driver.c          |    2 
 drivers/serial/jsm/jsm_neo.c             |    2 
 fs/direct-io.c                           |    3 
 fs/exec.c                                |    2 
 fs/hfsplus/bnode.c                       |    6 
 fs/hfsplus/btree.c                       |    3 
 fs/jffs2/background.c                    |    3 
 fs/smbfs/file.c                          |    6 
 fs/sysfs/inode.c                         |    3 
 include/linux/fs.h                       |    2 
 ipc/util.c                               |    6 
 kernel/power/Kconfig                     |    2 
 kernel/printk.c                          |    6 
 kernel/time.c                            |    8 
 mm/mmap.c                                |    9 -
 mm/swap_state.c                          |    3 
 mm/vmalloc.c                             |    3 
 32 files changed, 170 insertions(+), 196 deletions(-)


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
 

