Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316896AbSFQLDN>; Mon, 17 Jun 2002 07:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316897AbSFQLDM>; Mon, 17 Jun 2002 07:03:12 -0400
Received: from employees.nextframe.net ([212.169.100.200]:47349 "EHLO
	sexything.nextframe.net") by vger.kernel.org with ESMTP
	id <S316896AbSFQLDK>; Mon, 17 Jun 2002 07:03:10 -0400
Date: Mon, 17 Jun 2002 13:11:23 +0200
From: Morten Helgesen <morten.helgesen@nextframe.net>
To: Hanno =?iso-8859-1?Q?B=F6ck?= <hanno@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.22 compile problems
Message-ID: <20020617131123.A129@sexything>
Reply-To: morten.helgesen@nextframe.net
References: <20020617125905.5511b12c.hanno@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020617125905.5511b12c.hanno@gmx.de>
User-Agent: Mutt/1.3.22.1i
X-Editor: VIM - Vi IMproved 6.0
X-Keyboard: PFU Happy Hacking Keyboard
X-Operating-System: Slackware Linux (of course)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

enable APIC support ... the intel thermal stuff depends on it.

On Mon, Jun 17, 2002 at 12:59:05PM +0200, Hanno B?ck wrote:
> I tried to compile 2.5.22 and got the following errors:
> 
>    ld -m elf_i386  -r -o init.o main.o version.o do_mounts.o
> make[1]: Verlassen des Verzeichnisses Verzeichnis »/usr/src/linux-2.5.22/init«
>   ld -m elf_i386 -T /usr/src/linux-2.5.22/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/init.o --start-group arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o /usr/src/linux-2.5.22/arch/i386/lib/lib.a lib/lib.a /usr/src/linux-2.5.22/arch/i386/lib/lib.a drivers/built-in.o sound/sound.o arch/i386/pci/pci.o net/network.o --end-group -o vmlinux
> arch/i386/kernel/kernel.o: In function `intel_thermal_interrupt':
> arch/i386/kernel/kernel.o(.text+0x7821): undefined reference to `ack_APIC_irq'
> arch/i386/kernel/kernel.o: In function `intel_init_thermal':
> arch/i386/kernel/kernel.o(.text.init+0x1450): undefined reference to `apic_read'
> arch/i386/kernel/kernel.o(.text.init+0x149b): undefined reference to `apic_write_around'
> arch/i386/kernel/kernel.o(.text.init+0x14cd): undefined reference to `apic_read'
> arch/i386/kernel/kernel.o(.text.init+0x14e0): undefined reference to `apic_write_around'
> make: *** [vmlinux] Fehler 1
> 
> 
> 
> I have tried kernels 2.5.18, 2.5.20, 2.5.21 and 2.5.22 and I always had compile problems. Can't someone test the kernel-source with all options activated before it is released?
> I think it doesn't matter if this happens sometimes in the 2.5-series, but it should not become usual.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 

"Livet er ikke for nybegynnere" - sitat fra en klok person.

mvh
Morten Helgesen 
UNIX System Administrator & C Developer 
Nextframe AS
admin@nextframe.net / 93445641
http://www.nextframe.net
