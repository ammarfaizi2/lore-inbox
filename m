Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273213AbRJ0Qvt>; Sat, 27 Oct 2001 12:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273269AbRJ0Qvi>; Sat, 27 Oct 2001 12:51:38 -0400
Received: from pop3.telenet-ops.be ([195.130.132.40]:748 "EHLO
	pop3.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S273213AbRJ0QvW>; Sat, 27 Oct 2001 12:51:22 -0400
Date: Sat, 27 Oct 2001 18:51:58 +0200
From: Sven Vermeulen <sven.vermeulen@rug.ac.be>
To: Linux-Kernel Development Mailinglist 
	<linux-kernel@vger.kernel.org>
Subject: 2.4.14-pre3: some compilerwarnings...
Message-ID: <20011027185158.A5848@Zenith.starcenter>
Mail-Followup-To: Linux-Kernel Development Mailinglist <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.4.13
X-Telephone: +32 486 460306
X-Requested: Beautiful, smart and Linux-lovin' girlfriend
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A little grep on the stdout/stderr of "make bzImage":

gcc -D__KERNEL__ -I/home/nitro/src/linux-2.4.13/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6    -c -o fork.o fork.c
gcc -D__KERNEL__ -I/home/nitro/src/linux-2.4.13/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6    -c -o exec_domain.o exec_domain.c
exec_domain.c: In function `lookup_exec_domain':
exec_domain.c:80: warning: unused variable `buffer'
--
gcc -D__KERNEL__ -I/home/nitro/src/linux-2.4.13/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6    -c -o misc.o misc.c
gcc -D__KERNEL__ -I/home/nitro/src/linux-2.4.13/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6    -c -o random.o random.c
random.c: In function `xfer_secondary_pool':
random.c:1248: warning: comparison of distinct pointer types lacks a cast
--
gcc -D__KERNEL__ -I/home/nitro/src/linux-2.4.13/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6    -c -o procfs.o procfs.c
ld -m elf_i386 -r -o parport.o share.o ieee1284.o ieee1284_ops.o init.o procfs.o
gcc -D__KERNEL__ -I/home/nitro/src/linux-2.4.13/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6    -c -o parport_pc.o parport_pc.c
parport_pc.c:94: warning: `verbose_probing' defined but not used
parport_pc.c:2007: warning: `parport_ECP_supported' defined but not used
--
gcc -D__KERNEL__ -I/home/nitro/src/linux-2.4.13/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6    -c -o buffer.o buffer.c
gcc -D__KERNEL__ -I/home/nitro/src/linux-2.4.13/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6    -c -o super.o super.c
super.c: In function `mount_root':
super.c:1064: warning: label `attach_it' defined but not used
--
gcc -D__KERNEL__ -I/home/nitro/src/linux-2.4.13/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6    -c -o i387.o i387.c
gcc -D__KERNEL__ -I/home/nitro/src/linux-2.4.13/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6    -c -o bluesmoke.o bluesmoke.c
gcc -D__KERNEL__ -I/home/nitro/src/linux-2.4.13/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6    -c -o dmi_scan.o dmi_scan.c
dmi_scan.c:194: warning: `disable_ide_dma' defined but not used
--

I have no problems believing that some (most) of them are due to my .config,
but, as I said before, I *hate* warnings :)

-- 
You might as well skip the Xmas celebration completely, and instead
sit in front of your Linux computer playing with the 
all-new-and-improved Linux kernel version. ~(Linus Torvalds)

