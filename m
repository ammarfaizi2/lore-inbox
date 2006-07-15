Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161024AbWGOW13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161024AbWGOW13 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 18:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWGOW13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 18:27:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10910 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964796AbWGOW11 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 18:27:27 -0400
Date: Sat, 15 Jul 2006 15:27:21 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.6.18-rc2
Message-ID: <Pine.LNX.4.64.0607151523180.5623@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, there it is, in all the usual places.

I think the bulk of it are some MIPS and UML updates, along with a e1000 
driver update, but there's various more random things, including just lots 
of cleanups.

The shortlog is pretty readable, so without further ado, here it is:

		Linus

---

Adam B. Jerome:
      /fs/proc/: 'larger than buffer size' memory accessed by clear_user()

Adrian Bunk:
      [IRDA]: fix drivers/net/irda/ali-ircc.c:ali_ircc_init()
      [ATM] net/atm/clip.c: fix PROC_FS=n compile
      kernel/printk.c: EXPORT_SYMBOL_UNUSED
      mm/bootmem.c: EXPORT_UNUSED_SYMBOL
      mm/memory.c: EXPORT_UNUSED_SYMBOL
      mm/mmzone.c: EXPORT_UNUSED_SYMBOL
      fs/read_write.c: EXPORT_UNUSED_SYMBOL
      kernel/softirq.c: EXPORT_UNUSED_SYMBOL
      i386 defconfig: set CONFIG_PM_STD_PARTITION=""
      proper prototype for drivers/message/i2o/device.c:i2o_parm_issue()
      [ALSA] fix the SND_FM801_TEA575X dependencies
      [ALSA] sound/i2c/cs8427.c: don't export a static function
      [ALSA] make sound/isa/gus/gusextreme.c:devices static
      w1: remove drivers/w1/w1.h
      PCI: poper prototype for arch/i386/pci/pcbios.c:pcibios_sort()
      Driver core: bus.c cleanups
      remove kernel/power/pm.c:pm_unregister_all()
      The scheduled unexport of insert_resource
      [ARM] arch/arm/kernel/bios32.c: no need to set isa_bridge
      remove kernel/kthread.c:kthread_stop_sem()
      drivers/block/cpqarray.c: remove an unused variable
      unexport open_softirq
      let the the lockdep options depend on DEBUG_KERNEL

Al Viro:
      symlink nesting level change

Alan Cox:
      [DCCP]: Fix sparse warnings.
      ide: fix Jmicron support

Alan Stern:
      usb-storage: wait for URB to complete
      usb-storage: fix race between reset and disconnect
      USB hub: don't return status > 0 from resume
      usbcore: fixes for hub_port_resume
      USB: unusual_devs entry for Nokia N91
      USB: unusual_devs entry for Nokia E61

Ananda Raju:
      s2io driver irq fix

Andi Kleen:
      ACPI: delete some defaults from ACPI Kconfig
      Minor cleanup to lockdep.c
      x86_64: Update defconfig
      x86_64: Fix up bogus defaults in ACPI Kconfig
      x86_64: Allow oprofile for model P4 models
      x86_64: Fix access check in ptrace compat

Andreas Gruenbacher:
      Remove leftover ext3 acl declarations
      null-terminate over-long /proc/kallsyms symbols

Andreas Mohr:
      small kernel/sched.c cleanup

Andreas Schwab:
      Fix snd-aoa irq conversion

Andrew Morton:
      [SERIAL] 8250: sysrq deadlock fix
      ACPI: SBS: fix initialization, sem2mutex
      don't select CONFIG_HOTPLUG
      x86_64: e820.c needs pgtable.h
      count_vm_events() fix
      fadvise: remove dead comments
      md: fix oops in error-handling
      get_cmos_time() locking fix (lockdep)
      swsusp warning fix
      fix weird logic in alloc_fdtable()
      checklist update
      alloc_fdtable() expansion fix
      e1000: irq naming update
      8139cp.c printk fix
      [SPARC64]: of_device_register() error checking fix
      del_timer_sync(): add cpu_relax()

