Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267241AbTBXPoC>; Mon, 24 Feb 2003 10:44:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267243AbTBXPoC>; Mon, 24 Feb 2003 10:44:02 -0500
Received: from franka.aracnet.com ([216.99.193.44]:21465 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267241AbTBXPoA>; Mon, 24 Feb 2003 10:44:00 -0500
Date: Mon, 24 Feb 2003 07:54:09 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 398] New: OSS: Error compiling ad1848 
Message-ID: <7790000.1046102049@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=398

           Summary: OSS: Error compiling ad1848
    Kernel Version: 2.5.62-bk7
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: bwindle-kbt@fint.org


Distribution: Debian Testing
Hardware Environment: x86
Software Environment:

Linux razor 2.5.62bk4 #6 Fri Feb 21 11:47:01 EST 2003 i686 Pentium II
(Klamath)  GenuineIntel GNU/Linux

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
module-init-tools      implemented
e2fsprogs              1.30-WIP
reiserfsprogs          3.6.3
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.2

CONFIG_SOUND_GAMEPORT=y
CONFIG_SOUND=y
CONFIG_SOUND_PRIME=y
CONFIG_SOUND_OSS=y
CONFIG_SOUND_CS4232=y


Problem Description:

  gcc -Wp,-MD,sound/oss/.cs4232.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-
prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -
mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -
nostdinc -iwithprefix include    -DKBUILD_BASENAME=cs4232 -
DKBUILD_MODNAME=cs4232 -c -o sound/oss/cs4232.o sound/oss/cs4232.c
sound/oss/cs4232.c:327: warning: `synthirq' defined but not used
  gcc -Wp,-MD,sound/oss/.ad1848.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-
prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -
mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -
nostdinc -iwithprefix include    -DKBUILD_BASENAME=ad1848 -
DKBUILD_MODNAME=ad1848 -c -o sound/oss/ad1848.o sound/oss/ad1848.c
sound/oss/ad1848.c: In function `activate_dev':
sound/oss/ad1848.c:2990: too many arguments to function `pnp_activate_dev'
sound/oss/ad1848.c: In function `ad1848_isapnp_init':
sound/oss/ad1848.c:3027: structure has no member named `name'
sound/oss/ad1848.c:3027: structure has no member named `name'
sound/oss/ad1848.c: At top level:
sound/oss/ad1848.c:2966: warning: `id_table' defined but not used
make[2]: *** [sound/oss/ad1848.o] Error 1
make[1]: *** [sound/oss] Error 2
make: *** [sound] Error 2



Steps to reproduce:
This problem was not present in 2.5.62-bk4. (I skipped from bk4 to bk7).

