Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315748AbSIAGIk>; Sun, 1 Sep 2002 02:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315762AbSIAGIk>; Sun, 1 Sep 2002 02:08:40 -0400
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:4248 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S315748AbSIAGIg>; Sun, 1 Sep 2002 02:08:36 -0400
Subject: 2.5.33 -- make[1]: *** [char] Segmentation fault (core dumped)
From: Miles Lane <miles.lane@attbi.com>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1030858641.14260.46.camel@agate.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 31 Aug 2002 22:37:25 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have included output from make, strace -f -F -v -q make, 
ver_linux and the Char section of .config.  I hope this
will be sufficient.  I don't see anything in the output
that makes it clear what is crashing and why. 

make[2]: Entering directory `/usr/src/linux/drivers/char'
  gcc -Wp,-MD,./.mem.o.d -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -nostdinc -iwithprefix include    -DKBUILD_BASENAME=mem   -c -o mem.o mem.c
(and so on)
  gcc -Wp,-MD,./.consolemap.o.d -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -nostdinc -iwithprefix include    -DKBUILD_BASENAME=consolemap   -c -o consolemap.o consolemap.c
make[1]: *** [char] Segmentation fault (core dumped)
make[1]: Leaving directory `/usr/src/linux/drivers'

# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_CS=y
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=y

Linux agate 2.4.20-pre5 #4 Sat Aug 31 01:18:12 PDT 2002 i686 unknown
 
Gnu C                  2.95.3
Gnu make               3.78.1
binutils               2.11.2
util-linux             2.10f
mount                  2.10r
modutils               2.4.6
e2fsprogs              1.18
pcmcia-cs              3.2.1
PPP                    2.4.1
Linux C Library        2.1.3
Dynamic linker (ldd)   2.1.3
Linux C++ Library      3.0.0
Procps                 2.0.6
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         soundcore orinoco_cs orinoco hermes vfat fat

[pid 24029] brk(0x80f0000)              = 0x80f0000
[pid 24029] stat64(0x80742a0, 0xbfffda00) = 0
[pid 24029] stat64(0x8078c40, 0xbfffda2c) = -1 ENOENT (No such file or
directory)
[pid 24029] stat64(0x80c8a28, 0xbfffd9a0) = -1 ENOENT (No such file or
directory)
[pid 24029] stat64(0x80b8048, 0xbfffd914) = 0
[pid 24029] --- SIGSEGV (Segmentation fault) ---
[pid 24000] <... wait4 resumed> [WIFSIGNALED(s) && WTERMSIG(s) ==
SIGSEGV && WCOREDUMP(s)], 0, NULL) = 24029
[pid 24000] --- SIGCHLD (Child exited) ---
[pid 24000] sigreturn()                 = ? (mask now [])
[pid 24000] uname({sysname="Linux", nodename="agate",
release="2.4.20-pre5", version="#4 Sat Aug 31 01:18:12 PDT 2002",
machine="i686"}) = 0
[pid 24000] open("/usr/share/locale/locale.alias", O_RDONLY) = 4
[pid 24000] fstat64(0x4, 0xbfff962c)    = 0
[pid 24000] old_mmap(NULL, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40016000
[pid 24000] read(4, "# Locale name alias data base.\n#"..., 4096) = 2265
[pid 24000] brk(0x807d000)              = 0x807d000
[pid 24000] read(4, "", 4096)           = 0
[pid 24000] close(4)                    = 0
[pid 24000] munmap(0x40016000, 4096)    = 0
[pid 24000] open("/usr/share/i18n/locale.alias", O_RDONLY) = -1 ENOENT
(No such file or directory)
[pid 24000] open("/usr/share/locale/en_US/LC_MESSAGES/libc.mo",
O_RDONLY) = -1 ENOENT (No such file or directory)
[pid 24000] open("/usr/share/locale/en/LC_MESSAGES/libc.mo", O_RDONLY) =
-1 ENOENT (No such file or directory)
[pid 24000] write(2, "make[1]: ", 9make[1]: )    = 9
[pid 24000] write(2, "*** [char] Segmentation fault (c"..., 43*** [char]
Segmentation fault (core dumped)) = 43



