Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266271AbSKGBpn>; Wed, 6 Nov 2002 20:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266272AbSKGBpm>; Wed, 6 Nov 2002 20:45:42 -0500
Received: from pc2-colc1-6-cust11.col.cable.ntl.com ([62.254.117.11]:8459 "EHLO
	earth.dsh.org.uk") by vger.kernel.org with ESMTP id <S266271AbSKGBpi>;
	Wed, 6 Nov 2002 20:45:38 -0500
Date: Thu, 7 Nov 2002 01:59:21 +0000
From: Ian Norton <bredroll@atari.org>
To: linux-kernel@vger.kernel.org
Subject: bug report - 2.4.18 only compile with smp on
Message-ID: <20021107015921.A29498@earth.dsh.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

[1.] with 'CONFIG_SMP' not set kernel will not compile,

[2.] current system is debian duron (k7) 1200mhz, kernel will not compile with
SMP option set off, make dep works then actual compile fails with following:-

(apologies if this has been up before)

one note, the kernel running is the same one but with SMP enabled, 

<begin output from make bzImage > error.txt>

'
. scripts/mkversion > .tmpversion
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4   -DUTS_MACHINE='"i386"' -DKBUILD_BASENAME=version -c -o init/version.o init/version.c
make CFLAGS="-D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  " -C  kernel
make[1]: Entering directory `/usr/src/linux/kernel'
make all_targets
make[2]: Entering directory `/usr/src/linux/kernel'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -DKBUILD_BASENAME=ksyms  -DEXPORT_SYMTAB -c ksyms.c
make[2]: Leaving directory `/usr/src/linux/kernel'
make[1]: Leaving directory `/usr/src/linux/kernel'
'

<end output>

[3.] Non-SMP kernel compile failure

[4.] Linux version 2.4.18 (root@orion) (gcc version 2.95.4 20011002 (Debian prerelease)) #2 SMP Tue Nov 5 13:24:36 GMT 2002

[7.]
Version Script :-

Linux orion 2.4.18 #2 SMP Tue Nov 5 13:24:36 GMT 2002 i686 unknown unknown
GNU/Linux

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.19
e2fsprogs              1.27
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.12
Modules Loaded         sg visor usbserial ide-scsi ipv6 mod_quickcam
i2c-algo-bit es1370

-- end bug report --

Thanks folks :-)

Ian Norton-Badrul
