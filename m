Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbWDVVO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWDVVO1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 17:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWDVVO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 17:14:27 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:37600 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751139AbWDVVO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 17:14:27 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] 'make headers_install' kbuild target.
Date: Sat, 22 Apr 2006 23:13:42 +0200
User-Agent: KMail/1.9.1
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       sam@ravnborg.org, mschwid2@de.ibm.com
References: <1145672241.16166.156.camel@shinybook.infradead.org> <20060422132032.GB5010@stusta.de> <1145719812.11909.333.camel@pmac.infradead.org>
In-Reply-To: <1145719812.11909.333.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604222313.42976.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 22 April 2006 17:30, David Woodhouse wrote:
> 1. Identify those files which contain stuff which should be
> user-visible. I've done a first pass of this for arch-independent files
> and asm-powerpc already. We need it done for other architectures.

FWIW, I've just gone through the s390 specific header files in 2.6.17-rc2
to see who is supposed to see them, resulting in

** strictly kernel only:
bug.h                extmem.h       pgtable.h         string.h
bugs.h               futex.h        processor.h       suspend.h
cacheflush.h         hardirq.h      qdio.h            system.h
ccwdev.h             idals.h        qeth.h            thread_info.h
ccwgroup.h           io.h           rwsem.h           timer.h
checksum.h           irq.h          s390_ext.h        tlb.h
cio.h                kmap_types.h   s390_rdev.h       tlbflush.h
compat.h             local.h        scatterlist.h     todclk.h
cpcmd.h              lowcore.h      sections.h        topology.h
cputime.h            mathemu.h      segment.h         uaccess.h
current.h            mmu.h          semaphore.h       unaligned.h
delay.h              mmu_context.h  setup.h           user.h
div64.h              mutex.h        sfp-machine.h     vtoc.h
dma-mapping.h        namei.h        sigp.h            xor.h
dma.h                pci.h          smp.h
ebcdic.h             percpu.h       spinlock.h
emergency-restart.h  pgalloc.h      spinlock_types.h

** have stuff of interest to user space:
cmb.h    ioctls.h  param.h        shmbuf.h      sockios.h   timex.h
dasd.h   ipc.h     poll.h         shmparam.h    stat.h      types.h
debug.h  ipcbuf.h  posix_types.h  sigcontext.h  statfs.h    ucontext.h
errno.h  mman.h    ptrace.h       siginfo.h     tape390.h   unistd.h
fcntl.h  msgbuf.h  resource.h     signal.h      termbits.h
ioctl.h  page.h    sembuf.h       socket.h      termios.h

** non-trivial to decide, need to coordinate with other archs:
a.out.h   auxvec.h  byteorder.h  elf.h    linkage.h
atomic.h  bitops.h  cache.h      kexec.h  module.h

Hope that helps,

	Arnd <><
