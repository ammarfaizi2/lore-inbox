Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273355AbRIVEB5>; Sat, 22 Sep 2001 00:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273457AbRIVEBm>; Sat, 22 Sep 2001 00:01:42 -0400
Received: from femail17.sdc1.sfba.home.com ([24.0.95.144]:62379 "EHLO
	femail17.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S273355AbRIVEBX>; Sat, 22 Sep 2001 00:01:23 -0400
Date: Fri, 21 Sep 2001 23:58:20 -0400 (EDT)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@zod.capslock.lan>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Linux kernel 2.3.99-pre9 released (fwd)
Message-ID: <Pine.LNX.4.33.0109212358020.25731-100000@zod.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
X-Spam-To: uce@ftc.gov
Copyright: Copyright 2001 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there some time travel going on?



---------- Forwarded message ----------
Date: Fri, 21 Sep 2001 16:44:45 -0700
From: Linux Kernel Distribution System <kdist@linux.kernel.org>
To: linux-kernel-announce@hera.kernel.org
Subject: Linux kernel 2.3.99-pre9 released

Linux kernel version 2.3.99-pre9 has been released.  It is available from:

Patch:		ftp://ftp.kernel.org/pub/linux/kernel/v2.3/patch-2.3.99-pre9.gz
Full source:	ftp://ftp.kernel.org/pub/linux/kernel/v2.3/linux-2.3.99-pre9.tar.gz

Sizes in bytes			Compressed	Uncompressed
------------------------------------------------------------
Patch                               485801           2058800
Full source                       20881782          89313280

-----------------------------------------------------------------------------
 This is an automatically generated message.  To unsubscribe from this list,
 please send a message to majordomo@vger.kernel.org containing
 the line:

   unsubscribe linux-kernel-announce <your_email_address>

 ... where <your_email_address> is the email address you are receiving
     this message at.
-----------------------------------------------------------------------------

The following files were changed in this release:

 CREDITS                                   |   43
 Documentation/Configure.help              |   18
 Documentation/DocBook/Makefile            |   17
 Documentation/DocBook/kernel-api.tmpl     |    5
 Documentation/DocBook/kernel-hacking.tmpl | 1316 +++++++++++
 Documentation/DocBook/kernel-locking.tmpl | 1221 ++++++++++
 Documentation/DocBook/parportbook.tmpl    | 3408 +++++++++++++++++-------------
 Documentation/filesystems/cramfs.txt      |    4
 Documentation/kbuild/config-language.txt  |    2
 Documentation/kernel-doc-nano-HOWTO.txt   |  128 +
 Documentation/networking/8139too.txt      |   33
 Documentation/pci.txt                     |   10
 Documentation/s390/DASD                   |    2
 Documentation/usb/ov511.txt               |   52
 Documentation/usb/usb-serial.txt          |   25
 Documentation/video4linux/bttv/CARDLIST   |    4
 MAINTAINERS                               |   15
 Makefile                                  |    6
 arch/alpha/kernel/osf_sys.c               |    7
 arch/arm/Makefile                         |    2
 arch/arm/def-configs/ebsa110              |   41
 arch/arm/def-configs/footbridge           |  152 -
 arch/arm/def-configs/rpc                  |  199 +
 arch/arm/kernel/Makefile                  |    2
 arch/arm/kernel/iic.c                     |  248 --
 arch/arm/kernel/traps.c                   |    6
 arch/arm/lib/Makefile                     |    1
 arch/i386/config.in                       |    1
 arch/i386/defconfig                       |    8
 arch/i386/kernel/acpi.c                   |    2
 arch/i386/kernel/apic.c                   |    5
 arch/i386/kernel/apm.c                    |   50
 arch/i386/kernel/i8259.c                  |    2
 arch/i386/kernel/io_apic.c                |   32
 arch/i386/kernel/irq.c                    |    8
 arch/i386/kernel/ldt.c                    |    1
 arch/i386/kernel/mpparse.c                |   15
 arch/i386/kernel/pci-i386.c               |   22
 arch/i386/kernel/pci-irq.c                |    3
 arch/i386/kernel/pci-pc.c                 |   11
 arch/i386/kernel/setup.c                  |   58
 arch/i386/kernel/traps.c                  |    2
 arch/i386/mm/init.c                       |   54
 arch/ia64/ia32/sys_ia32.c                 |    4
 arch/mips/Makefile                        |    2
 arch/mips/arc/Makefile                    |    2
 arch/mips/arc/cmdline.c                   |    2
 arch/mips/arc/env.c                       |    6
 arch/mips/arc/file.c                      |    2
 arch/mips/arc/identify.c                  |    2
 arch/mips/arc/init.c                      |    4
 arch/mips/arc/memory.c                    |    7
 arch/mips/arc/misc.c                      |    2
 arch/mips/arc/salone.c                    |    2
 arch/mips/arc/time.c                      |    2
 arch/mips/arc/tree.c                      |    2
 arch/mips/baget/Makefile                  |   24
 arch/mips/baget/baget.c                   |    8
 arch/mips/baget/bagetIRQ.S                |    2
 arch/mips/baget/balo.c                    |    2
 arch/mips/baget/irq.c                     |    3
 arch/mips/baget/print.c                   |    2
 arch/mips/baget/prom/Makefile             |    2
 arch/mips/baget/time.c                    |    2
 arch/mips/baget/vacserial.c               |    2
 arch/mips/boot/Makefile                   |    2
 arch/mips/config.in                       |  362 +--
 arch/mips/ddb5074/Makefile                |    4
 arch/mips/ddb5074/int-handler.S           |    4
 arch/mips/ddb5074/irq.c                   |    4
 arch/mips/ddb5074/nile4.c                 |    4
 arch/mips/ddb5074/pci-dma.c               |   38
 arch/mips/ddb5074/pci.c                   |  281 +-
 arch/mips/ddb5074/prom.c                  |    4
 arch/mips/ddb5074/setup.c                 |   17
 arch/mips/ddb5074/time.c                  |    4
 arch/mips/dec/irq.c                       |    2
 arch/mips/dec/prom/Makefile               |    2
 arch/mips/dec/prom/init.c                 |    2
 arch/mips/dec/prom/memory.c               |    2
 arch/mips/dec/reset.c                     |    2
 arch/mips/dec/rtc-dec.c                   |    2
 arch/mips/dec/serial.c                    |   18
 arch/mips/defconfig                       |  204 -
 arch/mips/defconfig-decstation            |  141 -
 arch/mips/defconfig-ip22                  |  169 -
 arch/mips/jazz/Makefile                   |    2
 arch/mips/jazz/floppy-jazz.c              |    2
 arch/mips/jazz/int-handler.S              |    2
 arch/mips/jazz/kbd-jazz.c                 |    2
 arch/mips/jazz/reset.c                    |    2
 arch/mips/jazz/rtc-jazz.c                 |    2
 arch/mips/jazz/setup.c                    |    2
 arch/mips/kernel/Makefile                 |    2
 arch/mips/kernel/entry.S                  |    2
 arch/mips/kernel/fpe.c                    |    2
 arch/mips/kernel/gdb-low.S                |    2
 arch/mips/kernel/gdb-stub.c               |    2
 arch/mips/kernel/head.S                   |  175 -
 arch/mips/kernel/irix5sys.h               |    2
 arch/mips/kernel/irixelf.c                |   38
 arch/mips/kernel/irixinv.c                |    2
 arch/mips/kernel/irixioctl.c              |    2
 arch/mips/kernel/irixsig.c                |    2
 arch/mips/kernel/irq.c                    |   18
 arch/mips/kernel/mips_ksyms.c             |   10
 arch/mips/kernel/proc.c                   |   11
 arch/mips/kernel/process.c                |    6
 arch/mips/kernel/ptrace.c                 |  108
 arch/mips/kernel/r2300_fpu.S              |    2
 arch/mips/kernel/r2300_switch.S           |    2
 arch/mips/kernel/r4k_fpu.S                |    3
 arch/mips/kernel/r4k_misc.S               |    2
 arch/mips/kernel/r4k_switch.S             |    2
 arch/mips/kernel/r6000_fpu.S              |    2
 arch/mips/kernel/scall_o32.S              |    2
 arch/mips/kernel/setup.c                  |  149 +
 arch/mips/kernel/signal.c                 |    2
 arch/mips/kernel/softfp.S                 |    2
 arch/mips/kernel/syscall.c                |    2
 arch/mips/kernel/syscalls.h               |    4
 arch/mips/kernel/sysirix.c                |    8
 arch/mips/kernel/sysmips.c                |    9
 arch/mips/kernel/traps.c                  |   59
 arch/mips/kernel/unaligned.c              |    3
 arch/mips/lib/Makefile                    |    2
 arch/mips/lib/csum_partial.S              |    2
 arch/mips/lib/csum_partial_copy.c         |    2
 arch/mips/lib/floppy-no.c                 |    2
 arch/mips/lib/floppy-std.c                |    2
 arch/mips/lib/ide-no.c                    |    2
 arch/mips/lib/ide-std.c                   |    2
 arch/mips/lib/kbd-no.c                    |    2
 arch/mips/lib/kbd-std.c                   |    2
 arch/mips/lib/memcpy.S                    |    2
 arch/mips/lib/memset.S                    |    2
 arch/mips/lib/r3k_dump_tlb.c              |    2
 arch/mips/lib/rtc-no.c                    |    2
 arch/mips/lib/rtc-std.c                   |    2
 arch/mips/lib/strlen_user.S               |    2
 arch/mips/lib/strncpy_user.S              |    2
 arch/mips/lib/strnlen_user.S              |    2
 arch/mips/lib/watch.S                     |    2
 arch/mips/mm/andes.c                      |    2
 arch/mips/mm/fault.c                      |   19
 arch/mips/mm/init.c                       |    2
 arch/mips/mm/loadmmu.c                    |    4
 arch/mips/mm/r2300.c                      |    9
 arch/mips/mm/r4xx0.c                      |    2
 arch/mips/sgi/kernel/Makefile             |    2
 arch/mips/sgi/kernel/indyIRQ.S            |    2
 arch/mips/sgi/kernel/indy_hpc.c           |    1
 arch/mips/sgi/kernel/indy_int.c           |   20
 arch/mips/sgi/kernel/indy_mc.c            |    2
 arch/mips/sgi/kernel/indy_rtc.c           |    2
 arch/mips/sgi/kernel/indy_sc.c            |   44
 arch/mips/sgi/kernel/indy_timer.c         |    2
 arch/mips/sgi/kernel/promcon.c            |    3
 arch/mips/sgi/kernel/reset.c              |    2
 arch/mips/sgi/kernel/setup.c              |   14
 arch/mips/sgi/kernel/system.c             |    2
 arch/mips/sgi/kernel/time.c               |    2
 arch/mips/sni/Makefile                    |    2
 arch/mips/sni/dma.c                       |    2
 arch/mips/sni/int-handler.S               |    2
 arch/mips/sni/io.c                        |    2
 arch/mips/sni/pci.c                       |    2
 arch/mips/sni/pcimt_scache.c              |    2
 arch/mips/sni/setup.c                     |    2
 arch/mips/tools/Makefile                  |    2
 arch/mips/tools/offset.c                  |    2
 arch/mips64/Makefile                      |    2
 arch/mips64/arc/Makefile                  |    2
 arch/mips64/arc/cmdline.c                 |    2
 arch/mips64/arc/console.c                 |    2
 arch/mips64/arc/env.c                     |    2
 arch/mips64/arc/file.c                    |    2
 arch/mips64/arc/identify.c                |    2
 arch/mips64/arc/misc.c                    |    2
 arch/mips64/arc/printf.c                  |    2
 arch/mips64/arc/salone.c                  |    2
 arch/mips64/arc/time.c                    |    2
 arch/mips64/arc/tree.c                    |    2
 arch/mips64/boot/Makefile                 |    2
 arch/mips64/config.in                     |   29
 arch/mips64/defconfig                     |   52
 arch/mips64/defconfig-ip22                |   70
 arch/mips64/defconfig-ip27                |   92
 arch/mips64/kernel/Makefile               |    6
 arch/mips64/kernel/binfmt_elf32.c         |    2
 arch/mips64/kernel/branch.c               |    2
 arch/mips64/kernel/entry.S                |    8
 arch/mips64/kernel/head.S                 |   51
 arch/mips64/kernel/ioctl32.c              |  529 ++++
 arch/mips64/kernel/linux32.c              | 1317 +++++++++++
 arch/mips64/kernel/mips64_ksyms.c         |   12
 arch/mips64/kernel/proc.c                 |    7
 arch/mips64/kernel/process.c              |   14
 arch/mips64/kernel/ptrace.c               |  548 ++++
 arch/mips64/kernel/r4k_cache.S            |    2
 arch/mips64/kernel/r4k_fpu.S              |    2
 arch/mips64/kernel/r4k_genex.S            |   10
 arch/mips64/kernel/r4k_switch.S           |   12
 arch/mips64/kernel/r4k_tlb_debug.c        |    2
 arch/mips64/kernel/r4k_tlb_glue.S         |   32
 arch/mips64/kernel/scall_64.S             |   14
 arch/mips64/kernel/scall_o32.S            |   85
 arch/mips64/kernel/setup.c                |   12
 arch/mips64/kernel/signal.c               |   59
 arch/mips64/kernel/signal32.c             |   99
 arch/mips64/kernel/smp.c                  |  258 ++
 arch/mips64/kernel/softfp.S               |   77
 arch/mips64/kernel/syscall.c              |    9
 arch/mips64/kernel/traps.c                |   22
 arch/mips64/kernel/unaligned.c            |    2
 arch/mips64/lib/Makefile                  |    2
 arch/mips64/lib/csum_partial.S            |    2
 arch/mips64/lib/csum_partial_copy.c       |    2
 arch/mips64/lib/floppy-no.c               |    2
 arch/mips64/lib/floppy-std.c              |    2
 arch/mips64/lib/ide-no.c                  |    2
 arch/mips64/lib/ide-std.c                 |    2
 arch/mips64/lib/kbd-no.c                  |    2
 arch/mips64/lib/kbd-std.c                 |    2
 arch/mips64/lib/memcpy.S                  |    2
 arch/mips64/lib/memset.S                  |    2
 arch/mips64/lib/rtc-no.c                  |    2
 arch/mips64/lib/rtc-std.c                 |    2
 arch/mips64/lib/strlen_user.S             |    2
 arch/mips64/lib/strncpy_user.S            |    2
 arch/mips64/lib/strnlen_user.S            |    2
 arch/mips64/lib/watch.S                   |    2
 arch/mips64/mm/Makefile                   |    2
 arch/mips64/mm/andes.c                    |   53
 arch/mips64/mm/extable.c                  |    2
 arch/mips64/mm/fault.c                    |   52
 arch/mips64/mm/init.c                     |    8
 arch/mips64/mm/loadmmu.c                  |    2
 arch/mips64/mm/r4xx0.c                    |  143 -
 arch/mips64/mm/umap.c                     |    2
 arch/mips64/sgi-ip22/Makefile             |    2
 arch/mips64/sgi-ip22/ip22-berr.c          |    2
 arch/mips64/sgi-ip22/ip22-hpc.c           |    2
 arch/mips64/sgi-ip22/ip22-int.c           |   36
 arch/mips64/sgi-ip22/ip22-irq.S           |    2
 arch/mips64/sgi-ip22/ip22-mc.c            |    2
 arch/mips64/sgi-ip22/ip22-reset.c         |    2
 arch/mips64/sgi-ip22/ip22-rtc.c           |    2
 arch/mips64/sgi-ip22/ip22-sc.c            |   15
 arch/mips64/sgi-ip22/ip22-setup.c         |    2
 arch/mips64/sgi-ip22/ip22-timer.c         |    4
 arch/mips64/sgi-ip22/system.c             |    2
 arch/mips64/sgi-ip22/time.c               |    2
 arch/mips64/sgi-ip27/Makefile             |    4
 arch/mips64/sgi-ip27/TODO                 |   14
 arch/mips64/sgi-ip27/ip27-berr.c          |    2
 arch/mips64/sgi-ip27/ip27-init.c          |  364 ++-
 arch/mips64/sgi-ip27/ip27-irq-glue.S      |    2
 arch/mips64/sgi-ip27/ip27-irq.c           |  594 ++++-
 arch/mips64/sgi-ip27/ip27-klconfig.c      |  112
 arch/mips64/sgi-ip27/ip27-memory.c        |   42
 arch/mips64/sgi-ip27/ip27-nmi.c           |  165 +
 arch/mips64/sgi-ip27/ip27-pci-dma.c       |    2
 arch/mips64/sgi-ip27/ip27-pci.c           |  170 +
 arch/mips64/sgi-ip27/ip27-reset.c         |   23
 arch/mips64/sgi-ip27/ip27-setup.c         |  140 +
 arch/mips64/sgi-ip27/ip27-timer.c         |   85
 arch/mips64/tools/Makefile                |    2
 arch/mips64/tools/offset.c                |    1
 arch/ppc/8260_io/enet.c                   |    4
 arch/ppc/8260_io/uart.c                   |   12
 arch/ppc/configs/common_defconfig         |   16
 arch/ppc/defconfig                        |   15
 arch/ppc/kernel/chrp_pci.c                |   37
 arch/ppc/kernel/chrp_setup.c              |   39
 arch/ppc/kernel/chrp_time.c               |    9
 arch/ppc/kernel/entry.S                   |   89
 arch/ppc/kernel/head.S                    |    3
 arch/ppc/kernel/ppc_ksyms.c               |    3
 arch/ppc/kernel/ptrace.c                  |  519 +---
 arch/ppc/kernel/setup.c                   |    7
 arch/ppc/kernel/time.c                    |   24
 arch/ppc/kernel/traps.c                   |    9
 arch/ppc/mbxboot/Makefile                 |   79
 arch/ppc/mbxboot/embed_config.c           |   13
 arch/ppc/mbxboot/gzimage.c                |    8
 arch/ppc/mbxboot/head_8260.S              |   11
 arch/ppc/mbxboot/misc.c                   |    9
 arch/ppc/mbxboot/rdimage.c                |    8
 arch/ppc/mbxboot/vmlinux.lds              |  152 +
 arch/ppc/mm/fault.c                       |   93
 arch/ppc/mm/init.c                        |   10
 arch/ppc/treeboot/mkevimg                 |    2
 arch/ppc/treeboot/mkirimg                 |    6
 arch/ppc/vmlinux.lds                      |    8
 arch/sh/config.in                         |   15
 arch/sh/defconfig                         |   14
 arch/sh/kernel/Makefile                   |   10
 arch/sh/kernel/entry.S                    |   17
 arch/sh/kernel/io_generic.c               |   99
 arch/sh/kernel/io_se.c                    |  221 +
 arch/sh/kernel/irq.c                      |   10
 arch/sh/kernel/irq_ipr.c                  |  171 +
 arch/sh/kernel/irq_onchip.c               |  298 --
 arch/sh/kernel/ptrace.c                   |   36
 arch/sh/kernel/setup_se.c                 |  123 +
 arch/sh/kernel/signal.c                   |    4
 arch/sh/kernel/time.c                     |   54
 arch/sh/lib/checksum.S                    |  153 -
 arch/sh/mm/cache.c                        |  345 +--
 arch/sh/mm/fault.c                        |   81
 arch/sparc/config.in                      |    7
 arch/sparc/kernel/Makefile                |    4
 arch/sparc/kernel/entry.S                 |    2
 arch/sparc/kernel/head.S                  |    2
 arch/sparc/kernel/irq.c                   |    2
 arch/sparc/kernel/process.c               |    2
 arch/sparc/kernel/setup.c                 |    2
 arch/sparc/kernel/signal.c                |    2
 arch/sparc/kernel/sparc_ksyms.c           |    2
 arch/sparc/kernel/sun4d_irq.c             |    2
 arch/sparc/kernel/sys_sunos.c             |    7
 arch/sparc/kernel/time.c                  |    2
 arch/sparc/kernel/traps.c                 |    2
 arch/sparc/lib/rwsem.S                    |    2
 arch/sparc/mm/btfixup.c                   |    2
 arch/sparc/mm/hypersparc.S                |    2
 arch/sparc/mm/init.c                      |    2
 arch/sparc/mm/srmmu.c                     |    2
 arch/sparc/mm/sun4c.c                     |    2
 arch/sparc/mm/swift.S                     |    2
 arch/sparc/mm/tsunami.S                   |    2
 arch/sparc/mm/viking.S                    |    2
 arch/sparc64/config.in                    |    7
 arch/sparc64/kernel/Makefile              |    2
 arch/sparc64/kernel/head.S                |    2
 arch/sparc64/kernel/ioctl32.c             |   40
 arch/sparc64/kernel/irq.c                 |    2
 arch/sparc64/kernel/process.c             |    2
 arch/sparc64/kernel/setup.c               |    2
 arch/sparc64/kernel/sparc64_ksyms.c       |    2
 arch/sparc64/kernel/sys_sparc32.c         |    9
 arch/sparc64/kernel/sys_sunos32.c         |    7
 arch/sparc64/kernel/systbls.S             |    6
 arch/sparc64/kernel/time.c                |    2
 arch/sparc64/kernel/traps.c               |    2
 arch/sparc64/kernel/ttable.S              |    2
 arch/sparc64/lib/debuglocks.c             |    2
 arch/sparc64/mm/init.c                    |    2
 arch/sparc64/mm/ultra.S                   |    2
 arch/sparc64/prom/misc.c                  |    2
 arch/sparc64/solaris/misc.c               |    2
 drivers/acorn/net/Makefile                |    8
 drivers/acorn/net/ether1.c                |  232 --
 drivers/acorn/net/ether3.c                |  304 +-
 drivers/acorn/net/etherh.c                |  510 ++--
 drivers/atm/eni.c                         |    2
 drivers/block/Config.in                   |   10
 drivers/block/DAC960.c                    |  262 +-
 drivers/block/DAC960.h                    |  184 +
 drivers/block/elevator.c                  |    5
 drivers/block/floppy.c                    |  195 -
 drivers/block/loop.c                      |   72
 drivers/block/xor.c                       |    1
 drivers/char/Config.in                    |    6
 drivers/char/Makefile                     |   52
 drivers/char/bttv.c                       |  623 ++---
 drivers/char/bttv.h                       |   20
 drivers/char/epca.c                       |    3
 drivers/char/generic_serial.c             |   35
 drivers/char/lp.c                         |    8
 drivers/char/mem.c                        |   31
 drivers/char/msp3400.c                    |   16
 drivers/char/rio/func.h                   |    2
 drivers/char/rio/host.h                   |    8
 drivers/char/rio/linux_compat.h           |    1
 drivers/char/rio/rio_linux.c              |  285 --
 drivers/char/rio/rio_linux.h              |   27
 drivers/char/rio/rioboot.c                |  111
 drivers/char/rio/riocmd.c                 |    1
 drivers/char/rio/rioctrl.c                |    4
 drivers/char/rio/rioinit.c                |    2
 drivers/char/rio/riotty.c                 |   38
 drivers/char/rio/unixrup.h                |    2
 drivers/char/rtc.c                        |    7
 drivers/char/sh-sci.c                     |   31
 drivers/char/sh-sci.h                     |   25
 drivers/char/sx.c                         |   10
 drivers/char/tda7432.c                    |  505 ++++
 drivers/char/tda8425.c                    |    1
 drivers/char/tda985x.c                    |   58
 drivers/char/tda9875.c                    |  371 +++
 drivers/char/tea6420.c                    |  268 ++
 drivers/char/tty_io.c                     |    8
 drivers/char/videodev.c                   |    6
 drivers/ide/Config.in                     |    9
 drivers/ide/aec62xx.c                     |   43
 drivers/ide/alim15x3.c                    |   10
 drivers/ide/amd7409.c                     |   51
 drivers/ide/cmd64x.c                      |   34
 drivers/ide/hd.c                          |    9
 drivers/ide/hpt34x.c                      |   17
 drivers/ide/hpt366.c                      |   30
 drivers/ide/icside.c                      |  158 -
 drivers/ide/ide-disk.c                    |   11
 drivers/ide/ide-features.c                |   66
 drivers/ide/ide-pci.c                     |   20
 drivers/ide/ide-pmac.c                    |  243 +-
 drivers/ide/ide-probe.c                   |   66
 drivers/ide/ide.c                         |  224 -
 drivers/ide/pdc202xx.c                    |  245 +-
 drivers/ide/piix.c                        |  107
 drivers/ide/qd6580.c                      |  252 ++
 drivers/ide/sis5513.c                     |   16
 drivers/ide/via82cxxx.c                   |   48
 drivers/isdn/avmb1/kcapi.c                |    2
 drivers/macintosh/Makefile                |   30
 drivers/macintosh/adb.c                   |    6
 drivers/macintosh/mac_keyb.c              |   64
 drivers/macintosh/macserial.c             |  233 +-
 drivers/macintosh/macserial.h             |    2
 drivers/macintosh/mediabay.c              |  112
 drivers/macintosh/nvram.c                 |   13
 drivers/macintosh/via-pmu.c               |   49
 drivers/net/3c59x.c                       |    2
 drivers/net/8139too.c                     |  107
 drivers/net/Config.in                     |    5
 drivers/net/Makefile                      |    2
 drivers/net/Space.c                       |   22
 drivers/net/acenic.c                      |    2
 drivers/net/am79c961a.c                   |  235 +-
 drivers/net/arcnet/arc-rimi.c             |    5
 drivers/net/arcnet/com20020-isa.c         |    5
 drivers/net/arcnet/com20020-pci.c         |    4
 drivers/net/arcnet/com90io.c              |    5
 drivers/net/arcnet/com90xx.c              |    5
 drivers/net/bagetlance.c                  |    2
 drivers/net/declance.c                    |  207 -
 drivers/net/eepro100.c                    |    2
 drivers/net/epic100.c                     |    2
 drivers/net/hp100.c                       |   16
 drivers/net/ioc3-eth.c                    |   35
 drivers/net/ncr885e.c                     |    2
 drivers/net/ne2k-pci.c                    |    2
 drivers/net/pcnet32.c                     |    4
 drivers/net/ppp_synctty.c                 |   12
 drivers/net/pppoe.c                       |   83
 drivers/net/setup.c                       |   23
 drivers/net/sgiseeq.c                     |   11
 drivers/net/sgiseeq.h                     |    2
 drivers/net/sis900.c                      |    3
 drivers/net/slhc.c                        |    7
 drivers/net/starfire.c                    |    2
 drivers/net/stnic.c                       |  302 ++
 drivers/net/tulip/tulip_core.c            |    2
 drivers/net/via-rhine.c                   |    2
 drivers/net/wan/comx-hw-comx.c            |   12
 drivers/net/wan/comx-hw-locomx.c          |    8
 drivers/net/wan/comx-hw-mixcom.c          |   10
 drivers/net/wan/comx-proto-fr.c           |    9
 drivers/net/wan/comx-proto-lapb.c         |    6
 drivers/net/wan/comx.c                    |  127 -
 drivers/net/wan/lmc/lmc_main.c            |    2
 drivers/net/wavelan.c                     |    1
 drivers/net/wavelan.p.h                   |    2
 drivers/net/yellowfin.c                   |    2
 drivers/parport/ChangeLog                 |   40
 drivers/parport/daisy.c                   |   12
 drivers/parport/ieee1284.c                |    2
 drivers/parport/ieee1284_ops.c            |    4
 drivers/parport/parport_pc.c              |   93
 drivers/parport/share.c                   |   33
 drivers/pci/pci.ids                       |    7
 drivers/pcmcia/yenta.c                    |    2
 drivers/s390/block/dasd_proc.c            |   58
 drivers/scsi/BusLogic.c                   |    3
 drivers/scsi/aha152x.c                    |   31
 drivers/scsi/megaraid.c                   |    2
 drivers/scsi/megaraid.h                   |    1
 drivers/sound/ac97_codec.c                |    6
 drivers/sound/cmpci.c                     |    2
 drivers/sound/dmasound/dmasound_awacs.c   |  519 ++--
 drivers/sound/emu10k1/main.c              |    2
 drivers/sound/es1370.c                    |    2
 drivers/sound/es1371.c                    |    2
 drivers/sound/esssolo1.c                  |    2
 drivers/sound/sb_card.c                   |   15
 drivers/sound/sonicvibes.c                |    2
 drivers/sound/trident.c                   |   29
 drivers/sound/via82cxxx_audio.c           |    2
 drivers/tc/tc.c                           |    5
 drivers/tc/tcsyms.c                       |    9
 drivers/tc/zs.c                           |   24
 drivers/tc/zs.h                           |    4
 drivers/usb/Config.in                     |    2
 drivers/usb/audio.c                       |  129 -
 drivers/usb/hub.c                         |    4
 drivers/usb/input.c                       |    8
 drivers/usb/ov511.c                       |  745 +++---
 drivers/usb/ov511.h                       |  139 -
 drivers/usb/pegasus.c                     |   50
 drivers/usb/printer.c                     |   45
 drivers/usb/serial/Makefile               |   22
 drivers/usb/serial/digi_acceleport.c      | 1164 ++++++----
 drivers/usb/serial/ftdi_sio.c             |    6
 drivers/usb/serial/keyspan_pda.c          |    4
 drivers/usb/serial/omninet.c              |    6
 drivers/usb/serial/usbserial.c            |    4
 drivers/usb/serial/visor.c                |    7
 drivers/usb/serial/whiteheat.c            |    6
 drivers/usb/uhci.c                        |   31
 drivers/usb/usb-ohci.c                    |  160 -
 drivers/usb/usb-ohci.h                    |    2
 drivers/usb/usb-storage.c                 |  356 ++-
 drivers/usb/usb-storage.h                 |   14
 drivers/usb/usb-uhci.c                    |   85
 drivers/usb/usb-uhci.h                    |    4
 drivers/usb/wacom.c                       |    2
 drivers/video/cyber2000fb.c               |    2
 drivers/video/cyber2000fb.h               |    1
 drivers/video/newport_con.c               |   45
 drivers/video/riva/fbdev.c                |    4
 fs/Makefile                               |   14
 fs/affs/namei.c                           |    2
 fs/autofs/dir.c                           |   27
 fs/autofs/dirhash.c                       |    4
 fs/autofs4/root.c                         |   66
 fs/bfs/dir.c                              |    6
 fs/binfmt_aout.c                          |    4
 fs/buffer.c                               |   16
 fs/coda/cache.c                           |   44
 fs/coda/dir.c                             |   10
 fs/coda/psdev.c                           |    2
 fs/cramfs/inode.c                         |   57
 fs/dcache.c                               |  123 -
 fs/devfs/base.c                           |  822 ++++---
 fs/devfs/util.c                           |   73
 fs/exec.c                                 |   69
 fs/ext2/balloc.c                          |    2
 fs/ext2/namei.c                           |    2
 fs/hfs/balloc.c                           |    2
 fs/hfs/catalog.c                          |    8
 fs/hfs/dir.c                              |    2
 fs/hfs/file_hdr.c                         |    2
 fs/hfs/hfs.h                              |   16
 fs/hfs/hfs_btree.h                        |    4
 fs/hfs/mdb.c                              |    2
 fs/hfs/part_tbl.c                         |    2
 fs/hpfs/namei.c                           |    2
 fs/inode.c                                |    4
 fs/lockd/clntproc.c                       |   36
 fs/lockd/svclock.c                        |    6
 fs/minix/namei.c                          |    2
 fs/msdos/namei.c                          |    2
 fs/namei.c                                |   10
 fs/ncpfs/dir.c                            |   25
 fs/nfs/dir.c                              |  662 ++---
 fs/nfs/inode.c                            |   29
 fs/nfs/nfs2xdr.c                          |    7
 fs/nfs/nfs3proc.c                         |   18
 fs/nfs/proc.c                             |   18
 fs/nfs/read.c                             |   21
 fs/nfs/write.c                            |   63
 fs/nfsd/nfscache.c                        |    7
 fs/nfsd/nfsfh.c                           |    8
 fs/openpromfs/inode.c                     |    3
 fs/partitions/check.c                     |    3
 fs/pipe.c                                 |    3
 fs/proc/base.c                            |   70
 fs/proc/generic.c                         |   11
 fs/proc/kcore.c                           |   17
 fs/proc/proc_devtree.c                    |    1
 fs/proc/root.c                            |   29
 fs/qnx4/namei.c                           |    2
 fs/ramfs/inode.c                          |   62
 fs/readdir.c                              |   47
 fs/smbfs/dir.c                            |   13
 fs/smbfs/file.c                           |   23
 fs/smbfs/proc.c                           |   45
 fs/super.c                                |  102
 fs/sysv/namei.c                           |    2
 fs/udf/namei.c                            |   30
 fs/ufs/namei.c                            |    2
 fs/umsdos/Makefile                        |    2
 fs/umsdos/check.c                         |  229 --
 fs/umsdos/dir.c                           |    6
 fs/umsdos/inode.c                         |    8
 fs/umsdos/ioctl.c                         |    4
 fs/umsdos/namei.c                         |   19
 fs/umsdos/rdir.c                          |    2
 fs/vfat/namei.c                           |   21
 include/asm-alpha/ide.h                   |    3
 include/asm-arm/arch-ebsa285/irq.h        |   13
 include/asm-arm/arch-l7200/dma.h          |   23
 include/asm-arm/arch-l7200/hardware.h     |   49
 include/asm-arm/arch-l7200/ide.h          |   27
 include/asm-arm/arch-l7200/io.h           |  210 +
 include/asm-arm/arch-l7200/irq.h          |   66
 include/asm-arm/arch-l7200/irqs.h         |   45
 include/asm-arm/arch-l7200/memory.h       |   44
 include/asm-arm/arch-l7200/param.h        |   23
 include/asm-arm/arch-l7200/processor.h    |   27
 include/asm-arm/arch-l7200/serial_l7200.h |  101
 include/asm-arm/arch-l7200/system.h       |   30
 include/asm-arm/arch-l7200/time.h         |   68
 include/asm-arm/arch-l7200/timex.h        |   20
 include/asm-arm/arch-l7200/uncompress.h   |   19
 include/asm-arm/arch-l7200/vmalloc.h      |   16
 include/asm-arm/hardirq.h                 |   14
 include/asm-arm/proc-armo/semaphore.h     |   75
 include/asm-arm/proc-armv/locks.h         |   64
 include/asm-arm/softirq.h                 |    8
 include/asm-arm/string.h                  |    8
 include/asm-arm/unistd.h                  |    4
 include/asm-i386/apicdef.h                |    3
 include/asm-i386/hw_irq.h                 |   36
 include/asm-i386/ide.h                    |    1
 include/asm-i386/uaccess.h                |   22
 include/asm-ia64/ide.h                    |    1
 include/asm-mips/arc/types.h              |   72
 include/asm-mips/asmmacro.h               |    2
 include/asm-mips/atomic.h                 |    6
 include/asm-mips/baget/baget.h            |    2
 include/asm-mips/baget/vac.h              |    2
 include/asm-mips/baget/vic.h              |    2
 include/asm-mips/bcache.h                 |    2
 include/asm-mips/bitops.h                 |    4
 include/asm-mips/bootinfo.h               |   13
 include/asm-mips/branch.h                 |    2
 include/asm-mips/bugs.h                   |    7
 include/asm-mips/byteorder.h              |    2
 include/asm-mips/cache.h                  |    6
 include/asm-mips/checksum.h               |    2
 include/asm-mips/cpu.h                    |    2
 include/asm-mips/current.h                |    2
 include/asm-mips/ddb5074.h                |    2
 include/asm-mips/delay.h                  |    2
 include/asm-mips/div64.h                  |    2
 include/asm-mips/dma.h                    |    2
 include/asm-mips/ds1286.h                 |    2
 include/asm-mips/elf.h                    |    2
 include/asm-mips/fcntl.h                  |    2
 include/asm-mips/floppy.h                 |    2
 include/asm-mips/fp.h                     |    2
 include/asm-mips/gdb-stub.h               |    2
 include/asm-mips/gfx.h                    |    2
 include/asm-mips/hardirq.h                |   31
 include/asm-mips/hdreg.h                  |    2
 include/asm-mips/highmem.h                |    2
 include/asm-mips/hw_irq.h                 |    5
 include/asm-mips/ide.h                    |    4
 include/asm-mips/inventory.h              |    2
 include/asm-mips/ioctls.h                 |    2
 include/asm-mips/irq.h                    |    2
 include/asm-mips/isadep.h                 |    2
 include/asm-mips/jazz.h                   |    2
 include/asm-mips/jazzdma.h                |    2
 include/asm-mips/linux_logo.h             |    2
 include/asm-mips/mc146818rtc.h            |    2
 include/asm-mips/mipsregs.h               |    3
 include/asm-mips/mman.h                   |    6
 include/asm-mips/mmu_context.h            |    2
 include/asm-mips/namei.h                  |    2
 include/asm-mips/ng1.h                    |    2
 include/asm-mips/ng1hw.h                  |    2
 include/asm-mips/nile4.h                  |    4
 include/asm-mips/offset.h                 |    4
 include/asm-mips/paccess.h                |   98
 include/asm-mips/parport.h                |    8
 include/asm-mips/pci.h                    |    9
 include/asm-mips/pgalloc.h                |    2
 include/asm-mips/pgtable.h                |    3
 include/asm-mips/posix_types.h            |    2
 include/asm-mips/prctl.h                  |    2
 include/asm-mips/processor.h              |    8
 include/asm-mips/ptrace.h                 |    2
 include/asm-mips/r4kcache.h               |    2
 include/asm-mips/resource.h               |    2
 include/asm-mips/semaphore-helper.h       |    3
 include/asm-mips/semaphore.h              |    4
 include/asm-mips/serial.h                 |    4
 include/asm-mips/sgi/sgi.h                |    2
 include/asm-mips/sgi/sgihpc.h             |    8
 include/asm-mips/sgi/sgimc.h              |  184 -
 include/asm-mips/sgi/sgint23.h            |   24
 include/asm-mips/sgialib.h                |   17
 include/asm-mips/sgiarcs.h                |   11
 include/asm-mips/shmparam.h               |    2
 include/asm-mips/sigcontext.h             |   13
 include/asm-mips/siginfo.h                |    2
 include/asm-mips/signal.h                 |    2
 include/asm-mips/sni.h                    |    2
 include/asm-mips/socket.h                 |   12
 include/asm-mips/softirq.h                |    8
 include/asm-mips/spinlock.h               |    2
 include/asm-mips/stackframe.h             |    2
 include/asm-mips/string.h                 |   12
 include/asm-mips/system.h                 |    2
 include/asm-mips/termios.h                |    2
 include/asm-mips/timex.h                  |    4
 include/asm-mips/types.h                  |    2
 include/asm-mips/uaccess.h                |    2
 include/asm-mips/ucontext.h               |    2
 include/asm-mips/unaligned.h              |    2
 include/asm-mips/unistd.h                 |    6
 include/asm-mips/watch.h                  |    2
 include/asm-mips/wbflush.h                |    2
 include/asm-mips64/a.out.h                |    2
 include/asm-mips64/addrspace.h            |    7
 include/asm-mips64/arc/hinv.h             |    2
 include/asm-mips64/asm.h                  |    2
 include/asm-mips64/asmmacro.h             |    2
 include/asm-mips64/atomic.h               |    3
 include/asm-mips64/bcache.h               |    2
 include/asm-mips64/bitops.h               |   10
 include/asm-mips64/bootinfo.h             |    2
 include/asm-mips64/branch.h               |    2
 include/asm-mips64/bugs.h                 |    2
 include/asm-mips64/byteorder.h            |    2
 include/asm-mips64/cache.h                |    3
 include/asm-mips64/checksum.h             |    2
 include/asm-mips64/cpu.h                  |    2
 include/asm-mips64/current.h              |   19
 include/asm-mips64/delay.h                |    2
 include/asm-mips64/div64.h                |    2
 include/asm-mips64/dma.h                  |   11
 include/asm-mips64/ds1286.h               |    2
 include/asm-mips64/elf.h                  |    2
 include/asm-mips64/errno.h                |    2
 include/asm-mips64/fcntl.h                |    2
 include/asm-mips64/floppy.h               |    2
 include/asm-mips64/gfx.h                  |    2
 include/asm-mips64/hardirq.h              |   80
 include/asm-mips64/hdreg.h                |    2
 include/asm-mips64/highmem.h              |    2
 include/asm-mips64/hw_irq.h               |    5
 include/asm-mips64/ide.h                  |    4
 include/asm-mips64/init.h                 |    2
 include/asm-mips64/inst.h                 |    2
 include/asm-mips64/io.h                   |   52
 include/asm-mips64/ioc3.h                 |    2
 include/asm-mips64/ioctl.h                |    2
 include/asm-mips64/ioctls.h               |    2
 include/asm-mips64/irq.h                  |    2
 include/asm-mips64/linux_logo.h           |    2
 include/asm-mips64/mc146818rtc.h          |    2
 include/asm-mips64/mipsregs.h             |    3
 include/asm-mips64/mman.h                 |    6
 include/asm-mips64/mmu_context.h          |   56
 include/asm-mips64/mmzone.h               |   30
 include/asm-mips64/namei.h                |    2
 include/asm-mips64/ng1.h                  |    2
 include/asm-mips64/offset.h               |    3
 include/asm-mips64/paccess.h              |    2
 include/asm-mips64/param.h                |    2
 include/asm-mips64/parport.h              |    8
 include/asm-mips64/pci/bridge.h           |    9
 include/asm-mips64/pgalloc.h              |   20
 include/asm-mips64/pgtable.h              |   20
 include/asm-mips64/poll.h                 |    2
 include/asm-mips64/posix_types.h          |   22
 include/asm-mips64/processor.h            |   53
 include/asm-mips64/ptrace.h               |    2
 include/asm-mips64/r10kcache.h            |    2
 include/asm-mips64/r10kcacheops.h         |    2
 include/asm-mips64/r4kcache.h             |    2
 include/asm-mips64/r4kcacheops.h          |    2
 include/asm-mips64/regdef.h               |    2
 include/asm-mips64/resource.h             |    2
 include/asm-mips64/semaphore-helper.h     |    2
 include/asm-mips64/semaphore.h            |    2
 include/asm-mips64/serial.h               |    2
 include/asm-mips64/sgi/io.h               |    2
 include/asm-mips64/sgi/sgi.h              |    2
 include/asm-mips64/sgi/sgihpc.h           |    2
 include/asm-mips64/sgi/sgimc.h            |    2
 include/asm-mips64/sgi/sgint23.h          |    2
 include/asm-mips64/sgialib.h              |    2
 include/asm-mips64/sgiarcs.h              |    2
 include/asm-mips64/sgidefs.h              |    2
 include/asm-mips64/shmiq.h                |    2
 include/asm-mips64/shmparam.h             |    2
 include/asm-mips64/sigcontext.h           |    2
 include/asm-mips64/siginfo.h              |    2
 include/asm-mips64/signal.h               |    3
 include/asm-mips64/smp.h                  |   49
 include/asm-mips64/smplock.h              |   56
 include/asm-mips64/sn/addrs.h             |   53
 include/asm-mips64/sn/agent.h             |   11
 include/asm-mips64/sn/arch.h              |   35
 include/asm-mips64/sn/gda.h               |   30
 include/asm-mips64/sn/intr.h              |  122 +
 include/asm-mips64/sn/intr_public.h       |   53
 include/asm-mips64/sn/io.h                |   55
 include/asm-mips64/sn/klconfig.h          |  107
 include/asm-mips64/sn/kldir.h             |   35
 include/asm-mips64/sn/launch.h            |  123 +
 include/asm-mips64/sn/nmi.h               |  125 +
 include/asm-mips64/sn/sn0/addrs.h         |    2
 include/asm-mips64/sn/sn0/arch.h          |    2
 include/asm-mips64/sn/sn0/hub.h           |    2
 include/asm-mips64/sn/sn0/hubio.h         |    2
 include/asm-mips64/sn/sn0/hubni.h         |    2
 include/asm-mips64/sn/sn0/hubpi.h         |    2
 include/asm-mips64/sn/sn0/ip27.h          |   18
 include/asm-mips64/sn/sn0/sn0_fru.h       |    2
 include/asm-mips64/sn/sn_private.h        |    6
 include/asm-mips64/sn/types.h             |    5
 include/asm-mips64/socket.h               |    5
 include/asm-mips64/sockios.h              |    2
 include/asm-mips64/softirq.h              |    8
 include/asm-mips64/spinlock.h             |   23
 include/asm-mips64/stackframe.h           |   18
 include/asm-mips64/stat.h                 |   26
 include/asm-mips64/statfs.h               |    2
 include/asm-mips64/string.h               |    2
 include/asm-mips64/sysmips.h              |    2
 include/asm-mips64/system.h               |   42
 include/asm-mips64/termbits.h             |    2
 include/asm-mips64/termios.h              |    2
 include/asm-mips64/timex.h                |   10
 include/asm-mips64/types.h                |    2
 include/asm-mips64/uaccess.h              |    2
 include/asm-mips64/ucontext.h             |    2
 include/asm-mips64/unaligned.h            |    2
 include/asm-mips64/unistd.h               |   12
 include/asm-mips64/user.h                 |    2
 include/asm-mips64/usioctl.h              |    2
 include/asm-mips64/watch.h                |    2
 include/asm-mips64/xtalk/xtalk.h          |    2
 include/asm-mips64/xtalk/xwidget.h        |    2
 include/asm-ppc/bitops.h                  |    2
 include/asm-ppc/cpm_8260.h                |   19
 include/asm-ppc/init.h                    |    6
 include/asm-ppc/page.h                    |    3
 include/asm-ppc/siginfo.h                 |    2
 include/asm-ppc/string.h                  |   10
 include/asm-sh/cache.h                    |    4
 include/asm-sh/checksum.h                 |   37
 include/asm-sh/hitachi_se.h               |   53
 include/asm-sh/ide.h                      |   11
 include/asm-sh/io.h                       |  120 -
 include/asm-sh/irq.h                      |   72
 include/asm-sh/pgtable.h                  |    6
 include/asm-sh/smc37c93x.h                |  190 +
 include/asm-sh/system.h                   |   24
 include/asm-sh/unistd.h                   |    6
 include/asm-sparc/bitops.h                |    2
 include/asm-sparc/ide.h                   |    5
 include/asm-sparc/irq.h                   |    2
 include/asm-sparc/pgalloc.h               |    2
 include/asm-sparc/system.h                |    2
 include/asm-sparc/winmacro.h              |    2
 include/asm-sparc64/delay.h               |    2
 include/asm-sparc64/ide.h                 |    5
 include/asm-sparc64/irq.h                 |    2
 include/asm-sparc64/oplib.h               |    2
 include/asm-sparc64/processor.h           |    2
 include/asm-sparc64/system.h              |    2
 include/asm-sparc64/timer.h               |    2
 include/asm-sparc64/unistd.h              |    6
 include/linux/coda.h                      |    6
 include/linux/dcache.h                    |    9
 include/linux/elevator.h                  |    8
 include/linux/fb.h                        |    3
 include/linux/fs.h                        |    9
 include/linux/hdreg.h                     |   15
 include/linux/hdsmart.h                   |  205 -
 include/linux/ide.h                       |   52
 include/linux/if_pppox.h                  |    5
 include/linux/lvm.h                       |    6
 include/linux/mount.h                     |    1
 include/linux/netfilter_ipv6.h            |   10
 include/linux/netfilter_ipv6/ip6_tables.h |  452 +++
 include/linux/nfs_fs.h                    |   13
 include/linux/nfs_mount.h                 |    7
 include/linux/nfs_page.h                  |    2
 include/linux/nfs_xdr.h                   |    9
 include/linux/pci_ids.h                   |   22
 include/linux/proc_fs.h                   |    3
 include/linux/smb_fs.h                    |    1
 include/linux/smb_fs_i.h                  |    1
 include/linux/sunrpc/auth.h               |    5
 include/linux/umsdos_fs.p                 |    8
 include/linux/usbdevice_fs.h              |    2
 include/linux/vmalloc.h                   |   49
 include/linux/wait.h                      |    2
 include/linux/wrapper.h                   |    1
 include/net/slhc.h                        |    6
 init/main.c                               |   12
 ipc/shm.c                                 |   10
 ipc/util.c                                |   14
 kernel/exec_domain.c                      |   24
 kernel/fork.c                             |    2
 kernel/ksyms.c                            |    5
 mm/filemap.c                              |   65
 mm/highmem.c                              |    6
 mm/memory.c                               |    6
 mm/slab.c                                 |    2
 mm/swap_state.c                           |    2
 mm/swapfile.c                             |    2
 mm/vmalloc.c                              |   33
 mm/vmscan.c                               |   42
 net/Makefile                              |    9
 net/core/dev.c                            |    1
 net/core/skbuff.c                         |   10
 net/ipv4/ip_gre.c                         |    2
 net/ipv4/ipip.c                           |    4
 net/ipv6/Config.in                        |    4
 net/ipv6/netfilter/Config.in              |   49
 net/ipv6/netfilter/Makefile               |  180 +
 net/ipv6/netfilter/ip6_tables.c           | 1795 +++++++++++++++
 net/ipv6/netfilter/ip6t_MARK.c            |   66
 net/ipv6/netfilter/ip6t_limit.c           |  135 +
 net/ipv6/netfilter/ip6t_mark.c            |   50
 net/ipv6/netfilter/ip6table_filter.c      |  183 +
 net/sunrpc/auth.c                         |   12
 net/unix/af_unix.c                        |    2
 scripts/cramfs/mkcramfs.c                 |   22
 scripts/header.tk                         |  106
 scripts/mkdep.c                           |   14
 scripts/tail.tk                           |   10
 scripts/tkgen.c                           |   31
 scripts/tkparse.c                         |    4
 924 files changed, 28347 insertions, 12243 deletions

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel-announce" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Looking for Linux software?   http://freshmeat.net  http://www.rpmfind.net
http://filewatcher.org  http://www.coldstorage.org  http://sourceforge.net

