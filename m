Return-Path: <linux-kernel-owner+w=401wt.eu-S1425600AbWLHQeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425600AbWLHQeO (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 11:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760770AbWLHQeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 11:34:14 -0500
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:61695 "EHLO
	mtagate1.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760769AbWLHQeN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 11:34:13 -0500
Date: Fri, 8 Dec 2006 18:34:07 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Arkadiusz Miskiewicz <arekm@maven.pl>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: What was in the x86 merge for .20
Message-ID: <20061208163407.GE3545@rhun.ibm.com>
References: <200612080401.25746.ak@suse.de> <200612081304.23230.arekm@maven.pl> <20061208125107.GA3545@rhun.ibm.com> <200612081403.13404.arekm@maven.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200612081403.13404.arekm@maven.pl>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2006 at 02:03:12PM +0100, Arkadiusz Miskiewicz wrote:
> On Friday 08 December 2006 13:51, Muli Ben-Yehuda wrote:
> > On Fri, Dec 08, 2006 at 01:04:23PM +0100, Arkadiusz Miskiewicz wrote:
> > > On Friday 08 December 2006 04:01, Andi Kleen wrote:
> > > > - Support for a Processor Data Area (PDA) on i386. This makes
> > > > the code more similar to x86-64 and will allow some other
> > > > optimizations in the future.
> > >
> > >   LD      .tmp_vmlinux1
> > > arch/i386/kernel/built-in.o: In function `math_emulate':
> > > (.text+0x3809): undefined reference to `_proxy_pda'
> > > arch/i386/kernel/built-in.o: In function `smp_apic_timer_interrupt':
> > > (.text+0xe140): undefined reference to `_proxy_pda'
> > > kernel/built-in.o: In function `sys_set_tid_address':
> > > (.text+0x370b): undefined reference to `_proxy_pda'
> > > kernel/built-in.o: In function `switch_uid':
> > > (.text+0xcc6c): undefined reference to `_proxy_pda'
> > > mm/built-in.o: In function `sys_munlock':
> > > (.text+0xcaf1): undefined reference to `_proxy_pda'
> > > mm/built-in.o:(.text+0xcc11): more undefined references to `_proxy_pda'
> > > follow make: *** [.tmp_vmlinux1] Błąd 1
> > >
> > > Something related (git tree fetched 1-2h ago) ?
> >
> > Probably. Please send your .config.

I can't reproduce it, instead I get

OBJCOPY arch/i386/boot/compressed/vmlinux.bin
BFD: Warning: Writing section `.bss' to huge (ie negative) file offset0xc02a5000.
objcopy: arch/i386/boot/compressed/vmlinux.bin: File truncated
make[2]: *** [arch/i386/boot/compressed/vmlinux.bin] Error 1
make[1]: *** [arch/i386/boot/compressed/vmlinux] Error 2
make: *** [bzImage] Error 2

I'll try to find an i386 machine with a less ancient binutils.

Cheers,
Muli
