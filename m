Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267561AbUIUKuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267561AbUIUKuy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 06:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267563AbUIUKuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 06:50:54 -0400
Received: from dslsmtp.struer.net ([62.242.36.21]:34831 "EHLO
	dslsmtp.struer.net") by vger.kernel.org with ESMTP id S267561AbUIUKuu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 06:50:50 -0400
Message-ID: <58517.194.237.142.24.1095763849.squirrel@194.237.142.24>
In-Reply-To: <414FC41B.7080102@kegel.com>
References: <414FC41B.7080102@kegel.com>
Date: Tue, 21 Sep 2004 12:50:49 +0200 (CEST)
Subject: Re: 2.6.8 link failure for sparc32 (vmlinux.lds.s: No such file or 
     directory)?
From: "Sam Ravnborg" <sam@ravnborg.org>
To: "Dan Kegel" <dank@kegel.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm trying to verify that I can build toolchains and compile
> and link kernels for a large set of CPU types using simple kernel config
> files.
> I'm also somewhat foolishly trying to do all this with gcc-3.4.2.
> So any problems I run into are a bit hard to pin down to
> compiler, kernel, or user error, since this is mostly new territory for
> me.
>
> Here's another issue.
> When I build 2.6.8 for sparc32, using the config file
> http://kegel.com/crosstool/crosstool-0.28-rc36/sparc.config ,
> I get a link error:
>
> /opt/crosstool/sparc-unknown-linux-gnu/gcc-3.4.2-glibc-2.3.3/bin/sparc-unknown-linux-gnu-ld
> -m elf32_sparc  -T arch/sparc/kernel/vmlinux.lds.s
> arch/sparc/kernel/head.o arch/sparc/kernel/init_task.o  init/built-in.o
> --start-group
> usr/built-in.o  arch/sparc/kernel/built-in.o  arch/sparc/mm/built-in.o
> arch/sparc/math-emu/built-in.o  kernel/built-in.o  mm/built-in.o
> fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o
> lib/lib.a
> arch/sparc/prom/lib.a  arch/sparc/lib/lib.a  lib/built-in.o
> arch/sparc/prom/built-in.o  arch/sparc/lib/built-in.o  drivers/built-in.o
> sound/built-in.o  net/built-in.o --end-group .tmp_kallsyms2.o
> arch/sparc/boot/btfix.o -o
> arch/sparc/boot/image

Look like arch/sparc/boot/Makefile is too old.
vmlinux.lds.s were renamed to vmlinux.lds 2004/08/15 - maybe you need to
checkout that file?

   Sam

