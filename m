Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbWIDIcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWIDIcQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 04:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750921AbWIDIcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 04:32:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2461 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751321AbWIDCnA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 22:43:00 -0400
Date: Sun, 3 Sep 2006 19:42:47 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.18-rc6
Message-ID: <Pine.LNX.4.64.0609031939100.27779@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Things are definitely calming down, and while I'm not ready to call it a 
final 2.6.18 yet, this migt be the last -rc.

There's a few x86-64 updates, ARM and ppc stuff, and a couple of driver 
fixes. And a small cifs update. Both ShortLog and diffstat is appended, 
since they are both fairly small and easily viewed.

		Linus

--- shortlog snip snip ---

Adrian Bunk:
      [XFS] Fix char size overflow in bmap_alloc call for unwritten extent
      schedule obsolete OSS drivers for removal, 2nd round

Akinobu Mita:
      [NETLINK]: Call panic if nl_table allocation fails
      [NET]: Rate limiting for socket allocation failure messages.

Alan Cox:
      Missing PCI id update for VIA IDE

Alan Stern:
      UHCI: don't stop at an Iso error
      uhci-hcd: fix list access bug

Andi Kleen:
      x86_64: Update defconfig
      x86: Revert e820 MCFG heuristics
      x86_64: Add kernel thread stack frame termination for properly stopping stack unwinds.
      i386: Add kernel thread stack frame termination for properly stopping stack unwinds.
      x86_64: Recover 1MB of kernel memory
      x86_64: Remove alternative_smp
      i386: Remove alternative_smp
      x86: Disable MMCONFIG on Intel SDV using DMI blacklist
      x86_64: Remove __KERNEL__ ifdef around _syscall*()
      i386: Fix stack switching in do_IRQ
      i386: Remove __KERNEL__ ifdef around _syscall*()

Andrew Morton:
      USB: rtl8150_disconnect() needs tasklet_kill()
      x86: increase MAX_MP_BUSSES on default arch

Badari Pulavarty:
      manage-jbd-its-own-slab fix

Ben Dooks:
      [ARM] 3764/1: S3C24XX: change type naming to kernel style
      [ARM] 3765/1: S3C24XX: cleanup include/asm-arm/arch-s3c2410/dma.h

Benjamin Herrenschmidt:
      [POWERPC] Fix performance regression in IRQ radix tree locking
      [POWERPC] Fix MPIC sense codes in documentation
      [POWERPC] Make OF irq map code detect more error cases
      fbdev: Fix crashes in various fbdev's blank routines
      powerpc: More via-pmu backlight fixes
      powerpc: Fix PowerMac IRQ handling bug
      backlight last round of fixes
      powerpc: Fix typo in powermac platform functions

