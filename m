Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131724AbRDMQdy>; Fri, 13 Apr 2001 12:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131730AbRDMQdf>; Fri, 13 Apr 2001 12:33:35 -0400
Received: from www.topmail.de ([212.255.16.226]:30661 "HELO www.topmail.de")
	by vger.kernel.org with SMTP id <S131724AbRDMQdb>;
	Fri, 13 Apr 2001 12:33:31 -0400
From: mirabilos <eccesys@topmail.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: linux 2.4.3-ac5
Content-type: text/plain; charset=ISO_646.irv:1991
X-Mailer: telnet
Message-Id: <20010413162928.1B3DA46E396@www.topmail.de>
Date: Fri, 13 Apr 2001 18:29:28 +0200 (MET DST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear kernel gurus,
I cannot compile since -ac4 or -ac5 with same config, but it is _not_ related
to the problems reported earlier (rwsem and OLD_GCC).
It is a rwsem problem though, but look:

--8x---snip
gcc -D__KERNEL__ -I/glc/build/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686    -DEXPORT_SYMTAB -c sys.c
sys.c: In function `sys_gethostname':
/glc/build/linux/include/asm/rwsem-xadd.h:153: inconsistent operand constraints in an `asm'
make[2]: *** [sys.o] Error 1
make[2]: Leaving directory `/glc/build/linux/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/glc/build/linux/kernel'
make: *** [_dir_kernel] Error 2
--8x---snap

Now ver_linux:
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
Net-tools              1.52
Kbd                    0.99
Sh-utils               1.16
Modules Loaded
--8x---snap

The -ac3 is the kernel I am actually running which I updated to -ac5
by bzimage.org.
GCC is snapshot from 08.04.2001.

Thanks in advance,
-mirabilos