Anil Keshavamurthy:
      ia64: race flushing icache in COW path

Arjan van de Ven:
      8139too deadlock fix
      [ATM]: fix possible recursive locking in skb_migrate()
      ACPI: add 'const' to several ACPI file_operations
      lockdep: improve debug output
      put a comment at register_die_notifier that the export is used
      lockdep: disable lock debugging when kernel state becomes untrusted
      lockdep: annotate the sysfs i_mutex to be a separate class
      lockdep: annotate mm/slab.c
      lockdep: annotate the BLKPG_DEL_PARTITION ioctl

Atsushi Nemoto:
      [MIPS] Make SPARSEMEM selectable on QEMU.
      [MIPS] Make SPARSEMEM selectable on QEMU.
      [MIPS] Sparsemem fixes
      [MIPS] Do not count pages in holes with sparsemem
      [MIPS] Fix rdhwr_op definition.
      [MIPS] sparsemem: fix crash in show_mem

Auke Kok:
      e1000: prevent statistics from garbling during bus resets
      e1000: fix loopback ethtool test
      e1000: rework driver hardware reset locking
      e1000: Make PHY powerup/down a function
      e1000: fix CONFIG_PM blocks
      e1000: small performance tweak by removing double code
      e1000: add smart power down code
      e1000: change printk into DPRINTK
      e1000: recycle skb
      e1000: rework module param code with uninitialized values
      e1000: force register write flushes to circumvent broken platforms
      e1000: disable CRC stripping workaround
      e1000: fix adapter led blinking inconsistency
      e1000: M88 PHY workaround
      e1000: check return value of _get_speed_and_duplex
      e1000: disable ERT
      e1000: add ich8lan core functions
      e1000: integrate ich8 support into driver
      e1000: allow user to disable ich8 lock loss workaround
      e1000: add ich8lan device ID's
      e1000: increase version to 7.1.9-k2
      ixgb: fix tx unit hang - properly calculate desciptor count

Ayaz Abdulla:
      forcedeth: deferral fixup
      forcedeth: watermark fixup

Balbir Singh:
      per-task-delay-accounting: utilities for genetlink usage

Bart Oldeman:
      USB: ipw.c driver fix

Ben Gardner:
      w1: fix idle check loop in ds2482
      pca9539: Honor the force parameter

Benjamin Herrenschmidt:
      aoa: i2sbus: move module parameter declaration up
      aoa: i2sbus: fix for PowerMac7,2 and 7,3
      aoa: fix when all is built into the kernel
      aoa: i2sbus: revamp control layer
      aoa: pmf gpio: report if function calling fails
      aoa fabric layout: clean up messages
      aoa: tas: fix initialisation/reset
      powerpc: fix trigger handling in the new irq code
      powerpc: fix MPIC OF tree parsing on Apple quad g5
      powerpc: fix SMU driver interrupt mapping

Bob Moore:
      ACPI: ACPICA 20060707

Brian Haley:
      [IPV6]: order addresses by scope

Brice Goglin:
      myri10ge return value fix

Catalin Marinas:
      Fix a memory leak in the i386 setup code

Chandra Seetharaman:
      per-task-delay-accounting: cpu delay collection via schedstats

Charles Spirakis:
      hwmon: New maintainer for w83791d

Chase Venters:
      Make cpu_relax() imply barrier() on all arches

Chris Boot:
      LED Class support for Soekris net48xx
      net48xx LED cleanups

Chris Dearman:
      [MIPS] Less noise on multithreading exceptions.
      [MIPS] Use KERN_DEBUG to log the SDBBP messages
      [MIPS] Default cpu_has_mipsmt to a runtime check
      [MIPS] Panic on fp exception in kernel mode.

Christoph Hellwig:
      snsc: switch from force_sig to kill_proc
      disallow modular binfmt_elf32
      remove the tasklist_lock export

Christoph Lameter:
      ZVC: add __inc_zone_state for !SMP configuration
      USB: remove empty destructor from drivers/usb/mon/mon_text.c

Christophe Mariac:
      USB: new device ids for ftdi_sio driver

