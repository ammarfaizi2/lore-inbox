Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317874AbSHZEbx>; Mon, 26 Aug 2002 00:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317887AbSHZEbx>; Mon, 26 Aug 2002 00:31:53 -0400
Received: from signup.localnet.com ([207.251.201.46]:44216 "HELO
	smtp.localnet.com") by vger.kernel.org with SMTP id <S317874AbSHZEbw>;
	Mon, 26 Aug 2002 00:31:52 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-pre4-ac1 patch error and compile error
From: "James H. Cloos Jr." <cloos@jhcloos.com>
Date: 26 Aug 2002 00:36:05 -0400
Message-ID: <m3ptw6jky2.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The last few ac patches have, when patched to a clone of
bk://linux.bkbits.net/linux-2.4 limited to the appropriate cset, had
rejects from drivers/scsi/sim710_d.h.  patch(1) indicates a previously
applied patch.

arch/i386/kernel/time.c failed to compile.  Based on the error, the
required patch is:


--- linux-2.4.20-pre4-ac1/arch/i386/kernel/Makefile     Sun Aug 25 19:17:57 2002
+++ linux-2.4.20-pre4-ac1+/arch/i386/kernel/Makefile     Mon Aug 26 00:34:43 2002
@@ -14,10 +14,10 @@
 
 O_TARGET := kernel.o
 
-export-objs     := mca.o mtrr.o msr.o cpuid.o microcode.o i386_ksyms.o
+export-objs     := mca.o mtrr.o msr.o cpuid.o microcode.o i386_ksyms.o time.o
 
 obj-y  := process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
-               ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
+               ptrace.o i8259.o ioport.o ldt.o setup.o sys_i386.o \
                pci-dma.o i386_ksyms.o i387.o bluesmoke.o dmi_scan.o
 
 


-JimC

