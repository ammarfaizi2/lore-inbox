Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132243AbRCVX0j>; Thu, 22 Mar 2001 18:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132244AbRCVX0a>; Thu, 22 Mar 2001 18:26:30 -0500
Received: from feeder.cyberbills.com ([64.41.210.81]:8205 "EHLO
	sjc-smtp2.cyberbills.com") by vger.kernel.org with ESMTP
	id <S132243AbRCVX0O>; Thu, 22 Mar 2001 18:26:14 -0500
Date: Thu, 22 Mar 2001 15:25:26 -0800 (PST)
From: "Sergey Kubushin" <ksi@cyberbills.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2-ac21
In-Reply-To: <E14g9vt-000334-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.31ksi3.0103221518020.22784-100000@nomad.cyberbills.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Mar 2001, Alan Cox wrote:

Does not build for PPro/P-II. i586 is OK.

=== Cut ===
ld -m elf_i386 -T /tmp/build-kernel/usr/src/linux-2.4.2ac21/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o \
	--start-group \
	arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
	drivers/block/block.o drivers/char/char.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o  drivers/char/drm/drm.o drivers/net/fc/fc.o drivers/net/appletalk/appletalk.o drivers/net/tokenring/tr.o drivers/net/wan/wan.o drivers/atm/atm.o drivers/cdrom/driver.o drivers/pci/driver.o drivers/video/video.o drivers/net/hamradio/hamradio.o drivers/md/mddev.o \
	net/network.o \
	/tmp/build-kernel/usr/src/linux-2.4.2ac21/arch/i386/lib/lib.a /tmp/build-kernel/usr/src/linux-2.4.2ac21/lib/lib.a /tmp/build-kernel/usr/src/linux-2.4.2ac21/arch/i386/lib/lib.a \
	--end-group \
	-o vmlinux
arch/i386/mm/mm.o: In function `do_check_pgt_cache':
arch/i386/mm/mm.o(.text+0x201): undefined reference to `get_pmd_slow'
mm/mm.o: In function `clear_page_tables':
mm/mm.o(.text+0x150): undefined reference to `pmd_free'
mm/mm.o: In function `__pmd_alloc':
mm/mm.o(.text+0x1fe4): undefined reference to `get_pmd_slow'
mm/mm.o(.text+0x207a): undefined reference to `pmd_free'
mm/mm.o(.text+0x208a): undefined reference to `pgd_populate'
make: *** [vmlinux] Error 1
=== Cut ===

Here is the config (processor part). Full config is available on request.
Everything's modular except romfs and initrd.

=== Cut ===
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
CONFIG_M686=y
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_TOSHIBA=m
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
# CONFIG_NOHIGHMEM is not set
# CONFIG_HIGHMEM4G is not set
CONFIG_HIGHMEM64G=y
CONFIG_HIGHMEM=y
CONFIG_X86_PAE=y
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_HAVE_DEC_LOCK=y
=== Cut ===

---
Sergey Kubushin				Sr. Unix Administrator
CyberBills, Inc.			Phone:	702-567-8857
874 American Pacific Dr,		Fax:	702-567-8808
Henderson, NV, 89014