Chuck Ebbert:
      i386: system.h: remove extra semicolons and fix order
      i386: handle_BUG(): don't print garbage if debug info unavailable

Chuck Short:
      Add Computone IntelliPort Plus serial hotplug support
      Add Specialix IO8+ card support hotplug support

Clemens Ladisch:
      [ALSA] wavefront: fix __init/__devinit confusion
      [ALSA] remove unused snd_minor.name field

Colin Leroy:
      USB: Add one VID/PID to ftdi_sio

Cornelia Huck:
      [S390] subchannel register/unregister mutex.
      [S390] path grouping and path verifications fixes.

D. Peter Siddons:
      USB: new device id for Thorlabs motor driver

Dan Streetman:
      USB: add ZyXEL vendor/product ID to rtl8150 driver

Daniel Drake:
      zd1211rw: usb_clear_halt not allowed in IRQ context

Daniel Mack:
      USB: au1200: EHCI and OHCI fixes

Dave Jones:
      Fix cpufreq vs hotplug lockdep recursion.
      fix oddball boolean logic in s390 netiucv
      s390: broken null test in claw driver
      sch_htb compile fix.

David Brownell:
      USB: ehci: fix bogus alteration of a local variable
      USB: gadget section fixups

David Howells:
      FDPIC: Fix FDPIC compile errors
      FRV: Fix FRV arch compile errors
      NOMMU: Fix execution off of ramfs with mmap()
      FDPIC: Adjust the ELF-FDPIC driver to conform more to the CodingStyle
      FDPIC: Define SEEK_* constants in the Linux kernel headers
      FDPIC: Move roundup() into linux/kernel.h
      FDPIC: Add coredump capability for the ELF-FDPIC binfmt
      FRV: Introduce asm-offsets for FRV arch

David Miller:
      USB: OHCI hub code unaligned access

David S. Miller:
      [TCP]: Remove TCP Compound
      [SPARC64]: Update defconfig.
      [SPARC64]: Fix 2 bugs in sabre_irq_build()
      [SERIAL] sunsu: Handle keyboard and mouse ports directly.
      [SPARC64]: Refine Sabre wsync logic.
      [SPARC]: Fix OF register translations under sub-PCI busses.
      [SPARC64]: Make sure IRQs are disabled properly during early boot.
      [SERIAL] sunsu: Report keyboard and mouse ports in kernel log.
      [SERIAL] sunsab: Fix significant typo in sab_probe()
      [SPARC64] psycho: Fix pbm->name handling in pbm_register_toplevel_resources()

David Woodhouse:
      [SPARC64]: Fix make headers_install
      hdrinstall: remove asm/irq.h from user visibility
      hdrinstall: remove asm/atomic.h from user visibility
      hdrinstall: remove asm/io.h from user visibility

Davide Perini:
      usb-storage: unusual_devs entry for Motorola RAZR V3x

Deepak Saxena:
      Update smc91x driver with ARM Versatile board info

Dmitry Torokhov:
      smsc-ircc2: fix section reference mismatches

Domen Puncer:
      USB: au1xxx: compile fixes for OHCI for au1200
      [MIPS] au1xxx: Support both YAMON and U-Boot

Doug Thompson:
      Fix and enable EDAC sysfs operation

Eric Paris:
      SELinux: decouple fscontext/context mount options
      SELinux: add rootcontext= option to label root inode when mounting
      Fix security check for joint context= and fscontext= mount options

Eric Sesterhenn:
      cris: switch to iminor/imajor
      aoe: cleanup i_rdev usage
      isdn: cleanup i_rdev udage
      [ALSA] Memory leak in sound/pcmcia/pdaudiocf/pdaudiocf.c
      USB: fix pointer dereference in drivers/usb/misc/usblcd

Eric W. Biederman:
      msi: Only keep one msi_desc in each slab entry.
      i386 kexec: allow the kexec on panic support to compile on voyager

Ernis:
      USB: unusual_devs entry for Samsung MP3 player

Evgeniy Dushistov:
      JFS: commit_mutex cleanups

Evgeniy Polyakov:
      W1: remove w1 mail list from lm_sensors.

