Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317639AbSIOCII>; Sat, 14 Sep 2002 22:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317641AbSIOCII>; Sat, 14 Sep 2002 22:08:08 -0400
Received: from 210-54-175-12.visp.co.nz ([210.54.175.12]:35079 "EHLO
	mdew.dyndns.org") by vger.kernel.org with ESMTP id <S317639AbSIOCIH>;
	Sat, 14 Sep 2002 22:08:07 -0400
Subject: Re: [ANNOUNCE] [PATCH] Linux-2.5.34-mcp4
From: mdew <mdew@mdew.dyndns.org>
To: mdew-pop3 <mdew@mdew.dyndns.org>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1032051401.10627.35.camel@mdew>
References: <200209102044.57514.m.c.p@gmx.net> 
	<1032051401.10627.35.camel@mdew>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 15 Sep 2002 14:09:23 +1200
Message-Id: <1032055763.10627.38.camel@mdew>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-09-15 at 12:56, mdew wrote:
> Just a compile error on -mcp4
> 
> make[2]: Entering directory `/usr/src/linux-2.5.34/fs/xfs'
>   gcc -Wp,-MD,./.xfs_dmapi.o.d -D__KERNEL__
> -I/usr/src/linux-2.5.34/include -Wall -Wstrict-prototypes -Wno-trigraphs
> -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe
> -mpreferred-stack-boundary=2 -march=i686 -nostdinc -iwithprefix include 
> -I. -funsigned-char  -DKBUILD_BASENAME=xfs_dmapi   -c -o xfs_dmapi.o
> xfs_dmapi.c
> xfs_dmapi.c: In function `prohibited_mr_events':
> xfs_dmapi.c:207: `list_t' undeclared (first use in this function)
> xfs_dmapi.c:207: (Each undeclared identifier is reported only once
> xfs_dmapi.c:207: for each function it appears in.)
> xfs_dmapi.c:207: `curr' undeclared (first use in this function)
> xfs_dmapi.c:207: `head' undeclared (first use in this function)
> xfs_dmapi.c:207: warning: left-hand operand of comma expression has no
> effect
> xfs_dmapi.c:219: warning: left-hand operand of comma expression has no
> effect
> xfs_dmapi.c:219: warning: left-hand operand of comma expression has no
> effect
> xfs_dmapi.c: At top level:
> xfs_log.h:62: warning: `_lsn_cmp' defined but not used
> make[2]: *** [xfs_dmapi.o] Error 1
> make[2]: Leaving directory `/usr/src/linux-2.5.34/fs/xfs'
> make[1]: *** [xfs] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.5.34/fs'
> make: *** [fs] Error 2


oh another compile problem :) disabled dmapi to continue...


make[1]: Leaving directory `/usr/src/linux-2.5.34/arch/i386/pci'
  gcc -E -Wp,-MD,arch/i386/.vmlinux.lds.s.d_ -D__ASSEMBLY__ -D__KERNEL__
-I/usr/src/linux-2.5.34/include -nostdinc -iwithprefix include   -P -C
-Ui386   -o arch/i386/vmlinux.lds.s arch/i386/vmlinux.lds.S 
echo '  Generating build number'
  Generating build number
. scripts/mkversion > .tmpversion
mv -f .tmpversion .version
make -C init
make[1]: Entering directory `/usr/src/linux-2.5.34/init'
  Generating /usr/src/linux-2.5.34/include/linux/compile.h (unchanged)
make[1]: Leaving directory `/usr/src/linux-2.5.34/init'
  ld -m elf_i386 -T arch/i386/vmlinux.lds.s -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/init.o
--start-group arch/i386/kernel/kernel.o arch/i386/mm/mm.o
kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o security/built-in.o
/usr/src/linux-2.5.34/arch/i386/lib/lib.a lib/lib.a
/usr/src/linux-2.5.34/arch/i386/lib/lib.a drivers/built-in.o
sound/sound.o arch/i386/pci/pci.o net/network.o --end-group  -o vmlinux
net/network.o: In function `match':
net/network.o(.text+0x3e785): undefined reference to `ip_conntrack_get'
net/network.o: In function `init':
net/network.o(.text.init+0x10fd): undefined reference to
`ip_conntrack_module'
make: *** [vmlinux] Error 1



