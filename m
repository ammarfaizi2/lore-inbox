Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315414AbSGLJov>; Fri, 12 Jul 2002 05:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315419AbSGLJou>; Fri, 12 Jul 2002 05:44:50 -0400
Received: from tao-eth.natur.cuni.cz ([195.113.46.57]:26126 "EHLO
	natur.cuni.cz") by vger.kernel.org with ESMTP id <S315414AbSGLJos>;
	Fri, 12 Jul 2002 05:44:48 -0400
X-Obalka-From: mmokrejs@natur.cuni.cz
X-Obalka-To: <linux-kernel@vger.kernel.org>
Date: Fri, 12 Jul 2002 11:47:35 +0200 (CEST)
From: =?iso-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: Missing files in 2.4.19-rc1
Message-ID: <Pine.OSF.4.44.0207121138410.264794-100000@tao.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I'm getting while `make dep`

gcc -D__KERNEL__ -I/usr/src/linux-2.4.19-rc1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686  -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.4/include -E -D__GENKSYMS__ au1000_gpio.c
| /sbin/genksyms -p smp_ -k 2.4.19 > /usr/src/linux-2.4.19-rc1/include/linux/modules/au1000_gpio.ver.tmp
au1000_gpio.c:41: asm/au1000.h: No such file or directory
au1000_gpio.c:42: asm/au1000_gpio.h: No such file or directory
mv /usr/src/linux-2.4.19-rc1/include/linux/modules/au1000_gpio.ver.tmp /usr/src/linux-2.4.19-rc1/include/linux/modules/au1000_gpio.ver
[...]
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19-rc1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686  -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.4/include -E -D__GENKSYMS__ i2c-algo-ite.c
| /sbin/genksyms -p smp_ -k 2.4.19 > /usr/src/linux-2.4.19-rc1/include/linux/modules/i2c-algo-ite.ver.tmp
In file included from i2c-algo-ite.c:50:
i2c-ite.h:36: asm/it8172/it8172.h: No such file or directory
[...]
make[6]: Entering directory `/usr/src/linux-2.4.19-rc1/drivers/isdn/eicon'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19-rc1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686  -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.4/include -E -D__GENKSYMS__ Divas_mod.c
| /sbin/genksyms -p smp_ -k 2.4.19 > /usr/src/linux-2.4.19-rc1/include/linux/modules/Divas_mod.ver.tmp
mv /usr/src/linux-2.4.19-rc1/include/linux/modules/Divas_mod.ver.tmp /usr/src/linux-2.4.19-rc1/include/linux/modules/Divas_mod.ver
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19-rc1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686  -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.4/include -E -D__GENKSYMS__ eicon_mod.c
| /sbin/genksyms -p smp_ -k 2.4.19 > /usr/src/linux-2.4.19-rc1/include/linux/modules/eicon_mod.ver.tmp
mv /usr/src/linux-2.4.19-rc1/include/linux/modules/eicon_mod.ver.tmp /usr/src/linux-2.4.19-rc1/include/linux/modules/eicon_mod.ver
/usr/src/linux-2.4.19-rc1/scripts/mkdep -D__KERNEL__ -I/usr/src/linux-2.4.19-rc1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686  -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.4/include -- Divas_mod.c adapter.h bri.c common.c constant.h divalog.h divas.h dsp_defs.h dspdids.h eicon.h eicon_dsp.h eicon_idi.c eicon_idi.h eicon_io.c eicon_isa.c eicon_isa.h eicon_mod.c eicon_pci.c eicon_pci.h fourbri.c fpga.c idi.c idi.h kprintf.c lincfg.c linchr.c linio.c linsys.c log.c pc.h pc_maint.h pr_pc.h pri.c sys.h uxio.h xlog.c > .depend
make[6]: Leaving directory `/usr/src/linux-2.4.19-rc1/drivers/isdn/eicon'
make -C hisax fastdep
md5sum: can't open hfc_pci.
md5sum: can't open hfc_pci
make[6]: Entering directory `/usr/src/linux-2.4.19-rc1/drivers/isdn/hisax'
[...]
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19-rc1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686  -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.4/include -E -D__GENKSYMS__ rtc.c
| /sbin/genksyms -p smp_ -k 2.4.19 > /usr/src/linux-2.4.19-rc1/include/linux/modules/rtc.ver.tmp
rtc.c:27: asm/machdep.h: No such file or directory
rtc.c:29: asm/time.h: No such file or directory
mv /usr/src/linux-2.4.19-rc1/include/linux/modules/rtc.ver.tmp /usr/src/linux-2.4.19-rc1/include/linux/modules/rtc.ver
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19-rc1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686  -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.4/include -E -D__GENKSYMS__ mac_hid.c
| /sbin/genksyms -p smp_ -k 2.4.19 > /usr/src/linux-2.4.19-rc1/include/linux/modules/mac_hid.ver.tmp
mv /usr/src/linux-2.4.19-rc1/include/linux/modules/mac_hid.ver.tmp /usr/src/linux-2.4.19-rc1/include/linux/modules/mac_hid.ver
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19-rc1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686  -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.4/include -E -D__GENKSYMS__ via-pmu.c
| /sbin/genksyms -p smp_ -k 2.4.19 > /usr/src/linux-2.4.19-rc1/include/linux/modules/via-pmu.ver.tmp
via-pmu.c:40: asm/prom.h: No such file or directory
via-pmu.c:41: asm/machdep.h: No such file or directory
via-pmu.c:45: asm/sections.h: No such file or directory
via-pmu.c:48: asm/pmac_feature.h: No such file or directory
via-pmu.c:51: asm/sections.h: No such file or directory
via-pmu.c:52: asm/cputable.h: No such file or directory
via-pmu.c:53: asm/time.h: No such file or directory
mv /usr/src/linux-2.4.19-rc1/include/linux/modules/via-pmu.ver.tmp /usr/src/linux-2.4.19-rc1/include/linux/modules/via-pmu.ver
[...]
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19-rc1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686  -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.4/include -E -D__GENKSYMS__ amd7930.c
| /sbin/genksyms -p smp_ -k 2.4.19 > /usr/src/linux-2.4.19-rc1/include/linux/modules/amd7930.ver.tmp
amd7930.c:95: asm/openprom.h: No such file or directory
amd7930.c:96: asm/oplib.h: No such file or directory
amd7930.c:100: asm/sbus.h: No such file or directory
amd7930.c:102: asm/audioio.h: No such file or directory
mv /usr/src/linux-2.4.19-rc1/include/linux/modules/amd7930.ver.tmp /usr/src/linux-2.4.19-rc1/include/linux/modules/amd7930.ver
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19-rc1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686  -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.4/include -E -D__GENKSYMS__ dbri.c
| /sbin/genksyms -p smp_ -k 2.4.19 > /usr/src/linux-2.4.19-rc1/include/linux/modules/dbri.ver.tmp
dbri.c:53: asm/openprom.h: No such file or directory
dbri.c:54: asm/oplib.h: No such file or directory
dbri.c:58: asm/sbus.h: No such file or directory
dbri.c:61: asm/audioio.h: No such file or directory
mv /usr/src/linux-2.4.19-rc1/include/linux/modules/dbri.ver.tmp /usr/src/linux-2.4.19-rc1/include/linux/modules/dbri.ver
/usr/src/linux-2.4.19-rc1/scripts/mkdep -D__KERNEL__ -I/usr/src/linux-2.4.19-rc1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686  -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.4/include -- amd7930.c amd7930.h audio.c cs4215.h cs4231.c cs4231.h dbri.c dbri.h dmy.c dummy.h > .depend
make[6]: Leaving directory `/usr/src/linux-2.4.19-rc1/drivers/sbus/audio'
make -C char fastdep
make[6]: Entering directory `/usr/src/linux-2.4.19-rc1/drivers/sbus/char'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19-rc1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686  -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.4/include -E -D__GENKSYMS__ su.c
| /sbin/genksyms -p smp_ -k 2.4.19 > /usr/src/linux-2.4.19-rc1/include/linux/modules/su.ver.tmp
su.c:78: asm/oplib.h: No such file or directory
su.c:80: asm/ebus.h: No such file or directory
mv /usr/src/linux-2.4.19-rc1/include/linux/modules/su.ver.tmp /usr/src/linux-2.4.19-rc1/include/linux/modules/su.ver
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19-rc1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686  -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.4/include -E -D__GENKSYMS__ bbc_i2c.c
| /sbin/genksyms -p smp_ -k 2.4.19 > /usr/src/linux-2.4.19-rc1/include/linux/modules/bbc_i2c.ver.tmp
bbc_i2c.c:16: asm/oplib.h: No such file or directory
bbc_i2c.c:17: asm/ebus.h: No such file or directory
bbc_i2c.c:18: asm/spitfire.h: No such file or directory
bbc_i2c.c:19: asm/bbc.h: No such file or directory
In file included from bbc_i2c.c:21:
bbc_i2c.h:5: asm/ebus.h: No such file or directory
mv /usr/src/linux-2.4.19-rc1/include/linux/modules/bbc_i2c.ver.tmp /usr/src/linux-2.4.19-rc1/include/linux/modules/bbc_i2c.ver
[...]
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19-rc1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686  -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.4/include -E -D__GENKSYMS__ 53c700.c
| /sbin/genksyms -p smp_ -k 2.4.19 > /usr/src/linux-2.4.19-rc1/include/linux/modules/53c700.ver.tmp
In file included from 53c700.c:134:
53c700.h:40: #error "Config.in must define either CONFIG_53C700_IO_MAPPED or CONFIG_53C700_MEM_MAPPED to use this scsi core."
53c700.c:155: 53c700_d.h: No such file or directory
mv /usr/src/linux-2.4.19-rc1/include/linux/modules/53c700.ver.tmp /usr/src/linux-2.4.19-rc1/include/linux/modules/53c700.ver
[...]
make[6]: Entering directory `/usr/src/linux-2.4.19-rc1/drivers/sgi/char'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19-rc1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686  -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.4/include -E -D__GENKSYMS__ newport.c
| /sbin/genksyms -p smp_ -k 2.4.19 > /usr/src/linux-2.4.19-rc1/include/linux/modules/newport.ver.tmp
newport.c:11: asm/gfx.h: No such file or directory
newport.c:12: asm/ng1.h: No such file or directory
mv /usr/src/linux-2.4.19-rc1/include/linux/modules/newport.ver.tmp /usr/src/linux-2.4.19-rc1/include/linux/modules/newport.ver
[...]
i
Is this problem known? Is the source tree usable?
I could continue with mnoree such errors, if someone interrested. Please
Cc: me in replies. Thanks.
-- 
Martin Mokrejs <mmokrejs@natur.cuni.cz>
PGP5.0i key is at http://www.natur.cuni.cz/~mmokrejs
MIPS / Institute for Bioinformatics <http://mips.gsf.de>
GSF - National Research Center for Environment and Health
Ingolstaedter Landstrasse 1, D-85764 Neuherberg, Germany
tel.: +49-89-3187 3683 , fax: +49-89-3187 3585