Frank Gevaerts:
      USB: ipaq.c bugfixes
      USB: ipaq.c timing parameters

Greg Kroah-Hartman:
      USB: move usb-serial.h to include/linux/usb/

Greg Ungerer:
      m68knommu: fix result type in get_user() macro

Hans de Goede:
      hwmon: Fix for first generation Abit uGuru chips
      hwmon: Documentation update for abituguru

Heiko Carstens:
      vmstat: export all_vm_events()
      s390: remove BINFMT_ELF32 config option
      [S390] __builtin_trap() and gcc version.
      [S390] raw_local_save_flags/raw_local_irq_restore type check
      [S390] cpu_relax() is supposed to have barrier() semantics.
      [S390] xpram module parameter parsing.
      [S390] Fix sparse warnings.

Henrik Kretzschmar:
      Driver core: kernel-doc in drivers/base/core.c corrections

Herbert Valerio Riedel:
      RTC subsystem, Add ISL1208 support

Herbert Xu:
      [NET] gso: Add skb_is_gso
      [NET] gso: Fix up GSO packets with broken checksums
      [IPV4] inetpeer: Get rid of volatile from peer_total
      [IPCOMP]: Fix truesize after decompression
      [IPV4]: Fix error handling for fib_insert_node call
      [NET]: Update frag_list in pskb_trim

Hisashi Hifumi:
      reiserfs: fix journaling issue regarding fsync()

Horms:
      nfs: Update Documentation/nfsroot.txt to include dhcp, syslinux and isolinux

Ian Abbott:
      USB serial visor: fix race in open/close
      USB serial ftdi_sio: Prevent userspace DoS

Ian McDonald:
      [NET]: fix __sk_stream_mem_reclaim

Inaky Perez-Gonzalez:
      USB: Add some basic WUSB definitions

Ingo Molnar:
      lockdep: add more rwsem.h documentation
      lockdep: core, reduce per-lock class-cache size
      lockdep: clean up completion initializer in smpboot.c
      uninline init_waitqueue_head()
      lockdep: HPET/RTC fix
      lockdep: undo mm/slab.c annotation
      revert slab.c locking change
      lockdep: core, fix rq-lock handling on __ARCH_WANT_UNLOCKED_CTXSW

Ira Weiny:
      IB/cm: set private data length for reject messages

Irwan Djajadi:
      pcf8563: remove MOD_INC_USE_COUNT, MOD_DEC_USE_COUNT

Jack Morgenstein:
      IB/mthca: fix static rate returned by mthca_ah_query

Jacob Shin:
      x86_64: Fix hotplug problem in mce amd

Jan Kiszka:
      mm: fix oom roll-back of __vmalloc_area_node

Jaroslav Kysela:
      [ALSA] sound/pci/Kconfig - fix broken indenting for SND_FM801_TEA575X

Jean Delvare:
      scx200_acb: Fix the block transactions
      i2c-powermac: Fix master_xfer return value
      i2c-ite: Plan for removal
      i2c: New mailing list

Jeff Dike:
      uml: timer initialization cleanup
      uml: remove some useless exports
      uml: fix static binary segfault
      uml: remove useless declaration
      uml: signal initialization cleanup
      uml: timer handler tidying
      uml: ifdef a mode-specific function
      uml: mark forward_interrupts as being mode-specific
      uml: remove spinlock wrapper functions
      uml: remove os_isatty
      uml: fix exitcall ordering bug
      uml: make some symbols static
      uml: remove syscall debugging
      uml: move _kern.c files
      uml: formatting fixes
      uml: add some EINTR protection
      uml: remove unused variable
      uml: make mconsole version requests happen in a process
      uml: tidy longjmp macro
      uml: tidy biarch gcc support
      uml: header formatting cleanups
      UML - fix utsname build breakage

Jeff Garzik:
      [netdrvr] 3c59x: snip changelog from source code

Jeff Mahoney:
      reiserfs: fix handling of device names with /'s in them

Jens Axboe:
      Only the first two bits in bio->bi_rw and rq->flags match
      splice: fix problems with sys_tee()
      cdrom: fix bad cgc.buflen assignment