Bill Huey (hui:
      xtensa: ptrace: EXIT_ZOMBIE fix

Chris Wright:
      i386: rwlock.h fix smp alternatives fix

Christoph Lameter:
      [IA64] Increase default nodes shift to 10, nr_cpus to 1024
      ZVC: Overstep counters
      ZVC: Scale thresholds depending on the size of the system

Corey Minyard:
      IPMI: fix occasional oops on module unload

Daikichi Osuga:
      [TCP]: Two RFC3465 Appropriate Byte Count fixes.

Daniel Jacobowitz:
      [ARM] 3748/3: Correct error check in vfp_raise_exceptions
      [ARM] 3749/3: Correct VFP single/double conversion emulation
      [ARM] 3758/1: Preserve signalling NaNs in conversion
      [ARM] 3750/3: Fix double VFP emulation for EABI kernels

David Brownell:
      [ARM] 3741/1: remove sa1111.c build warning on non-sa1100 systems
      [ARM] 3763/1: add both rtcs to csb337 defconfig
      usb gadget: g_ether spinlock recursion fix

David S. Miller:
      [E100]: Add module option to ignore bad EEPROM checksums.
      [SPARC64]: Fix X server hangs due to large pages.

Dean Nelson:
      [IA64-SGI] Silent data corruption caused by XPC V2.

George G. Davis:
      [ARM] 3762/1: Fix ptrace cache coherency bug for ARM1136 VIPT nonaliasing Harvard caches

Heiko Carstens:
      [S390] cio: kernel stack overflow.

Helge Deller:
      [SERIAL] 8250: constify some serial structs

Henrik Kretzschmar:
      kerneldoc for handle_bad_irq()

Horst Hummel:
      [S390] dasd: fix device shutdown process.

Ian E. Morgan:
      SBC8360: module_param() permission fixes

Jan Beulich:
      x86: fix x86 cpuid keys used in alternative_smp()
      x86: Make backtracer fallback logic more bullet-proof

Jeremy Allison:
      [CIFS]

Jeremy Roberson:
      hid-core.c: Adds all GTCO CalComp Digitizers and InterWrite School Products to blacklist

John Keller:
      sgiioc4: fixup use of mmio ops

john stultz:
      Fix faulty HPET clocksource usage (fix for bug #7062)

Jon Loeliger:
      [POWERPC] Allow MPC8641 HPCN to build with CONFIG_PCI disabled too.
      [POWERPC] Use mpc8641hpcn PIC base address from dev tree.

juergen.mell@t-online.de:
      USB floppy drive SAMSUNG SFD-321U/EP detected 8 times

Keir Fraser:
      [IPV6]: ipv6_add_addr should install dstentry earlier

Keith Owens:
      x86_64: Save original IST values for checking stack addresses

Kim Phillips:
      [POWERPC] back up old school ipic.[hc] to arch/ppc
      [POWERPC] Adapt ipic driver to new host_ops interface, add set_irq_type to set IRQ sense
      [POWERPC] modify mpc83xx platforms to use new IRQ layer
      [POWERPC] Add MPC8349E MDS device tree source file to arch/powerpc/boot/dts

Krzysztof Helt:
      [SUNLANCE]: Fix probing problem.

Lennert Buytenhek:
      [ARM] 3761/1: fix armv4t breakage after adding thumb interworking to userspace helpers

Linus Torvalds:
      Linux 2.6.18-rc6

Lv Liangying:
      [IPV6]: SNMPv2 "ipv6IfStatsInAddrErrors" counter error

Mark Hindley:
      USB: Add VIA quirk fixup for VT8235 usb2

Martin Schwidefsky:
      [S390] broken copy_in_user function.

Matt Porter:
      [POWERPC] Remove flush_dcache_all export
      [POWERPC] Fix powerpc 44x_mmu build

Nathan Scott:
      [XFS] Update the MAINTAINERS file entry for XFS.

NeilBrown:
      md: Fix issues with referencing rdev in md/raid1

Nishanth Aravamudan:
      fix NUMA interleaving for huge pages

Nobuhiro Iwamatsu:
      USB: Support for ELECOM LD-USB20 in pegasus

Olaf Hering:
      exit early in floppy_init when no floppy exists

Oleg Nesterov:
      eligible_child: remove an obsolete ->tgid check

Paul Fulghum:
      synclink_gt: fix receive tty error handling

Paul Jackson:
      [IA64] panic if topology_init kzalloc fails

Paul Mackerras:
      [POWERPC] Restore copyright notice in arch/powerpc/kernel/fpu.S
      [POWERPC] Fix problem with time not advancing on 32-bit platforms
      [POWERPC] Fix irq enable/disable in smp_generic_take_timebase
      [POWERPC] Fix return value from memcpy
      ppc32: fix last_jiffy time comparison

Paul Sokolovsky:
      [ARM] 3760/1: This patch adds timeouts while working with SSP registers. Such timeouts were en

Pavel Mironchik:
      dm: work around mempool_alloc, bio_alloc_bioset deadlocks

Peter Horton:
      [SERIAL] Support for Intashield 2 port PCI serial card

Peter Oberparleiter:
      [S390] cio: no path after machine check.

Phil Dibowitz:
      USB Storage: Remove the finecam3 unusual_devs entry
      USB Storage: unusual_devs.h for Sony Ericsson M600i

Ping Cheng:
      USB: add all wacom device to hid-core.c blacklist

Roland Dreier:
      IB/mthca: Use IRQ safe locks to protect allocation bitmaps

Roland Scheidegger:
      drm: radeon flush TCL VAP for vertex program enable/disable

Russ Anderson:
      [IA64] remove redundant local_irq_save() calls from sn_sal.h

Russell King:
      [ARM] Arrange for isa.c to use named initialisers
      [ARM] Move prototype for register_isa_ports to asm/io.h
      [ARM] Add Integrator support for glibc outb() and friends
      [ARM] Fix ARM __raw_read_trylock() implementation

Sergei Shtylyov:
      [SERIAL] Make uart_match_port() work with all memory mapped UARTs

Shailabh Nagar:
      task delay accounting fixes

Sridhar Samudrala:
      [SCTP]: Fix sctp_primitive_ABORT() call in sctp_close().

Stefan Bader:
      [S390] cio: unsolicited interrupts during sense pgid.

Stephen Hemminger:
      [STRIP]: Fix neighbour table refcount leak.

Stephen Rothwell:
      [POWERPC] iseries: Define insw et al. so libata/ide will compile

Steve French:
      [CIFS] Do not time out posix brl requests when using new posix setfileinfo
      [CIFS] spinlock protect read of last srv response time in timeout path
      [CIFS] Make midState usage more consistent
      [CIFS] Allow cifsd to suspend if connection is lost
      [CIFS] Fix oops when negotiating lanman and no password specified
      [CIFS] Fix oops in cifs_close due to unitialized lock sem and list in
      [CIFS] endian errors in lanman protocol support
      [CIFS] Do not send Query All EAs SMB when mount option nouser_xattr

Suleiman Souhlal:
      x86_64: Don't write out segments from vsyscall32 DSO if it is not mapped

Takashi Iwai:
      ALSA: ac97: correct some Mic mixer elements

Wei Dong:
      [IPV4]: Fix SNMPv2 "ipFragFails" counter error

Will Schmidt:
      [POWERPC] Fix up ibm_architecture_vec definition

YOSHIFUJI Hideaki:
      [IPV6]: Fix kernel OOPs when setting sticky socket options.

Zang Roy-r61911:
      [POWERPC] Add mpc7448hpc2 device tree source file
      [POWERPC] Support for "weird" MPICs and fixup mpc7448_hpc2

--- diffstat snip snip ---

 Documentation/feature-removal-schedule.txt        |    7 
 Documentation/kernel-parameters.txt               |    2 
 Documentation/powerpc/booting-without-of.txt      |    6 
 MAINTAINERS                                       |    3 
 Makefile                                          |    2 
 arch/arm/Makefile                                 |    3 
 arch/arm/common/sa1111.c                          |    6 
 arch/arm/configs/csb337_defconfig                 |   37 +
 arch/arm/kernel/Makefile                          |    3 
 arch/arm/kernel/isa.c                             |   63 +
 arch/arm/mach-footbridge/dc21285.c                |    1 
 arch/arm/mach-integrator/pci_v3.c                 |    2 
 arch/arm/mach-pxa/corgi_ssp.c                     |   20 
 arch/arm/mach-pxa/ssp.c                           |   35 +
 arch/arm/mach-s3c2410/dma.c                       |   88 +-
 arch/arm/mach-sa1100/ssp.c                        |   46 +
 arch/arm/mm/Kconfig                               |   13 
 arch/arm/mm/flush.c                               |   26 +
 arch/arm/vfp/vfp.h                                |   18 
 arch/arm/vfp/vfpdouble.c                          |   50 +
 arch/arm/vfp/vfphw.S                              |   10 
 arch/arm/vfp/vfpmodule.c                          |    4 
 arch/arm/vfp/vfpsingle.c                          |   55 +
 arch/i386/kernel/head.S                           |   14 
 arch/i386/kernel/hpet.c                           |    2 
 arch/i386/kernel/irq.c                            |    5 
 arch/i386/kernel/setup.c                          |   32 -
 arch/i386/kernel/traps.c                          |   27 -
 arch/i386/pci/common.c                            |    5 
 arch/i386/pci/mmconfig.c                          |   34 +
 arch/i386/pci/pci.h                               |    3 
 arch/ia64/Kconfig                                 |    4 
 arch/ia64/kernel/topology.c                       |    6 
 arch/ia64/sn/kernel/xpc_channel.c                 |    4 
 arch/ia64/sn/kernel/xpc_main.c                    |   28 -
 arch/ia64/sn/kernel/xpc_partition.c               |   24 -
 arch/powerpc/Kconfig                              |   20 
 arch/powerpc/boot/dts/mpc7448hpc2.dts             |  190 ++++
 arch/powerpc/boot/dts/mpc8349emds.dts             |  328 ++++++++
 arch/powerpc/configs/mpc834x_mds_defconfig        |  915 +++++++++++++++++++++
 arch/powerpc/configs/mpc834x_sys_defconfig        |  915 ---------------------
 arch/powerpc/kernel/fpu.S                         |    5 
 arch/powerpc/kernel/irq.c                         |   84 ++
 arch/powerpc/kernel/pci_64.c                      |   11 
 arch/powerpc/kernel/ppc_ksyms.c                   |    4 
 arch/powerpc/kernel/prom_init.c                   |   10 
 arch/powerpc/kernel/prom_parse.c                  |   17 
 arch/powerpc/kernel/smp-tbsync.c                  |    5 
 arch/powerpc/kernel/time.c                        |   25 -
 arch/powerpc/lib/memcpy_64.S                      |   11 
 arch/powerpc/mm/44x_mmu.c                         |    4 
 arch/powerpc/platforms/83xx/mpc834x_itx.c         |   49 -
 arch/powerpc/platforms/83xx/mpc834x_sys.c         |   56 -
 arch/powerpc/platforms/83xx/mpc83xx.h             |    1 
 arch/powerpc/platforms/83xx/pci.c                 |    9 
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c        |   26 -
 arch/powerpc/platforms/86xx/pci.c                 |    3 
 arch/powerpc/platforms/embedded6xx/Kconfig        |    1 
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |    2 
 arch/powerpc/platforms/powermac/pfunc_base.c      |    2 
 arch/powerpc/platforms/powermac/pic.c             |    6 
 arch/powerpc/sysdev/Makefile                      |    4 
 arch/powerpc/sysdev/ipic.c                        |  303 +++++--
 arch/powerpc/sysdev/ipic.h                        |   23 -
 arch/powerpc/sysdev/mpic.c                        |  223 ++++-
 arch/ppc/kernel/smp-tbsync.c                      |    7 
 arch/ppc/syslib/Makefile                          |    2 
 arch/ppc/syslib/ipic.c                            |  646 +++++++++++++++
 arch/ppc/syslib/ipic.h                            |   47 +
 arch/s390/lib/uaccess.S                           |   33 -
 arch/s390/lib/uaccess64.S                         |   35 -
 arch/sparc64/mm/generic.c                         |    2 
 arch/x86_64/defconfig                             |   66 --
 arch/x86_64/ia32/ia32_binfmt.c                    |   57 +
 arch/x86_64/kernel/e820.c                         |   35 -
 arch/x86_64/kernel/entry.S                        |    3 
 arch/x86_64/kernel/head.S                         |    1 
 arch/x86_64/kernel/init_task.c                    |    5 
 arch/x86_64/kernel/setup.c                        |    6 
 arch/x86_64/kernel/setup64.c                      |    3 
 arch/x86_64/kernel/traps.c                        |   30 -
 arch/x86_64/pci/mmconfig.c                        |   34 +
 arch/xtensa/kernel/ptrace.c                       |    2 
 drivers/block/floppy.c                            |   12 
 drivers/char/drm/radeon_state.c                   |    9 
 drivers/char/ipmi/ipmi_msghandler.c               |    1 
 drivers/char/synclink_gt.c                        |   14 
 drivers/char/watchdog/sbc8360.c                   |    4 
 drivers/ide/pci/sgiioc4.c                         |   60 +
 drivers/ide/pci/via82cxxx.c                       |    3 
 drivers/infiniband/hw/mthca/mthca_allocator.c     |   15 
 drivers/macintosh/via-pmu-backlight.c             |   99 +-
 drivers/macintosh/via-pmu.c                       |   12 
 drivers/md/raid1.c                                |   57 +
 drivers/net/e100.c                                |    6 
 drivers/net/sunlance.c                            |   27 -
 drivers/net/wireless/strip.c                      |    6 
 drivers/pci/quirks.c                              |    1 
 drivers/s390/block/dasd.c                         |  192 +++-
 drivers/s390/block/dasd_genhd.c                   |   10 
 drivers/s390/cio/ccwgroup.c                       |   14 
 drivers/s390/cio/chsc.c                           |   10 
 drivers/s390/cio/device.c                         |   19 
 drivers/s390/cio/device_fsm.c                     |   20 
 drivers/s390/cio/device_pgid.c                    |   27 -
 drivers/serial/8250_pci.c                         |   31 +
 drivers/serial/serial_core.c                      |    3 
 drivers/usb/gadget/ether.c                        |   45 +
 drivers/usb/host/uhci-q.c                         |    4 
 drivers/usb/input/hid-core.c                      |  149 ++-
 drivers/usb/net/pegasus.h                         |    3 
 drivers/usb/net/rtl8150.c                         |    1 
 drivers/usb/storage/unusual_devs.h                |   24 -
 drivers/video/aty/aty128fb.c                      |   18 
 drivers/video/aty/atyfb_base.c                    |   18 
 drivers/video/aty/radeon_backlight.c              |    4 
 drivers/video/nvidia/nv_backlight.c               |   18 
 drivers/video/riva/fbdev.c                        |   18 
 fs/cifs/CHANGES                                   |   10 
 fs/cifs/README                                    |    2 
 fs/cifs/cifsencrypt.c                             |    3 
 fs/cifs/cifsfs.c                                  |    6 
 fs/cifs/cifsfs.h                                  |    2 
 fs/cifs/cifsglob.h                                |   18 
 fs/cifs/cifsproto.h                               |    4 
 fs/cifs/cifssmb.c                                 |   28 +
 fs/cifs/connect.c                                 |   32 +
 fs/cifs/dir.c                                     |    4 
 fs/cifs/file.c                                    |   97 ++
 fs/cifs/netmisc.c                                 |    1 
 fs/cifs/readdir.c                                 |    2 
 fs/cifs/sess.c                                    |    2 
 fs/cifs/smberr.h                                  |    1 
 fs/cifs/transport.c                               |  618 +++++++++-----
 fs/cifs/xattr.c                                   |    6 
 fs/jbd/transaction.c                              |    2 
 fs/xfs/xfs_bmap.c                                 |    2 
 include/asm-arm/arch-pxa/ssp.h                    |    4 
 include/asm-arm/arch-s3c2410/dma.h                |  150 ++-
 include/asm-arm/cacheflush.h                      |   18 
 include/asm-arm/hardware/ssp.h                    |    4 
 include/asm-arm/io.h                              |    7 
 include/asm-arm/spinlock.h                        |   16 
 include/asm-i386/alternative.h                    |   20 
 include/asm-i386/mach-default/mach_mpspec.h       |    4 
 include/asm-i386/rwlock.h                         |   28 -
 include/asm-i386/spinlock.h                       |   17 
 include/asm-i386/unistd.h                         |    4 
 include/asm-i386/unwind.h                         |    1 
 include/asm-ia64/sn/sn_sal.h                      |    6 
 include/asm-ia64/sn/xp.h                          |   22 -
 include/asm-ia64/sn/xpc.h                         |    4 
 include/asm-powerpc/io.h                          |    7 
 include/asm-powerpc/ipic.h                        |   12 
 include/asm-powerpc/mpc86xx.h                     |    3 
 include/asm-powerpc/mpic.h                        |  125 +++
 include/asm-powerpc/prom.h                        |    4 
 include/asm-powerpc/time.h                        |    4 
 include/asm-x86_64/alternative.h                  |   21 
 include/asm-x86_64/processor.h                    |    6 
 include/asm-x86_64/spinlock.h                     |   11 
 include/asm-x86_64/unistd.h                       |   11 
 include/asm-x86_64/unwind.h                       |    1 
 include/linux/delayacct.h                         |   10 
 include/linux/mmzone.h                            |    1 
 include/linux/pci_ids.h                           |    4 
 include/linux/sched.h                             |    1 
 kernel/delayacct.c                                |   16 
 kernel/exit.c                                     |    3 
 kernel/fork.c                                     |    6 
 kernel/irq/handle.c                               |    5 
 mm/mempolicy.c                                    |   10 
 mm/mempool.c                                      |    9 
 mm/vmstat.c                                       |  151 +++
 net/ipv4/ip_output.c                              |    1 
 net/ipv4/tcp_cong.c                               |    2 
 net/ipv4/tcp_input.c                              |    9 
 net/ipv6/addrconf.c                               |    4 
 net/ipv6/exthdrs.c                                |   29 -
 net/ipv6/route.c                                  |    4 
 net/netlink/af_netlink.c                          |   14 
 net/sctp/socket.c                                 |   10 
 net/socket.c                                      |    3 
 sound/oss/Kconfig                                 |   30 +
 sound/pci/ac97/ac97_codec.c                       |    4 
 185 files changed, 4986 insertions(+), 2598 deletions(-)

-- 
VGER BF report: S 0.999339
