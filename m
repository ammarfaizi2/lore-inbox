Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262044AbUCPPy5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 10:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263188AbUCPPxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 10:53:12 -0500
Received: from prosun.first.gmd.de ([194.95.168.2]:46761 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S262101AbUCPOf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:35:59 -0500
Subject: 2.6.5-rc1 compile errors on ppc...
From: Soeren Sonnenburg <kernel@nn7.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1079447741.2903.29.camel@localhost>
Mime-Version: 1.0
Date: Tue, 16 Mar 2004 15:35:42 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

trying to compile 2.6.5-rc1 on a ppc machine gives this:

  CHK     include/linux/version.h
  UPD     include/linux/version.h
  SYMLINK include/asm -> include/asm-ppc
  HOSTCC  scripts/split-include
  HOSTCC  scripts/conmakehash
  HOSTCC  scripts/docproc
  HOSTCC  scripts/kallsyms
  CC      scripts/empty.o
  HOSTCC  scripts/mk_elfconfig
  MKELF   scripts/elfconfig.h
  HOSTCC  scripts/file2alias.o
  HOSTCC  scripts/modpost.o
  HOSTCC  scripts/sumversion.o
  HOSTLD  scripts/modpost
  HOSTCC  scripts/pnmtologo
  HOSTCC  scripts/bin2c
  SPLIT   include/linux/autoconf.h -> include/config/*
  CC      arch/ppc/kernel/asm-offsets.s
  CHK     include/asm-ppc/offsets.h
  UPD     include/asm-ppc/offsets.h
  CC      init/main.o
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  CC      init/do_mounts.o
  CC      init/do_mounts_devfs.o
  LD      init/mounts.o
  CC      init/initramfs.o
  LD      init/built-in.o
  HOSTCC  usr/gen_init_cpio
  CPIO    usr/initramfs_data.cpio
  GZIP    usr/initramfs_data.cpio.gz
  AS      usr/initramfs_data.o
  LD      usr/built-in.o
  AS      arch/ppc/kernel/entry.o
  CC      arch/ppc/kernel/traps.o
  CC      arch/ppc/kernel/irq.o
In file included from include/linux/pci.h:720,
                 from arch/ppc/kernel/irq.c:42:
include/asm/pci.h: In function `pci_dma_sync_single_for_cpu':
include/asm/pci.h:203: warning: implicit declaration of function `consistent_sync_for_cpu'
include/asm/pci.h: In function `pci_dma_sync_single_for_device':
include/asm/pci.h:212: warning: implicit declaration of function `consistent_sync_for_device'
include/asm/pci.h: In function `pci_dma_sync_sg_for_cpu':
include/asm/pci.h:230: warning: implicit declaration of function `consistent_sync_page_for_cpu'
include/asm/pci.h: In function `pci_dma_sync_sg_for_device':
include/asm/pci.h:243: warning: implicit declaration of function `consistent_sync_page_for_device'
  CC      arch/ppc/kernel/idle.o
  CC      arch/ppc/kernel/time.o
  AS      arch/ppc/kernel/misc.o
  CC      arch/ppc/kernel/process.o
  CC      arch/ppc/kernel/signal.o
  CC      arch/ppc/kernel/ptrace.o
  CC      arch/ppc/kernel/align.o
  CC      arch/ppc/kernel/semaphore.o
  CC      arch/ppc/kernel/syscalls.o
  CC      arch/ppc/kernel/setup.o
In file included from include/linux/pci.h:720,
                 from include/linux/ide.h:20,
                 from arch/ppc/kernel/setup.c:13:
include/asm/pci.h: In function `pci_dma_sync_single_for_cpu':
include/asm/pci.h:203: warning: implicit declaration of function `consistent_sync_for_cpu'
include/asm/pci.h: In function `pci_dma_sync_single_for_device':
include/asm/pci.h:212: warning: implicit declaration of function `consistent_sync_for_device'
include/asm/pci.h: In function `pci_dma_sync_sg_for_cpu':
include/asm/pci.h:230: warning: implicit declaration of function `consistent_sync_page_for_cpu'
include/asm/pci.h: In function `pci_dma_sync_sg_for_device':
include/asm/pci.h:243: warning: implicit declaration of function `consistent_sync_page_for_device'
  CC      arch/ppc/kernel/cputable.o
  CC      arch/ppc/kernel/ppc_htab.o
  AS      arch/ppc/kernel/l2cr.o
  AS      arch/ppc/kernel/cpu_setup_6xx.o
  CC      arch/ppc/kernel/module.o
  CC      arch/ppc/kernel/ppc_ksyms.o
In file included from include/linux/pci.h:720,
                 from arch/ppc/kernel/ppc_ksyms.c:14:
include/asm/pci.h: In function `pci_dma_sync_single_for_cpu':
include/asm/pci.h:203: warning: implicit declaration of function `consistent_sync_for_cpu'
include/asm/pci.h: In function `pci_dma_sync_single_for_device':
include/asm/pci.h:212: warning: implicit declaration of function `consistent_sync_for_device'
include/asm/pci.h: In function `pci_dma_sync_sg_for_cpu':
include/asm/pci.h:230: warning: implicit declaration of function `consistent_sync_page_for_cpu'
include/asm/pci.h: In function `pci_dma_sync_sg_for_device':
include/asm/pci.h:243: warning: implicit declaration of function `consistent_sync_page_for_device'
  CC      arch/ppc/kernel/pci.o
In file included from include/linux/pci.h:720,
                 from arch/ppc/kernel/pci.c:7:
include/asm/pci.h: In function `pci_dma_sync_single_for_cpu':
include/asm/pci.h:203: warning: implicit declaration of function `consistent_sync_for_cpu'
include/asm/pci.h: In function `pci_dma_sync_single_for_device':
include/asm/pci.h:212: warning: implicit declaration of function `consistent_sync_for_device'
include/asm/pci.h: In function `pci_dma_sync_sg_for_cpu':
include/asm/pci.h:230: warning: implicit declaration of function `consistent_sync_page_for_cpu'
include/asm/pci.h: In function `pci_dma_sync_sg_for_device':
include/asm/pci.h:243: warning: implicit declaration of function `consistent_sync_page_for_device'
  CC      arch/ppc/kernel/pci-dma.o
In file included from include/linux/pci.h:720,
                 from arch/ppc/kernel/pci-dma.c:14:
include/asm/pci.h: In function `pci_dma_sync_single_for_cpu':
include/asm/pci.h:203: warning: implicit declaration of function `consistent_sync_for_cpu'
include/asm/pci.h: In function `pci_dma_sync_single_for_device':
include/asm/pci.h:212: warning: implicit declaration of function `consistent_sync_for_device'
include/asm/pci.h: In function `pci_dma_sync_sg_for_cpu':
include/asm/pci.h:230: warning: implicit declaration of function `consistent_sync_page_for_cpu'
include/asm/pci.h: In function `pci_dma_sync_sg_for_device':
include/asm/pci.h:243: warning: implicit declaration of function `consistent_sync_page_for_device'
  LD      arch/ppc/kernel/built-in.o
  AS      arch/ppc/kernel/head.o
  AS      arch/ppc/kernel/idle_6xx.o
  CPP     arch/ppc/kernel/vmlinux.lds.s
  CC      arch/ppc/platforms/pmac_pic.o
In file included from include/linux/pci.h:720,
                 from arch/ppc/platforms/pmac_pic.c:23:
include/asm/pci.h: In function `pci_dma_sync_single_for_cpu':
include/asm/pci.h:203: warning: implicit declaration of function `consistent_sync_for_cpu'
include/asm/pci.h: In function `pci_dma_sync_single_for_device':
include/asm/pci.h:212: warning: implicit declaration of function `consistent_sync_for_device'
include/asm/pci.h: In function `pci_dma_sync_sg_for_cpu':
include/asm/pci.h:230: warning: implicit declaration of function `consistent_sync_page_for_cpu'
include/asm/pci.h: In function `pci_dma_sync_sg_for_device':
include/asm/pci.h:243: warning: implicit declaration of function `consistent_sync_page_for_device'
  CC      arch/ppc/platforms/pmac_setup.o
In file included from include/linux/pci.h:720,
                 from include/linux/ide.h:20,
                 from arch/ppc/platforms/pmac_setup.c:46:
include/asm/pci.h: In function `pci_dma_sync_single_for_cpu':
include/asm/pci.h:203: warning: implicit declaration of function `consistent_sync_for_cpu'
include/asm/pci.h: In function `pci_dma_sync_single_for_device':
include/asm/pci.h:212: warning: implicit declaration of function `consistent_sync_for_device'
include/asm/pci.h: In function `pci_dma_sync_sg_for_cpu':
include/asm/pci.h:230: warning: implicit declaration of function `consistent_sync_page_for_cpu'
include/asm/pci.h: In function `pci_dma_sync_sg_for_device':
include/asm/pci.h:243: warning: implicit declaration of function `consistent_sync_page_for_device'
  CC      arch/ppc/platforms/pmac_time.o
  CC      arch/ppc/platforms/pmac_feature.o
In file included from include/linux/pci.h:720,
                 from arch/ppc/platforms/pmac_feature.c:31:
include/asm/pci.h: In function `pci_dma_sync_single_for_cpu':
include/asm/pci.h:203: warning: implicit declaration of function `consistent_sync_for_cpu'
include/asm/pci.h: In function `pci_dma_sync_single_for_device':
include/asm/pci.h:212: warning: implicit declaration of function `consistent_sync_for_device'
include/asm/pci.h: In function `pci_dma_sync_sg_for_cpu':
include/asm/pci.h:230: warning: implicit declaration of function `consistent_sync_page_for_cpu'
include/asm/pci.h: In function `pci_dma_sync_sg_for_device':
include/asm/pci.h:243: warning: implicit declaration of function `consistent_sync_page_for_device'
  CC      arch/ppc/platforms/pmac_pci.o
In file included from include/linux/pci.h:720,
                 from arch/ppc/platforms/pmac_pci.c:16:
include/asm/pci.h: In function `pci_dma_sync_single_for_cpu':
include/asm/pci.h:203: warning: implicit declaration of function `consistent_sync_for_cpu'
include/asm/pci.h: In function `pci_dma_sync_single_for_device':
include/asm/pci.h:212: warning: implicit declaration of function `consistent_sync_for_device'
include/asm/pci.h: In function `pci_dma_sync_sg_for_cpu':
include/asm/pci.h:230: warning: implicit declaration of function `consistent_sync_page_for_cpu'
include/asm/pci.h: In function `pci_dma_sync_sg_for_device':
include/asm/pci.h:243: warning: implicit declaration of function `consistent_sync_page_for_device'
  AS      arch/ppc/platforms/pmac_sleep.o
  CC      arch/ppc/platforms/pmac_low_i2c.o
  CC      arch/ppc/platforms/chrp_setup.o
In file included from include/linux/pci.h:720,
                 from arch/ppc/platforms/chrp_setup.c:29:
include/asm/pci.h: In function `pci_dma_sync_single_for_cpu':
include/asm/pci.h:203: warning: implicit declaration of function `consistent_sync_for_cpu'
include/asm/pci.h: In function `pci_dma_sync_single_for_device':
include/asm/pci.h:212: warning: implicit declaration of function `consistent_sync_for_device'
include/asm/pci.h: In function `pci_dma_sync_sg_for_cpu':
include/asm/pci.h:230: warning: implicit declaration of function `consistent_sync_page_for_cpu'
include/asm/pci.h: In function `pci_dma_sync_sg_for_device':
include/asm/pci.h:243: warning: implicit declaration of function `consistent_sync_page_for_device'
  CC      arch/ppc/platforms/chrp_time.o
  CC      arch/ppc/platforms/chrp_pci.o
In file included from include/linux/pci.h:720,
                 from arch/ppc/platforms/chrp_pci.c:7:
include/asm/pci.h: In function `pci_dma_sync_single_for_cpu':
include/asm/pci.h:203: warning: implicit declaration of function `consistent_sync_for_cpu'
include/asm/pci.h: In function `pci_dma_sync_single_for_device':
include/asm/pci.h:212: warning: implicit declaration of function `consistent_sync_for_device'
include/asm/pci.h: In function `pci_dma_sync_sg_for_cpu':
include/asm/pci.h:230: warning: implicit declaration of function `consistent_sync_page_for_cpu'
include/asm/pci.h: In function `pci_dma_sync_sg_for_device':
include/asm/pci.h:243: warning: implicit declaration of function `consistent_sync_page_for_device'
  CC      arch/ppc/platforms/prep_pci.o
In file included from include/linux/pci.h:720,
                 from arch/ppc/platforms/prep_pci.c:11:
include/asm/pci.h: In function `pci_dma_sync_single_for_cpu':
include/asm/pci.h:203: warning: implicit declaration of function `consistent_sync_for_cpu'
include/asm/pci.h: In function `pci_dma_sync_single_for_device':
include/asm/pci.h:212: warning: implicit declaration of function `consistent_sync_for_device'
include/asm/pci.h: In function `pci_dma_sync_sg_for_cpu':
include/asm/pci.h:230: warning: implicit declaration of function `consistent_sync_page_for_cpu'
include/asm/pci.h: In function `pci_dma_sync_sg_for_device':
include/asm/pci.h:243: warning: implicit declaration of function `consistent_sync_page_for_device'
  CC      arch/ppc/platforms/prep_setup.o
In file included from include/linux/pci.h:720,
                 from arch/ppc/platforms/prep_setup.c:38:
include/asm/pci.h: In function `pci_dma_sync_single_for_cpu':
include/asm/pci.h:203: warning: implicit declaration of function `consistent_sync_for_cpu'
include/asm/pci.h: In function `pci_dma_sync_single_for_device':
include/asm/pci.h:212: warning: implicit declaration of function `consistent_sync_for_device'
include/asm/pci.h: In function `pci_dma_sync_sg_for_cpu':
include/asm/pci.h:230: warning: implicit declaration of function `consistent_sync_page_for_cpu'
include/asm/pci.h: In function `pci_dma_sync_sg_for_device':
include/asm/pci.h:243: warning: implicit declaration of function `consistent_sync_page_for_device'
  CC      arch/ppc/platforms/pmac_nvram.o
  CC      arch/ppc/platforms/pmac_cpufreq.o
  CC      arch/ppc/platforms/pmac_backlight.o
  LD      arch/ppc/platforms/built-in.o
  CC      arch/ppc/mm/fault.o
  CC      arch/ppc/mm/init.o
  CC      arch/ppc/mm/mem_pieces.o
  CC      arch/ppc/mm/mmu_context.o
  CC      arch/ppc/mm/pgtable.o
  AS      arch/ppc/mm/hashtable.o
  CC      arch/ppc/mm/ppc_mmu.o
  CC      arch/ppc/mm/tlb.o
  LD      arch/ppc/mm/built-in.o
  AS      arch/ppc/lib/checksum.o
  AS      arch/ppc/lib/string.o
  CC      arch/ppc/lib/strcase.o
  CC      arch/ppc/lib/dec_and_lock.o
  AS      arch/ppc/lib/div64.o
  LD      arch/ppc/lib/built-in.o
  CC      arch/ppc/syslib/prep_nvram.o
  CC      arch/ppc/syslib/prom_init.o
In file included from include/linux/pci.h:720,
                 from arch/ppc/syslib/prom_init.c:16:
include/asm/pci.h: In function `pci_dma_sync_single_for_cpu':
include/asm/pci.h:203: warning: implicit declaration of function `consistent_sync_for_cpu'
include/asm/pci.h: In function `pci_dma_sync_single_for_device':
include/asm/pci.h:212: warning: implicit declaration of function `consistent_sync_for_device'
include/asm/pci.h: In function `pci_dma_sync_sg_for_cpu':
include/asm/pci.h:230: warning: implicit declaration of function `consistent_sync_page_for_cpu'
include/asm/pci.h: In function `pci_dma_sync_sg_for_device':
include/asm/pci.h:243: warning: implicit declaration of function `consistent_sync_page_for_device'
  CC      arch/ppc/syslib/prom.o
In file included from include/linux/pci.h:720,
                 from arch/ppc/syslib/prom.c:20:
include/asm/pci.h: In function `pci_dma_sync_single_for_cpu':
include/asm/pci.h:203: warning: implicit declaration of function `consistent_sync_for_cpu'
include/asm/pci.h: In function `pci_dma_sync_single_for_device':
include/asm/pci.h:212: warning: implicit declaration of function `consistent_sync_for_device'
include/asm/pci.h: In function `pci_dma_sync_sg_for_cpu':
include/asm/pci.h:230: warning: implicit declaration of function `consistent_sync_page_for_cpu'
include/asm/pci.h: In function `pci_dma_sync_sg_for_device':
include/asm/pci.h:243: warning: implicit declaration of function `consistent_sync_page_for_device'
  CC      arch/ppc/syslib/of_device.o
  CC      arch/ppc/syslib/open_pic.o
  CC      arch/ppc/syslib/indirect_pci.o
In file included from include/linux/pci.h:720,
                 from arch/ppc/syslib/indirect_pci.c:13:
include/asm/pci.h: In function `pci_dma_sync_single_for_cpu':
include/asm/pci.h:203: warning: implicit declaration of function `consistent_sync_for_cpu'
include/asm/pci.h: In function `pci_dma_sync_single_for_device':
include/asm/pci.h:212: warning: implicit declaration of function `consistent_sync_for_device'
include/asm/pci.h: In function `pci_dma_sync_sg_for_cpu':
include/asm/pci.h:230: warning: implicit declaration of function `consistent_sync_page_for_cpu'
include/asm/pci.h: In function `pci_dma_sync_sg_for_device':
include/asm/pci.h:243: warning: implicit declaration of function `consistent_sync_page_for_device'
arch/ppc/syslib/indirect_pci.c: In function `indirect_read_config':
arch/ppc/syslib/indirect_pci.c:47: error: `dev' undeclared (first use in this function)
arch/ppc/syslib/indirect_pci.c:47: error: (Each undeclared identifier is reported only once
arch/ppc/syslib/indirect_pci.c:47: error: for each function it appears in.)
arch/ppc/syslib/indirect_pci.c: In function `indirect_write_config':
arch/ppc/syslib/indirect_pci.c:86: error: `dev' undeclared (first use in this function)
make[1]: *** [arch/ppc/syslib/indirect_pci.o] Error 1


