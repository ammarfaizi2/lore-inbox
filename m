Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318279AbSGXI0D>; Wed, 24 Jul 2002 04:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318276AbSGXI0D>; Wed, 24 Jul 2002 04:26:03 -0400
Received: from conductor.synapse.net ([199.84.54.18]:52742 "HELO
	conductor.synapse.net") by vger.kernel.org with SMTP
	id <S318273AbSGXIZ5>; Wed, 24 Jul 2002 04:25:57 -0400
Content-Type: text/plain; charset=US-ASCII
From: "D.A.M. Revok" <marvin@synapse.net>
To: linux-kernel@vger.kernel.org
Subject: Compile Bogons in 2.4.19-rc3 with Caldera OpenLinux 3.1's patched 2.95.2
Date: Wed, 24 Jul 2002 04:29:03 -0400
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020724082557Z318273-685+17059@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I compile with
mv .config ..
make mrproper
mv ../.config .
make oldconfig
make dep clean bzImage modules > /dev/null ( to make me see the erors, since 
allowing 'em to be hidden amongst the seas of warnings don't clue me in. . . )
and possibly the "make clean" portion of that isn't recommended anymore ( but 
I didn't ever see any recommendation to /not/ use it for any raisin. . . )

I've got 2.4.18 in /usr/src/linux ( symlink to linux-2.4.19 ), patched.

The "*" marked lines are the ones that showed up on stderr, the following lines 
show the context from a re-everything of the kernel ( using the finally-learned-
-about trick of "&> ../compile.log" ), so youse can figure out what and where it's 
going on.

I'll not be using Caldera much longer, so it'll be either SuSE 8 or Gentoo or LFS 
for me ( e-mail me if their compilers are known to be broken, I'd rather know up-
front and grab the stock one, no that won't work, according to LFS 2.95.3 needs 
2 minor patches   hmmm )

PS, if you want more context for one or another of these ( or what I'm getting 
included/set in my config ), just e-mail me & ask, please.

=======================================================

*au1000_gpio.c:41: asm/au1000.h: No such file or directory
*au1000_gpio.c:42: asm/au1000_gpio.h: No such file or directory
context:
mv /usr/src/linux-2.4.19/include/linux/modules/generic_serial.ver.tmp
 /usr/src/linux-2.4.19/include/linux/modules/generic_serial.ver
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes
 -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe
 -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4   -nostdinc -I
 /usr/lib/gcc-lib/i386-linux/2.95.2/include -E -D__GENKSYMS__ au1000_gpio.c
| /sbin/genksyms  -k 2.4.19 >
 /usr/src/linux-2.4.19/include/linux/modules/au1000_gpio.ver.tmp
au1000_gpio.c:41: asm/au1000.h: No such file or directory
au1000_gpio.c:42: asm/au1000_gpio.h: No such file or directory
mv /usr/src/linux-2.4.19/include/linux/modules/au1000_gpio.ver.tmp
 /usr/src/linux-2.4.19/include/linux/modules/au1000_gpio.ver


*In file included from i2c-algo-ite.c:50:
*i2c-ite.h:36: asm/it8172/it8172.h: No such file or directory
context:
mv /usr/src/linux-2.4.19/include/linux/modules/i2c-algo-pcf.ver.tmp
 /usr/src/linux-2.4.19/include/linux/modules/i2c-algo-pcf.ver
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes
 -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe
 -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4   -nostdinc -I
 /usr/lib/gcc-lib/i386-linux/2.95.2/include -E -D__GENKSYMS__ i2c-algo-ite.c
| /sbin/genksyms  -k 2.4.19 >
 /usr/src/linux-2.4.19/include/linux/modules/i2c-algo-ite.ver.tmp
In file included from i2c-algo-ite.c:50:
i2c-ite.h:36: asm/it8172/it8172.h: No such file or directory
mv /usr/src/linux-2.4.19/include/linux/modules/i2c-algo-ite.ver.tmp
 /usr/src/linux-2.4.19/include/linux/modules/i2c-algo-ite.ver


*rtc.c:27: asm/machdep.h: No such file or directory
*rtc.c:29: asm/time.h: No such file or directory

*via-pmu.c:40: asm/prom.h: No such file or directory
*via-pmu.c:41: asm/machdep.h: No such file or directory
*via-pmu.c:45: asm/sections.h: No such file or directory
*via-pmu.c:48: asm/pmac_feature.h: No such file or directory
*via-pmu.c:51: asm/sections.h: No such file or directory
*via-pmu.c:52: asm/cputable.h: No such file or directory
*via-pmu.c:53: asm/time.h: No such file or directory
context:
mv /usr/src/linux-2.4.19/include/linux/modules/adb.ver.tmp
 /usr/src/linux-2.4.19/include/linux/modules/adb.ver
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes
 -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe
 -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4   -nostdinc -I
 /usr/lib/gcc-lib/i386-linux/2.95.2/include -E -D__GENKSYMS__ rtc.c
| /sbin/genksyms  -k 2.4.19 >
 /usr/src/linux-2.4.19/include/linux/modules/rtc.ver.tmp
rtc.c:27: asm/machdep.h: No such file or directory
rtc.c:29: asm/time.h: No such file or directory
mv /usr/src/linux-2.4.19/include/linux/modules/rtc.ver.tmp
 /usr/src/linux-2.4.19/include/linux/modules/rtc.ver
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes
 -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe
 -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4   -nostdinc -I
 /usr/lib/gcc-lib/i386-linux/2.95.2/include -E -D__GENKSYMS__ mac_hid.c
| /sbin/genksyms  -k 2.4.19 >
 /usr/src/linux-2.4.19/include/linux/modules/mac_hid.ver.tmp
mv /usr/src/linux-2.4.19/include/linux/modules/mac_hid.ver.tmp
 /usr/src/linux-2.4.19/include/linux/modules/mac_hid.ver
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes
 -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe
 -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4   -nostdinc -I
 /usr/lib/gcc-lib/i386-linux/2.95.2/include -E -D__GENKSYMS__ via-pmu.c
| /sbin/genksyms  -k 2.4.19 >
 /usr/src/linux-2.4.19/include/linux/modules/via-pmu.ver.tmp
via-pmu.c:40: asm/prom.h: No such file or directory
via-pmu.c:41: asm/machdep.h: No such file or directory
via-pmu.c:45: asm/sections.h: No such file or directory
via-pmu.c:48: asm/pmac_feature.h: No such file or directory
via-pmu.c:51: asm/sections.h: No such file or directory
via-pmu.c:52: asm/cputable.h: No such file or directory
via-pmu.c:53: asm/time.h: No such file or directory
mv /usr/src/linux-2.4.19/include/linux/modules/via-pmu.ver.tmp
 /usr/src/linux-2.4.19/include/linux/modules/via-pmu.ver
/usr/src/linux-2.4.19/scripts/mkdep -D__KERNEL__
 -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2
 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe
 -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4   -nostdinc -I
 /usr/lib/gcc-lib/i386-linux/2.95.2/include -- adb-iop.c adb.c adbhid.c
 ans-lcd.c apm_emu.c mac_hid.c mac_keyb.c macio-adb.c macserial.c macserial.h
 mediabay.c nvram.c rtc.c via-cuda.c via-macii.c via-maciisi.c via-pmu.c
 via-pmu68k.c > .depend


*audio.c:41: asm/audioio.h: No such file or directory
context:
make[6]: Entering directory `/usr/src/linux-2.4.19/drivers/sbus/audio'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes
 -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe
 -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4   -nostdinc -I
 /usr/lib/gcc-lib/i386-linux/2.95.2/include -E -D__GENKSYMS__ audio.c
| /sbin/genksyms  -k 2.4.19 >
 /usr/src/linux-2.4.19/include/linux/modules/audio.ver.tmp
audio.c:41: asm/audioio.h: No such file or directory
mv /usr/src/linux-2.4.19/include/linux/modules/audio.ver.tmp
 /usr/src/linux-2.4.19/include/linux/modules/audio.ver
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes
 -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe
 -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4   -nostdinc -I
 /usr/lib/gcc-lib/i386-linux/2.95.2/include -E -D__GENKSYMS__ amd7930.c
--
amd7930.c:95: asm/openprom.h: No such file or directory
amd7930.c:96: asm/oplib.h: No such file or directory
amd7930.c:100: asm/sbus.h: No such file or directory
amd7930.c:102: asm/audioio.h: No such file or directory
mv /usr/src/linux-2.4.19/include/linux/modules/amd7930.ver.tmp
 /usr/src/linux-2.4.19/include/linux/modules/amd7930.ver
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes
 -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe
 -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4   -nostdinc -I
 /usr/lib/gcc-lib/i386-linux/2.95.2/include -E -D__GENKSYMS__ dbri.c
--
dbri.c:53: asm/openprom.h: No such file or directory
dbri.c:54: asm/oplib.h: No such file or directory
dbri.c:58: asm/sbus.h: No such file or directory
dbri.c:61: asm/audioio.h: No such file or directory
mv /usr/src/linux-2.4.19/include/linux/modules/dbri.ver.tmp
 /usr/src/linux-2.4.19/include/linux/modules/dbri.ver
/usr/src/linux-2.4.19/scripts/mkdep -D__KERNEL__
 -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2
 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe
 -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4   -nostdinc -I
 /usr/lib/gcc-lib/i386-linux/2.95.2/include -- amd7930.c amd7930.h audio.c
 cs4215.h cs4231.c cs4231.h dbri.c dbri.h dmy.c dummy.h > .depend


*amd7930.c:95: asm/openprom.h: No such file or directory
*amd7930.c:96: asm/oplib.h: No such file or directory
*amd7930.c:100: asm/sbus.h: No such file or directory
*amd7930.c:102: asm/audioio.h: No such file or directory
context:
mv /usr/src/linux-2.4.19/include/linux/modules/audio.ver.tmp
 /usr/src/linux-2.4.19/include/linux/modules/audio.ver
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes
 -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe
 -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4   -nostdinc -I
 /usr/lib/gcc-lib/i386-linux/2.95.2/include -E -D__GENKSYMS__ amd7930.c
| /sbin/genksyms  -k 2.4.19 >
 /usr/src/linux-2.4.19/include/linux/modules/amd7930.ver.tmp
amd7930.c:95: asm/openprom.h: No such file or directory
amd7930.c:96: asm/oplib.h: No such file or directory
amd7930.c:100: asm/sbus.h: No such file or directory
amd7930.c:102: asm/audioio.h: No such file or directory
mv /usr/src/linux-2.4.19/include/linux/modules/amd7930.ver.tmp
 /usr/src/linux-2.4.19/include/linux/modules/amd7930.ver
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes
 -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe
 -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4   -nostdinc -I
 /usr/lib/gcc-lib/i386-linux/2.95.2/include -E -D__GENKSYMS__ dbri.c


*dbri.c:53: asm/openprom.h: No such file or directory
*dbri.c:54: asm/oplib.h: No such file or directory
*dbri.c:58: asm/sbus.h: No such file or directory
*dbri.c:61: asm/audioio.h: No such file or directory
context:
mv /usr/src/linux-2.4.19/include/linux/modules/amd7930.ver.tmp
 /usr/src/linux-2.4.19/include/linux/modules/amd7930.ver
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes
 -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe
 -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4   -nostdinc -I
 /usr/lib/gcc-lib/i386-linux/2.95.2/include -E -D__GENKSYMS__ dbri.c
| /sbin/genksyms  -k 2.4.19 >
 /usr/src/linux-2.4.19/include/linux/modules/dbri.ver.tmp
dbri.c:53: asm/openprom.h: No such file or directory
dbri.c:54: asm/oplib.h: No such file or directory
dbri.c:58: asm/sbus.h: No such file or directory
dbri.c:61: asm/audioio.h: No such file or directory
mv /usr/src/linux-2.4.19/include/linux/modules/dbri.ver.tmp
 /usr/src/linux-2.4.19/include/linux/modules/dbri.ver
/usr/src/linux-2.4.19/scripts/mkdep -D__KERNEL__
 -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2
 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe
 -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4   -nostdinc -I
 /usr/lib/gcc-lib/i386-linux/2.95.2/include -- amd7930.c amd7930.h audio.c
 cs4215.h cs4231.c cs4231.h dbri.c dbri.h dmy.c dummy.h > .depend


*su.c:78: asm/oplib.h: No such file or directory
*su.c:80: asm/ebus.h: No such file or directory
context:
make[6]: Entering directory `/usr/src/linux-2.4.19/drivers/sbus/char'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes
 -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe
 -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4   -nostdinc -I
 /usr/lib/gcc-lib/i386-linux/2.95.2/include -E -D__GENKSYMS__ su.c
| /sbin/genksyms  -k 2.4.19 >
 /usr/src/linux-2.4.19/include/linux/modules/su.ver.tmp
su.c:78: asm/oplib.h: No such file or directory
su.c:80: asm/ebus.h: No such file or directory
mv /usr/src/linux-2.4.19/include/linux/modules/su.ver.tmp
 /usr/src/linux-2.4.19/include/linux/modules/su.ver
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes
 -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe
 -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4   -nostdinc -I
 /usr/lib/gcc-lib/i386-linux/2.95.2/include -E -D__GENKSYMS__ bbc_i2c.c


*bbc_i2c.c:16: asm/oplib.h: No such file or directory
*bbc_i2c.c:17: asm/ebus.h: No such file or directory
*bbc_i2c.c:18: asm/spitfire.h: No such file or directory
*bbc_i2c.c:19: asm/bbc.h: No such file or directory
*In file included from bbc_i2c.c:21:
*bbc_i2c.h:5: asm/ebus.h: No such file or directory
context:
mv /usr/src/linux-2.4.19/include/linux/modules/su.ver.tmp
 /usr/src/linux-2.4.19/include/linux/modules/su.ver
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes
 -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe
 -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4   -nostdinc -I
 /usr/lib/gcc-lib/i386-linux/2.95.2/include -E -D__GENKSYMS__ bbc_i2c.c
| /sbin/genksyms  -k 2.4.19 >
 /usr/src/linux-2.4.19/include/linux/modules/bbc_i2c.ver.tmp
bbc_i2c.c:16: asm/oplib.h: No such file or directory
bbc_i2c.c:17: asm/ebus.h: No such file or directory
bbc_i2c.c:18: asm/spitfire.h: No such file or directory
bbc_i2c.c:19: asm/bbc.h: No such file or directory
In file included from bbc_i2c.c:21:
bbc_i2c.h:5: asm/ebus.h: No such file or directory
mv /usr/src/linux-2.4.19/include/linux/modules/bbc_i2c.ver.tmp
 /usr/src/linux-2.4.19/include/linux/modules/bbc_i2c.ver


*In file included from 53c700.c:134:
*53c700.h:40: #error "Config.in must define either CONFIG_53C700_IO_MAPPED or
 CONFIG_53C700_MEM_MAPPED to use this scsi core."
*53c700.c:155: 53c700_d.h: No such file or directory
context:
mv /usr/src/linux-2.4.19/include/linux/modules/scsi_syms.ver.tmp
 /usr/src/linux-2.4.19/include/linux/modules/scsi_sy
ms.ver
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes
 -Wno-trigraphs -O2 -fno-strict-aliasing -
fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686
 -malign-functions=4   -nostdinc -I /u
sr/lib/gcc-lib/i386-linux/2.95.2/include -E -D__GENKSYMS__ 53c700.c
| /sbin/genksyms  -k 2.4.19 >
 /usr/src/linux-2.4.19/include/linux/modules/53c700.ver.tmp
In file included from 53c700.c:134:
53c700.h:40: #error "Config.in must define either CONFIG_53C700_IO_MAPPED or
 CONFIG_53C700_MEM_MAPPED to use this sc
si core."
53c700.c:155: 53c700_d.h: No such file or directory
mv /usr/src/linux-2.4.19/include/linux/modules/53c700.ver.tmp
 /usr/src/linux-2.4.19/include/linux/modules/53c700.ver


*fas216.c:55: asm/ecard.h: No such file or directory
context:
make[6]: Entering directory `/usr/src/linux-2.4.19/drivers/acorn/scsi'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes
 -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe
 -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4   -nostdinc -I
 /usr/lib/gcc-lib/i386-linux/2.95.2/include -E -D__GENKSYMS__ fas216.c
| /sbin/genksyms  -k 2.4.19 >
 /usr/src/linux-2.4.19/include/linux/modules/fas216.ver.tmp
fas216.c:55: asm/ecard.h: No such file or directory
mv /usr/src/linux-2.4.19/include/linux/modules/fas216.ver.tmp
 /usr/src/linux-2.4.19/include/linux/modules/fas216.ver
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes
 -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe
 -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4   -nostdinc -I
 /usr/lib/gcc-lib/i386-linux/2.95.2/include -E -D__GENKSYMS__ queue.c
| /sbin/genksyms  -k 2.4.19 >
 /usr/src/linux-2.4.19/include/linux/modules/queue.ver.tmp


*newport.c:11: asm/gfx.h: No such file or directory
*newport.c:12: asm/ng1.h: No such file or directory
context:
make[6]: Entering directory `/usr/src/linux-2.4.19/drivers/sgi/char'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes
 -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe
 -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4   -nostdinc -I
 /usr/lib/gcc-lib/i386-linux/2.95.2/include -E -D__GENKSYMS__ newport.c
| /sbin/genksyms  -k 2.4.19 >
 /usr/src/linux-2.4.19/include/linux/modules/newport.ver.tmp
newport.c:11: asm/gfx.h: No such file or directory
newport.c:12: asm/ng1.h: No such file or directory
mv /usr/src/linux-2.4.19/include/linux/modules/newport.ver.tmp
 /usr/src/linux-2.4.19/include/linux/modules/newport.ver
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes
 -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe
 -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4   -nostdinc -I
 /usr/lib/gcc-lib/i386-linux/2.95.2/include -E -D__GENKSYMS__ rrm.c


*rrm.c:15: asm/rrm.h: No such file or directory
context:
mv /usr/src/linux-2.4.19/include/linux/modules/newport.ver.tmp
 /usr/src/linux-2.4.19/include/linux/modules/newport.ver
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes
 -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe
 -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4   -nostdinc -I
 /usr/lib/gcc-lib/i386-linux/2.95.2/include -E -D__GENKSYMS__ rrm.c
| /sbin/genksyms  -k 2.4.19 >
 /usr/src/linux-2.4.19/include/linux/modules/rrm.ver.tmp
rrm.c:15: asm/rrm.h: No such file or directory
mv /usr/src/linux-2.4.19/include/linux/modules/rrm.ver.tmp
 /usr/src/linux-2.4.19/include/linux/modules/rrm.ver
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes
 -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe
 -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4   -nostdinc -I
 /usr/lib/gcc-lib/i386-linux/2.95.2/include -E -D__GENKSYMS__ shmiq.c
| /sbin/genksyms  -k 2.4.19 >
 /usr/src/linux-2.4.19/include/linux/modules/shmiq.ver.tmp


*shmiq.c:57: asm/shmiq.h: No such file or directory
*shmiq.c:58: asm/gfx.h: No such file or directory
context:
mv /usr/src/linux-2.4.19/include/linux/modules/rrm.ver.tmp
 /usr/src/linux-2.4.19/include/linux/modules/rrm.ver
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes
 -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe
 -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4   -nostdinc -I
 /usr/lib/gcc-lib/i386-linux/2.95.2/include -E -D__GENKSYMS__ shmiq.c
| /sbin/genksyms  -k 2.4.19 >
 /usr/src/linux-2.4.19/include/linux/modules/shmiq.ver.tmp
shmiq.c:57: asm/shmiq.h: No such file or directory
shmiq.c:58: asm/gfx.h: No such file or directory
mv /usr/src/linux-2.4.19/include/linux/modules/shmiq.ver.tmp
 /usr/src/linux-2.4.19/include/linux/modules/shmiq.ver
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes
 -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe
 -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4   -nostdinc -I
 /usr/lib/gcc-lib/i386-linux/2.95.2/include -E -D__GENKSYMS__ sgicons.c

*usema.c:38: asm/usioctl.h: No such file or directory
context:
mv /usr/src/linux-2.4.19/include/linux/modules/sgicons.ver.tmp
 /usr/src/linux-2.4.19/include/linux/modules/sgicons.ver
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes
 -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe
 -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4   -nostdinc -I
 /usr/lib/gcc-lib/i386-linux/2.95.2/include -E -D__GENKSYMS__ usema.c
| /sbin/genksyms  -k 2.4.19 >
 /usr/src/linux-2.4.19/include/linux/modules/usema.ver.tmp
usema.c:38: asm/usioctl.h: No such file or directory
mv /usr/src/linux-2.4.19/include/linux/modules/usema.ver.tmp
 /usr/src/linux-2.4.19/include/linux/modules/usema.ver
/usr/src/linux-2.4.19/scripts/mkdep -D__KERNEL__
 -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2
 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe
 -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4
 -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.2/include -- ds1286.c gconsole.h
 graphics.c graphics.h newport.c rrm.c sgicons.c sgiserial.c sgiserial.h
 shmiq.c streamable.c usema.c usema.h > .depend
make[6]: Leaving directory `/usr/src/linux-2.4.19/drivers/sgi/char'


*tc.c:15: asm/addrspace.h: No such file or directory
*tc.c:17: asm/dec/machtype.h: No such file or directory
*tc.c:18: asm/dec/tcinfo.h: No such file or directory
*tc.c:19: asm/dec/tcmodule.h: No such file or directory
*tc.c:20: asm/dec/interrupts.h: No such file or directory
** there isn't any asm/dec directory at all, in linux/include/asm
context:
make[4]: Entering directory `/usr/src/linux-2.4.19/drivers/tc'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes
 -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe
 -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4   -nostdinc -I
 /usr/lib/gcc-lib/i386-linux/2.95.2/include -E -D__GENKSYMS__ tc.c
| /sbin/genksyms  -k 2.4.19 >
 /usr/src/linux-2.4.19/include/linux/modules/tc.ver.tmp
tc.c:15: asm/addrspace.h: No such file or directory
tc.c:17: asm/dec/machtype.h: No such file or directory
tc.c:18: asm/dec/tcinfo.h: No such file or directory
tc.c:19: asm/dec/tcmodule.h: No such file or directory
tc.c:20: asm/dec/interrupts.h: No such file or directory
mv /usr/src/linux-2.4.19/include/linux/modules/tc.ver.tmp
 /usr/src/linux-2.4.19/include/linux/modules/tc.ver


*sa1100fb.c:164: linux/cpufreq.h: No such file or directory
*sa1100fb.c:166: asm/hardware.h: No such file or directory
*sa1100fb.c:169: asm/mach-types.h: No such file or directory
*sa1100fb.c:171: asm/arch/assabet.h: No such file or directory
context:
mv /usr/src/linux-2.4.19/include/linux/modules/cyber2000fb.ver.tmp
 /usr/src/linux-2.4.19/include/linux/modules/cyber2000fb.ver
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes
 -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe
 -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4   -nostdinc -I
 /usr/lib/gcc-lib/i386-linux/2.95.2/include -E -D__GENKSYMS__ sa1100fb.c
| /sbin/genksyms  -k 2.4.19 >
 /usr/src/linux-2.4.19/include/linux/modules/sa1100fb.ver.tmp
sa1100fb.c:164: linux/cpufreq.h: No such file or directory
sa1100fb.c:166: asm/hardware.h: No such file or directory
sa1100fb.c:169: asm/mach-types.h: No such file or directory
sa1100fb.c:171: asm/arch/assabet.h: No such file or directory
mv /usr/src/linux-2.4.19/include/linux/modules/sa1100fb.ver.tmp
 /usr/src/linux-2.4.19/include/linux/modules/sa1100fb.ver
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes
 -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe
 -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4   -nostdinc -I
 /usr/lib/gcc-lib/i386-linux/2.95.2/include -E -D__GENKSYMS__ fbcon-hga.c


*In file included from zorro.c:17:
*/usr/src/linux-2.4.19/include/linux/zorro.h:158: asm/zorro.h: No such file or
 directory
*zorro.c:20: asm/amigahw.h: No such file or directory
context:
make[4]: Entering directory `/usr/src/linux-2.4.19/drivers/zorro'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes
 -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe
 -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4   -nostdinc -I
 /usr/lib/gcc-lib/i386-linux/2.95.2/include -E -D__GENKSYMS__ zorro.c
| /sbin/genksyms  -k 2.4.19 >
 /usr/src/linux-2.4.19/include/linux/modules/zorro.ver.tmp
In file included from zorro.c:17:
/usr/src/linux-2.4.19/include/linux/zorro.h:158: asm/zorro.h: No such file or
 directory
zorro.c:20: asm/amigahw.h: No such file or directory
mv /usr/src/linux-2.4.19/include/linux/modules/zorro.ver.tmp
 /usr/src/linux-2.4.19/include/linux/modules/zorro.ver
/usr/src/linux-2.4.19/scripts/mkdep -D__KERNEL__
 -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2
 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe
 -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4
 -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.2/include -- gen-devlist.c
 names.c proc.c zorro.c > .depend
make[4]: Leaving directory `/usr/src/linux-2.4.19/drivers/zorro'


*init/do_mounts.c:980: warning: `crd_load' defined but not used
context:
. scripts/mkversion > .tmpversion
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4   -DUTS_MACHINE='"i386"' -DKBUILD_BASENAME=version -c -o init/version.o init/version.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -DKBUILD_BASENAME=do_mounts -c -o init/do_mounts.o init/do_mounts.c
init/do_mounts.c:980: warning: `crd_load' defined but not used
make CFLAGS="-D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
-fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  " -C  kernel
make[1]: Entering directory `/usr/src/linux-2.4.19/kernel'
make all_targets


*agpgart_be.c: In function `agp_generic_agp_enable':
*agpgart_be.c:400: warning: unused variable `cap_id'
*agpgart_be.c: In function `agp_find_supported_device':
*agpgart_be.c:4298: warning: unused variable `scratch'
*agpgart_be.c:4298: warning: unused variable `cap_id'
context:
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.2/include -DKBUILD_BASENAME=agpgart_fe  -c -o agpgart_fe.o agpgart_fe.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.2/include -DKBUILD_BASENAME=agpgart_be  -DEXPORT_SYMTAB -c agpgart_be.c
agpgart_be.c: In function `agp_generic_agp_enable':
agpgart_be.c:400: warning: unused variable `cap_id'
agpgart_be.c: In function `agp_find_supported_device':
agpgart_be.c:4298: warning: unused variable `scratch'
agpgart_be.c:4298: warning: unused variable `cap_id'
ld -m elf_i386  -r -o agpgart.o agpgart_fe.o agpgart_be.o
rm -f agp.o


*ppp_generic.c: In function `ppp_read':
*ppp_generic.c:381: warning: `ret' might be used uninitialized in this function
context:
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.2/include -DKBUILD_BASENAME=loopback  -c -o loopback.o loopback.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.2/include -DKBUILD_BASENAME=ppp_generic  -DEXPORT_SYMTAB -c ppp_generic.c
ppp_generic.c: In function `ppp_read':
ppp_generic.c:381: warning: `ret' might be used uninitialized in this function
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.2/include -DKBUILD_BASENAME=slhc  -DEXPORT_SYMTAB -c slhc.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.2/include -DKBUILD_BASENAME=ppp_synctty  -c -o ppp_synctty.o ppp_synctty.c


*dnotify.c: In function `__inode_dir_notify':
*dnotify.c:139: warning: label `out' defined but not used
context:
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.2/include -DKBUILD_BASENAME=iobuf  -c -o iobuf.o iobuf.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.2/include -DKBUILD_BASENAME=dnotify  -c -o dnotify.o dnotify.c
dnotify.c: In function `__inode_dir_notify':
dnotify.c:139: warning: label `out' defined but not used
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.2/include -DKBUILD_BASENAME=filesystems  -DEXPORT_SYMTAB -c filesystems.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.2/include -DKBUILD_BASENAME=namespace  -c -o namespace.o namespace.c


*namespace.c: In function `mnt_init':
*namespace.c:1093: warning: implicit declaration of function `init_rootfs'
context:
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.2/include -DKBUILD_BASENAME=filesystems  -DEXPORT_SYMTAB -c filesystems.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.2/include -DKBUILD_BASENAME=namespace  -c -o namespace.o namespace.c
namespace.c: In function `mnt_init':
namespace.c:1093: warning: implicit declaration of function `init_rootfs'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.2/include -DKBUILD_BASENAME=seq_file  -c -o seq_file.o seq_file.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.2/include -DKBUILD_BASENAME=noquot  -c -o noquot.o noquot.c


*setup.c: In function `amd_adv_spec_cache_feature':
*setup.c:751: warning: implicit declaration of function `have_cpuid_p'
*setup.c: At top level:
*setup.c:2629: warning: `have_cpuid_p' was declared implicitly `extern' and later `static'
*setup.c:751: warning: previous declaration of `have_cpuid_p'
context:
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.2/include -DKBUILD_BASENAME=ldt  -c -o ldt.o ldt.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.2/include -DKBUILD_BASENAME=setup  -c -o setup.o setup.c
setup.c: In function `amd_adv_spec_cache_feature':
setup.c:751: warning: implicit declaration of function `have_cpuid_p'
setup.c: At top level:
setup.c:2629: warning: `have_cpuid_p' was declared implicitly `extern' and later `static'
setup.c:751: warning: previous declaration of `have_cpuid_p'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.2/include -DKBUILD_BASENAME=time  -c -o time.o time.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.2/include -DKBUILD_BASENAME=sys_i386  -c -o sys_i386.o sys_i386.c


*dmi_scan.c:196: warning: `disable_ide_dma' defined but not used
context:
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.2/include -DKBUILD_BASENAME=i387  -c -o i387.o i387.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.2/include -DKBUILD_BASENAME=bluesmoke  -c -o bluesmoke.o bluesmoke.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.2/include -DKBUILD_BASENAME=dmi_scan  -c -o dmi_scan.o dmi_scan.c
dmi_scan.c:196: warning: `disable_ide_dma' defined but not used
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.2/include -DKBUILD_BASENAME=pci_i386  -c -o pci-i386.o pci-i386.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.2/include -DKBUILD_BASENAME=pci_pc  -c -o pci-pc.o pci-pc.c


*{standard input}: Assembler messages:
*{standard input}:1066: Warning: indirect lcall without `*'
*{standard input}:1151: Warning: indirect lcall without `*'
*{standard input}:1238: Warning: indirect lcall without `*'
*{standard input}:1310: Warning: indirect lcall without `*'
*{standard input}:1321: Warning: indirect lcall without `*'
*{standard input}:1332: Warning: indirect lcall without `*'
*{standard input}:1409: Warning: indirect lcall without `*'
*{standard input}:1421: Warning: indirect lcall without `*'
*{standard input}:1433: Warning: indirect lcall without `*'
*{standard input}:1913: Warning: indirect lcall without `*'
*{standard input}:2017: Warning: indirect lcall without `*'
context:
dmi_scan.c:196: warning: `disable_ide_dma' defined but not used
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.2/include -DKBUILD_BASENAME=pci_i386  -c -o pci-i386.o pci-i386.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.2/include -DKBUILD_BASENAME=pci_pc  -c -o pci-pc.o pci-pc.c
{standard input}: Assembler messages:
{standard input}:1066: Warning: indirect lcall without `*'
{standard input}:1151: Warning: indirect lcall without `*'
{standard input}:1238: Warning: indirect lcall without `*'
{standard input}:1310: Warning: indirect lcall without `*'
{standard input}:1321: Warning: indirect lcall without `*'
{standard input}:1332: Warning: indirect lcall without `*'
{standard input}:1409: Warning: indirect lcall without `*'
{standard input}:1421: Warning: indirect lcall without `*'
{standard input}:1433: Warning: indirect lcall without `*'
{standard input}:1913: Warning: indirect lcall without `*'
{standard input}:2017: Warning: indirect lcall without `*'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.2/include -DKBUILD_BASENAME=pci_irq  -c -o pci-irq.o pci-irq.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.2/include -DKBUILD_BASENAME=mtrr  -DEXPORT_SYMTAB -c mtrr.c


*{standard input}: Assembler messages:
*{standard input}:237: Warning: indirect lcall without `*'
*{standard input}:331: Warning: indirect lcall without `*'
context:
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.2/include -DKBUILD_BASENAME=mtrr  -DEXPORT_SYMTAB -c mtrr.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.2/include -DKBUILD_BASENAME=msr  -DEXPORT_SYMTAB -c msr.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.2/include -DKBUILD_BASENAME=apm  -c -o apm.o apm.c
{standard input}: Assembler messages:
{standard input}:237: Warning: indirect lcall without `*'
{standard input}:331: Warning: indirect lcall without `*'
rm -f kernel.o
ld -m elf_i386  -r -o kernel.o process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o pci-dma.o i386_ksyms.o i387.o bluesmoke.o dmi_scan.o pci-i386.o pci-pc.o pci-irq.o mtrr.o msr.o apm.o
gcc -D__ASSEMBLY__ -D__KERNEL__ -I/usr/src/linux-2.4.19/include -traditional -c head.S -o head.o
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.2/include -DKBUILD_BASENAME=init_task  -c -o init_task.o init_task.c
make[1]: Leaving directory `/usr/src/linux-2.4.19/arch/i386/kernel'


*bbootsect.s: Assembler messages:
*bbootsect.s:257: Warning: indirect lcall without `*'
context:
make[1]: Entering directory `/usr/src/linux-2.4.19/arch/i386/boot'
gcc -E -D__KERNEL__ -I/usr/src/linux-2.4.19/include -D__BIG_KERNEL__ -traditional -DSVGA_MODE=NORMAL_VGA  bootsect.S -o bbootsect.s
as -o bbootsect.o bbootsect.s
bbootsect.s: Assembler messages:
bbootsect.s:257: Warning: indirect lcall without `*'
ld -m elf_i386 -Ttext 0x0 -s --oformat binary bbootsect.o -o bbootsect
gcc -E -D__KERNEL__ -I/usr/src/linux-2.4.19/include -D__BIG_KERNEL__ -D__ASSEMBLY__ -traditional -DSVGA_MODE=NORMAL_VGA  setup.S -o bsetup.s
as -o bsetup.o bsetup.s


*bsetup.s: Assembler messages:
*bsetup.s:1537: Warning: Value 0x37ffffff truncated to 0x37ffffff.
*bsetup.s:1927: Warning: indirect lcall without `*'
This one I dearly love ( number truncated to itself? ):
ld -m elf_i386 -Ttext 0x0 -s --oformat binary bbootsect.o -o bbootsect
gcc -E -D__KERNEL__ -I/usr/src/linux-2.4.19/include -D__BIG_KERNEL__ -D__ASSEMBLY__ -traditional -DSVGA_MODE=NORMAL_VGA  setup.S -o bsetup.s
as -o bsetup.o bsetup.s
bsetup.s: Assembler messages:
bsetup.s:1537: Warning: Value 0x37ffffff truncated to 0x37ffffff.
bsetup.s:1927: Warning: indirect lcall without `*'
ld -m elf_i386 -Ttext 0x0 -s --oformat binary -e begtext -o bsetup bsetup.o
make[2]: Entering directory `/usr/src/linux-2.4.19/arch/i386/boot/compressed'


*Boot sector 512 bytes.
*Setup is 4778 bytes.
*System is 1023 kB
*warning: kernel is too big for standalone boot from floppy
next is the "modules" section of the compile. . .

*awe_wave.c:4794: warning: initialization from incompatible pointer type
context:
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -DMODULE -DMODVERSIONS -include
/usr/src/linux-2.4.19/include/linux/modversions.h  -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.2/include -DKBUILD_BASENAME=opl3  -DEXPORT_SYMTAB -c opl3.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -DMODULE -DMODVERSIONS -include
/usr/src/linux-2.4.19/include/linux/modversions.h  -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.2/include -DKBUILD_BASENAME=v_midi  -c -o v_midi.o v_midi.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -DMODULE -DMODVERSIONS -include
/usr/src/linux-2.4.19/include/linux/modversions.h  -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.2/include -DKBUILD_BASENAME=awe_wave  -c -o awe_wave.o awe_wave.c
awe_wave.c:4794: warning: initialization from incompatible pointer type
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -DMODULE -DMODVERSIONS -include
/usr/src/linux-2.4.19/include/linux/modversions.h  -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.2/include -DKBUILD_BASENAME=es1371  -c -o es1371.o es1371.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -DMODULE -DMODVERSIONS -include
/usr/src/linux-2.4.19/include/linux/modversions.h  -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.2/include -DKBUILD_BASENAME=ac97_codec  -DEXPORT_SYMTAB -c ac97_codec.c


*ip_nat_core.c:205: warning: `do_extra_mangle' defined but not used
context:
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -DMODULE -DMODVERSIONS -include
/usr/src/linux-2.4.19/include/linux/modversions.h  -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.2/include -DKBUILD_BASENAME=ip_nat_rule  -c -o ip_nat_rule.o ip_nat_rule.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -DMODULE -DMODVERSIONS -include
/usr/src/linux-2.4.19/include/linux/modversions.h  -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.2/include -DKBUILD_BASENAME=ip_nat_helper  -c -o ip_nat_helper.o ip_nat_helper.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -DMODULE -DMODVERSIONS -include
/usr/src/linux-2.4.19/include/linux/modversions.h  -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.2/include -DKBUILD_BASENAME=ip_nat_core  -c -o ip_nat_core.o ip_nat_core.c
ip_nat_core.c:205: warning: `do_extra_mangle' defined but not used
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -DMODULE -DMODVERSIONS -include
/usr/src/linux-2.4.19/include/linux/modversions.h  -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.2/include -DKBUILD_BASENAME=ip_nat_proto_unknown  -c -o ip_nat_proto_unknown.o ip_nat_proto_unknown.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.19/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -DMODULE -DMODVERSIONS -include
/usr/src/linux-2.4.19/include/linux/modversions.h  -nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.2/include -DKBUILD_BASENAME=ip_nat_proto_tcp  -c -o ip_nat_proto_tcp.o ip_nat_proto_tcp.c