Jim Cromie:
      pc8736x_gpio: fix re-modprobe errors: define and use constants
      pc8736x_gpio: fix re-modprobe errors: undo region reservation
      pc8736x_gpio: fix re-modprobe errors: fix/finish cdev-init
      scx200_gpio: 1 cdev for N minors: cleanup, prep
      scx200_gpio: use 1 cdev for N minors, not N for N
      gpio: drop vtable members .gpio_set_high .gpio_set_low gpio_set is enough
      gpio: cosmetics: remove needless newlines
      gpio: rename exported vtables to better match purpose

Johannes Berg:
      aoa: tas: change PCM1 name to PCM
      aoa: tas: surface DRC control again
      aoa: layout fabric: add missing module aliases
      aoa: tas: add missing bass/treble controls

john stultz:
      improve timekeeping resume robustness

John W. Linville:
      [TG3]: add amd8131 to "write reorder" chipsets

Jon Smirl:
      vt: Remove VT-specific declarations and definitions from tty.h
      tty: Remove include of screen_info.h from tty.h

Jonathan Corbet:
      VFS documentation tweak

Julien BLACHE:
      [SERIAL] IP22: fix serial console hangs
      [MIPS] IP22 Fix brown paper bag in RTC code.

Karsten Keil:
      hisax: fix usage of __init*

Kevin Lloyd:
      USB: add driver for non-composite Sierra Wireless devices

Kirill Korotaev:
      fix fdset leakage
      struct file leakage

Koen Kooi:
      [ARM] 3729/3: EABI padding rules necessitate the packed attribute of floatx80

Konstantin Karasyov:
      ACPI: fix fan/thermal resume

Kristen Accardi:
      ACPI: ACPI_DOCK: Initialize the atomic notifier list

Kristen Carlson Accardi:
      PCI: PCIE power management quirk

Krzysztof Halasa:
      [WAN]: converting generic HDLC to use netif_dormant*()

Kyle McMartin:
      USB: Kill compiler warning in quirk_usb_handoff_ohci

Kylene Jo Hall:
      tpm: interrupt clear fix
      tpm: Add force device probe option
      tpm_tis: use resource_size_t

Larry Finger:
      bcm43xx-softmac: Fix an off-by-one condition in handle_irq_noise

Lars Jacob:
      USB: unusual_devs entry for Sony DSC-H5

Len Brown:
      ACPI: acpi_os_get_thread_id() returns current
      Revert "Revert "ACPI: dock driver""
      ACPI: ACPI_DOCK Kconfig
      ACPI: "Device `[%s]' is not power manageable" make message debug only
      ACPI: acpi_os_allocate() fixes
      Revert "ACPI: execute Notify() handlers on new thread"

Lennert Buytenhek:
      make valid_mmap_phys_addr_range() take a pfn
      [ARM] 3726/1: update {ep93xx,ixp2000,ixp23xx,lpd270,onearm} defconfigs to 2.6.18-rc1
      USB: ohci bits for the cirrus ep93xx

Linas Vepstas:
      pci: initialize struct pci_dev.error_state

Linus Torvalds:
      power: improve inline asm memory constraints
      i386: improve and correct inline asm memory constraints
      Revert "ACPI: dock driver"
      swsusp: fix panic when signature can't be read
      x86 MacMini: make built-in speaker sound actually work
      Add PIIX4 APCI quirk for the 440MX chipset too
      Revert "pcmcia: Make ide_cs work with the memory space of CF-Cards if IO space is not available"
      Fix nasty /proc vulnerability
      Relax /proc fix a bit
      Mark /proc MS_NOSUID and MS_NOEXEC
      Don't allow chmod() on the /proc/<pid>/ files
      Linux 2.6.18-rc2

Luca Tettamanti:
      Add try_to_freeze() to rt-test kthreads

Luiz Fernando N. Capitulino:
      Updates CREDITS file
      USB: Anydata: Fixes wrong URB callback.

Luke Yang:
      nommu: export two symbols for drivers to use

