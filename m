Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278668AbRJXRxZ>; Wed, 24 Oct 2001 13:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278680AbRJXRxT>; Wed, 24 Oct 2001 13:53:19 -0400
Received: from tartarus.telenet-ops.be ([195.130.132.34]:22960 "EHLO
	tartarus.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S278668AbRJXRxI>; Wed, 24 Oct 2001 13:53:08 -0400
Date: Wed, 24 Oct 2001 19:53:42 +0200
From: Sven Vermeulen <sven.vermeulen@rug.ac.be>
To: Linux-Kernel Development Mailinglist 
	<linux-kernel@vger.kernel.org>
Subject: 2.4.13: some compilerwarnings...
Message-ID: <20011024195342.A464@Zenith.starcenter>
Mail-Followup-To: Linux-Kernel Development Mailinglist <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.4.13
X-Telephone: +32 486 460306
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No fatal errors or anything, kernel runs fine, but some compilerwarnings...
they could be in other kernelversions too, I only noticed them this time.

~$ make dep
[...]
make -C eicon fastdep
make[6]: Entering directory `/home/nitro/src/linux/drivers/isdn/eicon'
/home/nitro/src/linux/scripts/mkdep -D__KERNEL__ -I/home/nitro/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6  -- Divas_mod.c adapter.h bri.c common.c constant.h divalog.h divas.h dsp_defs.h dspdids.h eicon.h eicon_dsp.h eicon_idi.c eicon_idi.h eicon_io.c eicon_isa.c eicon_isa.h eicon_mod.c eicon_pci.c eicon_pci.h fourbri.c fpga.c idi.c idi.h kprintf.c lincfg.c linchr.c linio.c linsys.c log.c pc.h pc_maint.h pr_pc.h pri.c sys.h uxio.h xlog.c > .depend
make[6]: Leaving directory `/home/nitro/src/linux/drivers/isdn/eicon'
make -C hisax fastdep
md5sum: WARNING: 13 of 13 computed checksums did NOT match
[...]

~$ make bzImage
[...]
gcc -D__KERNEL__ -I/home/nitro/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6    -c -o pci-i386.o pci-i386.c
gcc -D__KERNEL__ -I/home/nitro/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6    -c -o pci-pc.o pci-pc.c
{standard input}: Assembler messages:
{standard input}:1040: Warning: indirect lcall without `*'
{standard input}:1125: Warning: indirect lcall without `*'
{standard input}:1208: Warning: indirect lcall without `*'
{standard input}:1282: Warning: indirect lcall without `*'
{standard input}:1293: Warning: indirect lcall without `*'
{standard input}:1304: Warning: indirect lcall without `*'
{standard input}:1378: Warning: indirect lcall without `*'
{standard input}:1389: Warning: indirect lcall without `*'
{standard input}:1400: Warning: indirect lcall without `*'
{standard input}:1862: Warning: indirect lcall without `*'
{standard input}:1951: Warning: indirect lcall without `*'
[...]
gcc -D__KERNEL__ -I/home/nitro/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6    -c -o msr.o msr.c
gcc -D__KERNEL__ -I/home/nitro/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6    -c -o apm.o apm.c
{standard input}: Assembler messages:
{standard input}:187: Warning: indirect lcall without `*'
{standard input}:282: Warning: indirect lcall without `*'
[...]
gcc -E -D__KERNEL__ -I/home/nitro/src/linux/include -D__BIG_KERNEL__ -traditional -DSVGA_MODE=NORMAL_VGA  bootsect.S -o bbootsect.s
as -o bbootsect.o bbootsect.s
bbootsect.s: Assembler messages:
bbootsect.s:256: Warning: indirect lcall without `*'
[...]
gcc -E -D__KERNEL__ -I/home/nitro/src/linux/include -D__BIG_KERNEL__ -D__ASSEMBLY__ -traditional -DSVGA_MODE=NORMAL_VGA  setup.S -o bsetup.s
as -o bsetup.o bsetup.s
bsetup.s: Assembler messages:
bsetup.s:1459: Warning: indirect lcall without `*'
[...]


btw: gcc-version is 2.96, as-version is 2.11.90.0.8

Keep up the good work!

	Sven Vermeulen

-- 
Unix, MS-DOS and Windows NT (also known as the Good, the Bad and the
Ugly). ~(Matt Welsh)
