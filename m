Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132552AbRDNVNv>; Sat, 14 Apr 2001 17:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132551AbRDNVNk>; Sat, 14 Apr 2001 17:13:40 -0400
Received: from www.topmail.de ([212.255.16.226]:17116 "HELO www.topmail.de")
	by vger.kernel.org with SMTP id <S132548AbRDNVN3>;
	Sat, 14 Apr 2001 17:13:29 -0400
From: Thorsten Glaser Geuer <eccesys@topmail.de>
To: linux-kernel@vger.kernel.org
X-Mailer: Linux telnet
Subject: Still cannot compile, 2.4.3-ac6
Date: 14 Apr 2001 21:09 UTC
Message-Id: <20010414210834.4D195A5A843@www.topmail.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Sirs,
I still cannot compile with gcc-3.0 from 08.04.
Yesterday I tried -ac5 (same problem reported
earlier) and using egcs-2.91.66 for _only_
the peoblematic files (sys.c exec.c binfmt_elf.c
and two others which I dont remember) but the
kernel could not boot.

Now I get:
gcc -D__KERNEL__ -I/glc/build/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686    -DEXPORT_SYMTAB -c signal.c
gcc -D__KERNEL__ -I/glc/build/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686    -DEXPORT_SYMTAB -c sys.c
sys.c: In function `sys_gethostname':
/glc/build/linux/include/asm/rwsem-xadd.h:153: inconsistent operand constraints in an `asm'
make[2]: *** [sys.o] Error 1
make[2]: Leaving directory `/glc/build/linux/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/glc/build/linux/kernel'
make: *** [_dir_kernel] Error 2
ecce:/usr/src/linux #

And ver_linux reports:
ecce:/usr/src/linux # sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux ecce.homeip.net 2.4.3-ac3 #3 Sun Apr 8 22:06:09 /etc/localtime 2001 i686 unknown

Gnu C                  3.0
Gnu make               3.77
binutils               2.10.0.33
util-linux             2.11a
mount                  2.11a
modutils               2.4.5
e2fsprogs              1.19
reiserfsprogs          3.x.0j
PPP                    2.4.1b2
Linux C Library        x   1 root     root      1248080 Apr  8 21:14 /lib/libc.so.6
Dynamic linker (ldd)   2.2
Procps                 1.2.11
Net-tools              1.59
Kbd                    0.99
Sh-utils               1.16
Modules Loaded
ecce:/usr/src/linux #

LIBC6 is originally from SuSE 6.2 but I updated with the one from SuSE 7.1
manually (I think I have both here?? will recompile soon glibc-2.2.2)

If any of you could help me, thanks in advance.
The problem _did_ _not_ exist with same gcc-3 and 2.4.3-ac3.
It doesn't vanish when I get the full patches, not the interdiffs.

-mirabilos
