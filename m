Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293285AbSB1NTY>; Thu, 28 Feb 2002 08:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293297AbSB1NQv>; Thu, 28 Feb 2002 08:16:51 -0500
Received: from ns1.yourmail.at ([193.53.80.95]:5812 "EHLO zaphod.gnc.at")
	by vger.kernel.org with ESMTP id <S293285AbSB1NOy>;
	Thu, 28 Feb 2002 08:14:54 -0500
Message-ID: <64123.62.178.116.169.1014901987.squirrel@mail.gnc.at>
Date: Thu, 28 Feb 2002 14:13:07 +0100 (CET)
Subject: 2.5.5 compile error with 
From: "[GNC] Gerald Weber" <gerald.weber@gnc.at>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
Cc: <achim@vortex.de>
X-Mailer: SquirrelMail (version 1.2.4)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi there,

suse 7.3,gcc version 2.95.3 20010315 (SuSE),xfs-1.0.2 patch for
2.5.5 applied,gives compile errors: (if anyone needs something else,
please let me know)

thx,
gw

gcc -D__KERNEL__ -I/usr/src/linux-2.5.5/include  -Wall -Wstrict-prototypes -
Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -
pipe -mpreferred-stack-boundary=2 -march=i686   -
DKBUILD_BASENAME=scsi_syms  -DEXPORT_SYMTAB -c scsi_syms.c
ld -m elf_i386 -r -o scsi_mod.o scsi.o hosts.o scsi_ioctl.o constants.o
scsicam.o scsi_proc.o scsi_error.o scsi_queue.o scsi_lib.o scsi_merge.o
scsi_scan.o scsi_syms.o
gcc -D__KERNEL__ -I/usr/src/linux-2.5.5/include  -Wall -Wstrict-prototypes -
Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -
pipe -mpreferred-stack-boundary=2 -march=i686   -
DKBUILD_BASENAME=sym53c8xx  -c -o sym53c8xx.o sym53c8xx.c
gcc -D__KERNEL__ -I/usr/src/linux-2.5.5/include  -Wall -Wstrict-prototypes -
Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -
pipe -mpreferred-stack-boundary=2 -march=i686   -DKBUILD_BASENAME=gdth  -c -
o gdth.o gdth.c
gdth.c:298: #error Please convert me to Documentation/DMA-mapping.txt
In file included from gdth.c:704:
gdth_proc.c:1393: macro `GDTH_LOCK_SCSI_DONE' used with just one arg
gdth.c:3346: macro `GDTH_UNLOCK_SCSI_DONE' used with too many (2) args
In file included from gdth.c:704:
gdth_proc.c: In function `gdth_wait_completion':
gdth_proc.c:1393: parse error before `)'
gdth_proc.c:1393: invalid type argument of `->'
gdth_proc.c:1395: `dev' undeclared (first use in this function)
gdth_proc.c:1395: (Each undeclared identifier is reported only once
gdth_proc.c:1395: for each function it appears in.)
gdth.c: In function `gdth_copy_internal_data':
gdth.c:2633: structure has no member named `address'
gdth.c:2633: structure has no member named `address'
gdth.c: In function `gdth_fill_cache_cmd':
gdth.c:2808: structure has no member named `address'
gdth.c: In function `gdth_fill_raw_cmd':
gdth.c:2925: structure has no member named `address'
gdth.c: In function `gdth_interrupt':
gdth.c:3346: `dev' undeclared (first use in this function)
make[3]: *** [gdth.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5.5/drivers/scsi'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.5.5/drivers/scsi'
make[1]: *** [_subdir_scsi] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.5/drivers'
make: *** [_dir_drivers] Error 2


