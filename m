Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161128AbWJPWAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161128AbWJPWAa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 18:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161129AbWJPWAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 18:00:30 -0400
Received: from mail.kroah.org ([69.55.234.183]:26764 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161128AbWJPWA2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 18:00:28 -0400
Date: Mon, 16 Oct 2006 14:59:02 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, stable@kernel.org
Subject: Linux 2.6.18.1
Message-ID: <20061016215902.GA17594@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We (the -stable team) are announcing the release of the 2.6.18.1 kernel.

I will not be replying to this message with this patch, as it is too big
to do so, sorry about that...

The updated 2.6.18.y git tree can be found at:
 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.18.y.git
and can be browsed at the normal kernel.org git web browser:
	www.kernel.org/git/

thanks,

greg k-h

--------

 Documentation/dontdiff                             |    1 
 Documentation/sysctl/vm.txt                        |   27 
 Makefile                                           |   13 
 arch/i386/kernel/smpboot.c                         |    6 
 arch/i386/mm/boot_ioremap.c                        |    7 
 arch/ia64/kernel/acpi.c                            |   13 
 arch/ia64/kernel/numa.c                            |   34 
 arch/ia64/kernel/topology.c                        |    4 
 arch/s390/lib/uaccess.S                            |   12 
 arch/s390/lib/uaccess64.S                          |   12 
 arch/sh/kernel/process.c                           |    1 
 arch/sparc64/kernel/time.c                         |    2 
 arch/sparc64/mm/init.c                             |    3 
 arch/um/Kconfig                                    |    5 
 arch/um/Makefile-x86_64                            |    2 
 arch/um/include/common-offsets.h                   |    1 
 arch/um/include/sysdep-i386/kernel-offsets.h       |    1 
 arch/um/include/sysdep-x86_64/kernel-offsets.h     |    1 
 arch/um/os-Linux/process.c                         |    4 
 arch/um/os-Linux/sys-i386/tls.c                    |    4 
 arch/um/os-Linux/tls.c                             |    7 
 arch/x86_64/kernel/pci-calgary.c                   |   13 
 block/elevator.c                                   |    4 
 drivers/char/rtc.c                                 |    5 
 drivers/clocksource/scx200_hrt.c                   |    4 
 drivers/cpufreq/cpufreq_stats.c                    |    2 
 drivers/ide/pci/generic.c                          |   10 
 drivers/ide/ppc/pmac.c                             |    2 
 drivers/infiniband/hw/mthca/mthca_mad.c            |    2 
 drivers/md/md.c                                    |    1 
 drivers/media/dvb/frontends/cx24123.c              |    4 
 drivers/media/video/msp3400-driver.c               |    2 
 drivers/media/video/msp3400-driver.h               |    1 
 drivers/media/video/msp3400-kthreads.c             |    5 
 drivers/media/video/pvrusb2/Kconfig                |    9 
 drivers/media/video/pvrusb2/pvrusb2-ctrl.c         |   21 
 drivers/media/video/pvrusb2/pvrusb2-hdw-internal.h |    2 
 drivers/media/video/pvrusb2/pvrusb2-hdw.c          |   30 
 drivers/media/video/pvrusb2/pvrusb2-v4l2.c         |   95 --
 drivers/media/video/videodev.c                     |    6 
 drivers/net/lp486e.c                               |    6 
 drivers/net/mv643xx_eth.c                          |    2 
 drivers/net/sky2.c                                 |    8 
 drivers/net/sky2.h                                 |    2 
 drivers/net/wireless/bcm43xx/bcm43xx.h             |  181 ++--
 drivers/net/wireless/bcm43xx/bcm43xx_debugfs.c     |   80 +
 drivers/net/wireless/bcm43xx/bcm43xx_debugfs.h     |    1 
 drivers/net/wireless/bcm43xx/bcm43xx_dma.c         |  583 ++++++++-----
 drivers/net/wireless/bcm43xx/bcm43xx_dma.h         |  296 +++++-
 drivers/net/wireless/bcm43xx/bcm43xx_leds.c        |   10 
 drivers/net/wireless/bcm43xx/bcm43xx_main.c        |  905 ++++++++++++---------
 drivers/net/wireless/bcm43xx/bcm43xx_main.h        |    6 
 drivers/net/wireless/bcm43xx/bcm43xx_phy.c         |   48 -
 drivers/net/wireless/bcm43xx/bcm43xx_pio.c         |    4 
 drivers/net/wireless/bcm43xx/bcm43xx_sysfs.c       |   46 -
 drivers/net/wireless/bcm43xx/bcm43xx_wx.c          |  121 +-
 drivers/net/wireless/zd1211rw/zd_chip.c            |    2 
 drivers/rtc/rtc-pcf8563.c                          |    4 
 drivers/scsi/sata_mv.c                             |    1 
 drivers/usb/gadget/ether.c                         |    4 
 drivers/video/fbmem.c                              |    3 
 drivers/video/fbsysfs.c                            |   12 
 fs/buffer.c                                        |    5 
 fs/jbd/commit.c                                    |  182 ++--
 fs/sysfs/file.c                                    |    5 
 include/Kbuild                                     |   11 
 include/asm-alpha/Kbuild                           |   10 
 include/asm-arm/elf.h                              |   18 
 include/asm-arm/page.h                             |    4 
 include/asm-arm26/Kbuild                           |    1 
 include/asm-cris/Kbuild                            |    4 
 include/asm-cris/arch-v10/Kbuild                   |    2 
 include/asm-cris/arch-v32/Kbuild                   |    2 
 include/asm-cris/byteorder.h                       |    3 
 include/asm-cris/elf.h                             |    8 
 include/asm-cris/page.h                            |    8 
 include/asm-cris/posix_types.h                     |    9 
 include/asm-cris/unistd.h                          |    4 
 include/asm-generic/Kbuild                         |   15 
 include/asm-generic/Kbuild.asm                     |   38 
 include/asm-h8300/page.h                           |    7 
 include/asm-i386/Kbuild                            |    9 
 include/asm-ia64/Kbuild                            |   18 
 include/asm-ia64/numa.h                            |    6 
 include/asm-m32r/page.h                            |    3 
 include/asm-m32r/ptrace.h                          |    4 
 include/asm-m32r/signal.h                          |    1 
 include/asm-m32r/unistd.h                          |    4 
 include/asm-m32r/user.h                            |    1 
 include/asm-m68knommu/page.h                       |    7 
 include/asm-powerpc/Kbuild                         |   45 -
 include/asm-powerpc/ptrace.h                       |    4 
 include/asm-s390/Kbuild                            |   11 
 include/asm-sh/page.h                              |    3 
 include/asm-sh/ptrace.h                            |    2 
 include/asm-sh64/page.h                            |    3 
 include/asm-sh64/shmparam.h                        |   16 
 include/asm-sh64/signal.h                          |    1 
 include/asm-sh64/user.h                            |    1 
 include/asm-sparc/Kbuild                           |   17 
 include/asm-sparc/page.h                           |    8 
 include/asm-sparc64/Kbuild                         |   24 
 include/asm-sparc64/page.h                         |    9 
 include/asm-sparc64/shmparam.h                     |    2 
 include/asm-um/Kbuild                              |    1 
 include/asm-v850/page.h                            |    7 
 include/asm-v850/param.h                           |    4 
 include/asm-x86_64/Kbuild                          |   18 
 include/linux/Kbuild                               |  400 +++++++--
 include/linux/byteorder/Kbuild                     |    9 
 include/linux/dvb/Kbuild                           |   11 
 include/linux/mmzone.h                             |    3 
 include/linux/netfilter/Kbuild                     |   47 -
 include/linux/netfilter_arp/Kbuild                 |    5 
 include/linux/netfilter_bridge/Kbuild              |   21 
 include/linux/netfilter_ipv4/Kbuild                |   82 +
 include/linux/netfilter_ipv6/Kbuild                |   27 
 include/linux/nfsd/Kbuild                          |    9 
 include/linux/raid/Kbuild                          |    3 
 include/linux/scx200.h                             |    2 
 include/linux/stddef.h                             |    2 
 include/linux/sunrpc/Kbuild                        |    2 
 include/linux/swap.h                               |    1 
 include/linux/sysctl.h                             |    1 
 include/linux/tc_act/Kbuild                        |    5 
 include/linux/tc_ematch/Kbuild                     |    5 
 include/mtd/Kbuild                                 |    8 
 include/rdma/Kbuild                                |    2 
 include/scsi/Kbuild                                |    4 
 include/sound/Kbuild                               |   12 
 include/video/Kbuild                               |    2 
 init/Kconfig                                       |    1 
 kernel/module.c                                    |    6 
 kernel/sched.c                                     |   54 +
 kernel/sysctl.c                                    |   11 
 mm/page_alloc.c                                    |   21 
 mm/truncate.c                                      |   34 
 mm/vmscan.c                                        |   58 -
 net/core/dev.c                                     |   14 
 net/ipv4/netfilter/ip_nat_standalone.c             |   11 
 net/ipv4/tcp_input.c                               |   16 
 net/ipv6/ipv6_sockglue.c                           |    3 
 net/ipv6/tcp_ipv6.c                                |    2 
 net/sched/cls_api.c                                |    4 
 net/sched/cls_basic.c                              |    2 
 net/sched/sch_api.c                                |   16 
 net/sched/sch_generic.c                            |   66 -
 sound/core/control.c                               |    1 
 148 files changed, 2816 insertions(+), 1435 deletions(-)

Summary of changes from v2.6.18 to v2.6.18.1
============================================

Alan Cox:
      ide-generic: jmicron fix

Andrew Morton:
      invalidate_inode_pages2(): ignore page refcounts

Arnd Bergmann:
      powerpc: fix building gdb against asm/ptrace.h

Benjamin Herrenschmidt:
      powerpc: Fix ohare IDE irq workaround on old powermacs

Christoph Lameter:
      Fix longstanding load balancing bug in the scheduler
      zone_reclaim: dynamic slab reclaim

Daniel Drake:
      zd1211rw: ZD1211B ASIC/FWT, not jointly decoder

Dave Jones:
      CPUFREQ: Fix some more CPU hotplug locking.
      add utsrelease.h to the dontdiff file

David Miller:
      PKT_SCHED: cls_basic: Use unsigned int when generating handle
      IPV6: Disable SG for GSO unless we have checksum
      TCP: Fix and simplify microsecond rtt sampling

David Rientjes:
      do not free non slab allocated per_cpu_pageset

David S. Miller:
      SPARC64: Fix serious bug in sched_clock() on sparc64
      SPARC64: Fix sparc64 ramdisk handling

David Woodhouse:
      One line per header in Kbuild files to reduce conflicts
      Fix ARM 'make headers_check'
      Fix 'make headers_check' on m32r
      Fix exported headers for SPARC, SPARC64
      Fix m68knommu exported headers
      Fix H8300 exported headers.
      Remove ARM26 header export.
      Remove UML header export
      Don't advertise (or allow) headers_{install,check} where inappropriate.
      Fix v850 exported headers
      Clean up exported headers on CRIS
      Remove offsetof() from user-visible <linux/stddef.h>

Ed Swierk:
      load_module: no BUG if module_subsys uninitialized

Fabio Olive Leite:
      IPV6: bh_lock_sock_nested on tcp_v6_rcv

Geert Uytterhoeven:
      fbdev: correct buffer size limit in fbmem_read_proc()

Greg Kroah-Hartman:
      Linux 2.6.18.1

Hans Verkuil:
      V4L: Fix msp343xG handling regression

Hidetoshi Seto:
      sysfs: remove duplicated dput in sysfs_update_file

Jack Morgenstein:
      IB/mthca: Fix lid used for sending traps

Jan Kara:
      jbd: fix commit of ordered data buffers

Jean-Baptiste Maneyrol:
      rtc driver rtc-pcf8563 century bit inversed

Jeff Dike:
      UML: Fix UML build failure

Jeff Garzik:
      mv643xx_eth: fix obvious typo, which caused build breakage
      netdrvr: lp486e: fix typo
      sata_mv: fix oops

Jim Cromie:
      scx200_hrt: fix precedence bug manifesting as 27x clock in 1 MHz mode

Jon Mason:
      x86-64: Calgary IOMMU: Fix off by one when calculating register space location

Jonathan Corbet:
      Fix VIDIOC_ENUMSTD bug

KAMEZAWA Hiroyuki:
      cpu to node relationship fixup: acpi_map_cpu2node
      cpu to node relationship fixup: map cpu to node

keith mannthey:
      i386 bootioremap / kexec fix
      i386: fix flat mode numa on a real numa system

Larry Finger:
      bcm43xx: fix regressions in 2.6.18

Martin Schwidefsky:
      S390: user readable uninitialised kernel memory (CVE-2006-5174)

Michael Hanselmann:
      backlight: fix oops in __mutex_lock_slowpath during head /sys/class/graphics/fb0/*

Mike Isely:
      V4L: pvrusb2: Solve mutex deadlock
      V4L: pvrusb2: improve 24XXX config option description
      V4L: pvrusb2: Suppress compiler warning
      V4L: pvrusb2: Limit hor res for 24xxx devices

Neil Brown:
      MD: Fix problem where hot-added drives are not resynced.

Nick Piggin:
      mm: bug in set_page_dirty_buffers

Paolo 'Blaisorblade' Giarrusso:
      uml: allow using again x86/x86_64 crypto code
      uml: use DEFCONFIG_LIST to avoid reading host's config

Patrick McHardy:
      NET_SCHED: Fix fallout from dev->qdisc RCU change
      NETFILTER: NAT: fix NOTRACK checksum handling

Paul Mundt:
      Fix 'make headers_check' on sh
      Fix 'make headers_check' on sh64

Peter Zijlstra:
      rtc: lockdep fix/workaround

Sascha Hauer:
      V4L: copy-paste bug in videodev.c

Stephen Hemminger:
      sky2: tx pause bug fix
      sky2 network driver device ids

Takashi Iwai:
      ALSA: Fix initiailization of user-space controls

Tony Lindgren:
      USB: Allow compile in g_ether, fix typo

Vasily Tarasov:
      block layer: elv_iosched_show should get elv_list_lock

Yeasah Pell:
      DVB: cx24123: fix PLL divisor setup

