Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317598AbSG2SiG>; Mon, 29 Jul 2002 14:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317599AbSG2SiG>; Mon, 29 Jul 2002 14:38:06 -0400
Received: from [64.246.18.23] ([64.246.18.23]:15030 "EHLO ensim.2hosting.net")
	by vger.kernel.org with ESMTP id <S317598AbSG2SiE>;
	Mon, 29 Jul 2002 14:38:04 -0400
From: "Stephen Lee" <steve@tuxsoft.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: RE: Linux 2.4.19-rc3-ac4
Date: Mon, 29 Jul 2002 13:41:07 -0500
Message-ID: <008401c2372f$8c02cea0$0100a8c0@mars>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
In-Reply-To: <200207291740.g6THewQ19578@devserv.devel.redhat.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling with this patch I get the following:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.19-rc3-ac4/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-f
rame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon
-DKBUILD_BASENAME=main -c -o init/main.o init/main.c
In file included from
/usr/src/linux-2.4.19-rc3-ac4/include/linux/smp.h:14,
                 from
/usr/src/linux-2.4.19-rc3-ac4/include/linux/sched.h:23,
                 from
/usr/src/linux-2.4.19-rc3-ac4/include/linux/mm.h:4,
                 from
/usr/src/linux-2.4.19-rc3-ac4/include/linux/slab.h:14,
                 from
/usr/src/linux-2.4.19-rc3-ac4/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/usr/src/linux-2.4.19-rc3-ac4/include/asm/smp.h: In function
`find_idle_package':
/usr/src/linux-2.4.19-rc3-ac4/include/asm/smp.h:153: `smp_num_cpus'
undeclared (first use in this function)
/usr/src/linux-2.4.19-rc3-ac4/include/asm/smp.h:153: (Each undeclared
identifier is reported only once
/usr/src/linux-2.4.19-rc3-ac4/include/asm/smp.h:153: for each function
it appears in.)
/usr/src/linux-2.4.19-rc3-ac4/include/asm/smp.h:163: warning: implicit
declaration of function `idle_cpu'
/usr/src/linux-2.4.19-rc3-ac4/include/asm/smp.h: In function
`arch_load_balance':
/usr/src/linux-2.4.19-rc3-ac4/include/asm/smp.h:177: warning: implicit
declaration of function `cpu_rq'
/usr/src/linux-2.4.19-rc3-ac4/include/asm/smp.h:177: warning: assignment
makes pointer from integer without a cast
/usr/src/linux-2.4.19-rc3-ac4/include/asm/smp.h:178: warning: implicit
declaration of function `resched_task'
/usr/src/linux-2.4.19-rc3-ac4/include/asm/smp.h:178: dereferencing
pointer to incomplete type
In file included from
/usr/src/linux-2.4.19-rc3-ac4/include/linux/sched.h:23,
                 from
/usr/src/linux-2.4.19-rc3-ac4/include/linux/mm.h:4,
                 from
/usr/src/linux-2.4.19-rc3-ac4/include/linux/slab.h:14,
                 from
/usr/src/linux-2.4.19-rc3-ac4/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/usr/src/linux-2.4.19-rc3-ac4/include/linux/smp.h: At top level:
/usr/src/linux-2.4.19-rc3-ac4/include/linux/smp.h:58: `smp_num_cpus'
used prior to declaration
make: *** [init/main.o] Error 1

rc3-ac3 compiled fine, I used my previous .config from rc3-ac3 using
make oldconfig.  This method usually works fine.

Steve


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Alan Cox
Sent: Monday, July 29, 2002 12:41 PM
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.19-rc3-ac4

[+ indicates stuff that went to Marcelo, o stuff that has not,
 * indicates stuff that is merged in mainstream now, X stuff that proved
   bad and was dropped out]

This patch contains SiS IDE updates. Usual caveats apply. The HP merge
is
now down to 5340 lines.

Linux 2.4.19rc3-ac4
o	Support "help" button Vaio PCG-NV105		(Frank
Schusdziarra)
o	Clear AC on int in vm86 emulation		(Stas Sergeev)
o	Clean up stack handling macros in vm86		(Stas Sergeev)
o	Handle multiple prefixes on vm86 traps		(Stas Sergeev)
o	Use FIXMAP for f00f fixups			(Andrea
Arcangeli,
							 Christoph
Hellwig)
o	Cacheline align tlb state			(Andrea
Arcangeli)
o	cmpxchg8 needs lock prefix			(Andrea
Arcangeli)
o	Make O1 scheduler hyperthreading aware		(Andrea
Arcangeli)
	| Plus some cleanup, performance fix
o	make xconfig fix up				(Pete Zaitcev)
o	Fix a misidentification of Tualatin		(Dave Jones)
o	Update SiS IDE driver for ATA133		(Lui-Chen Chang,
							 Lionel Bouton)
o	Update procfs for inode sysctl changes		(James Antill)
o	Final fixups for summit support			(James
Cleverdon)
o	Fix missing sign check in se401 driver		(Silvio Cesare)
o	Fix missing wrap check in usbvideo		(Silvio Cesare)
o	Fix netsyms includes				(Martin Uecker)
o	Penguin logo frame buffer fix			(Geert
Uytterhoeven)
o	sym53c8xx_2 fixes for bugs tickled on hppa	(Grant Grundler)
o	Remove vm_unacct_vma				(Hugh Dickins)
o	Handle do_mmap_pgoff mask properly		(Hugh Dickins)
o	Update to rmap-13b				(Rik van Riel,
						Arjan van de Ven, Hugh
Dickins)
o	Fix trident audio suspend/resume crash		(Muli
Ben-Yehuda)
o	Give panic info in morse code on graphic oops	(Andrew Rodland)
o	Add a new kaweth usb ident			(Harm Verhagen)
o	Fix warnings from init_task.c			(Alex Riesen)
o	IRQ balancing fix backport from 2.5		(Zwane
Mwaikambo)
o	Clean up LDM support				(Richard Russon)
o	Fix lib/rbtree mismerge				(Christoph
Hellwig)
o	Endian fixes for 8390 drivers			(from HPPA
merge)
o	Support tulip on the parisc platform		(from HPPA
merge)
o	Update parport_gsc				(Helge Deller)
o	Merge fault handling changes for upward		(from HPPA
merge)
	growing stacks
o	Fix undefined C in speakup			(me)
o	Fix umem undefined C				(me)
o	Fix a few other warnings			(me)
o	Lots of gcc 3.1 __FUNCTION__ warning fixes	(me)


