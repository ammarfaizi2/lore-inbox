Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261842AbSJ2MWK>; Tue, 29 Oct 2002 07:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261844AbSJ2MWK>; Tue, 29 Oct 2002 07:22:10 -0500
Received: from louise.pinerecords.com ([212.71.160.16]:25096 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S261842AbSJ2MWK>; Tue, 29 Oct 2002 07:22:10 -0500
Date: Tue, 29 Oct 2002 13:28:24 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5 merge candidate list, final version.  (End of "crunch time" series.)
Message-ID: <20021029122824.GJ22687@louise.pinerecords.com>
References: <200210280534.16821.landley@trommello.org> <15805.27643.403378.829985@laputa.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15805.27643.403378.829985@laputa.namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Snapshot is available at http://www.namesys.com/snapshots/:
> 
> http://www.namesys.com/snapshots/reiser4-2002.10.24.tar.gz
> http://www.namesys.com/snapshots/reiser4-core-2002.10.24.diff

2.5.44:
Producing a module I get a couple unresolved symbols,
and trying to build directly into the kernel results in

...
ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o --start-group  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-generic/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o --end-group  -o vmlinux
fs/built-in.o(.init.text+0x1381): In function `init_reiser4':
: undefined reference to `local symbols in discarded section .exit.text'
make[1]: *** [vmlinux] Error 1
make: *** [vmlinux] Error 2

> http://www.namesys.com/snapshots/reiser4progs-2002.10.24.tar.gz

... is missing the "configure" script.
Generating one with autoconf 2.53 doesn't seem to work, either.

T.
