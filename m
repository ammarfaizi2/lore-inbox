Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266252AbUG0E7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266252AbUG0E7S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 00:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266254AbUG0E7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 00:59:18 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:61929 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S266252AbUG0E7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 00:59:14 -0400
Date: Tue, 27 Jul 2004 01:02:42 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Ilyak Kasnacheev <ilyak@office.uw.ru>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel panic (reiserfs), some hangs - bad hardware?.
In-Reply-To: <4104E587.1050606@office.uw.ru>
Message-ID: <Pine.LNX.4.58.0407262300280.25781@montezuma.fsmlabs.com>
References: <4104E587.1050606@office.uw.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jul 2004, Ilyak Kasnacheev wrote:

> I have following problems:
>
> Am i crazy? 2) With bad interface cable, my system used to just hang.
> With better?/40pin cable, it do this very rare. Memtest86 and burncpu do
> not produce errors, and windows works fine on same box. Both 2.4.x and
> 2.6.7 kernels. 3) Main. I have got a reiserfs partition with some errors
> (due to 2)), and kernel panics on it when i do 'find /'. with these
> errors: == double fault, gdt at c03d2000 [255 bytes] double fault, tss
> at c030e80 eip = c0115116 esp = cd0e98b0768 eax = 00000a96 ebx =
> cf2a547c ecx = 0f0001e3 edx = 0f000000 esi = 00000000 edi = c0115030
>  *OR*
> EFLAGS: 0010007 (2.6.7)
> EIP is at scheduler_tick+0x108/0x400
> eax: 00000000 ebx: 00000001 ecx: 0000023d edx: 00000000
> esi: ca0a9750 edi: c0343520 ebp: ca0a7d4c esp: ca0a7d30
> ds: 007b es: 007b ss: 0068
> Process (pid: -1048345824, threadinfo = ca0a6000, task=ca0a9750)
> Stack: c188a23c 00145ad7 00000000 3d108500 00000000 00000001 00000000
>        ca0a7dd4 c0121606 00000000 00000001 00000001 00000000 ca0a6000
>        ca0a7dd4 c0121834 00000000 ca0a6000 c010a2ce ca0a7dd4 c02d51c4
>        20000001 00000000 c010632a

Perhaps a stack overflow? Change THREAD_SIZE in
include/asm-i386/thread_info.h to 16384.

