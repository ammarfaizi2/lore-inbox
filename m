Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262248AbVCVAtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262248AbVCVAtV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 19:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262246AbVCVAsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 19:48:52 -0500
Received: from fire.osdl.org ([65.172.181.4]:57227 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262221AbVCVArL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 19:47:11 -0500
Date: Mon, 21 Mar 2005 16:47:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Miles Lane <miles.lane@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops: 2.6.11-mm3 -- NULL pointer -- EIP is at
 i2c_add_driver+0xa2/0xd0
Message-Id: <20050321164714.38991186.akpm@osdl.org>
In-Reply-To: <a44ae5cd050313180915a70a51@mail.gmail.com>
References: <a44ae5cd050313180915a70a51@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane <miles.lane@gmail.com> wrote:
>
> I2c /dev/ entries driver
> Unable to handle kernel NULL pointer dereference at virtual address 00000000

Miles, does 2.6.12-rc1-mm1 fix this?

Thanks.

>  Printing eip:
> C028bbc2
> *pde = 00000000
> Oops: 0000 [#1]
> PREEMPT
> Modules linked in:
> CPU:     0
> EIP:     0060:[<c028bbc2>]   Not tainted VLI
> EFLAGS:  00010282   (2.6.11-mm3)
> EIP is at i2c_add_driver+0xa2/0xd0
> Eax: 00000000   ebx: 00000000   ecx: 00000000   edx: f7e99504
> Esi: c03f5260   edi: 00000000   ebp: f7c21fa4   esp: f7c21f90
> Ds: 007b   es: 007b   ss: 0068
> Process swapper (pid: 1, threadinfo=f7c20000 task=c17fca40)
> Stack: f7c00540 c03f5264 00000000 00000000 00000000 f7c21fbc c0480695 c03f5260
>        c03724f8 c03f5140 c048d204 f7c21fd8 c04668ab c01002d0 00000000 00000000
>        c01002d0 00000000 f7c21fec c0100302 0000007b 0000007b ffffffff 00000000
> Call Trace:
>  [<c010404f>] show_stack+0x7f/0xa0
>  [<c01041ea>] show_registers+0x15a/0x1c0
>  [<c01043e0>] die+0xf0/0x190
>  [<c011450b>] do_page_fault+0x31b/0x670
>  [<c0103c83>] error_code+0x2b/0x30
>  [<c0480695>] i2c_dev_init+0x55/0xa0
>  [<c04668ab>] do_initcalls+0x2b/0xc0
>  [<c0100302>] init+0x32/0x130
>  [<c0101351>] kernel_thread_helper+0x5/0x14