Maciej W. Rozycki:
      char/rtc: Handle memory-mapped chips properly

Magnus Damm:
      release_firmware() fixes

Marc Zyngier:
      [SPARC64] Fix PSYCHO PCI controler init.

Marcel Holtmann:
      Fix prctl privilege escalation and suid_dumpable (CVE-2006-2451)
      [Bluetooth] Remaining transitions to use kzalloc()
      [Bluetooth] Avoid NULL pointer dereference with tty->driver
      [Bluetooth] Let BT_HIDP depend on INPUT
      [Bluetooth] Fix deadlock in the L2CAP layer

Mark M. Hoffman:
      i2c: Fix 'ignore' module parameter handling in i2c-core
      i2c: Handle i2c_add_adapter failure in i2c algorithm drivers

Markus Schoder:
      x86_64: Bring x86-64 ia32 emul in sync with i386 on READ_IMPLIES_EXEC enabling

Martin Michlmayr:
      [SERIAL] dz: Fix compilation error

Martin Schwidefsky:
      [S390] fix futex_atomic_cmpxchg_inatomic

Matt LaPlante:
      [ATM]: Typo in drivers/atm/Kconfig...

Matthew Garrett:
      PCI: Clear abnormal poweroff flag on VIA southbridges, fix resume

Matthew Meno:
      USB: Support for Susteen Datapilot Universal-2 cable in pl2303

Matthias Urlichs:
      USB: Option driver: new product ID

Michael Hanselmann:
      powermac: Combined fixes for backlight code

Michael S. Tsirkin:
      IB/mthca: comment fix
      IB/cm: drop REQ when out of memory
      IB/addr: gid structure alignment fix
      fmr pool: remove unnecessary pointer dereference
      IB/core: use correct gfp_mask in sa_query

Michal Ludvig:
      [CRYPTO] padlock: Fix alignment after aes_ctx rearrange

Michal Piotrowski:
      USB: remove devfs information from Kconfig

Mike Rapoport:
      mbxfb: Add framebuffer driver for the Intel 2700G

Muli Ben-Yehuda:
      x86_64: Add a MAINTAINERS entry for Calgary
      x86_64: Fix Calgary copyright statements per IBM guidelines

Nathan Scott:
      blktrace: fix barrier vs sync typo
      blktrace: readahead support
      Update ramdisk documentation
      ramdisk blocksize Kconfig entry

Navaho Gunleg:
      USB: add support for WiseGroup., Ltd SmartJoy Dual PLUS Adapter

NeilBrown:
      md: possible fix for unplug problem
      md: set desc_nr correctly for version-1 superblocks
      md: delay starting md threads until array is completely setup
      md: fix resync speed calculation for restarted resyncs
      md: fix a plug/unplug race in raid5
      md: fix some small races in bitmap plugging in raid5
      md: fix usage of wrong variable in raid1
      md: unify usage of symbolic names for perms
      md: require CAP_SYS_ADMIN for (re-)configuring md devices via sysfs
      md: include sector number in messages about corrected read errors

OGAWA Hirofumi:
      Fix sighand->siglock usage in kernel/acct.c

Oliver Bock:
      USB: rename Cypress CY7C63xxx driver to proper name and fix up some tiny things

Oliver Neukum:
      USB: update for acm in quirks and debug

Patrick McHardy:
      [NET]: Fix IPv4/DECnet routing rule dumping

Pavel Machek:
      [ARM] 3721/1: Small cleanup for locomo.c
      [ARM] 3727/1: fix ucb initialization on collie
      [ARM] 3723/1: collie charging
      [ARM] 3725/1: sharpsl_pm: warn about wrong temperature

Pete Zaitcev:
      USB: fix usb-serial leaks, oopses on disconnect
      USB: fix visor leaks

Peter Milne:
      i2c-iop3xx: Avoid addressing self

Peter Moulder:
      USB: Addition of vendor/product id pair for pl2303 driver

Peter Oberparleiter:
      partitions: let partitions inherit policy from disk

Peter Williams:
      sched: fix bug in __migrate_task()

