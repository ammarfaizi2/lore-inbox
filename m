Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbTDFVuh (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 17:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263120AbTDFVuh (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 17:50:37 -0400
Received: from marcie.netcarrier.net ([216.178.72.21]:5900 "HELO
	marcie.netcarrier.net") by vger.kernel.org with SMTP
	id S263117AbTDFVue (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 17:50:34 -0400
Message-ID: <3E90A341.54C017A0@compuserve.com>
Date: Sun, 06 Apr 2003 17:59:29 -0400
From: Kevin Brosius <cobra@compuserve.com>
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.5.66 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@codemonkey.org.uk>
CC: torvalds@transmeta.com, kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 bk undefined reference to ip_amanda_lock ?
References: <3E8ED6C6.316264C6@compuserve.com> <20030406195706.GA18213@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> 
> 
> On Sat, Apr 05, 2003 at 08:14:46AM -0500, Kevin Brosius wrote:
>  > Anyone else seeing:
>  >
>  >         ld -m elf_i386  -T arch/i386/vmlinux.lds.s
>  > arch/i386/kernel/head.o arch/i386/kernel/init_task.o   init/built-in.o
>  > --start-group  usr/built-in.o  arch/i386/kernel/built-in.o
>  > arch/i386/mm/built-in.o  arch/i386/mach-default/built-in.o
>  > kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o
>  > security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a
>  > drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o
>  > net/built-in.o --end-group  -o .tmp_vmlinux1
>  > net/built-in.o: In function `help':
>  > net/built-in.o(.text+0x6a283): undefined reference to `ip_amanda_lock'
>  > net/built-in.o(.text+0x6a2ac): undefined reference to `ip_amanda_lock'
>  > net/built-in.o(.text+0x6a2c5): undefined reference to `ip_amanda_lock'
>  > net/built-in.o(.text+0x6a2da): undefined reference to `ip_amanda_lock'
>  > net/built-in.o(.text+0x6a2ec): undefined reference to `ip_amanda_lock'
>  > net/built-in.o(.text+0x6a334): more undefined references to
>  > `ip_amanda_lock' follow
>  > make: *** [.tmp_vmlinux1] Error 1
>  >
>  > in 2.5 bk current?  I've attached 'grep "=[y|m]" .config'
> 
> Looks like a cut-n-paste thinko.
> 
>                 Dave
> 

Excellent, that fixes it.  Thank you.

-- 
Kevin
