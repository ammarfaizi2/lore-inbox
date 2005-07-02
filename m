Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261310AbVGBWO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbVGBWO6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 18:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVGBWO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 18:14:57 -0400
Received: from [85.8.12.41] ([85.8.12.41]:7356 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S261310AbVGBWIn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 18:08:43 -0400
Message-ID: <42C70F81.4010500@drzeus.cx>
Date: Sun, 03 Jul 2005 00:04:49 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.2-7 (X11/20050623)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hermes.drzeus.cx-8504-1120342118-0001-2"
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ISA DMA suspend for x86_64
References: <42B1A08B.8080601@drzeus.cx.suse.lists.linux.kernel> <20050616170622.A1712@flint.arm.linux.org.uk.suse.lists.linux.kernel> <42C3A698.9020404@drzeus.cx.suse.lists.linux.kernel> <1120130926.6482.83.camel@localhost.localdomain.suse.lists.linux.kernel> <42C3E3A4.3090305@drzeus.cx.suse.lists.linux.kernel> <42C432BB.407@drzeus.cx.suse.lists.linux.kernel> <p73u0jeg5lg.fsf@verdi.suse.de> <42C6CF40.4040308@drzeus.cx> <20050702174055.GI21330@wotan.suse.de> <42C6D3D5.6070909@drzeus.cx> <20050702182749.GJ21330@wotan.suse.de>
In-Reply-To: <20050702182749.GJ21330@wotan.suse.de>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hermes.drzeus.cx-8504-1120342118-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Andi Kleen wrote:

>>Like this?
>>    
>>
>
>You still need to add it to the obj-ys
>
>  
>

Ah, sorry. Not quite familiar with how the kernel's build system works.
Is it more correct this time? =)

Rgds
Pierre


--=_hermes.drzeus.cx-8504-1120342118-0001-2
Content-Type: text/x-patch; name="i8237-x86_64.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i8237-x86_64.patch"

Index: linux-wbsd/arch/x86_64/kernel/Makefile
===================================================================
--- linux-wbsd/arch/x86_64/kernel/Makefile	(revision 153)
+++ linux-wbsd/arch/x86_64/kernel/Makefile	(working copy)
@@ -7,7 +7,7 @@
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o \
 		ptrace.o time.o ioport.o ldt.o setup.o i8259.o sys_x86_64.o \
 		x8664_ksyms.o i387.o syscall.o vsyscall.o \
-		setup64.o bootflag.o e820.o reboot.o quirks.o
+		setup64.o bootflag.o e820.o reboot.o quirks.o i8237.o

 obj-$(CONFIG_X86_MCE)         += mce.o
 obj-$(CONFIG_X86_MCE_INTEL)	+= mce_intel.o
@@ -44,3 +45,4 @@
 microcode-$(subst m,y,$(CONFIG_MICROCODE))  += ../../i386/kernel/microcode.o
 intel_cacheinfo-y		+= ../../i386/kernel/cpu/intel_cacheinfo.o
 quirks-y			+= ../../i386/kernel/quirks.o
+i8237-y				+= ../../i386/kernel/i8237.o

--=_hermes.drzeus.cx-8504-1120342118-0001-2--
