Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262553AbSJGRuc>; Mon, 7 Oct 2002 13:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262551AbSJGRuc>; Mon, 7 Oct 2002 13:50:32 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:35813 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262553AbSJGRuc>;
	Mon, 7 Oct 2002 13:50:32 -0400
Date: Mon, 7 Oct 2002 19:55:55 +0200
From: Jens Axboe <axboe@suse.de>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.40-mm2
Message-ID: <20021007175555.GF1160@suse.de>
References: <3DA0854E.CF9080D7@digeo.com> <200210071745.g97Hjth23332@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210071745.g97Hjth23332@eng2.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07 2002, Badari Pulavarty wrote:
> Andrew,
> 
> I get following compile errors while using 2.5.40-mm2.
> Missing some exports ?
> 
> - Badari
> 
>         ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o --start-group  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-generic/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o --end-group -o .tmp_vmlinux
> drivers/built-in.o: In function `aic7xxx_biosparam':
> drivers/built-in.o(.text+0xcfc71): undefined reference to `__udivdi3'
> drivers/built-in.o(.text+0xcfca8): undefined reference to `__udivdi3'
> drivers/built-in.o: In function `qla1280_proc_info':
> drivers/built-in.o(.text+0xd0ca0): undefined reference to `get_free_page'
> drivers/built-in.o: In function `qla1280_biosparam':
> drivers/built-in.o(.text+0xd1daa): undefined reference to `__udivdi3'
> drivers/built-in.o(.text+0xd1dce): undefined reference to `__udivdi3'
> make: *** [.tmp_vmlinux] Error 1

someone is doing divisions on 64-bit ints, at least that's the
__udivdi3.

-- 
Jens Axboe

