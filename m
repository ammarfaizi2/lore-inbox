Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275057AbTHMNie (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 09:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275050AbTHMNiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 09:38:24 -0400
Received: from sampa7.prodam.sp.gov.br ([200.230.190.107]:52998 "EHLO
	sampa7.prodam.sp.gov.br") by vger.kernel.org with ESMTP
	id S275014AbTHMNiP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 09:38:15 -0400
Subject: Re: 2.6.0-test3-mm2
From: Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <200308132302.26656.kernel@kolivas.org>
References: <20030813013156.49200358.akpm@osdl.org>
	 <200308132302.26656.kernel@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1
Organization: Governo Eletronico - SP
Message-Id: <1060781719.449.6.camel@lorien>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 13 Aug 2003 10:35:45 -0300
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Qua, 2003-08-13 às 10:02, Con Kolivas escreveu:
> Got this on running lilo (scary but it didn't kill my bootblock).
> 
> Aug 13 22:54:58 pc kernel:  ------------[ cut here ]------------
> Aug 13 22:54:58 pc kernel: kernel BUG at mm/filemap.c:1930!
> Aug 13 22:54:58 pc kernel: invalid operand: 0000 [#2]
> Aug 13 22:54:58 pc kernel: PREEMPT
> Aug 13 22:54:58 pc kernel: CPU:    0
> Aug 13 22:54:58 pc kernel: EIP:    0060:[<c013b519>]    Not tainted VLI
> Aug 13 22:54:58 pc kernel: EFLAGS: 00010282
> Aug 13 22:54:58 pc kernel: EIP is at generic_file_aio_write_nolock+0xe8/0xf5
> Aug 13 22:54:58 pc kernel: eax: 00000000   ebx: 00000000   ecx: df5a4ab0   
> edx: df5a4ab0
> Aug 13 22:54:58 pc kernel: esi: 00000000   edi: deecdf6c   ebp: deecde84   
> esp: deecde40
> Aug 13 22:54:58 pc kernel: ds: 007b   es: 007b   ss: 0068
> Aug 13 22:54:58 pc kernel: Process lilo (pid: 396, threadinfo=deecc000 
> task=c17ac6a0)
> Aug 13 22:54:58 pc kernel: Stack: deecc000 00034001 00000000 00000129 00000138 
> c17a7c80 c17a7d10 df909980
> Aug 13 22:54:58 pc kernel:        deecde84 df909980 00000000 00000000 c013b682 
> deecde84 deecdf6c 00000001
> Aug 13 22:54:58 pc kernel:        df9099a0 0806f220 00000200 00000000 00000001 
> ffffffff df909980 de86ee68
> Aug 13 22:54:58 pc kernel: Call Trace:
> Aug 13 22:54:58 pc kernel:  [<c013b682>] generic_file_write_nolock+0xa2/0xba
> Aug 13 22:54:58 pc kernel:  [<c011f126>] autoremove_wake_function+0x0/0x4f
> Aug 13 22:54:58 pc kernel:  [<c01a4ba9>] reiserfs_bmap+0x62/0xa6
> Aug 13 22:54:58 pc kernel:  [<c01a89ce>] reiserfs_aop_bmap+0x0/0x23
> Aug 13 22:54:58 pc kernel:  [<c0158a7b>] generic_block_bmap+0x38/0x40
> Aug 13 22:54:58 pc kernel:  [<c01c46e2>] reiserfs_ioctl+0x2b2/0x2b9
> Aug 13 22:54:58 pc kernel:  [<c015c939>] blkdev_file_write+0x37/0x3b
> Aug 13 22:54:58 pc kernel:  [<c015420c>] vfs_write+0xbc/0x127
> Aug 13 22:54:58 pc kernel:  [<c015b7e8>] block_llseek+0x0/0xd5
> Aug 13 22:54:58 pc kernel:  [<c015431c>] sys_write+0x42/0x63
> Aug 13 22:54:58 pc kernel:  [<c031280f>] syscall_call+0x7/0xb
> Aug 13 22:54:58 pc kernel:  [<c031007b>] pfkey_spdflush+0xb8/0xd6
> Aug 13 22:54:58 pc kernel:
> Aug 13 22:54:58 pc kernel: Code: eb f2 8b 54 24 40 89 7c 24 04 c7 44 24 08 01 
> 00 00 00 89 54 24 0c 89 2c 24 e8 75 f4 ff ff 8
> 3 7d 10 ff 89 c7 75 ce e9 70 ff ff ff <0f> 0b 8a 07 3f b7 32 c0 e9 54 ff ff ff 
> 53 ba 00 e0 ff ff 21 e2

 I got the some thing, this happens when fsck will check the
first partition.

PS: my offesets and the call trace is different. Do you need
it ?

-- 
Luiz Fernando N. Capitulino

<lcapitulino@prefeitura.sp.gov.br>
<http://www.telecentros.sp.gov.br>