Phil Dibowitz:
      USB Storage: US_FL_MAX_SECTORS_64 flag
      USB Storage: Uname in PR/SC Unneeded message
      USB: another unusual device

Pierre Ossman:
      [MMC] Fix incorrect register access
      [MMC] Change SDHCI version error to a warning

Rafael J. Wysocki:
      swsusp: do not use memcpy for snapshotting memory

Ralf Baechle:
      [AX.25]: Use kzalloc
      [AX.25]: Get rid of the last volatile.
      [BPQ] lockdep: fix false positive
      [AX.25]: Fix locking of ax25 protocol function list.
      [NETROM]: Fix locking order when establishing a NETROM circuit.
      [NETROM]: Drop lock before calling nr_destroy_socket
      [AX.25]: Optimize AX.25 socket list lock
      [ROSE] lockdep: fix false positive
      [NETROM] lockdep: fix false positive
      [MIPS] Avoid interprocessor function calls.
      [MIPS] IP27: Don't destroy interrupt routing information on shutdown irq.
      [MIPS] Update defconfigs to 2.6.18-rc1.
      [MIPS] Don't include obsolete <linux/config.h>.
      [MIPS] Eleminate interrupt migration helper use.
      [MIPS] Wire up vmsplice(2) and move_pages(2).
      [MIPS] Malta: Fix build of certain configs.
      [MIPS] IP22: Remove SYS_SUPPORTS_SMP test code.
      [MIPS] Use the proper technical term for naming some of the cache  macros.
      [MIPS] TRACE_IRQFLAGS_SUPPORT support.
      [MIPS] IP27: struct irq_desc member handler was renamed to chip.
      [MIPS] IP27: irq_chip startup method returns unsigned int.
      [MIPS] IP27: Invoke setup_irq for timer interrupt so proc stats will be shown.
      [MIPS] IP27: Reformatting.
      [MIPS] MIPSsim: Delete redeclaration of ll_local_timer_interrupt.
      [MIPS] SMTC: Reformat to Linux style.
      [MIPS] Nuke redeclarations of board_timer_setup.
      [MIPS] Remove redeclarations of setup_irq().
      [MIPS] Nuke redeclarations of board_time_init.
      [MIPS] Replace board_timer_setup function pointer by plat_timer_setup.
      [MIPS] Atlas, Malta, SEAD: Don't disable interrupts in mips_time_init().
      [MIPS] Remove unused code.
      [MIPS] MIPSsim: Build fix, rename sim_timer_setup -> plat_timer_setup.

Randy Dunlap:
      [ALSA] Fix no mpu401 interface can cause hard freeze
      [ALSA] Fix undefined (missing) references in ISA MIRO sound driver
      USB: fix usb kernel-doc
      Driver core: fix driver-core kernel-doc
      TPM: fix failure path leak
      actual mailing list in MAINTAINERS

Roland Dreier:
      Convert idr's internal locking to _irqsave variant

Rolf Eike Beer:
      add function documentation for register_chrdev()
      Remove pci_dac_set_dma_mask() from Documentation/DMA-mapping.txt

Roman Zippel:
      adjust clock for lost ticks

Russell King:
      [ARM] Allow Versatile to be built for AB and PB
      Fix broken kernel headers preventing ARM build

Segher Boessenkool:
      powerpc: make OF interrupt tree parsing more strict

Serge E. Hallyn:
      s390: move var declarations behind ifdef

Shailabh Nagar:
      list_is_last utility
      per-task-delay-accounting: setup
      per-task-delay-accounting: sync block I/O and swapin delay collection
      per-task-delay-accounting: taskstats interface
      per-task-delay-accounting: delay accounting usage of taskstats interface
      per-task-delay-accounting: documentation
      per-task-delay-accounting: /proc export of aggregated block I/O delays
      delay accounting taskstats interface send tgid once
      per task delay accounting taskstats interface: documentation fix
      per-task delay accounting: avoid send without listeners
      per-task delay accounting taskstats interface: control exit data through cpumasks
      Remove down_write() from taskstats code invoked on the exit() path

Shankar Anand:
      knfsd: nfsd4: add per-operation server stats

