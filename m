Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131841AbQKTObP>; Mon, 20 Nov 2000 09:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131844AbQKTObF>; Mon, 20 Nov 2000 09:31:05 -0500
Received: from smtp02.mrf.mail.rcn.net ([207.172.4.61]:32230 "EHLO
	smtp02.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S131841AbQKTOax>; Mon, 20 Nov 2000 09:30:53 -0500
Date: Mon, 20 Nov 2000 09:00:47 -0500 (EST)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: "Charles Turner, Ph.D." <cturner@quark.analogic.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Defective Red Hat Distribution poorly represents Linux
In-Reply-To: <Pine.LNX.3.95.1001120084920.580A-100000@quark.analogic.com>
Message-ID: <Pine.LNX.4.30.0011200900310.4887-100000@viper.haque.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You're complaining on the wrong list.


On Mon, 20 Nov 2000, Charles Turner, Ph.D. wrote:

>
> I tried to help a friend this weekend convert to Linux.
> He lives in Upstate New York, so it was a long trip from
> Cambridge, Massachusetts.
>
> He has a Dual Pentium III, 600 MHz TYAN "Thunderbolt".
> It has a built-in Adaptec SCSI controller and Intel
> 100-base-T Ethernet controller. It also has 1/2 Gbytes
> of RAM. It's a superb machine.
>
> It had been running Windows 2000 "Professional". Several months
> ago, he purchased Red Hat "DELUXE" version 6.2. He was unable to
> install it. I convinced him that installation was easy.
>
> I was terribly wrong. This Red Hat version is irrevocably defective.
>
> (1)	It will not create a bootable disk because it forgets
> 	to load scsi_mod.o, and sd_mod.o  before it loads
> 	aic7xxx.o
> 	/etc/conf.modules was found to contain only aic7xxx
> 	as an alias for scsi_hostadapter.
>
> (2)	Once I made a bootable diskette from a working machine
> 	at home (200 miles round-trip distance), I was able to
> 	install its supplied kernel version 2.2.14-5.0, and
> 	2.2.14-5.0smp into the LILO boot sequence.
>
> (3)	It "sort of" worked. However, network daemons kept
> 	dropping core. X would eventually crash, leaving the
> 	terminal in an unusable state, etc.
>
> (4)	It is impossible to build a known working kernel on the
> 	machine because the linker, `ld` crashes:
>
> Script started on Sun Nov 19 19:11:55 2000
> [root@merrimac linux-2.2.17]# make dep
> gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o scripts/mkdep scripts/mkdep.c
> collect2: ld terminated with signal 11 [Segmentation fault], core dumped
> make: *** [scripts/mkdep] Error 1
> [root@merrimac linux-2.2.17]# ld --version
> GNU ld 2.9.5
> Copyright 1997 Free Software Foundation, Inc.
> This program is free software; you may redistribute it under the terms of
> the GNU General Public License.  This program has absolutely no warranty.
>   Supported emulations:
>    elf_i386
>    i386linux
> [root@merrimac linux-2.2.17]# cd scripts
> [root@merrimac scripts]# gcc -o mkdep.o mkdep.c
> collect2: ld terminated with signal 11 [Segmentation fault], core dumped
> [root@merrimac scripts]# gcc -c -o mkdep.o mkdep.c
> [root@merrimac scripts]# ld -o mkdep mkdep.o
> Segmentation fault (core dumped)
>
> [root@merrimac scripts]# strace ld -o mkdep mkdep.c
> execve("/usr/bin/ld", ["ld", "-o", "mkdep", "mkdep.o"], [/* 20 vars */]) = 0
> brk(0)                                  = 0x807bb84
> old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40014000
> open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
> open("/etc/ld.so.cache", O_RDONLY)      = 3
> fstat(3, {st_mode=S_IFREG|0644, st_size=16290, ...}) = 0
> old_mmap(NULL, 16290, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40015000
> close(3)                                = 0
> open("/usr/lib/libbfd-2.9.5.0.22.so", O_RDONLY) = 3
> fstat(3, {st_mode=S_IFREG|0755, st_size=314936, ...}) = 0
> read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\320\242"..., 4096) = 4096
> old_mmap(NULL, 279260, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40019000
> mprotect(0x40059000, 17116, PROT_NONE)  = 0
> old_mmap(0x40059000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x3f000) = 0x40059000
> old_mmap(0x4005d000, 732, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4005d000
> close(3)                                = 0
> open("/lib/libdl.so.2", O_RDONLY)       = 3
> fstat(3, {st_mode=S_IFREG|0755, st_size=75131, ...}) = 0
> read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\340\34"..., 4096) = 4096
> old_mmap(NULL, 12428, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4005e000
> mprotect(0x40060000, 4236, PROT_NONE)   = 0
> old_mmap(0x40060000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x1000) = 0x40060000
> close(3)                                = 0
> open("/lib/libc.so.6", O_RDONLY)        = 3
> fstat(3, {st_mode=S_IFREG|0755, st_size=4101324, ...}) = 0
> read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\210\212"..., 4096) = 4096
> old_mmap(NULL, 1001564, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40062000
> mprotect(0x4014f000, 30812, PROT_NONE)  = 0
> old_mmap(0x4014f000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0xec000) = 0x4014f000
> old_mmap(0x40153000, 14428, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40153000
> close(3)                                = 0
> mprotect(0x40062000, 970752, PROT_READ|PROT_WRITE) = 0
> mprotect(0x40062000, 970752, PROT_READ|PROT_EXEC) = 0
> munmap(0x40015000, 16290)               = 0
> personality(PER_LINUX)                  = 0
> getpid()                                = 763
> getrusage(RUSAGE_SELF, {ru_utime={0, 0}, ru_stime={0, 0}, ...}) = 0
> brk(0)                                  = 0x807bb84
> brk(0x807bbbc)                          = 0x807bbbc
> brk(0x807c000)                          = 0x807c000
> open("/usr/share/locale/locale.alias", O_RDONLY) = 3
> fstat64(0x3, 0xbfffb84c)                = -1 ENOSYS (Function not implemented)
> fstat(3, {st_mode=S_IFREG|0644, st_size=2265, ...}) = 0
> old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40015000
> read(3, "# Locale name alias data base.\n#"..., 4096) = 2265
> brk(0x807d000)                          = 0x807d000
> read(3, "", 4096)                       = 0
> close(3)                                = 0
> munmap(0x40015000, 4096)                = 0
> open("/usr/share/i18n/locale.alias", O_RDONLY) = -1 ENOENT (No such file or directory)
> open("/usr/share/locale/en_US/LC_MESSAGES", O_RDONLY) = 3
> fstat(3, {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
> close(3)                                = 0
> open("/usr/share/locale/en_US/LC_MESSAGES/SYS_LC_MESSAGES", O_RDONLY) = 3
> fstat(3, {st_mode=S_IFREG|0644, st_size=44, ...}) = 0
> old_mmap(NULL, 44, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40015000
> close(3)                                = 0
> stat("/usrusr/lib/ldscripts", 0xbffffa7c) = -1 ENOENT (No such file or directory)
> brk(0x807f000)                          = 0x807f000
> brk(0x8080000)                          = 0x8080000
> brk(0x8081000)                          = 0x8081000
> brk(0x8082000)                          = 0x8082000
> brk(0x8083000)                          = 0x8083000
> unlink("mkdep")                         = -1 ENOENT (No such file or directory)
> open("mkdep", O_WRONLY|O_CREAT|O_TRUNC, 0666) = 3
> brk(0x8084000)                          = 0x8084000
> brk(0x8088000)                          = 0x8088000
> brk(0x8089000)                          = 0x8089000
> brk(0x808a000)                          = 0x808a000
> open("mkdep.o", O_RDONLY)               = 4
> fstat(4, {st_mode=S_IFREG|0644, st_size=9716, ...}) = 0
> old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40016000
> _llseek(4, 0, [0], SEEK_SET)            = 0
> read(4, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\1\0\3\0\1\0\0\0\0\0\0\0"..., 4096) = 4096
> _llseek(4, 4096, [4096], SEEK_SET)      = 0
> _llseek(4, 4096, [4096], SEEK_SET)      = 0
> _llseek(4, 4096, [4096], SEEK_SET)      = 0
> _llseek(4, 4096, [4096], SEEK_SET)      = 0
> _llseek(4, 4096, [4096], SEEK_SET)      = 0
> _llseek(4, 4096, [4096], SEEK_SET)      = 0
> _llseek(4, 4096, [4096], SEEK_SET)      = 0
> _llseek(4, 4096, [4096], SEEK_SET)      = 0
> _llseek(4, 4096, [4096], SEEK_SET)      = 0
> _llseek(4, 4096, [4096], SEEK_SET)      = 0
> read(4, "E\364\215\24E\0\0\0\0\241\0\0\0\0f\213\24\20\203\342\10"..., 4096) = 4096
> _llseek(4, 8192, [8192], SEEK_SET)      = 0
> --- SIGSEGV (Segmentation fault) ---
> +++ killed by SIGSEGV +++
> [root@merrimac scripts]# exit
> exit
>
> Script done on Sun Nov 19 19:14:35 2000
>
> I can even see obvious bugs in the trace, i.e., :
>
> stat("/usrusr/lib/ldscripts", 0xbffffa7c) = -1 ENOENT (No such file or directory)
> ----------^^^
>
> Although this was not the reason for the seg-fault.
>
>
> (5)	I returned home (200 mile round trip), removed my
> 	SCSI disks from my home machine, and then returned
> 	and installed them in my friend's machine. The
> 	machine worked perfectly with Linux version 2.2.17,
> 	and gcc-2.7.2.3, Binutils-2.8.1.0, etc., the standard
> 	stuff.
>
> 	This shows that the problems are not because of a
> 	defective machine.
>
> 	I cloned my disks to his disks and, he's running.
> 	however, I don't have all the GUI stuff installed that
> 	he likes (needs).  My disks had been built up over
> 	over several years by Richard Johnson, a frequent
> 	contributor to Linux.
>
> (6)	I have been told that I could get a statically-linked
> 	version of `ld`, plus another 'C' compiler statically-
> 	linked so that these don't use the possibly defective
> 	dynamic libraries. I could then build a decent working
> 	system using sources available on the Internet.
>
> 	From a customer's perspective, this is absurd. When
> 	a customer purchases a "shrink-wrapped" operating
> 	system he expects it to work.
>
> (7)	This fiasco is an example of why Linux is in big trouble.
> 	Once Linux obtained visibility, it became necessary for
> 	the most visible distributors and VARs to provide a high
> 	quality product.
>
> 	Red Hat, provably does not. Red Hat employees dominate
> 	Linux kernel development, even moderating (read controlling)
> 	what will be and what will not be done within this operating
> 	system.
>
> 	As repeatably demonstrated on this list, Red Hat employees
> 	spend much time denigrating others at the expense of providing
> 	a useful product.
>
> (8)	Now I'm pretty sure that this email will generate a lot of
> 	flames. So be it. Linux, as an operating system to replace
> 	windows,  has gone to hell because of at least one distributor's
> 	selling of garbage. There may be more such defective distributions
> 	out there. I certainly don't know what to purchase for my
> 	next attempt at a "shrink-wrap" installation.
>
>
>    Very Truly Yours,
>
>    Charles Turner
>
> Member(s) IEEE, IEEE Computer Society, AIAA
>
>           I speak only for myself, which is enough of a problem.
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
