Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317415AbSHTWHI>; Tue, 20 Aug 2002 18:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317422AbSHTWHI>; Tue, 20 Aug 2002 18:07:08 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:24486 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317415AbSHTWGk>; Tue, 20 Aug 2002 18:06:40 -0400
Date: Tue, 20 Aug 2002 15:14:41 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: davidm@hpl.hp.com
cc: Hanna Linder <hannal@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-ia64@linuxia64.org
Subject: Re: PCI Cleanup
Message-ID: <68750000.1029881681@w-hlinder>
In-Reply-To: <15714.36383.143413.598935@napali.hpl.hp.com>
References: <36220000.1029866315@w-hlinder><15714.33709.181011.773290@napali.hpl.hp.com><39680000.1029868258@w-hlinder> <15714.36383.143413.598935@napali.hpl.hp.com>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Tuesday, August 20, 2002 11:44:47 -0700 David Mosberger <davidm@napali.hpl.hp.com> wrote:

>>>>>> On Tue, 20 Aug 2002 11:30:58 -0700, Hanna Linder <hannal@us.ibm.com> said:
> 
>   Hanna> Thanks for your quick reply. I found your 2.5.30 test patch
>   Hanna> and I will give it a try on a system here. They are all MP
>   Hanna> but I will configure it as UP.
> 
> Just a caveat: don't use the CMD649 IDE driver.  It seems to like to
> eat your filesystem.  Other than that, I haven't had any problems.
> 
> 	--david
> 

Should there have been another patch that would go before the 2.5.30 
test patch on top of a kernel.org clean 2.5.30 kernel? It is not 
applying cleanly and before I dig into code Im not very familiar 
with I thought I would ask here. Yes, this is my first time on
an ia64 system.

Thanks,

Hanna Linder
hannal@us.ibm.com

----------

Here are the results from patch:

