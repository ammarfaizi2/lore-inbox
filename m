Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267330AbUIUGFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267330AbUIUGFQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 02:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267334AbUIUGFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 02:05:16 -0400
Received: from relay.pair.com ([209.68.1.20]:48657 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S267330AbUIUGFG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 02:05:06 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <414FC41B.7080102@kegel.com>
Date: Mon, 20 Sep 2004 23:03:07 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en, de-de
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.8 link failure for sparc32 (vmlinux.lds.s: No such file or directory)?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to verify that I can build toolchains and compile
and link kernels for a large set of CPU types using simple kernel config files.
I'm also somewhat foolishly trying to do all this with gcc-3.4.2.
So any problems I run into are a bit hard to pin down to
compiler, kernel, or user error, since this is mostly new territory for me.

Here's another issue.
When I build 2.6.8 for sparc32, using the config file
http://kegel.com/crosstool/crosstool-0.28-rc36/sparc.config ,
I get a link error:

/opt/crosstool/sparc-unknown-linux-gnu/gcc-3.4.2-glibc-2.3.3/bin/sparc-unknown-linux-gnu-ld -m elf32_sparc  -T arch/sparc/kernel/vmlinux.lds.s arch/sparc/kernel/head.o arch/sparc/kernel/init_task.o  init/built-in.o --start-group 
usr/built-in.o  arch/sparc/kernel/built-in.o  arch/sparc/mm/built-in.o  arch/sparc/math-emu/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  lib/lib.a 
arch/sparc/prom/lib.a  arch/sparc/lib/lib.a  lib/built-in.o  arch/sparc/prom/built-in.o  arch/sparc/lib/built-in.o  drivers/built-in.o  sound/built-in.o  net/built-in.o --end-group .tmp_kallsyms2.o arch/sparc/boot/btfix.o -o 
arch/sparc/boot/image
/opt/crosstool/sparc-unknown-linux-gnu/gcc-3.4.2-glibc-2.3.3/bin/sparc-unknown-linux-gnu-ld: cannot open linker script file arch/sparc/kernel/vmlinux.lds.s: No such file or directory
make[1]: *** [arch/sparc/boot/image] Error 1
make: *** [image] Error 2

Anyone seen this?
Thanks,
Dan

-- 
My technical stuff: http://kegel.com
My politics: see http://www.misleader.org for examples of why I'm for regime change
