Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262877AbSKYLGz>; Mon, 25 Nov 2002 06:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262884AbSKYLGz>; Mon, 25 Nov 2002 06:06:55 -0500
Received: from kiruna.synopsys.com ([204.176.20.18]:45555 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S262877AbSKYLGy>; Mon, 25 Nov 2002 06:06:54 -0500
Date: Mon, 25 Nov 2002 12:13:50 +0100
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.48+bk: piix: undefined references
Message-ID: <20021125111350.GA27097@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
References: <20021122135322.GE16412@riesen-pc.gr05.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021122135322.GE16412@riesen-pc.gr05.synopsys.com>
User-Agent: Mutt/1.4i
Organization: Synopsys, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2002 at 02:53:22PM +0100, Alex Riesen wrote:
>    ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o init/do_mounts.o init/initramfs.o
>         ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o --start-group  usr/built-in.o  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-generic/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o --end-group  -o vmlinux
> drivers/built-in.o(.text+0x3f392): In function `piix_ratemask':
> : undefined reference to `eighty_ninty_three'

IDE was set to compile as module. Apparently it doesn't like to be a
module yet.

