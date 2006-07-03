Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbWGCTh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWGCTh0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 15:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWGCTh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 15:37:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14220 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751248AbWGCThZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 15:37:25 -0400
Date: Mon, 3 Jul 2006 12:37:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm6
Message-Id: <20060703123715.6e6d9c2c.akpm@osdl.org>
In-Reply-To: <200607032007.11782.s0348365@sms.ed.ac.uk>
References: <20060703030355.420c7155.akpm@osdl.org>
	<200607032007.11782.s0348365@sms.ed.ac.uk>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jul 2006 20:07:11 +0100
Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:

> On Monday 03 July 2006 11:03, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17
> >-mm6/
> 
> Haven't tried an -mm kernel for a while, but I'm getting some linker warnings 
> (buggy linker)?
> 
> [alistair] 20:02 [~] as --version
> GNU assembler 2.16.91.0.7 20060317
> 
> [alistair] 20:02 [~] gcc --version
> gcc (GCC) 4.1.1
> 
> SYSCALL arch/x86_64/ia32/vsyscall-sysenter.so
> /usr/bin/ld: warning: i386 architecture of input file 
> `arch/x86_64/ia32/vsyscall-sysenter.o' is incompatible with i386:x86-64 
> output
> 
> SYSCALL arch/x86_64/ia32/vsyscall-syscall.so
> /usr/bin/ld: warning: i386 architecture of input file 
> `arch/x86_64/ia32/vsyscall-syscall.o' is incompatible with i386:x86-64 output
> 
>   CC      kernel/lockdep.o
> {standard input}: Assembler messages:
> {standard input}:6223: Warning: .space or .fill with negative value, ignored
> {standard input}:6682: Warning: .space or .fill with negative value, ignored
> {standard input}:7332: Warning: .space or .fill with negative value, ignored
> {standard input}:8134: Warning: .space or .fill with negative value, ignored
> {standard input}:8305: Warning: .space or .fill with negative value, ignored
> 
>   LD      arch/x86_64/boot/compressed/vmlinux
> ld: warning: i386:x86-64 architecture of input file 
> `arch/x86_64/boot/compressed/head.o' is incompatible with i386 output
> 
> I get this last one on mainline too.

Perhaps a `make mrproper' is needed?
