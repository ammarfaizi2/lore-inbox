Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbVGBRkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbVGBRkM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 13:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVGBRkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 13:40:12 -0400
Received: from [85.8.12.41] ([85.8.12.41]:3772 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S261235AbVGBRhC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 13:37:02 -0400
Message-ID: <42C6CF40.4040308@drzeus.cx>
Date: Sat, 02 Jul 2005 19:30:40 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.2-7 (X11/20050623)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hermes.drzeus.cx-7619-1120325821-0001-2"
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ISA DMA suspend for x86_64
References: <42987450.9000601@drzeus.cx.suse.lists.linux.kernel>	<1117288285.2685.10.camel@localhost.localdomain.suse.lists.linux.kernel>	<42A2B610.1020408@drzeus.cx.suse.lists.linux.kernel>	<42A3061C.7010604@drzeus.cx.suse.lists.linux.kernel>	<42B1A08B.8080601@drzeus.cx.suse.lists.linux.kernel>	<20050616170622.A1712@flint.arm.linux.org.uk.suse.lists.linux.kernel>	<42C3A698.9020404@drzeus.cx.suse.lists.linux.kernel>	<1120130926.6482.83.camel@localhost.localdomain.suse.lists.linux.kernel>	<42C3E3A4.3090305@drzeus.cx.suse.lists.linux.kernel>	<42C432BB.407@drzeus.cx.suse.lists.linux.kernel> <p73u0jeg5lg.fsf@verdi.suse.de>
In-Reply-To: <p73u0jeg5lg.fsf@verdi.suse.de>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hermes.drzeus.cx-7619-1120325821-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Andi Kleen wrote:

>
>This is identical to the i386 version isn't it? 
>Please just reuse the i386 version then in the Makefile.
>  
>

Ok. Done and attached.

>And the whole thing should be probably dependent on CONFIG_SOFTWARE_SUSPEND
>
>  
>

I used i8259.c as an example and it includes its suspend routines in all
cases. Also, the problem this patch solves is for suspend-to-ram, not
suspend-to-disk (i.e. software suspend).

Rgds
Pierre


--=_hermes.drzeus.cx-7619-1120325821-0001-2
Content-Type: text/x-patch; name="i8237-x86_64.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i8237-x86_64.patch"

Index: linux-wbsd/arch/x86_64/kernel/Makefile
===================================================================
--- linux-wbsd/arch/x86_64/kernel/Makefile	(revision 153)
+++ linux-wbsd/arch/x86_64/kernel/Makefile	(working copy)
@@ -7,7 +7,8 @@
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o \
 		ptrace.o time.o ioport.o ldt.o setup.o i8259.o sys_x86_64.o \
 		x8664_ksyms.o i387.o syscall.o vsyscall.o \
-		setup64.o bootflag.o e820.o reboot.o quirks.o
+		setup64.o bootflag.o e820.o reboot.o quirks.o \
+		../../i386/kernel/i8237.o

 obj-$(CONFIG_X86_MCE)         += mce.o
 obj-$(CONFIG_X86_MCE_INTEL)	+= mce_intel.o

--=_hermes.drzeus.cx-7619-1120325821-0001-2--
