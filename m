Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315151AbSD2MiR>; Mon, 29 Apr 2002 08:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315152AbSD2MiQ>; Mon, 29 Apr 2002 08:38:16 -0400
Received: from bernstein.mrc-bsu.cam.ac.uk ([193.60.86.52]:204 "EHLO
	bernstein.mrc-bsu.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S315151AbSD2MiO>; Mon, 29 Apr 2002 08:38:14 -0400
Date: Mon, 29 Apr 2002 13:38:13 +0100 (BST)
From: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>
X-X-Sender: alastair@gerber
To: linux-kernel@vger.kernel.org
Subject: Compile failure: 2.4.19-pre7-ac3
Message-ID: <Pine.GSO.4.44.0204291333460.13800-100000@gerber>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan et al: I got the following error from the sound drivers when
compiling 2.4.19-pre7-ac3 on a dual Athlon machine under RH7.2 (fully
updated). I had previously compiled -ac1 without any problems, and my
.config hasn't changed. I ran the usual "make distclean" and then
"oldconfig dep clean modules bzImage" etc:

gcc -D__KERNEL__ -I/home/alastair/linux-2.4/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon
-DMODULE -DMODVERSIONS -include
/home/alastair/linux-2.4/include/linux/modversions.h  -nostdinc -I
/usr/lib/gcc-lib/i386-redhat-linux/2.96/include
-DKBUILD_BASENAME=aic7xxx_pci  -c -o aic7xxx_pci.o aic7xxx_pci.c
ld -m elf_i386  -r -o aic7xxx.o aic7xxx_osm.o aic7xxx_proc.o
aic7770_osm.o aic7xxx_osm_pci.o aic7xxx_core.o aic7xxx_93cx6.o aic7770.o
aic7xxx_pci.o
make[3]: Leaving directory
`/home/alastair/linux-2.4/drivers/scsi/aic7xxx'
make[2]: Leaving directory `/home/alastair/linux-2.4/drivers/scsi'
make -C sound modules
make[2]: Entering directory `/home/alastair/linux-2.4/drivers/sound'
gcc -D__KERNEL__ -I/home/alastair/linux-2.4/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon
-DMODULE -DMODVERSIONS -include
/home/alastair/linux-2.4/include/linux/modversions.h  -nostdinc -I
/usr/lib/gcc-lib/i386-redhat-linux/2.96/include
-DKBUILD_BASENAME=opl3sa2  -c -o opl3sa2.o opl3sa2.copl3sa2.c: In
function `probe_opl3sa2':
opl3sa2.c:721: structure has no member named `iobase'
opl3sa2.c: At top level:
opl3sa2.c:347: warning: `opl3sa2_mixer_restore' defined but not used
make[2]: *** [opl3sa2.o] Error 1
make[2]: Leaving directory `/home/alastair/linux-2.4/drivers/sound'
make[1]: *** [_modsubdir_sound] Error 2
make[1]: Leaving directory `/home/alastair/linux-2.4/drivers'
make: *** [_mod_drivers] Error 2

Cheers
Alastair

o o o o o o o o o o o o o o o o o o o o o o o o o o o o
Alastair Stevens           \ \
MRC Biostatistics Unit      \ \___________ 01223 330383
Cambridge UK                 \___ www.mrc-bsu.cam.ac.uk

