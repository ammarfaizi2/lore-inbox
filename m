Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266699AbUFYKlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266699AbUFYKlI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 06:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266702AbUFYKlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 06:41:07 -0400
Received: from mailbox.univie.ac.at ([131.130.1.18]:38040 "EHLO
	login.univie.ac.at") by vger.kernel.org with ESMTP id S266699AbUFYKlC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 06:41:02 -0400
Date: Fri, 25 Jun 2004 12:40:50 +0200 (MSZ)
From: "Klaus A. Kreil" <klaus.kreil@univie.ac.at>
To: linux-kernel@vger.kernel.org
Subject: kernel compile error on SuSE 9.1
Message-ID: <Pine.A41.4.56.0406251237060.33444@login.univie.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DCC-ZID-Univie-Metrics: imap 4247; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I hope that's the right address to send this error information to:

I am currently trying to compile an new kernel on SuSE 9.1. I have used
make menuconfig to set kernel options and started the compile process with
make.

It is for kernel 2.6.5-7.75-smp - i.e. for a kernel for a dual XEON system
and it includes the latest updates from SuSE.

The compile process throws up a few warning messages (like type mismatches
etc. - nothing to worrysome from my point of view) and all the object
modules appear to be there. Only at the end it comes up with error
messages as follows indicating that the linker has a problem. This clearly
means, no kernel image is created:

======
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
CHK include/linux/compile.h
UPD include/linux/compile.h
CC init/version.o
LD init/built-in.o
GEN .version
CHK include/linux/compile.h
UPD include/linux/compile.h
CC init/version.o
LD init/built-in.o
LD .tmp_vmlinux1
drivers/built-in.o(.text+0x30a46): In function `cleanup_module':
: multiple definition of `cleanup_module'
kernel/built-in.o(.text+0x1a046): first defined here
ld: Warning: size of symbol `cleanup_module' changed from 1 in
kernel/built-in.o to 51 in drivers/built-in.o
drivers/built-in.o(.text+0x30bf7): In function `init_module':
: multiple definition of `init_module'
kernel/built-in.o(.text+0x19d40): first defined here
ld: Warning: size of symbol `init_module' changed from 3 in
kernel/built-in.o to 220 in drivers/built-in.o
make: *** [.tmp_vmlinux1] Error 1
======

This is actually the output of an additional make bzImage after the full
kernel compile with make. The relevant part of the original output with
make was the same, but only longer because everything had to be compiled.

Any help greatly appreciated. If you need any further information please
do not hesitate to contact me again.

If this is the wrong way of submitting this information, please do me a
favour and point me towards the right channel to route this through.

Many thanks and best regards,

Klaus
