Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267639AbTBQXMt>; Mon, 17 Feb 2003 18:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267644AbTBQXMt>; Mon, 17 Feb 2003 18:12:49 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46346 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267639AbTBQXMi> convert rfc822-to-8bit; Mon, 17 Feb 2003 18:12:38 -0500
Date: Mon, 17 Feb 2003 15:18:43 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.5.62
Message-ID: <Pine.LNX.4.44.0302171515110.1150-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id h1HNMRF03298
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hmm.. Mostly lots of small updates, although the merge with Andrew
included the RCU dcache patches from IBM that he has carried along for a
while (ie fairly fundamnetal, but also very well tested).

ARM, PPC, PPC64, alpha, kbuild.

Oh, and as a sign that 2.6.x really _is_ approaching, people have started 
sending me spelling fixes. Kernel coders are apparently all atrocious 
spellers, and for some reason the spelling police always comes out of the 
woodwork when stable releases get closer.

		Linus

---

Summary of changes from v2.5.61 to v2.5.62
============================================

<d.mueller@elsoft.ch>:
  o PPC32: Export additional symbols for CONFIG_4xx

<tinglett@vnet.ibm.com>:
  o ppc64: revised machine check exception handler
  o ppc64: new scanlog interface

Adrian Bunk <bunk@fs.tum.de>:
  o [netdrvr] make CONFIG_MII one-line desc more pretty

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o Add printk levels to mtrr, also clarify
  o merge the NEC98 parsing code
  o make the io-apic printk generate less junk mail
  o printk levels for mpparse
  o remove bogowarning
  o itanic people cant spell either
  o nor PPC people ;)
  o specialix fix from 2.4 missing in 2.5
  o bring 2.5 arcnet into line with 2.4
  o Fix aha1542
  o mca 53c9x also needs mca-legacy
  o another ia64 typo
  o header update for arcnet updates (again to match 2.4)

Andrew Morton <akpm@digeo.com>:
  o ppc64: kill ppc64 unused var warning
  o ppc64: fix warning in smp_prepare_cpus
  o JFS build fix with gcc-2.95.3
  o flush_tlb_all is not preempt safe
  o move fault_in_pages_readable/writeable to header
  o separate checks from generic_file_aio_write
  o fix ext3 BUG due to race with truncate
  o crc32 improvements
  o dcache_rcu: revert fast_walk code
  o dcache_rcu
  o error checking in ext3 xattr code
  o xattr: listxattr fix
  o xattr: infrastructure for permission overrides
  o xattr: allow kernel code to override EA permissions
  o xattr: trusted extended attributes
  o blk_congestion_wait tuning and lockup fix
  o cciss driver update
  o cciss, fix array bounds overrun
  o direct-io return value fix
  o direct-io: allow reading of the part-filled EOF block
  o Fix ext3 build when EXT3_DEBUG is defined
  o Make the world safe for -Wundef
  o fix compile breakage on drivers/scsi/NCR53C9x.c
  o Use table lookup for radix_tree_maxindex()
  o elv_former_request reversion

Andries E. Brouwer <andries.brouwer@cwi.nl>:
  o add static, fix typo

Anton Blanchard <anton@samba.org>:
  o ppc64: add TCSBRKP
  o ppc64: Remove sys32_mremap, not required on ppc64 since we alter
    TASK_SIZE
  o ppc64: fix compile warnings
  o ppc64: clean up some of big bad sys_ppc32.c
  o ppc64: always compile in 32bit ELF support
  o ppc64: Never call event-scan faster than once per second, required
    on some machines
  o ppc64: dont attempt a traceback table lookup for userspace
    addresses
  o ppc64: warning fix, caused by me
  o ppc64: use get_user in alignment exception handler
  o ppc64: ptrace signal fix
  o ppc64: make sure socketcall_table is 8 byte aligned
  o ppc64: add set_tid_address and fadvise64
  o disable printout of interrupts in /proc/stat on ppc64
  o enable OFFB on ppc64
  o remove stale comment
  o compat futex fix

Art Haas <ahaas@airmail.net>:
  o C99 initializers for drivers/net/aironet4500_proc.c
  o C99 initializers for drivers/char/rtc.c
  o C99 initializers for drivers/cdrom/cdrom.c
  o C99 initializers for drivers/net/arlan-proc.c

Ben Collins <bcollins@debian.org>:
  o IEEE-1394 Updates

Brian Gerst <bgerst@didntduck.org>:
  o remove .mod.c files in make clean

Daniel Jacobowitz <drow@nevyn.them.org>:
  o Clean up ptrace_setoptions and PT_* constants
  o Set ptrace_message before PT_TRACE_EXIT

Dave Kleikamp <shaggy@shaggy.austin.ibm.com>:
  o JFS: Fix jfs_sync_fs

Dominik Brodowski <linux@brodo.de>:
  o pcmcia: add device_class pcmcia_socket, update devices & drivers
  o pcmcia: use device_class->add_device/remove_device
  o cpufreq: move frequency table helpers to extra module
  o cpufreq: move /proc/cpufreq interface code to extra module
  o cpufreq: fix compilation of ACPI if !CPU_FREQ
  o pcmcia: small bugfix & cleanup

François Romieu <romieu@fr.zoreil.com>:
  o [netdrvr rrunner] small fixes and cleanups

Jaroslav Kysela <perex@suse.cz>:
  o ALSA update

Jeff Wiedemeier <jeff.wiedemeier@hp.com>:
  o alpha numa setup_memory leaves meaningless {min,max}_low_pfn
  o delay marvel agp printk until after !hose check

