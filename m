Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318341AbSGRU5M>; Thu, 18 Jul 2002 16:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318346AbSGRU5M>; Thu, 18 Jul 2002 16:57:12 -0400
Received: from nemesis.systems.pipex.net ([62.190.223.8]:55236 "EHLO
	nemesis.systems.pipex.net") by vger.kernel.org with ESMTP
	id <S318341AbSGRU5K>; Thu, 18 Jul 2002 16:57:10 -0400
Subject: Compile failure: 2.4.19-rc2-ac2
From: Alastair Stevens <alastair@camlinux.co.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Jul 2002 22:00:04 +0100
Message-Id: <1027026004.13704.6.camel@dolphin.entropy.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan & others

Just a compile failure report for 2.4.19-rc2-ac2, hope it's useful. My
system is an ordinary Athlon XP running RH7.3, and I'm currently on
2.4.19-pre10-ac2. Using the same .config which I've been using for quite
some time, I got the following error, having done "make oldconfig dep
clean modules bzImage" from a pristine tree:

gcc -D__KERNEL__ -I/home/alastair/linux-2.4/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon   
-nostdinc -I /usr/lib/gcc-lib/i386-redhat-linux/2.96/include
-DKBUILD_BASENAME=pci_irq  -c -o pci-irq.o pci-irq.c
gcc -D__KERNEL__ -I/home/alastair/linux-2.4/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon   
-nostdinc -I /usr/lib/gcc-lib/i386-redhat-linux/2.96/include
-DKBUILD_BASENAME=mtrr  -DEXPORT_SYMTAB -c mtrr.c
gcc -D__KERNEL__ -I/home/alastair/linux-2.4/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon   
-nostdinc -I /usr/lib/gcc-lib/i386-redhat-linux/2.96/include
-DKBUILD_BASENAME=msr  -DEXPORT_SYMTAB -c msr.c
gcc -D__KERNEL__ -I/home/alastair/linux-2.4/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon   
-nostdinc -I /usr/lib/gcc-lib/i386-redhat-linux/2.96/include
-DKBUILD_BASENAME=cpuid  -DEXPORT_SYMTAB -c cpuid.c
gcc -D__KERNEL__ -I/home/alastair/linux-2.4/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon   
-nostdinc -I /usr/lib/gcc-lib/i386-redhat-linux/2.96/include
-DKBUILD_BASENAME=mpparse  -c -o mpparse.o mpparse.c
mpparse.c:74: `dest_LowestPrio' undeclared here (not in a function)
mpparse.c: In function `smp_read_mpc':
mpparse.c:609: `dest_Fixed' undeclared (first use in this function)
mpparse.c:609: (Each undeclared identifier is reported only once
mpparse.c:609: for each function it appears in.)
mpparse.c:609: `dest_LowestPrio' undeclared (first use in this function)
make[1]: *** [mpparse.o] Error 1
make[1]: Leaving directory `/home/alastair/linux-2.4/arch/i386/kernel'
make: *** [_dir_arch/i386/kernel] Error 2

Regards
Alastair

-- 
 \\ Alastair Stevens                        Cambridge
  \\ Technical Director                        /     \..-^..^...
   \\                                          |Linux solutions \
    \\ 01223 813774                            \     /........../
     \\ www.camlinux.co.uk                      '-=-'
      --