> [root@elm3a75 linux-2.5.30]# patch -p1 <ia64-2.5.30.patch
> patching file Documentation/mmio_barrier.txt
> patching file Makefile
> patching file arch/i386/mm/fault.c
> patching file arch/ia64/Makefile
> Hunk #2 succeeded at 26 with fuzz 1.
> patching file arch/ia64/boot/Makefile
> patching file arch/ia64/config.in
> Hunk #1 FAILED at 64.
> Hunk #2 FAILED at 100.
> Hunk #3 FAILED at 123.
> Hunk #4 FAILED at 155.
> 4 out of 5 hunks FAILED -- saving rejects to file arch/ia64/config.in.rej
> patching file arch/ia64/hp/Config.in
> Reversed (or previously applied) patch detected!  Assume -R? [n] n
> Apply anyway? [n] n
> Skipping patch.
> 1 out of 1 hunk ignored -- saving rejects to file arch/ia64/hp/Config.in.rej
> patching file arch/ia64/hp/common/sba_iommu.c
> Hunk #2 succeeded at 111 with fuzz 2.
> Hunk #3 FAILED at 217.
> Hunk #7 FAILED at 362.
> Hunk #8 FAILED at 406.
> Hunk #10 FAILED at 450.
> Hunk #14 FAILED at 624.
> Hunk #16 FAILED at 693.
> Hunk #17 FAILED at 709.
> Hunk #19 FAILED at 747.
> Hunk #20 FAILED at 758.
> Hunk #21 succeeded at 792 with fuzz 2.
> Hunk #22 FAILED at 806.
> Hunk #23 FAILED at 860.
> Hunk #24 FAILED at 908.
> Hunk #25 FAILED at 964.
> Hunk #27 FAILED at 1085.
> Hunk #28 succeeded at 1141 with fuzz 2.
> Hunk #29 FAILED at 1157.
> Hunk #30 FAILED at 1180.
> Hunk #31 succeeded at 1199 with fuzz 1.
> Hunk #32 FAILED at 1207.
> Hunk #33 FAILED at 1268.
> Hunk #34 FAILED at 1291.
> Hunk #35 succeeded at 1301 with fuzz 1.
> Hunk #36 succeeded at 1314 with fuzz 2.
> Hunk #37 FAILED at 1455.
> Hunk #38 FAILED at 1463.
> Hunk #39 succeeded at 1586 with fuzz 2.
> Hunk #40 FAILED at 1595.
> 22 out of 40 hunks FAILED -- saving rejects to file arch/ia64/hp/common/sba_iommu.c.rejpatching file arch/ia64/hp/sim/Config.in
> patching file arch/ia64/hp/sim/hpsim_console.c
> Hunk #1 FAILED at 30.
> 1 out of 1 hunk FAILED -- saving rejects to file arch/ia64/hp/sim/hpsim_console.c.rej
> patching file arch/ia64/hp/sim/hpsim_irq.c
> Hunk #1 FAILED at 22.
> 1 out of 1 hunk FAILED -- saving rejects to file arch/ia64/hp/sim/hpsim_irq.c.rej
> patching file arch/ia64/hp/sim/hpsim_setup.c
> Hunk #1 FAILED at 1.
> Hunk #2 FAILED at 56.
> 2 out of 2 hunks FAILED -- saving rejects to file arch/ia64/hp/sim/hpsim_setup.c.rej
> patching file arch/ia64/hp/sim/simscsi.c
> Hunk #2 FAILED at 150.
> Hunk #3 succeeded at 231 with fuzz 1.
> Hunk #4 succeeded at 272 with fuzz 1.
> Hunk #5 FAILED at 284.
> Hunk #6 succeeded at 345 with fuzz 2.
> 2 out of 6 hunks FAILED -- saving rejects to file arch/ia64/hp/sim/simscsi.c.rej
> patching file arch/ia64/hp/sim/simserial.c
> Hunk #1 succeeded at 13 with fuzz 1.
> Hunk #2 FAILED at 32.
> Hunk #3 FAILED at 63.
> Hunk #4 FAILED at 235.
> Hunk #5 succeeded at 250 with fuzz 2.
> Hunk #6 succeeded at 293 with fuzz 1.
> Hunk #7 succeeded at 317 with fuzz 2.
> Hunk #8 FAILED at 333.
> Hunk #10 FAILED at 398.
> Hunk #11 FAILED at 573.
> Hunk #12 FAILED at 634.
> Hunk #13 FAILED at 665.
> Hunk #14 succeeded at 777 with fuzz 2.
> Hunk #15 FAILED at 858.
> 9 out of 15 hunks FAILED -- saving rejects to file arch/ia64/hp/sim/simserial.c.rej
> patching file arch/ia64/hp/zx1/hpzx1_machvec.c
> Reversed (or previously applied) patch detected!  Assume -R? [n] n
> Apply anyway? [n] n
> Skipping patch.
> 1 out of 1 hunk ignored -- saving rejects to file arch/ia64/hp/zx1/hpzx1_machvec.c.rej patching file arch/ia64/hp/zx1/hpzx1_misc.c
> Hunk #1 FAILED at 12.
> Hunk #2 FAILED at 89.
> Hunk #4 FAILED at 202.
> Hunk #5 FAILED at 243.
> Hunk #6 FAILED at 256.
> Hunk #7 FAILED at 267.
> Hunk #9 FAILED at 310.
> Hunk #10 FAILED at 324.
> 8 out of 11 hunks FAILED -- saving rejects to file arch/ia64/hp/zx1/hpzx1_misc.c.rej
> patching file arch/ia64/ia32/binfmt_elf32.c
> patching file arch/ia64/ia32/ia32_ioctl.c
> Hunk #1 FAILED at 30.
> 1 out of 1 hunk FAILED -- saving rejects to file arch/ia64/ia32/ia32_ioctl.c.rej
> patching file arch/ia64/kernel/acpi.c
> Hunk #1 FAILED at 56.
> Hunk #2 FAILED at 102.
> Hunk #3 succeeded at 135 with fuzz 1.
> Hunk #5 FAILED at 194.
> Hunk #7 succeeded at 227 with fuzz 2.
> Hunk #13 FAILED at 361.
> Hunk #14 FAILED at 370.
> Hunk #16 FAILED at 401.
> Hunk #19 FAILED at 430.
> Hunk #20 FAILED at 500.
> Hunk #21 FAILED at 509.
> Hunk #22 FAILED at 550.
> Hunk #24 FAILED at 606.
> Hunk #26 FAILED at 628.
> Hunk #27 FAILED at 643.
> 13 out of 28 hunks FAILED -- saving rejects to file arch/ia64/kernel/acpi.c.rej
> patching file arch/ia64/kernel/efi.c
> Hunk #1 succeeded at 125 with fuzz 1.
> Hunk #2 succeeded at 207 with fuzz 2.
> Hunk #3 FAILED at 217.
> Hunk #5 FAILED at 366.
> Hunk #6 FAILED at 446.
> Hunk #7 FAILED at 478.
> 4 out of 7 hunks FAILED -- saving rejects to file arch/ia64/kernel/efi.c.rej
> patching file arch/ia64/kernel/entry.S
> Hunk #1 FAILED at 175.
> 1 out of 1 hunk FAILED -- saving rejects to file arch/ia64/kernel/entry.S.rej
> patching file arch/ia64/kernel/ia64_ksyms.c
> Reversed (or previously applied) patch detected!  Assume -R? [n] n
> Apply anyway? [n] n
> Skipping patch.
> 1 out of 1 hunk ignored -- saving rejects to file arch/ia64/kernel/ia64_ksyms.c.rej
> patching file arch/ia64/kernel/init_task.c
> Hunk #1 FAILED at 34.
> 1 out of 1 hunk FAILED -- saving rejects to file arch/ia64/kernel/init_task.c.rej
> patching file arch/ia64/kernel/iosapic.c
> Hunk #1 FAILED at 88.
> Hunk #3 succeeded at 160 with fuzz 2.
> Hunk #4 FAILED at 326.
> Hunk #5 FAILED at 370.
> Hunk #6 FAILED at 410.
> Hunk #8 FAILED at 645.
> Hunk #9 FAILED at 684.
> Hunk #10 FAILED at 761.
> 7 out of 10 hunks FAILED -- saving rejects to file arch/ia64/kernel/iosapic.c.rej
> patching file arch/ia64/kernel/irq.c
> Hunk #1 FAILED at 200.
> Hunk #2 FAILED at 217.
> Hunk #4 FAILED at 282.
> Hunk #5 succeeded at 345 with fuzz 1.
> Hunk #6 FAILED at 368.
> Hunk #8 FAILED at 403.
> Hunk #9 succeeded at 412 with fuzz 2.
> Hunk #10 FAILED at 542.
> 6 out of 12 hunks FAILED -- saving rejects to file arch/ia64/kernel/irq.c.rej
> patching file arch/ia64/kernel/irq_ia64.c
> Hunk #1 succeeded at 36 with fuzz 2.
> Hunk #3 FAILED at 153.
> Hunk #4 FAILED at 181.
> 2 out of 4 hunks FAILED -- saving rejects to file arch/ia64/kernel/irq_ia64.c.rej
> patching file arch/ia64/kernel/irq_lsapic.c
> Hunk #1 FAILED at 27.
> 1 out of 1 hunk FAILED -- saving rejects to file arch/ia64/kernel/irq_lsapic.c.rej
> patching file arch/ia64/kernel/machvec.c
> patching file arch/ia64/kernel/mca.c
> Hunk #1 FAILED at 82.
> 1 out of 3 hunks FAILED -- saving rejects to file arch/ia64/kernel/mca.c.rej
> patching file arch/ia64/kernel/mca_asm.S
> patching file arch/ia64/kernel/pci.c
> Hunk #2 FAILED at 174.
> Hunk #3 FAILED at 265.
> 2 out of 3 hunks FAILED -- saving rejects to file arch/ia64/kernel/pci.c.rej
> patching file arch/ia64/kernel/perfmon.c
> Hunk #1 succeeded at 106 with fuzz 2.
> Hunk #4 FAILED at 908.
> Hunk #5 FAILED at 931.
> Hunk #6 succeeded at 975 with fuzz 2.
> Hunk #7 FAILED at 1287.
> Hunk #8 FAILED at 1378.
> Hunk #9 succeeded at 1401 with fuzz 1.
> Hunk #10 FAILED at 1447.
> Hunk #11 FAILED at 1471.
> Hunk #12 FAILED at 1493.
> Hunk #13 FAILED at 1502.
> Hunk #14 FAILED at 1510.
> Hunk #15 succeeded at 1559 with fuzz 2.
> Hunk #17 FAILED at 1964.
> Hunk #18 succeeded at 1974 with fuzz 2.
> Hunk #19 FAILED at 1982.
> Hunk #20 FAILED at 2370.
> Hunk #21 FAILED at 2402.
> Hunk #22 FAILED at 2418.
> Hunk #23 FAILED at 2965.
> Hunk #24 FAILED at 4125.
> Hunk #25 FAILED at 4157.
> 17 out of 26 hunks FAILED -- saving rejects to file arch/ia64/kernel/perfmon.c.rej
> patching file arch/ia64/kernel/perfmon_itanium.h
> patching file arch/ia64/kernel/perfmon_mckinley.h
> patching file arch/ia64/kernel/process.c
> Hunk #1 FAILED at 325.
> 1 out of 1 hunk FAILED -- saving rejects to file arch/ia64/kernel/process.c.rej
> patching file arch/ia64/kernel/setup.c
> Hunk #1 succeeded at 347 with fuzz 1.
> Hunk #2 FAILED at 444.
> Hunk #4 succeeded at 550 with fuzz 1.
> 1 out of 4 hunks FAILED -- saving rejects to file arch/ia64/kernel/setup.c.rej
> patching file arch/ia64/kernel/signal.c
> Hunk #1 succeeded at 146 with fuzz 1.
> patching file arch/ia64/kernel/smpboot.c
> Hunk #1 FAILED at 1.
> Hunk #3 FAILED at 88.
> Hunk #5 FAILED at 278.
> Hunk #7 FAILED at 398.
> Hunk #9 FAILED at 459.
> Hunk #10 FAILED at 510.
> Hunk #12 FAILED at 567.
> 7 out of 12 hunks FAILED -- saving rejects to file arch/ia64/kernel/smpboot.c.rej
> patching file arch/ia64/kernel/sys_ia64.c
> Hunk #1 FAILED at 82.
> Hunk #2 FAILED at 135.
> 2 out of 2 hunks FAILED -- saving rejects to file arch/ia64/kernel/sys_ia64.c.rej
> patching file arch/ia64/kernel/time.c
> Hunk #1 FAILED at 41.
> Hunk #2 FAILED at 286.
> 2 out of 2 hunks FAILED -- saving rejects to file arch/ia64/kernel/time.c.rej
> patching file arch/ia64/kernel/traps.c
> Hunk #1 FAILED at 62.
> Hunk #3 succeeded at 130 with fuzz 2.
> Hunk #4 succeeded at 436 with fuzz 2.
> Hunk #6 FAILED at 516.
> Hunk #7 succeeded at 533 with fuzz 2.
> 2 out of 7 hunks FAILED -- saving rejects to file arch/ia64/kernel/traps.c.rej
> patching file arch/ia64/kernel/unwind.c
> Hunk #1 FAILED at 140.
> Hunk #2 FAILED at 189.
> Hunk #3 FAILED at 634.
> Hunk #4 FAILED at 814.
> 4 out of 4 hunks FAILED -- saving rejects to file arch/ia64/kernel/unwind.c.rej
> patching file arch/ia64/lib/Makefile
> Hunk #1 FAILED at 6.
> 1 out of 1 hunk FAILED -- saving rejects to file arch/ia64/lib/Makefile.rej
> patching file arch/ia64/lib/copy_user.S
> patching file arch/ia64/lib/io.c
> Hunk #1 succeeded at 87 with fuzz 1.
> Hunk #2 FAILED at 104.
> 1 out of 2 hunks FAILED -- saving rejects to file arch/ia64/lib/io.c.rej
> patching file arch/ia64/lib/memcpy_mck.S
> patching file arch/ia64/lib/swiotlb.c
> Hunk #1 FAILED at 415.
> Hunk #2 FAILED at 447.
> Hunk #3 FAILED at 469.
> 3 out of 3 hunks FAILED -- saving rejects to file arch/ia64/lib/swiotlb.c.rej
> patching file arch/ia64/mm/init.c
> Hunk #1 FAILED at 10.
> Hunk #3 succeeded at 86 with fuzz 2.
> Hunk #4 FAILED at 108.
> Hunk #5 FAILED at 162.
> 3 out of 5 hunks FAILED -- saving rejects to file arch/ia64/mm/init.c.rej
> patching file arch/ia64/mm/tlb.c
> Hunk #1 FAILED at 35.
> Hunk #2 succeeded at 51 with fuzz 2.
> Hunk #3 FAILED at 80.
> 2 out of 3 hunks FAILED -- saving rejects to file arch/ia64/mm/tlb.c.rej
> patching file arch/ia64/sn/io/ifconfig_net.c
> patching file arch/ia64/sn/io/pciba.c
> patching file arch/ia64/sn/io/sn1/hubcounters.c
> patching file arch/ia64/sn/io/sn1/pcibr.c
> patching file arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c
> patching file arch/ia64/sn/kernel/setup.c
> Hunk #2 FAILED at 170.
> 1 out of 2 hunks FAILED -- saving rejects to file arch/ia64/sn/kernel/setup.c.rej
> patching file arch/ia64/tools/Makefile
> patching file arch/ia64/vmlinux.lds.S
> patching file arch/parisc/kernel/traps.c
> patching file drivers/acpi/bus.c
> Hunk #1 succeeded at 2167 with fuzz 2.
> patching file drivers/acpi/osl.c
> Hunk #1 succeeded at 80 with fuzz 2.
> Hunk #2 FAILED at 177.
> Hunk #3 succeeded at 352 with fuzz 2.
> Hunk #4 succeeded at 397 with fuzz 2.
> 1 out of 4 hunks FAILED -- saving rejects to file drivers/acpi/osl.c.rej
> patching file drivers/acpi/pci_irq.c
> Hunk #1 FAILED at 33.
> 1 out of 1 hunk FAILED -- saving rejects to file drivers/acpi/pci_irq.c.rej
> patching file drivers/char/agp/agp.c
> Hunk #1 FAILED at 25.
> Hunk #2 FAILED at 34.
> Hunk #4 FAILED at 151.
> Hunk #6 FAILED at 205.
> Hunk #7 FAILED at 655.
> 5 out of 9 hunks FAILED -- saving rejects to file drivers/char/agp/agp.c.rej
> patching file drivers/char/agp/agp.h
> patching file drivers/char/agp/amd-agp.c
> Hunk #1 FAILED at 330.
> 1 out of 1 hunk FAILED -- saving rejects to file drivers/char/agp/amd-agp.c.rej
> patching file drivers/char/agp/hp-agp.c
> Hunk #1 FAILED at 43.
> Hunk #2 FAILED at 356.
> 2 out of 4 hunks FAILED -- saving rejects to file drivers/char/agp/hp-agp.c.rej
> patching file drivers/char/agp/i460-agp.c
> Hunk #1 succeeded at 4 with fuzz 2.
> Hunk #2 FAILED at 20.
> Hunk #3 FAILED at 126.
> Hunk #4 FAILED at 148.
> Hunk #5 FAILED at 165.
> Hunk #8 FAILED at 200.
> Hunk #9 FAILED at 242.
> 6 out of 9 hunks FAILED -- saving rejects to file drivers/char/agp/i460-agp.c.rej
> patching file drivers/char/agp/i810-agp.c
> Hunk #1 FAILED at 179.
> Hunk #2 FAILED at 247.
> Hunk #3 FAILED at 484.
> Hunk #4 FAILED at 545.
> 4 out of 4 hunks FAILED -- saving rejects to file drivers/char/agp/i810-agp.c.rej
> patching file drivers/char/agp/sworks-agp.c
> Hunk #1 FAILED at 405.
> 1 out of 1 hunk FAILED -- saving rejects to file drivers/char/agp/sworks-agp.c.rej
> patching file drivers/char/drm/ati_pcigart.h
> Hunk #1 FAILED at 30.
> 1 out of 1 hunk FAILED -- saving rejects to file drivers/char/drm/ati_pcigart.h.rej
> patching file drivers/char/drm/drmP.h
> Hunk #1 FAILED at 199.
> Hunk #2 FAILED at 226.
> 2 out of 3 hunks FAILED -- saving rejects to file drivers/char/drm/drmP.h.rej
> patching file drivers/char/drm/drm_bufs.h
> Hunk #1 FAILED at 107.
> Hunk #2 FAILED at 124.
> Hunk #3 FAILED at 245.
> 3 out of 3 hunks FAILED -- saving rejects to file drivers/char/drm/drm_bufs.h.rej
> patching file drivers/char/drm/drm_drv.h
> Hunk #1 FAILED at 423.
> 1 out of 1 hunk FAILED -- saving rejects to file drivers/char/drm/drm_drv.h.rej
> patching file drivers/char/drm/drm_memory.h
> Hunk #1 FAILED at 33.
> Hunk #2 FAILED at 294.
> Hunk #4 FAILED at 411.
> Hunk #6 FAILED at 444.
> 4 out of 6 hunks FAILED -- saving rejects to file drivers/char/drm/drm_memory.h.rej
> patching file drivers/char/drm/drm_vm.h
> Hunk #1 FAILED at 108.
> Hunk #2 FAILED at 207.
> Hunk #3 FAILED at 421.
> Hunk #4 FAILED at 441.
> 4 out of 4 hunks FAILED -- saving rejects to file drivers/char/drm/drm_vm.h.rej
> patching file drivers/char/drm/gamma_dma.c
> Hunk #1 FAILED at 638.
> Hunk #2 FAILED at 668.
> 2 out of 2 hunks FAILED -- saving rejects to file drivers/char/drm/gamma_dma.c.rej
> patching file drivers/char/drm/i810_dma.c
> Hunk #1 FAILED at 309.
> Hunk #2 FAILED at 323.
> Hunk #3 FAILED at 395.
> Hunk #4 FAILED at 448.
> 4 out of 4 hunks FAILED -- saving rejects to file drivers/char/drm/i810_dma.c.rej
> patching file drivers/char/drm/i830_dma.c
> Hunk #1 FAILED at 340.
> Hunk #2 FAILED at 354.
> Hunk #3 FAILED at 426.
> Hunk #4 FAILED at 483.
> 4 out of 4 hunks FAILED -- saving rejects to file drivers/char/drm/i830_dma.c.rej
> patching file drivers/char/drm/mga_dma.c
> Hunk #1 FAILED at 559.
> Hunk #2 FAILED at 649.
> 2 out of 2 hunks FAILED -- saving rejects to file drivers/char/drm/mga_dma.c.rej
> patching file drivers/char/drm/mga_drv.h
> Hunk #1 FAILED at 213.
> Hunk #2 FAILED at 224.
> Hunk #3 FAILED at 247.
> Hunk #4 FAILED at 276.
> Hunk #5 FAILED at 297.
> 5 out of 5 hunks FAILED -- saving rejects to file drivers/char/drm/mga_drv.h.rej
> patching file drivers/char/drm/mga_state.c
> Hunk #1 FAILED at 523.
> Hunk #2 FAILED at 617.
> Hunk #3 FAILED at 826.
> Hunk #4 FAILED at 1029.
> 4 out of 4 hunks FAILED -- saving rejects to file drivers/char/drm/mga_state.c.rej
> patching file drivers/char/drm/r128_cce.c
> Hunk #1 FAILED at 354.
> Hunk #2 FAILED at 552.
> Hunk #3 FAILED at 626.
> 3 out of 3 hunks FAILED -- saving rejects to file drivers/char/drm/r128_cce.c.rej
> patching file drivers/char/drm/r128_drv.h
> Hunk #1 succeeded at 436 with fuzz 1.
> patching file drivers/char/drm/radeon_cp.c
> Hunk #1 FAILED at 627.
> Hunk #2 FAILED at 844.
> Hunk #3 FAILED at 989.
> 3 out of 3 hunks FAILED -- saving rejects to file drivers/char/drm/radeon_cp.c.rej
> patching file drivers/char/drm/radeon_drv.h
> Hunk #1 succeeded at 657 with fuzz 1.
> patching file drivers/char/drm/radeon_state.c
> Hunk #1 FAILED at 327.
> Hunk #2 FAILED at 1507.
> Hunk #3 FAILED at 1759.
> Hunk #4 FAILED at 1870.
> 4 out of 4 hunks FAILED -- saving rejects to file drivers/char/drm/radeon_state.c.rej
> patching file drivers/char/mem.c
> Hunk #1 FAILED at 510.
> 1 out of 1 hunk FAILED -- saving rejects to file drivers/char/mem.c.rej
> patching file drivers/media/radio/Makefile
> patching file drivers/media/radio/dummy.c
> patching file drivers/media/video/Makefile
> patching file drivers/media/video/dummy.c
> patching file drivers/message/fusion/mptscsih.c
> Hunk #1 succeeded at 99 with fuzz 1.
> Hunk #2 FAILED at 1158.
> Hunk #3 succeeded at 1222 with fuzz 2.
> 1 out of 3 hunks FAILED -- saving rejects to file drivers/message/fusion/mptscsih.c.rejpatching file drivers/net/eepro100.c
> Hunk #1 succeeded at 25 with fuzz 2.
> Hunk #5 FAILED at 1240.
> Hunk #6 FAILED at 1634.
> Hunk #7 succeeded at 2320 with fuzz 1.
> 2 out of 7 hunks FAILED -- saving rejects to file drivers/net/eepro100.c.rej
> patching file drivers/net/tulip/media.c
> Hunk #1 FAILED at 278.
> 1 out of 1 hunk FAILED -- saving rejects to file drivers/net/tulip/media.c.rej
> patching file drivers/scsi/megaraid.c
> Hunk #1 FAILED at 2047.
> Hunk #2 FAILED at 3356.
> 2 out of 2 hunks FAILED -- saving rejects to file drivers/scsi/megaraid.c.rej
> patching file drivers/scsi/scsi_ioctl.c
> Hunk #2 FAILED at 212.
> 1 out of 2 hunks FAILED -- saving rejects to file drivers/scsi/scsi_ioctl.c.rej
> patching file drivers/scsi/sym53c8xx_2/sym_glue.c
> Reversed (or previously applied) patch detected!  Assume -R? [n] n
> Apply anyway? [n] n
> Skipping patch.
> 1 out of 1 hunk ignored -- saving rejects to file drivers/scsi/sym53c8xx_2/sym_glue.c.rej
> patching file drivers/scsi/sym53c8xx_2/sym_malloc.c
> Hunk #1 succeeded at 143 with fuzz 2.
> patching file drivers/serial/8250.c
> patching file drivers/serial/Config.in
> patching file drivers/serial/Makefile
> patching file drivers/video/radeonfb.c
> Hunk #2 FAILED at 727.
> Hunk #3 FAILED at 857.
> 2 out of 3 hunks FAILED -- saving rejects to file drivers/video/radeonfb.c.rej
> patching file fs/fcntl.c
> Hunk #1 FAILED at 303.
> 1 out of 1 hunk FAILED -- saving rejects to file fs/fcntl.c.rej
> patching file fs/proc/base.c
> patching file include/asm-i386/hw_irq.h
> patching file include/asm-i386/ptrace.h
> Hunk #1 succeeded at 58 with fuzz 2.
> patching file include/asm-ia64/acpi.h
> patching file include/asm-ia64/agp.h
> patching file include/asm-ia64/bitops.h
> patching file include/asm-ia64/cacheflush.h
> Hunk #1 FAILED at 6.
> Hunk #2 FAILED at 25.
> 2 out of 2 hunks FAILED -- saving rejects to file include/asm-ia64/cacheflush.h.rej
> patching file include/asm-ia64/delay.h
> Hunk #1 FAILED at 53.
> 1 out of 1 hunk FAILED -- saving rejects to file include/asm-ia64/delay.h.rej
> patching file include/asm-ia64/efi.h
> patching file include/asm-ia64/elf.h
> Hunk #1 succeeded at 2 with fuzz 1.
> patching file include/asm-ia64/hardirq.h
> Hunk #1 FAILED at 17.
> 1 out of 1 hunk FAILED -- saving rejects to file include/asm-ia64/hardirq.h.rej
> patching file include/asm-ia64/hw_irq.h
> Hunk #1 FAILED at 2.
> 1 out of 2 hunks FAILED -- saving rejects to file include/asm-ia64/hw_irq.h.rej
> patching file include/asm-ia64/keyboard.h
> patching file include/asm-ia64/kregs.h
> Hunk #1 succeeded at 64 with fuzz 2.
> Hunk #2 FAILED at 94.
> Hunk #3 FAILED at 105.
> 2 out of 3 hunks FAILED -- saving rejects to file include/asm-ia64/kregs.h.rej
> patching file include/asm-ia64/machvec.h
> patching file include/asm-ia64/machvec_init.h
> Hunk #1 succeeded at 16 with fuzz 1.
> patching file include/asm-ia64/mmu_context.h
> Hunk #1 FAILED at 2.
> Hunk #2 FAILED at 13.
> Hunk #3 FAILED at 21.
> Hunk #6 FAILED at 72.
> 4 out of 7 hunks FAILED -- saving rejects to file include/asm-ia64/mmu_context.h.rej
> patching file include/asm-ia64/module.h
> Hunk #1 FAILED at 75.
> 1 out of 1 hunk FAILED -- saving rejects to file include/asm-ia64/module.h.rej
> patching file include/asm-ia64/offsets.h
> patching file include/asm-ia64/page.h
> Hunk #1 FAILED at 87.
> 1 out of 1 hunk FAILED -- saving rejects to file include/asm-ia64/page.h.rej
> patching file include/asm-ia64/param.h
> Hunk #1 FAILED at 4.
> 1 out of 2 hunks FAILED -- saving rejects to file include/asm-ia64/param.h.rej
> patching file include/asm-ia64/pci.h
> Hunk #2 FAILED at 90.
> 1 out of 2 hunks FAILED -- saving rejects to file include/asm-ia64/pci.h.rej
> patching file include/asm-ia64/perfmon.h
> patching file include/asm-ia64/pgalloc.h
> Hunk #1 FAILED at 15.
> 1 out of 1 hunk FAILED -- saving rejects to file include/asm-ia64/pgalloc.h.rej
> patching file include/asm-ia64/processor.h
> Hunk #1 FAILED at 270.
> Hunk #2 FAILED at 280.
> 2 out of 2 hunks FAILED -- saving rejects to file include/asm-ia64/processor.h.rej
> patching file include/asm-ia64/rmap.h
> Hunk #1 FAILED at 1.
> 1 out of 1 hunk FAILED -- saving rejects to file include/asm-ia64/rmap.h.rej
> patching file include/asm-ia64/scatterlist.h
> patching file include/asm-ia64/serial.h
> patching file include/asm-ia64/smp.h
> Hunk #1 FAILED at 17.
> Hunk #3 FAILED at 47.
> 2 out of 4 hunks FAILED -- saving rejects to file include/asm-ia64/smp.h.rej
> patching file include/asm-ia64/smplock.h
> Hunk #1 FAILED at 14.
> Hunk #2 FAILED at 21.
> 2 out of 2 hunks FAILED -- saving rejects to file include/asm-ia64/smplock.h.rej
> patching file include/asm-ia64/softirq.h
> Hunk #1 FAILED at 4.
> 1 out of 1 hunk FAILED -- saving rejects to file include/asm-ia64/softirq.h.rej
> patching file include/asm-ia64/system.h
> Hunk #1 FAILED at 13.
> Hunk #2 succeeded at 104 with fuzz 2.
> Hunk #3 FAILED at 172.
> Hunk #5 FAILED at 368.
> Hunk #6 FAILED at 396.
> 4 out of 6 hunks FAILED -- saving rejects to file include/asm-ia64/system.h.rej
> patching file include/asm-ia64/tlb.h
> Hunk #1 FAILED at 1.
> 1 out of 1 hunk FAILED -- saving rejects to file include/asm-ia64/tlb.h.rej
> patching file include/asm-ia64/tlbflush.h
> Hunk #1 FAILED at 60.
> Hunk #2 FAILED at 72.
> 2 out of 2 hunks FAILED -- saving rejects to file include/asm-ia64/tlbflush.h.rej
> patching file include/asm-ia64/unistd.h
> Hunk #1 succeeded at 223 with fuzz 2.
> patching file include/linux/acpi_serial.h
> patching file include/linux/agp_backend.h
> patching file include/linux/fs.h
> Hunk #1 FAILED at 513.
> 1 out of 1 hunk FAILED -- saving rejects to file include/linux/fs.h.rej
> patching file include/linux/highmem.h
> Hunk #1 FAILED at 3.
> 1 out of 1 hunk FAILED -- saving rejects to file include/linux/highmem.h.rej
> patching file include/linux/irq.h
> Hunk #1 succeeded at 56 with fuzz 2.
> patching file include/linux/irq_cpustat.h
> patching file include/linux/kernel.h
> Hunk #1 succeeded at 37 with fuzz 2.
> patching file include/linux/mm.h
> patching file include/linux/mmzone.h
> patching file include/linux/page-flags.h
> Hunk #1 succeeded at 42 with fuzz 1.
> Hunk #2 FAILED at 230.
> 1 out of 2 hunks FAILED -- saving rejects to file include/linux/page-flags.h.rej
> patching file include/linux/percpu.h
> Hunk #1 FAILED at 2.
> 1 out of 1 hunk FAILED -- saving rejects to file include/linux/percpu.h.rej
> patching file include/linux/sched.h
> patching file include/linux/serial.h
> patching file include/linux/smp.h
> Hunk #1 FAILED at 57.
> 1 out of 2 hunks FAILED -- saving rejects to file include/linux/smp.h.rej
> patching file include/linux/vmalloc.h
> Hunk #1 succeeded at 8 with fuzz 1.
> patching file kernel/exec_domain.c
> Hunk #1 FAILED at 196.
> 1 out of 1 hunk FAILED -- saving rejects to file kernel/exec_domain.c.rej
> patching file kernel/fork.c
> Hunk #2 succeeded at 132 with fuzz 1.
> patching file kernel/ksyms.c
> patching file kernel/printk.c
> Hunk #1 FAILED at 16.
> Hunk #4 succeeded at 699 with fuzz 1.
> 1 out of 4 hunks FAILED -- saving rejects to file kernel/printk.c.rej
> patching file kernel/softirq.c
> Hunk #4 FAILED at 96.
> Hunk #7 FAILED at 416.
> 2 out of 7 hunks FAILED -- saving rejects to file kernel/softirq.c.rej
> patching file kernel/timer.c
> Hunk #1 FAILED at 886.
> Hunk #2 succeeded at 899 with fuzz 2.
> 1 out of 2 hunks FAILED -- saving rejects to file kernel/timer.c.rej
> patching file mm/bootmem.c
> Hunk #2 FAILED at 169.
> Hunk #3 FAILED at 183.
> Hunk #4 FAILED at 203.
> Hunk #5 FAILED at 263.
> 4 out of 5 hunks FAILED -- saving rejects to file mm/bootmem.c.rej
> patching file mm/memory.c
> Hunk #1 FAILED at 110.
> 1 out of 1 hunk FAILED -- saving rejects to file mm/memory.c.rej
> patching file mm/page_alloc.c
> Hunk #1 FAILED at 47.
> Hunk #2 FAILED at 497.
> Hunk #3 FAILED at 637.
> Hunk #4 FAILED at 684.
> Hunk #5 FAILED at 692.
> Hunk #6 FAILED at 807.
> 6 out of 6 hunks FAILED -- saving rejects to file mm/page_alloc.c.rej
> patching file mm/vmalloc.c
> Hunk #1 succeeded at 367 with fuzz 1.
> patching file sound/oss/cs4281/cs4281m.c
> Hunk #1 FAILED at 1942.
> Hunk #2 FAILED at 1978.
> Hunk #3 FAILED at 2011.
> Hunk #4 FAILED at 2045.
> Hunk #5 FAILED at 2177.
> Hunk #6 FAILED at 2742.
> Hunk #7 FAILED at 2823.
> Hunk #8 FAILED at 2870.
> Hunk #9 FAILED at 2893.
> Hunk #10 FAILED at 2950.
> Hunk #11 FAILED at 2969.
> Hunk #12 FAILED at 2985.
> Hunk #13 FAILED at 3041.
> Hunk #14 FAILED at 3162.
> Hunk #15 FAILED at 3198.
> Hunk #16 FAILED at 3206.
> Hunk #17 FAILED at 3592.
> Hunk #18 FAILED at 3627.
> Hunk #19 FAILED at 4337.
> Hunk #20 FAILED at 4385.
> Hunk #21 FAILED at 4441.
> 21 out of 21 hunks FAILED -- saving rejects to file sound/oss/cs4281/cs4281m.c.rej
> patching file sound/oss/cs4281/cs4281pm-24.c
> Hunk #1 FAILED at 38.
> 1 out of 2 hunks FAILED -- saving rejects to file sound/oss/cs4281/cs4281pm-24.c.rej


