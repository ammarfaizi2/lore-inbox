Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265888AbSKBHUD>; Sat, 2 Nov 2002 02:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265889AbSKBHUD>; Sat, 2 Nov 2002 02:20:03 -0500
Received: from mail.michigannet.com ([208.49.116.30]:27659 "EHLO
	member.michigannet.com") by vger.kernel.org with ESMTP
	id <S265888AbSKBHUC>; Sat, 2 Nov 2002 02:20:02 -0500
Date: Sat, 2 Nov 2002 02:26:27 -0500
From: Paul <set@pobox.com>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] [PATCH] Linux-2.5.45-mcp2
Message-ID: <20021102072627.GB20069@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>,
	Marc-Christian Petersen <m.c.p@wolk-project.de>,
	linux-kernel@vger.kernel.org
References: <200211020255.05597.m.c.p@wolk-project.de> <20021102050353.GJ7170@squish.home.loc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021102050353.GJ7170@squish.home.loc>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul <set@pobox.com>, on Sat Nov 02, 2002 [12:03:53 AM] said:
[...]
> make[2]: *** [drivers/md/dm-ioctl.o] Error 1
> make[1]: *** [drivers/md] Error 2
> make: *** [drivers] Error 2
> 
> 	This looks similar to the error I got with 2.5.45
> virgin. (was hoping device mapper fixes would make it go away)
> 
	Argh. I downloaded the patch, made the link dir with
the right name, and forgot to apply the patch!@#$ :(

	After actually patching (and a make mrproper to make
sure), I get this error, though:

        ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s
arch/i386/kernel/head.o arch/i386/kernel/init_task.o
init/built-in.o --start-group  arch/i386/kernel/built-in.o
arch/i386/mm/built-in.o  arch/i386/mach-generic/built-in.o
kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o
security/built-in.o  crypto/built-in.o  lib/lib.a
arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o
arch/i386/pci/built-in.o  net/built-in.o --end-group  -o vmlinux
fs/built-in.o: In function `init_reiser4':
fs/built-in.o(.init.text+0x11d3): undefined reference to `local
symbols in discarded section .exit.text'
make: *** [vmlinux] Error 1


Paul
set@pobox.com
