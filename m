Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311424AbSD2OlT>; Mon, 29 Apr 2002 10:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312418AbSD2OlS>; Mon, 29 Apr 2002 10:41:18 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:4872 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S311424AbSD2OlR>; Mon, 29 Apr 2002 10:41:17 -0400
Date: Mon, 29 Apr 2002 16:40:12 +0200
From: tomas szepe <kala@pinerecords.com>
To: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compile failure: 2.4.19-pre7-ac3
Message-ID: <20020429144012.GC24016@louise.pinerecords.com>
In-Reply-To: <Pine.GSO.4.44.0204291333460.13800-100000@gerber>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-OS: Linux/sparc 2.2.21-rc3-ext3-0.0.7a SMP (up 7 days, 8:54)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently gcc 2.95.3 goes signal-11 while gcc 2.96 and 3.0.4 (didn't
try any other) blast the above.

t.


> Alan et al: I got the following error from the sound drivers when
> compiling 2.4.19-pre7-ac3 on a dual Athlon machine under RH7.2 (fully
> updated). I had previously compiled -ac1 without any problems, and my
> .config hasn't changed. I ran the usual "make distclean" and then
> "oldconfig dep clean modules bzImage" etc:
> 
> gcc -D__KERNEL__ -I/home/alastair/linux-2.4/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon
> -DMODULE -DMODVERSIONS -include
> /home/alastair/linux-2.4/include/linux/modversions.h  -nostdinc -I
> /usr/lib/gcc-lib/i386-redhat-linux/2.96/include
> -DKBUILD_BASENAME=aic7xxx_pci  -c -o aic7xxx_pci.o aic7xxx_pci.c
> ld -m elf_i386  -r -o aic7xxx.o aic7xxx_osm.o aic7xxx_proc.o
> aic7770_osm.o aic7xxx_osm_pci.o aic7xxx_core.o aic7xxx_93cx6.o aic7770.o
> aic7xxx_pci.o
> make[3]: Leaving directory
> `/home/alastair/linux-2.4/drivers/scsi/aic7xxx'
> make[2]: Leaving directory `/home/alastair/linux-2.4/drivers/scsi'
> make -C sound modules
> make[2]: Entering directory `/home/alastair/linux-2.4/drivers/sound'
> gcc -D__KERNEL__ -I/home/alastair/linux-2.4/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon
> -DMODULE -DMODVERSIONS -include
> /home/alastair/linux-2.4/include/linux/modversions.h  -nostdinc -I
> /usr/lib/gcc-lib/i386-redhat-linux/2.96/include
> -DKBUILD_BASENAME=opl3sa2  -c -o opl3sa2.o opl3sa2.copl3sa2.c: In
> function `probe_opl3sa2':
> opl3sa2.c:721: structure has no member named `iobase'
> opl3sa2.c: At top level:
> opl3sa2.c:347: warning: `opl3sa2_mixer_restore' defined but not used
> make[2]: *** [opl3sa2.o] Error 1
> make[2]: Leaving directory `/home/alastair/linux-2.4/drivers/sound'
> make[1]: *** [_modsubdir_sound] Error 2
> make[1]: Leaving directory `/home/alastair/linux-2.4/drivers'
> make: *** [_mod_drivers] Error 2
> 
> Cheers
> Alastair
> 
> o o o o o o o o o o o o o o o o o o o o o o o o o o o o
> Alastair Stevens           \ \
> MRC Biostatistics Unit      \ \___________ 01223 330383
> Cambridge UK                 \___ www.mrc-bsu.cam.ac.uk
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
"hello it's not like i read my mail so that you have where to offer to sell me
a giant turnip or anything else thankyou." -tomas szepe <kala@pinerecords.com>          