Jens Axboe <axboe@suse.de>:
  o deadline ioscheduler bug fixes
  o fix request-to-request front merging
  o missing lock in get_request_wait()
  o front merge fix (really!)

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
  o kbuild: Always postprocess modules
  o kbuild: Move the version magic generation into module
    postprocessing
  o kbuild: Use list of modules for "make modules_install"
  o kbuild: Do module post processing in C
  o kbuild: Add dependency info to modules
  o kbuild: Add dependency info to modules
  o kbuild: Figure endianness / word size at compile time
  o kbuild: Merge file2alias into scripts/modpost.c
  o kbuild: Rename some module postprocessing stuff
  o kbuild: scripts/elfconfig.h is generated
  o kbuild: Warn on undefined exported symbols
  o kbuild: Fix modules_install w/o modules error
  o kbuild: Fix a 64-bit issue in scripts/modpost.c
  o kbuild: Fix a "make -j" bug

Linus Torvalds <torvalds@home.transmeta.com>:
  o Fix futex compile breakage introduced by the compat code
  o Clean up and fix locking around signal rendering
  o Do proper signal locking for the old-style /proc/stat too
  o It's usually considered stupid to lock the same spinlock twice in
    close succession. However, for this once we'll just call it
    "inspired".
  o Fix locking for "send_sig_info()", to avoid possible races with
    signal state changes due to execve() and exit(). We need to hold
    the tasklist lock to guarantee stability of "task->sighand".

Marc Zyngier <mzyngier@freesurf.fr>:
  o EISA/sysfs updates

Matthew Wilcox <willy@debian.org>:
  o Fix mandatory locking

Paul Mackerras <paulus@samba.org>:
  o PPC32: Changes to accommodate recent signal changes
    (current->sighand)
  o PPC32: Fix compile warnings in some programs used in the build
    process
  o PPC32: Add set_tid_address and fadvise64 system calls
  o PPC32: declare pm_power_off
  o PPC32: use ptrace_notify

Randy Dunlap <rddunlap@osdl.org>:
  o fix Documentation/cli-sti-removal.txt thinko

Richard Henderson <rth@are.twiddle.net>:
  o [ALPHA] Add missing sighand bits
  o [ALPHA] Add isa_eth_io_copy_and_sum
  o [ALPHA] Add fadvise64

Rob Weryk <rjweryk@uwo.ca>:
  o Fix small typo

Robert Love <rml@tech9.net>:
  o trivial: unused var in sunrpc

Roger Luethi <rl@hellgate.ch>:
  o [netdrvr via-rhine] trivial bits
  o [netdrvr via-rhine] fix broken tx-underrun handling
  o [netdrvr via-rhine] various duplex-related fixes
  o [netdrvr via-rhine] reset function rewrite
  o [netdrvr via-rhine] bump version, use constant instead of magic
    number
  o Fix 8139too device close

Russell King <rmk@flint.arm.linux.org.uk>:
  o [ARM] Fix resource initialisation for IOP310
  o [ARM] Miscellaneous cleanups
  o [ARM] Reduce scope of "safe_buffers"
  o [ARM PATCH] 1372/1: EPXA10DB: Add missing include files to irq.c
    for 2.5.59
  o [ARM PATCH] 1373/1: EPXA10DB: Update def-config file
  o [ARM PATCH] 1376/1: Use #defines for iq80310 serial port
  o [ARM PATCH] 1377/1: Retain endianess state on XScale CPUs during
    boot
  o [ARM PATCH] 1368/1: Fix some typos in proc-armv/system.h
  o [ARM] Better handling of bad IRQ implementations
  o [ARM PATCH] 1380/1: Big-Endian support for jiffies
  o [ARM] Add init_sighand for 2.5.60
  o [ARM] Ensure backtrace terminates on corrupted frame pointers
  o [ARM] Update Acorn SCSI drivers
  o [ARM] Update wdt285 and wdt977 watchdog drivers
  o [ARM] Add input_devclass support to SA1111 PS/2 port driver
  o [ARM PATCH] 1099/4: trizeps MTD support
  o [ARM] Update signal handling for ARM

Rusty Russell <rusty@rustcorp.com.au>:
  o kbuild: Module alias and device table support
  o kbuild: Do modversions checks on module structure
  o get rid of exec_usermodehelper, replace with call_usermodehelper
  o kbuild: Fix non-verbose make modules_install output

Sam Ravnborg <sam@ravnborg.org>:
  o fix warning in kernel/dma.c
  o char/drivers/random.c - fix warning

Scott Anderson <scott_anderson@mvista.com>:
  o PPC32: Invalidate the icache before use on PPC40x

Stephen Rothwell <sfr@canb.auug.org.au>:
  o compat_sys_futex 1/3 generic, parisc, ppc64, s390x and x86_64

Steve French <stevef@smfhome1.austin.rr.com>:
  o Merge in fixes from version 0.6.5 of the CIFS VFS.  Greatly
    improved performance including improved distributed caching support
    and support for readpages and larger read sizes. Cache data now
    flushed properly at file close time. Socket and memory leak fixed. 
    Fix two oops. Fix error logging and made more consistent.  Generic
    sendfile added

Steven Cole <elenstev@mesatop.com>:
  o [tokenring proteon] trivial, spelling fix
  o high pedantry in ppc spelling
  o alpha typo fix
  o 2.5.61 fix erroneous spellings of error
  o 2.5.61 Reduce the number of "nuber" by four
  o 2.5.61 fix spelling of necessary in 11 files
  o fix different spellings of different and differences
  o correct the spelling of correction and correctly
  o more accurate spelling of accuracy
  o yet more pedantry: complement vs compliment

Tom Rini <trini@kernel.crashing.org>:
  o PPC32: Fix some license drain bamage.  Noticed by Christoph Hellwig


