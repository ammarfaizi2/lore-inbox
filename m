Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315783AbSGNLHv>; Sun, 14 Jul 2002 07:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315784AbSGNLHu>; Sun, 14 Jul 2002 07:07:50 -0400
Received: from moutvdomng0.kundenserver.de ([195.20.224.130]:50405 "EHLO
	moutvdomng0.schlund.de") by vger.kernel.org with ESMTP
	id <S315783AbSGNLHt>; Sun, 14 Jul 2002 07:07:49 -0400
Date: Sun, 14 Jul 2002 13:11:53 +0200
From: Heinz Diehl <hd@cavy.de>
To: Dave Jones <davej@suse.de>
Cc: benc@hawaga.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.25-dj2
Message-ID: <20020714111153.GA4692@chiara.cavy.de>
Mail-Followup-To: Dave Jones <davej@suse.de>, benc@hawaga.org.uk,
	linux-kernel@vger.kernel.org
References: <20020713172627.GA5606@chiara.cavy.de> <Pine.LNX.4.44.0207131046510.5808-100000@barbarella.hawaga.org.uk> <20020714115525.C28859@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020714115525.C28859@suse.de>
Organization: private site in Mannheim/Germany
X-PGP-Key: Use PGP! Get my key at http://www.cavy.de/hd.key
User-Agent: Mutt/1.5.1i (Linux 2.4.19-rc1-ac3 i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Jul 14 2002, Dave Jones wrote:

>  > >   ide-scsi24.c:847: unknown field abort' specified in initializer
>  > >   ide-scsi24.c:847: warning: initialization from incompatible pointer type
>  > >   ide-scsi24.c:848: unknown field reset' specified in initializer
>  > >   ide-scsi24.c:848: warning: initialization from incompatible pointer type
 
> Just kill those lines.

This leads to:

make[2]: Entering directory /usr/src/linux/init'
Generating /usr/src/linux/include/linux/compile.h (updated)
gcc -Wp,-MD,./.version.o.d -D__KERNEL__ -I/usr/src/linux/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
-fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2
-march=k6 -nostdinc -iwithprefix include    -DKBUILD_BASENAME=version
-c -o version.o version.c
ld -m elf_i386  -r -o init.o main.o version.o do_mounts.o
make[2]: Leaving directory /usr/src/linux/init'
ld -m elf_i386 -T arch/i386/vmlinux.lds -e stext
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/init.o
--start-group arch/i386/kernel/kernel.o arch/i386/mm/mm.o
kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o
/usr/src/linux/arch/i386/lib/lib.a lib/lib.a
/usr/src/linux/arch/i386/lib/lib.a drivers/built-in.o
sound/sound.o arch/i386/pci/pci.o net/network.o --end-group -o vmlinux
fs/fs.o: In function proc_pid_stat':
fs/fs.o(.text+0x21a29): undefined reference to __udivdi3'
fs/fs.o: In function kstat_read_proc':
fs/fs.o(.text+0x22a7b): undefined reference to __udivdi3'
fs/fs.o(.text+0x22b11): undefined reference to __udivdi3'
make[1]: *** [vmlinux] Error 1
make[1]: Leaving directory /usr/src/linux'
make: *** [bzImage] Error 2
chiara:/usr/src/linux #
	 
-- 
# Heinz Diehl, 68259 Mannheim, Germany