Stephane Eranian:
      i386: use thread_info flags for debug regs and IO bitmaps

Stephen Hemminger:
      [NET]: Fix network device interface printk message priority
      [MAINTAINERS]: Add proper entry for TC classifier
      sky2: fix truncated collision threshold mask
      skge: fix truncated collision threshold mask
      sk98lin: fix truncated collision threshold mask
      sky2: sky2_reset section mismatch
      sky2: NAPI suspend/resume of dual port cards
      sky2: PHY power on delays
      sky2: optimize receive restart
      [IPV4]: Clear skb cb on IP input
      [PKT_SCHED] HTB: initialize upper bound properly
      [VLAN]: __vlan_hwaccel_rx can use the faster ether_compare_addr

Steve French:
      [CIFS] CIFS_DEBUG2 depends on CIFS

Steven Rostedt:
      remove set_wmb - doc update
      remove set_wmb - arch removal

Takashi Iwai:
      [ALSA] Reduce the string length of Terratec Aureon 7.1 Universe
      [ALSA] intel8x0 - Add ac97 quirk for Tyan Thunder K8WE board
      [ALSA] trivial: Code clean up of i2c/cs8427.c
      [ALSA] Fix workaround for AD1988A rev2 codec
      [ALSA] Fix section mismatch errors in ALSA PCI drivers
      [ALSA] Fix a deadlock in snd-rtctimer
      [ALSA] hda-codec - Fix missing array terminators in AD1988 codec support

Thiemo Seufer:
      [MIPS] Uses MIPS_CONF_AR instead of magic constants.
      [MIPS] Save 2k text size in cpu-probe
      [MIPS] Sibyte: Improve interrupt latency again for sb1250/bcm1480
      [MIPS] BCM1480: Fix fatal typo in the rewritten interrupt handler.
      [MIPS] IP32: Fix wreckage caused by recent SA_* constant replacement.
      [MIPS] Oprofile: Fix build failure due to warning and -Werror.
      [MIPS] Print out TLB handler assembly for debugging.

Thomas Andrews:
      scx200_acb: Fix the state machine

Thomas Gleixner:
      pi-futex: Validate futex type instead of oopsing
      [ARM] 3728/1: Restore missing CPU Hotplug irq helper

Thomas Graf:
      [PKT_SCHED]: act_api: Fix module leak while flushing actions

Tyler:
      uml: clean up address space limits code

Urs Thuermann:
      RCU Documentation fix

Uwe Bugla:
      i2c-algo-bit: Wipe out dead code

Vadim Lobanov:
      i386: remove redundant might_sleep() in user accessors.

Vu Pham:
      srp: fix fmr error handling

Xiaoliang (David) Wei:
      [TCP] tcp_highspeed: Fix AI updates.

Yoichi Yuasa:
      [MIPS] vr41xx: Removed unused definitions for NEC CMBVR4133.
      [MIPS] Au1000: Remove au1000 code.
      [MIPS] MIPS MT: Fix build error.
      [MIPS] VR41xx: Set VR41_CONF_BP only for PrId 0x0c80.
      [MIPS] vr41xx: Changed workaround to recommended method
      [MIPS] vr41xx: Replace magic number for P4K bit with symbol.
      [MIPS] Remove vmlinux.rm200 target from makefile.
      [MIPS] vr41xx: Move IRQ numbers to asm-mips/vr41xx/irq.h
      [MIPS] vr41xx: Removed old v2.4 VRC4173 driver
      [MIPS] vr41xx: Update e55 setup function
      [MIPS] vr41xx: Update workpad setup function

YOSHIFUJI Hideaki:
      [IPV6]: Use ipv6_addr_src_scope for link address sorting.

Yoshinori Sato:
      h8300 remove duplicate define

Zang Roy-r61911:
      [SERIAL] 8250: add tsi108 serial support

Zhang, Yanmin:
      mmap zero-length hugetlb file with PROT_NONE to protect a hugetlb virtual area
      PCI: add PCI Express AER register definitions to pci_regs.h

Zoran Marceta:
      usbfs: use the correct signal number for disconnection

