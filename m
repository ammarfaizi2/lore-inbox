Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261540AbSJYSsH>; Fri, 25 Oct 2002 14:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261542AbSJYSsH>; Fri, 25 Oct 2002 14:48:07 -0400
Received: from fepC.post.tele.dk ([195.41.46.147]:63674 "EHLO
	fepC.post.tele.dk") by vger.kernel.org with ESMTP
	id <S261540AbSJYSsF>; Fri, 25 Oct 2002 14:48:05 -0400
Message-ID: <002f01c27c57$a3e8fef0$0b00a8c0@runner>
From: "Rune" <runner@mail.tele.dk>
To: "Martin J. Bligh" <mbligh@aracnet.com>, <linux-kernel@vger.kernel.org>
References: <20021025131349.GA25980@an.local> <2925311195.1035536802@[10.10.2.3]>
Subject: Re: 2.5.44-ac3 - don't compile.
Date: Fri, 25 Oct 2002 20:52:13 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mikael Pettersson"
Sent: Wednesday, October 23, 2002 1:43 PM
Subject: Re: [PATCH 2.5.44] compile error whit LOCAL_APIC disabled...


>
> Known bug in scripts/Configure when switching from an APIC-enabled to
> an APIC-disabled config. `make oldconfig' fixes it.


or just comment out in your ".config":
CONFIG_X86_EXTRA_IRQS
CONFIG_X86_FIND_SMP_CONFIG
CONFIG_X86_MPPARSE

Rune Petersen
----- Original Message -----
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Andrey Nekrasov" <andy@spylog.ru>; <linux-kernel@vger.kernel.org>
Sent: Friday, October 25, 2002 6:06 PM
Subject: Re: 2.5.44-ac3 - don't compile.


> Odd. I'm sure akpm fixed this in 44, unless -ac3 reverts it.
> Can you search back for posts by Andrew Morton, and find the
> fix, and try it?
>
> M.
>
> --On Friday, October 25, 2002 5:13 PM +0400 Andrey Nekrasov
<andy@spylog.ru> wrote:
>
> > Hello.
> >
> >
> >  x86, no SMP.
> >
> >
> > ...
> > make -f init/Makefile
> >   Generating init/../include/linux/compile.h (updated)
> >


gcc -Wp,-MD,init/.version.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototyp
es
> > -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe
> > -mpreferred-stack-boundary=2 -march=i686 -Iarch/i386/mach-generic
> > -fomit-frame-pointer -nostdinc -iwithprefix
lude    -DKBUILD_BASENAME=version
> > -c -o init/version.o init/version.c
> >    ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o
> > init/do_mounts.o
> >         ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s
arch/i386/kernel/head.o
> > arch/i386/kernel/init_task.o  init/built-in.o --start-group
> > arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o
> > arch/i386/mach-generic/built-in.o  kernel/built-in.o  mm/built-in.o
fs/built-in.o
> > ipc/built-in.o  security/built-in.o  lib/lib.a  arch/i386/lib/lib.a
> > drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o
net/built-in.o
> > --end-group  -o vmlinux
> > arch/i386/kernel/built-in.o: In function `MP_processor_info':
> > arch/i386/kernel/built-in.o(.init.text+0x46a3): undefined reference to
`Dprintk'
> > arch/i386/kernel/built-in.o(.init.text+0x46b6): undefined reference to
`Dprintk'
> > arch/i386/kernel/built-in.o(.init.text+0x46c9): undefined reference to
`Dprintk'
> > arch/i386/kernel/built-in.o(.init.text+0x46dc): undefined reference to
`Dprintk'
> > arch/i386/kernel/built-in.o(.init.text+0x46ef): undefined reference to
`Dprintk'
> > arch/i386/kernel/built-in.o(.init.text+0x4702): more undefined
references to
> > `Dprintk' follow
> > make: *** [vmlinux] Error 1
> > ...
> >
> > Why?
> >
> >
> >
> > --
> > bye.
> > Andrey Nekrasov, SpyLOG.
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> >
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

