Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261440AbSJGRk1>; Mon, 7 Oct 2002 13:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261608AbSJGRk0>; Mon, 7 Oct 2002 13:40:26 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:20959 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261440AbSJGRkZ>; Mon, 7 Oct 2002 13:40:25 -0400
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200210071745.g97Hjth23332@eng2.beaverton.ibm.com>
Subject: Re: 2.5.40-mm2
To: akpm@digeo.com (Andrew Morton)
Date: Mon, 7 Oct 2002 10:45:55 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org (lkml),
       linux-mm@kvack.org (linux-mm@kvack.org)
In-Reply-To: <3DA0854E.CF9080D7@digeo.com> from "Andrew Morton" at Oct 06, 2002 10:47:42 AM PST
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

I get following compile errors while using 2.5.40-mm2.
Missing some exports ?

- Badari

        ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o --start-group  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-generic/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o --end-group -o .tmp_vmlinux
drivers/built-in.o: In function `aic7xxx_biosparam':
drivers/built-in.o(.text+0xcfc71): undefined reference to `__udivdi3'
drivers/built-in.o(.text+0xcfca8): undefined reference to `__udivdi3'
drivers/built-in.o: In function `qla1280_proc_info':
drivers/built-in.o(.text+0xd0ca0): undefined reference to `get_free_page'
drivers/built-in.o: In function `qla1280_biosparam':
drivers/built-in.o(.text+0xd1daa): undefined reference to `__udivdi3'
drivers/built-in.o(.text+0xd1dce): undefined reference to `__udivdi3'
make: *** [.tmp_vmlinux] Error 1



