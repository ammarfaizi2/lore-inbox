Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262309AbREZQbr>; Sat, 26 May 2001 12:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262176AbREZQbh>; Sat, 26 May 2001 12:31:37 -0400
Received: from [194.64.254.254] ([194.64.254.254]:52491 "EHLO
	springer254.asv.de") by vger.kernel.org with ESMTP
	id <S262164AbREZQbc>; Sat, 26 May 2001 12:31:32 -0400
Message-ID: <022e01c0e5fc$39ac0cf0$2e2ca8c0@buxtown.de>
From: "Ingo T. Storm" <it@lapavoni.de>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <3B0BFE90.CE148B7@kjist.ac.kr> <20010523210923.A730@athlon.random>
Subject: 2.4.5 does not link on Ruffian (alpha)
Date: Sat, 26 May 2001 17:20:29 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.3018.1300
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.3018.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just tried to compile 2.4.5 on a Ruffian. With CPU selection "generic" it
fails when linking the kernel (see below). With CPU=Ruffian, it compiles and
links fine. Haven't tried booting yet, 'cause the machine is some 20 miles
away from here.

What more can I provide/do to help?

Cheers,
Ingo

-------------

ld  -r -o kernel.o entry.o traps.o process.o osf_sys.o irq.o irq_alpha.o
signal.
o setup.o ptrace.o time.o semaphore.o alpha_ksyms.o irq_i8259.o irq_srm.o
es1888
.o smc37c669.o smc37c93x.o ns87312.o pci.o pci_iommu.o core_apecs.o
core_cia.o c
ore_irongate.o core_lca.o core_mcpcia.o core_polaris.o core_t2.o
core_tsunami.o
core_titan.o sys_alcor.o sys_cabriolet.o sys_dp264.o sys_eb64p.o sys_eiger.o
sys
_jensen.o sys_miata.o sys_mikasa.o sys_nautilus.o sys_titan.o sys_noritake.o
sys
_rawhide.o sys_ruffian.o sys_rx164.o sys_sable.o sys_sio.o sys_sx164.o
sys_takar
a.o sys_wildfire.o core_wildfire.o irq_pyxis.o
sys_dp264.o: In function `tsunami_inb':
sys_dp264.c(.text+0x440): multiple definition of `tsunami_inb'
core_tsunami.o(.text+0x500):core_tsunami.c: first defined here
sys_dp264.o: In function `clipper_map_irq':
sys_dp264.c(.text+0x480): multiple definition of `tsunami_inw'
core_tsunami.o(.text+0x540):core_tsunami.c: first defined here
sys_dp264.o: In function `tsunami_inl':
sys_dp264.c(.text+0x4c0): multiple definition of `tsunami_inl'
core_tsunami.o(.text+0x580):core_tsunami.c: first defined here
sys_dp264.o: In function `tsunami_outb':
sys_dp264.c(.text+0x460): multiple definition of `tsunami_outb'
core_tsunami.o(.text+0x520):core_tsunami.c: first defined here
sys_dp264.o: In function `tsunami_outw':
sys_dp264.c(.text+0x4a0): multiple definition of `tsunami_outw'
core_tsunami.o(.text+0x560):core_tsunami.c: first defined here
sys_dp264.o: In function `dp264_init_pci':
sys_dp264.c(.text+0x4e0): multiple definition of `tsunami_outl'
core_tsunami.o(.text+0x5a0):core_tsunami.c: first defined here
sys_dp264.o: In function `tsunami_readb':
sys_dp264.c(.text+0x540): multiple definition of `tsunami_readb'
core_tsunami.o(.text+0x600):core_tsunami.c: first defined here
sys_dp264.o: In function `tsunami_readw':
sys_dp264.c(.text+0x560): multiple definition of `tsunami_readw'
core_tsunami.o(.text+0x620):core_tsunami.c: first defined here
sys_dp264.o: In function `webbrick_init_arch':
sys_dp264.c(.text+0x580): multiple definition of `tsunami_readl'
core_tsunami.o(.text+0x640):core_tsunami.c: first defined here
sys_dp264.o: In function `tsunami_readq':
sys_dp264.c(.text+0x5a0): multiple definition of `tsunami_readq'
core_tsunami.o(.text+0x660):core_tsunami.c: first defined here
sys_dp264.o: In function `tsunami_writeb':
sys_dp264.c(.text+0x5c0): multiple definition of `tsunami_writeb'
core_tsunami.o(.text+0x680):core_tsunami.c: first defined here
sys_dp264.o: In function `tsunami_writew':
sys_dp264.c(.text+0x5e0): multiple definition of `tsunami_writew'
core_tsunami.o(.text+0x6a0):core_tsunami.c: first defined here
sys_dp264.o: In function `tsunami_writel':
sys_dp264.c(.text+0x600): multiple definition of `tsunami_writel'
core_tsunami.o(.text+0x6c0):core_tsunami.c: first defined here
sys_dp264.o: In function `tsunami_writeq':
sys_dp264.c(.text+0x620): multiple definition of `tsunami_writeq'
core_tsunami.o(.text+0x6e0):core_tsunami.c: first defined here
sys_dp264.o: In function `tsunami_ioremap':
sys_dp264.c(.text+0x500): multiple definition of `tsunami_ioremap'
core_tsunami.o(.text+0x5c0):core_tsunami.c: first defined here
sys_dp264.o: In function `monet_init_pci':
sys_dp264.c(.text+0x520): multiple definition of `tsunami_is_ioaddr'
core_tsunami.o(.text+0x5e0):core_tsunami.c: first defined here
make[1]: *** [kernel.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.5/arch/alpha/kernel'
make: *** [_dir_arch/alpha/kernel] Error 2

