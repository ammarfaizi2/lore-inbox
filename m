Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263937AbUAYK1o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 05:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263942AbUAYK1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 05:27:44 -0500
Received: from mxout.hispeed.ch ([62.2.95.247]:12210 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S263937AbUAYK1l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 05:27:41 -0500
From: Marco Rebsamen <mrebsamen@swissonline.ch>
To: linux-kernel@vger.kernel.org
Subject: Re: Troubles Compiling 2.6.1 on SuSE 9
Date: Sun, 25 Jan 2004 11:31:39 +0100
User-Agent: KMail/1.5.4
References: <200401242137.34881.mrebsamen@swissonline.ch>
In-Reply-To: <200401242137.34881.mrebsamen@swissonline.ch>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401251131.39665.mrebsamen@swissonline.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


no one knows the answer ? :(

Am Samstag, 24. Januar 2004 21:37 schrieb Marco Rebsamen:
> Hi there...
>
> I try to compile my own kernel with 2.6.1 on suse 9. But i always get the
> same error. i applied the patch 2.6.2-rc1 but wasn't helping.
>
> The error:
>
> ld -m elf_i386  -T arch/i386/kernel/vmlinux.lds.s arch/i386/kernel/head.o
> arch/i386/kernel/init_task.o   init/built-in.o --start-group 
> usr/built-in.o arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o 
> arch/i386/mach-default/ built-in.o  kernel/built-in.o  mm/built-in.o 
> fs/built-in.o  ipc/built-in.o security/built-in.o  crypto/built-in.o 
> lib/lib.a  arch/i386/lib/lib.a  lib/ built-in.o  arch/i386/lib/built-in.o 
> drivers/built-in.o  sound/built-in.o arch/i386/pci/built-in.o 
> arch/i386/power/built-in.o  net/built-in.o --end-group .tmp_kallsyms2.o -o
> vmlinux
> make -f scripts/Makefile.build obj=arch/i386/boot arch/i386/boot/bzImage
>   gcc -Wp,-MD,arch/i386/boot/.bootsect.o.d -nostdinc -iwithprefix include
> -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -D__ASSEMBLY__ -Iinclude/
> asm-i386/mach-default -traditional -DSVGA_MODE=NORMAL_VGA  -D__BIG_KERNEL__
> -c -o arch/i386/boot/bootsect.o arch/i386/boot/bootsect.S
>   ld -m elf_i386  -Ttext 0x0 -s --oformat binary arch/i386/boot/bootsect.o
> -o arch/i386/boot/bootsect
>   gcc -Wp,-MD,arch/i386/boot/.setup.o.d -nostdinc -iwithprefix include
> -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -D__ASSEMBLY__ -Iinclude/
> asm-i386/mach-default -traditional -DSVGA_MODE=NORMAL_VGA  -D__BIG_KERNEL__
> -c -o arch/i386/boot/setup.o arch/i386/boot/setup.S
> arch/i386/boot/setup.S: Assembler messages:
> arch/i386/boot/setup.S:165: Warning: value 0x37ffffff truncated to
> 0x37ffffff ld -m elf_i386  -Ttext 0x0 -s --oformat binary -e begtext
> arch/i386/boot/ setup.o -o arch/i386/boot/setup
> make -f scripts/Makefile.build obj=arch/i386/boot/compressed
> IMAGE_OFFSET=0x100000 arch/i386/boot/compressed/vmlinux
>   gcc -Wp,-MD,arch/i386/boot/compressed/.head.o.d -nostdinc -iwithprefix
> include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -D__ASSEMBLY__
> -Iinclude/asm-i386/mach-default -traditional   -c -o arch/i386/boot/
> compressed/head.o arch/i386/boot/compressed/head.S
>   gcc -Wp,-MD,arch/i386/boot/compressed/.misc.o.d -nostdinc -iwithprefix
> include -D__KERNEL__ -Iinclude  -D__KERNEL__ -Iinclude  -Wall
> -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -pipe
> -mpreferred-stack-boundary=2 -march=athlon -Iinclude/asm-i386/mach-default
> -O2 -fomit-frame-pointer     -DKBUILD_BASENAME=misc -DKBUILD_MODNAME=misc
> -c -o arch/i386/boot/compressed/misc.o arch/i386/boot/compressed/misc.c
> objcopy -O binary -R .note -R .comment -S  vmlinux arch/i386/boot/
> compressed/vmlinux.bin
> make[2]: *** [arch/i386/boot/compressed/vmlinux.bin] Fehler 132
> make[1]: *** [arch/i386/boot/compressed/vmlinux] Fehler 2
> make: *** [bzImage] Fehler 2
>
>
> thanks and i hope i'm not completle wrong here :-D
> Marco
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

