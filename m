Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277653AbRJIANq>; Mon, 8 Oct 2001 20:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277654AbRJIANh>; Mon, 8 Oct 2001 20:13:37 -0400
Received: from knight.ca.mdis.co.jp ([202.253.208.54]:46996 "EHLO
	knight.ca.mdis.co.jp") by vger.kernel.org with ESMTP
	id <S277653AbRJIANV>; Mon, 8 Oct 2001 20:13:21 -0400
Message-Id: <200110090013.AA00291@MJ136.kamakura.mdis.co.jp>
From: Seiichi Nakashima <nakasei@kamakura.mdis.co.jp>
Date: Tue, 09 Oct 2001 09:13:38 +0900
To: David Weinehall <tao@acc.umu.se>
Cc: linux-kernel@vger.kernel.org, nakasei@fa.mdis.co.jp
Subject: linux-2.0.40-pre2 patch error
In-Reply-To: <20010923145654.F26627@khan.acc.umu.se>
In-Reply-To: <20010923145654.F26627@khan.acc.umu.se>
MIME-Version: 1.0
X-Mailer: AL-Mail32 Version 1.12
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear. David Weinehall

I am Seiichi Nakashima.

>
>Thanks a lot. I've fixed those two warnings and the error in my tree;
>expect a pre2 shortly.
>


Today, I download pre-patch-2.0.40-2 from www.kernel.org in tao's directory,
and update linux-2.0.39 to use pre-patch-2.0.40-2.

but patch error occured sched.c step.
I send you patch log file and sched.c.rej file.

< patch log >

patching file `linux-2.0.40/CREDITS'
patching file `linux-2.0.40/Documentation/Configure.help'
patching file `linux-2.0.40/Documentation/cdrom/sbpcd'
patching file `linux-2.0.40/Documentation/magic-number.txt'
patching file `linux-2.0.40/MAINTAINERS'
patching file `linux-2.0.40/Makefile'
patching file `linux-2.0.40/arch/alpha/config.in'
patching file `linux-2.0.40/arch/i386/config.in'
patching file `linux-2.0.40/arch/i386/kernel/head.S'
patching file `linux-2.0.40/arch/i386/kernel/process.c'
patching file `linux-2.0.40/arch/i386/kernel/ptrace.c'
patching file `linux-2.0.40/arch/i386/kernel/setup.c'
patching file `linux-2.0.40/arch/i386/kernel/signal.c'
patching file `linux-2.0.40/arch/i386/kernel/traps.c'
patching file `linux-2.0.40/arch/i386/math-emu/Makefile'
patching file `linux-2.0.40/arch/i386/math-emu/README'
patching file `linux-2.0.40/arch/i386/math-emu/control_w.h'
patching file `linux-2.0.40/arch/i386/math-emu/div_Xsig.S'
patching file `linux-2.0.40/arch/i386/math-emu/div_small.S'
patching file `linux-2.0.40/arch/i386/math-emu/errors.c'
patching file `linux-2.0.40/arch/i386/math-emu/exception.h'
patching file `linux-2.0.40/arch/i386/math-emu/fpu_arith.c'
patching file `linux-2.0.40/arch/i386/math-emu/fpu_asm.h'
patching file `linux-2.0.40/arch/i386/math-emu/fpu_aux.c'
patching file `linux-2.0.40/arch/i386/math-emu/fpu_debug.c'
patching file `linux-2.0.40/arch/i386/math-emu/fpu_emu.h'
patching file `linux-2.0.40/arch/i386/math-emu/fpu_entry.c'
patching file `linux-2.0.40/arch/i386/math-emu/fpu_etc.c'
patching file `linux-2.0.40/arch/i386/math-emu/fpu_proto.h'
patching file `linux-2.0.40/arch/i386/math-emu/fpu_system.h'
patching file `linux-2.0.40/arch/i386/math-emu/fpu_tags.c'
patching file `linux-2.0.40/arch/i386/math-emu/fpu_trig.c'
patching file `linux-2.0.40/arch/i386/math-emu/get_address.c'
patching file `linux-2.0.40/arch/i386/math-emu/load_store.c'
patching file `linux-2.0.40/arch/i386/math-emu/poly.h'
patching file `linux-2.0.40/arch/i386/math-emu/poly_2xm1.c'
patching file `linux-2.0.40/arch/i386/math-emu/poly_atan.c'
patching file `linux-2.0.40/arch/i386/math-emu/poly_l2.c'
patching file `linux-2.0.40/arch/i386/math-emu/poly_sin.c'
patching file `linux-2.0.40/arch/i386/math-emu/poly_tan.c'
patching file `linux-2.0.40/arch/i386/math-emu/reg_add_sub.c'
patching file `linux-2.0.40/arch/i386/math-emu/reg_compare.c'
patching file `linux-2.0.40/arch/i386/math-emu/reg_constant.c'
patching file `linux-2.0.40/arch/i386/math-emu/reg_constant.h'
patching file `linux-2.0.40/arch/i386/math-emu/reg_convert.c'
patching file `linux-2.0.40/arch/i386/math-emu/reg_div.S'
patching file `linux-2.0.40/arch/i386/math-emu/reg_divide.c'
patching file `linux-2.0.40/arch/i386/math-emu/reg_ld_str.c'
patching file `linux-2.0.40/arch/i386/math-emu/reg_mul.c'
patching file `linux-2.0.40/arch/i386/math-emu/reg_norm.S'
patching file `linux-2.0.40/arch/i386/math-emu/reg_round.S'
patching file `linux-2.0.40/arch/i386/math-emu/reg_u_add.S'
patching file `linux-2.0.40/arch/i386/math-emu/reg_u_div.S'
patching file `linux-2.0.40/arch/i386/math-emu/reg_u_mul.S'
patching file `linux-2.0.40/arch/i386/math-emu/reg_u_sub.S'
patching file `linux-2.0.40/arch/i386/math-emu/status_w.h'
patching file `linux-2.0.40/arch/i386/math-emu/version.h'
patching file `linux-2.0.40/arch/i386/math-emu/wm_shrx.S'
patching file `linux-2.0.40/arch/i386/math-emu/wm_sqrt.S'
patching file `linux-2.0.40/arch/i386/mm/fault.c'
patching file `linux-2.0.40/arch/i386/mm/init.c'
patching file `linux-2.0.40/arch/m68k/config.in'
patching file `linux-2.0.40/arch/mips/config.in'
patching file `linux-2.0.40/arch/mips/kernel/sysmips.c'
patching file `linux-2.0.40/arch/ppc/config.in'
patching file `linux-2.0.40/arch/sparc/config.in'
patching file `linux-2.0.40/arch/sparc/kernel/sparc-stub.c'
patching file `linux-2.0.40/drivers/block/ll_rw_blk.c'
patching file `linux-2.0.40/drivers/block/promise.h'
patching file `linux-2.0.40/drivers/cdrom/aztcd.c'
patching file `linux-2.0.40/drivers/cdrom/cdi.c'
patching file `linux-2.0.40/drivers/cdrom/cdu31a.c'
patching file `linux-2.0.40/drivers/cdrom/mcd.c'
patching file `linux-2.0.40/drivers/cdrom/mcdx.c'
patching file `linux-2.0.40/drivers/cdrom/optcd.c'
patching file `linux-2.0.40/drivers/cdrom/sbpcd.c'
patching file `linux-2.0.40/drivers/char/lp_m68k.c'
patching file `linux-2.0.40/drivers/char/misc.c'
patching file `linux-2.0.40/drivers/char/vga.c'
patching file `linux-2.0.40/drivers/isdn/hisax/elsa_ser.c'
patching file `linux-2.0.40/drivers/isdn/icn/icn.c'
patching file `linux-2.0.40/drivers/isdn/isdn_common.c'
patching file `linux-2.0.40/drivers/isdn/isdn_net.c'
patching file `linux-2.0.40/drivers/isdn/isdnloop/isdnloop.c'
patching file `linux-2.0.40/drivers/net/atp.c'
patching file `linux-2.0.40/drivers/net/auto_irq.c'
patching file `linux-2.0.40/drivers/net/tulip.c'
patching file `linux-2.0.40/drivers/sbus/char/sunserial.c'
patching file `linux-2.0.40/drivers/scsi/NCR5380.h'
patching file `linux-2.0.40/drivers/scsi/NCR53c406a.c'
patching file `linux-2.0.40/drivers/scsi/aha152x.c'
patching file `linux-2.0.40/drivers/scsi/aha1542.c'
patching file `linux-2.0.40/drivers/scsi/aic7xxx.c'
patching file `linux-2.0.40/drivers/scsi/pci2000.c'
patching file `linux-2.0.40/drivers/scsi/ultrastor.c'
patching file `linux-2.0.40/drivers/sound/gus_wave.c'
patching file `linux-2.0.40/fs/buffer.c'
patching file `linux-2.0.40/fs/exec.c'
patching file `linux-2.0.40/fs/ext2/dir.c'
patching file `linux-2.0.40/fs/ext2/super.c'
patching file `linux-2.0.40/fs/ext2/truncate.c'
patching file `linux-2.0.40/fs/isofs/inode.c'
patching file `linux-2.0.40/fs/pipe.c'
patching file `linux-2.0.40/fs/proc/array.c'
patching file `linux-2.0.40/include/asm-i386/bugs.h'
patching file `linux-2.0.40/include/asm-i386/math_emu.h'
patching file `linux-2.0.40/include/asm-i386/processor.h'
patching file `linux-2.0.40/include/asm-m68k/zorro.h'
patching file `linux-2.0.40/include/asm-sparc/bitops.h'
patching file `linux-2.0.40/include/asm-sparc/head.h'
patching file `linux-2.0.40/include/linux/binfmts.h'
patching file `linux-2.0.40/include/linux/blk.h'
patching file `linux-2.0.40/include/linux/cdrom.h'
patching file `linux-2.0.40/include/linux/cm206.h'
patching file `linux-2.0.40/include/linux/if_frad.h'
patching file `linux-2.0.40/include/linux/kernel.h'
patching file `linux-2.0.40/include/linux/md.h'
patching file `linux-2.0.40/include/linux/optcd.h'
patching file `linux-2.0.40/include/linux/sbpcd.h'
patching file `linux-2.0.40/include/linux/skbuff.h'
patching file `linux-2.0.40/init/main.c'
patching file `linux-2.0.40/kernel/printk.c'
patching file `linux-2.0.40/kernel/sched.c'
Hunk #3 FAILED at 241.
1 out of 18 hunks FAILED -- saving rejects to linux-2.0.40/kernel/sched.c.rej
patching file `linux-2.0.40/lib/vsprintf.c'
patching file `linux-2.0.40/mm/kmalloc.c'
patching file `linux-2.0.40/net/core/skbuff.c'
patching file `linux-2.0.40/net/ipv4/tcp.c'
patching file `linux-2.0.40/net/ipv4/tcp_input.c'
patching file `linux-2.0.40/scripts/checkconfig.pl'
patching file `linux-2.0.40/scripts/checkhelp.pl'
patching file `linux-2.0.40/scripts/checkincludes.pl'
patching file `linux-2.0.40/scripts/mkdep.c'


< shced.c.rej >

***************
*** 241,255 ****
  {
  	int weight;
  
- #ifdef __SMP__	
  	/* We are not permitted to run a task someone else is running */
  	if (p->processor != NO_PROC_ID)
  		return -1000;
- #ifdef PAST_2_0		
  	/* This process is locked to a processor group */
- 	if (p->processor_mask && !(p->processor_mask & (1<<this_cpu)))
  		return -1000;
- #endif		
  #endif
  
  	/*
--- 241,255 ----
  {
  	int weight;
  
+ #ifdef __SMP__
  	/* We are not permitted to run a task someone else is running */
  	if (p->processor != NO_PROC_ID)
  		return -1000;
+ #ifdef PAST_2_0
  	/* This process is locked to a processor group */
+ 	if (p->processor_mask && !(p->processor_mask & (1<<this_cpu))
  		return -1000;
+ #endif
  #endif
  
  	/*

------------------------------------
 Name:  Seiichi Nakashima
 Email: nakasei@kamakura.mdis.co.jp
------------------------------------
