Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131886AbRDAFuS>; Sun, 1 Apr 2001 00:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131988AbRDAFuI>; Sun, 1 Apr 2001 00:50:08 -0500
Received: from c209680-a.afour1.il.home.com ([24.14.110.121]:11746 "HELO
	yakov.dls.net") by vger.kernel.org with SMTP id <S131886AbRDAFuC>;
	Sun, 1 Apr 2001 00:50:02 -0500
Date: Sat, 31 Mar 2001 23:58:34 -0600 (CST)
From: "Arc C." <achapkis@yakov.dls.net>
To: <linux-kernel@vger.kernel.org>
Subject: kernel compilation errors
Message-ID: <Pine.LNX.4.30.0103312352220.29854-100000@yakov.dls.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello. I'm trying to compile new kernel 2.4.3 and I get some errors:

yakov:/usr/src/linux$ make modules
....
....
make[2]: Entering directory `/home/linux-2.4.3/drivers/block'
gcc -D__KERNEL__ -I/home/linux-2.4.3/include -Wall -Wstrict-prototypes -O2
-fomi
t-frame-pointer -fno-strict-aliasing -pipe -mno-fp-regs -ffixed-8
-mcpu=ev4 -Wa,
-mev6 -DMODULE -DMODVERSIONS -include
/home/linux-2.4.3/include/linux/modversion
s.h   -DEXPORT_SYMTAB -c loop.c
In file included from /home/linux-2.4.3/include/linux/highmem.h:6,
                 from /home/linux-2.4.3/include/linux/pagemap.h:17,
                 from /home/linux-2.4.3/include/linux/locks.h:9,
                 from /home/linux-2.4.3/include/linux/blk.h:6,
                 from loop.c:65:
/home/linux-2.4.3/include/asm/pgalloc.h:334: conflicting types for
`pte_alloc'
/home/linux-2.4.3/include/linux/mm.h:399: previous declaration of
`pte_alloc'
/home/linux-2.4.3/include/asm/pgalloc.h:352: conflicting types for
`pmd_alloc'
/home/linux-2.4.3/include/linux/mm.h:412: previous declaration of
`pmd_alloc'
make[2]: *** [loop.o] Error 1
make[2]: Leaving directory `/home/linux-2.4.3/drivers/block'
make[1]: *** [_modsubdir_block] Error 2
make[1]: Leaving directory `/home/linux-2.4.3/drivers'
make: *** [_mod_drivers] Error 2

  Here's the output of scripts/ver_linux:

Linux yakov.dls.net 2.4.0 #1 Sat Jan 6 20:17:19 CST 2001 alpha unknown

Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.0.18
util-linux             2.10m
modutils               2.4.2
e2fsprogs              1.19
Linux C Library        > libc.2.2
Dynamic linker (ldd)   2.2
Procps                 2.0.7
Net-tools              1.56
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         autofs

yakov:/usr/src/linux$ cat /proc/cpuinfo
cpu                     : Alpha
cpu model               : EV4
cpu variation           : 0
cpu revision            : 0
cpu serial number       : Linux_is_Great!
system type             : Avanti
system variation        : 0
system revision         : 0
system serial number    : MILO-2.0.35-c5.
cycle frequency [Hz]    : 233313724
timer frequency [Hz]    : 1024.00
page size [bytes]       : 8192
phys. address bits      : 34
max. addr. space #      : 63
BogoMIPS                : 459.64
kernel unaligned acc    : 8 (pc=fffffc000040e100,va=fffffc00001c79f2)
user unaligned acc      : 8184 (pc=1200016dc,va=11ffff6c2)
platform string         : N/A
cpus detected           : 0

  Thank you,

Arc C.

