Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751509AbWIMCdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbWIMCdL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 22:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbWIMCdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 22:33:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11430 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751509AbWIMCdF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 22:33:05 -0400
Date: Tue, 12 Sep 2006 19:33:00 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.6.18-rc7
Message-ID: <Pine.LNX.4.64.0609121927110.4388@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, ok, don't rub it in. I know I thought -rc6 would be the last one, but 
I just feel more comfy doing an -rc7, even if most of the changes are 
pretty minor.

This adds some some arm, sh64 and ia64 archictecture updates. In drivers, 
we've got some dvb and usb fixes (with a few small mmc and ide fixes 
thrown in too). Add some audit fixes, and CIFS and XFS updates to round it 
all up.

		Linus

--- snip snip for shortlog ---
Adrian Bunk:
      USB: hid-core.c: fix duplicate USB_DEVICE_ID_GTCO_404

Al Viro:
      syscall classes hookup for ppc and s390
      audit: more syscall classes added
      audit: AUDIT_PERM support
      syscall class hookup for all normal targets
      sparc64 audit syscall classes hookup

Alan Cox:
      Fix 2.6.18-rc6 IDE breakage, add missing ident needed for current VIA boards

Alexey Dobriyan:
      optical /proc/ide/*/media
      sh: fix FPN_START typo

Amy Griffis:
      sanity check audit_buffer
      update audit rule change messages

Andreas Schwab:
      [IA64] Unwire set/get_robust_list

Andres Salomon:
      [libata] sata_mv: errata check buglet fix

Andrew de Quincey:
      V4L/DVB (4608b): i2c deps fix on DVB

Andrew Morton:
      invalidate_complete_page() race fix

Badari Pulavarty:
      ext3_getblk() should handle HOLE correctly

Ben Dooks:
      [ARM] 3767/1: S3C24XX: remove changelog comments from arch/arm/mach-s3c2410
      [ARM] 3774/1: S3C24XX: SMDK2413 has two machine IDs
      [ARM] 3775/1: S3C24XX: do not add same sysdev_driver to two classes
      [ARM] 3776/1: S3C24XX: remove changelogs from include/asm-arm/arch-s3c2410
      [ARM] 3777/1: S3C24XX:  remove changelogs from include/asm-arm/arch-s3c2410 [regs-*.h]
      [ARM] 3779/1: S3C24XX: remove changelogs from include/asm-arm/arch-s3c2410 [left]
      [ARM] 3783/1: S3C2412: fix IRQ_EINT0 to IRQ_EINT3 handling
      [ARM] 3778/1: S3C24XX: remove changelogs from include/asm-arm/arch-s3c2410 [simtec]

Brice Goglin:
      myri10ge: update the firmware download URL in Kconfig

Catalin Marinas:
      [ARM] 3766/1: Fix typo in ARM _raw_read_trylock
      [ARM] 3773/1: Add the HWCAP_VFP bit for the ARM926 CPUs

David Brownell:
      [MMC] constify mmc_host_ops

David Chinner:
      [XFS] Prevent free space oversubscription and xfssyncd looping.
      [XFS] Fix xfs_splice_write() so appended data gets to disk.

David Wang:
      sis5513: add SiS south bridge ID 0x966 and 0x968

David Woodhouse:
      Remove unneeded asm-i386/cpufeature.h from user visibility.

Dirk Opfer:
      Fix dm9000 release_resource

Henk Vergonet:
      USB: Fix unload oops and memory leak in yealink driver

Henrik Kretzschmar:
      Documentation for lock_key in struct hrtimer_base
      add missing desctiption in super.c

Hermann Pitton:
      V4L/DVB (4511): Restore tuner_ymec_tvf66t5_b_dff_pal_ranges[] to fix UHF switch functionality

Ingo Molnar:
      lockdep: do not touch console state when tainting the kernel

Ismail Donmez:
      Move linux/device.h include in linux/atmdev.h to #ifdef __KERNEL__ section

Jack Steiner:
      [IA64] Save register stack contents on cpu start
      [IA64] SN fix for cpu hotplug/kexec

Jarek Poplawski:
      lockdep ifdef fix

john stultz:
      FRV: Use the generic time stuff for FRV

Kai Lindhom:
      usbtouchscreen: fix ITM data reading

Kirill Korotaev:
      IA64,sparc: local DoS with corrupted ELFs

Lachlan McIlroy:
      [XFS] Fix ABBA deadlock between i_mutex and iolock. Avoid calling

Linus Torvalds:
      Linux v2.6.18-rc7

Martin Michlmayr:
      [ARM] 3772/1: Fix compilation error in mach-ixp4xx/nslu2*

Matthias Urlichs:
      usbserial: Reference leak

Mauro Carvalho Chehab:
      V4L/DVB (4494a): Fix compilation when V4L1 support is not present
      V4L/DVB (4520): Fix an error when loading bttv driver on PV M4900.
      V4L/DVB (4605): Fixes an issue with V4L1 and make headers-install
      V4L/DVB (4608c): Fix I2C dependencies for saa7146 modules

Nathan Scott:
      [XFS] Fix a bad pointer dereference in the quota statvfs handling.

Nobuhiro Iwamatsu:
      USB: Support for USB20SVGA-WH & USB20SVGA-DG

Paul Mundt:
      sh64: Drop deprecated ISA tuning for legacy toolchains.
      sh64: Trivial build fixes.
      sh64: Use generic BUG_ON()/WARN_ON().
      sh64: Add a sane pm_power_off implementation.

Pavel Machek:
      prevent swsusp with PAE

Pavel Pisa:
      [ARM] 3751/1: i.MX/MX1 SD/MMC use 512 bytes request for SCR read

Pierre Ossman:
      [MMC] Fix SD timeout calculation
      [MMC] Always use a sector size of 512 bytes

Ralf Schlatterbeck:
      USB: New device ID for ftdi_sio usb serial driver

Russell King:
      [MMC] Cleanup 385e3227d4d83ab13d7767c4bb3593b0256bf246

Stephane Eranian:
      [IA64] correct file descriptor reference counting in perfmon

Steve French:
      [CIFS] Fix CIFS readdir access denied when SE Linux enabled

Steve Grubb:
      fix ppid bug in 2.6.18 kernel

Tejun Heo:
      ata_piix: add map 01b for ICH7M

Thomas Gleixner:
      prevent timespec/timeval to ktime_t overflow
      Use the correct restart option for futex_lock_pi

Trond Myklebust:
      NFS: large non-page-aligned direct I/O clobbers memory

--- snip snip for diffstat ---
 Makefile                                     |    2 
 arch/arm/mach-ixp4xx/nslu2-pci.c             |    1 
 arch/arm/mach-ixp4xx/nslu2-power.c           |    1 
 arch/arm/mach-s3c2410/Makefile               |    1 
 arch/arm/mach-s3c2410/cpu.h                  |   10 --
 arch/arm/mach-s3c2410/devs.c                 |   12 --
 arch/arm/mach-s3c2410/irq.c                  |    4 -
 arch/arm/mach-s3c2410/irq.h                  |    5 +
 arch/arm/mach-s3c2410/mach-bast.c            |   25 -----
 arch/arm/mach-s3c2410/mach-h1940.c           |   17 ---
 arch/arm/mach-s3c2410/mach-rx3715.c          |    9 --
 arch/arm/mach-s3c2410/mach-smdk2410.c        |    4 -
 arch/arm/mach-s3c2410/mach-smdk2413.c        |   15 +++
 arch/arm/mach-s3c2410/mach-vr1000.c          |   19 ----
 arch/arm/mach-s3c2410/s3c2400-gpio.c         |    5 -
 arch/arm/mach-s3c2410/s3c2410.h              |    8 --
 arch/arm/mach-s3c2410/s3c2412-irq.c          |  130 ++++++++++++++++++++++++++
 arch/arm/mach-s3c2410/s3c2440-irq.c          |    3 -
 arch/arm/mach-s3c2410/s3c244x-irq.c          |   12 +-
 arch/arm/mm/proc-arm926.S                    |    2 
 arch/frv/Kconfig                             |    4 +
 arch/frv/kernel/time.c                       |   81 ----------------
 arch/i386/kernel/Makefile                    |    1 
 arch/i386/kernel/audit.c                     |   23 -----
 arch/ia64/Kconfig                            |    4 +
 arch/ia64/ia32/audit.c                       |   26 +++++
 arch/ia64/kernel/audit.c                     |   35 +++++++
 arch/ia64/kernel/entry.S                     |    4 -
 arch/ia64/kernel/head.S                      |    5 +
 arch/ia64/kernel/perfmon.c                   |    4 +
 arch/ia64/kernel/sys_ia64.c                  |   28 +++---
 arch/ia64/sn/kernel/setup.c                  |    2 
 arch/powerpc/Kconfig                         |    4 +
 arch/powerpc/kernel/Makefile                 |    2 
 arch/powerpc/kernel/audit.c                  |   66 +++++++++++++
 arch/powerpc/kernel/compat_audit.c           |   38 ++++++++
 arch/s390/Kconfig                            |    4 +
 arch/s390/kernel/Makefile                    |    4 +
 arch/s390/kernel/audit.c                     |   66 +++++++++++++
 arch/s390/kernel/compat_audit.c              |   38 ++++++++
 arch/sh64/Makefile                           |    1 
 arch/sh64/kernel/process.c                   |    3 +
 arch/sh64/mach-cayman/setup.c                |    6 +
 arch/sh64/mm/ioremap.c                       |    4 +
 arch/sparc/kernel/sys_sparc.c                |   27 +++--
 arch/sparc64/Kconfig                         |    4 +
 arch/sparc64/kernel/Makefile                 |    3 +
 arch/sparc64/kernel/audit.c                  |   66 +++++++++++++
 arch/sparc64/kernel/compat_audit.c           |   37 +++++++
 arch/sparc64/kernel/sys_sparc.c              |   36 ++++---
 arch/x86_64/Kconfig                          |    4 +
 arch/x86_64/ia32/audit.c                     |   26 +++++
 arch/x86_64/kernel/audit.c                   |   35 +++++++
 drivers/ide/ide-proc.c                       |    2 
 drivers/ide/pci/aec62xx.c                    |   12 +-
 drivers/ide/pci/serverworks.c                |   10 +-
 drivers/ide/pci/siimage.c                    |    6 +
 drivers/ide/pci/sis5513.c                    |    2 
 drivers/media/Kconfig                        |    2 
 drivers/media/common/saa7146_video.c         |    2 
 drivers/media/dvb/b2c2/Kconfig               |    1 
 drivers/media/dvb/bt8xx/Kconfig              |    1 
 drivers/media/dvb/dvb-usb/Kconfig            |    1 
 drivers/media/dvb/frontends/Kconfig          |   60 ++++++------
 drivers/media/dvb/frontends/Makefile         |    2 
 drivers/media/dvb/pluto2/Kconfig             |    1 
 drivers/media/dvb/ttpci/Kconfig              |    5 +
 drivers/media/dvb/ttusb-budget/Kconfig       |    3 -
 drivers/media/video/Kconfig                  |    8 +-
 drivers/media/video/bt8xx/bttv-input.c       |    1 
 drivers/media/video/cx88/Kconfig             |    1 
 drivers/media/video/saa7134/Kconfig          |    1 
 drivers/media/video/tuner-types.c            |   10 ++
 drivers/media/video/zoran.h                  |    2 
 drivers/media/video/zoran_driver.c           |   22 ++--
 drivers/mmc/imxmmc.c                         |   69 +++++++-------
 drivers/mmc/mmc.c                            |   55 ++++++++++-
 drivers/mmc/mmc_block.c                      |   60 +-----------
 drivers/net/Kconfig                          |    2 
 drivers/net/dm9000.c                         |    4 -
 drivers/scsi/ata_piix.c                      |   36 +++++++
 drivers/scsi/sata_mv.c                       |    3 -
 drivers/scsi/sata_via.c                      |    1 
 drivers/serial/sh-sci.c                      |    4 -
 drivers/usb/input/hid-core.c                 |    4 -
 drivers/usb/input/usbtouchscreen.c           |    2 
 drivers/usb/input/yealink.c                  |   12 +-
 drivers/usb/misc/sisusbvga/sisusb.c          |    2 
 drivers/usb/serial/ftdi_sio.c                |    1 
 drivers/usb/serial/ftdi_sio.h                |    5 +
 drivers/usb/serial/usb-serial.c              |    4 +
 fs/cifs/readdir.c                            |   11 +-
 fs/ext3/inode.c                              |   11 +-
 fs/nfs/direct.c                              |   50 +++-------
 fs/nfs/read.c                                |   24 +++--
 fs/nfs/write.c                               |   37 +++----
 fs/super.c                                   |    1 
 fs/xfs/linux-2.6/xfs_aops.c                  |   18 +++-
 fs/xfs/linux-2.6/xfs_lrw.c                   |   27 ++++-
 fs/xfs/quota/xfs_qm_bhv.c                    |    2 
 fs/xfs/xfs_alloc.h                           |   20 ++++
 fs/xfs/xfs_fsops.c                           |   16 ++-
 fs/xfs/xfs_mount.c                           |   32 ++----
 fs/xfs/xfs_vfsops.c                          |    3 -
 include/asm-arm/arch-s3c2410/anubis-cpld.h   |    3 -
 include/asm-arm/arch-s3c2410/anubis-irq.h    |    4 -
 include/asm-arm/arch-s3c2410/anubis-map.h    |    2 
 include/asm-arm/arch-s3c2410/audio.h         |    4 -
 include/asm-arm/arch-s3c2410/bast-cpld.h     |    5 -
 include/asm-arm/arch-s3c2410/bast-irq.h      |    6 -
 include/asm-arm/arch-s3c2410/bast-map.h      |    4 -
 include/asm-arm/arch-s3c2410/bast-pmu.h      |    3 -
 include/asm-arm/arch-s3c2410/debug-macro.S   |    3 -
 include/asm-arm/arch-s3c2410/fb.h            |    7 -
 include/asm-arm/arch-s3c2410/hardware.h      |   10 --
 include/asm-arm/arch-s3c2410/idle.h          |    4 -
 include/asm-arm/arch-s3c2410/iic.h           |    4 -
 include/asm-arm/arch-s3c2410/io.h            |    8 --
 include/asm-arm/arch-s3c2410/irqs.h          |    9 --
 include/asm-arm/arch-s3c2410/map.h           |    7 -
 include/asm-arm/arch-s3c2410/memory.h        |   14 ---
 include/asm-arm/arch-s3c2410/nand.h          |    3 -
 include/asm-arm/arch-s3c2410/osiris-map.h    |    2 
 include/asm-arm/arch-s3c2410/regs-adc.h      |    3 -
 include/asm-arm/arch-s3c2410/regs-clock.h    |   12 --
 include/asm-arm/arch-s3c2410/regs-gpio.h     |   15 ---
 include/asm-arm/arch-s3c2410/regs-gpioj.h    |    4 -
 include/asm-arm/arch-s3c2410/regs-iic.h      |    4 -
 include/asm-arm/arch-s3c2410/regs-iis.h      |   12 --
 include/asm-arm/arch-s3c2410/regs-irq.h      |    9 --
 include/asm-arm/arch-s3c2410/regs-lcd.h      |    8 --
 include/asm-arm/arch-s3c2410/regs-mem.h      |    6 -
 include/asm-arm/arch-s3c2410/regs-nand.h     |    4 -
 include/asm-arm/arch-s3c2410/regs-rtc.h      |    5 -
 include/asm-arm/arch-s3c2410/regs-sdi.h      |    5 -
 include/asm-arm/arch-s3c2410/regs-serial.h   |    5 -
 include/asm-arm/arch-s3c2410/regs-spi.h      |    8 --
 include/asm-arm/arch-s3c2410/regs-timer.h    |    7 -
 include/asm-arm/arch-s3c2410/regs-udc.h      |    8 --
 include/asm-arm/arch-s3c2410/regs-watchdog.h |    7 -
 include/asm-arm/arch-s3c2410/system.h        |    9 --
 include/asm-arm/arch-s3c2410/timex.h         |    6 -
 include/asm-arm/arch-s3c2410/uncompress.h    |    9 --
 include/asm-arm/arch-s3c2410/usb-control.h   |    5 -
 include/asm-arm/arch-s3c2410/vmalloc.h       |    6 -
 include/asm-arm/arch-s3c2410/vr1000-cpld.h   |    4 -
 include/asm-arm/arch-s3c2410/vr1000-irq.h    |    6 -
 include/asm-arm/arch-s3c2410/vr1000-map.h    |    6 -
 include/asm-arm/spinlock.h                   |    2 
 include/asm-generic/audit_read.h             |    8 ++
 include/asm-generic/audit_write.h            |   11 ++
 include/asm-i386/Kbuild                      |    2 
 include/asm-ia64/mman.h                      |    8 ++
 include/asm-ia64/unistd.h                    |    3 -
 include/asm-sh/page.h                        |    2 
 include/asm-sh64/bug.h                       |   16 +--
 include/asm-sh64/byteorder.h                 |    4 -
 include/asm-sh64/dma-mapping.h               |   16 ++-
 include/asm-sh64/io.h                        |    7 +
 include/asm-sh64/ptrace.h                    |    2 
 include/asm-sh64/system.h                    |    2 
 include/asm-sh64/uaccess.h                   |   19 +---
 include/asm-sparc/mman.h                     |    8 ++
 include/asm-sparc64/mman.h                   |    8 ++
 include/linux/atmdev.h                       |    2 
 include/linux/audit.h                        |   11 ++
 include/linux/hrtimer.h                      |    1 
 include/linux/ktime.h                        |    7 +
 include/linux/mmc/host.h                     |    2 
 include/linux/mmc/mmc.h                      |    2 
 include/linux/nfs_fs.h                       |    6 +
 include/linux/nfs_xdr.h                      |    4 -
 include/linux/pci_ids.h                      |    2 
 include/linux/videodev.h                     |    3 -
 include/linux/videodev2.h                    |    2 
 include/media/v4l2-dev.h                     |    7 +
 kernel/audit.c                               |    6 +
 kernel/audit.h                               |    1 
 kernel/auditfilter.c                         |   37 ++++++-
 kernel/auditsc.c                             |   51 ++++++++++
 kernel/futex.c                               |   84 ++---------------
 kernel/panic.c                               |    2 
 kernel/power/Kconfig                         |    6 +
 kernel/spinlock.c                            |    2 
 lib/Kconfig                                  |    5 +
 lib/Makefile                                 |    1 
 lib/audit.c                                  |   53 +++++++++++
 mm/mmap.c                                    |   17 +++
 mm/truncate.c                                |   11 +-
 189 files changed, 1399 insertions(+), 966 deletions(-)
