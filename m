Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264340AbTF3Qeo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 12:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265178AbTF3Qeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 12:34:44 -0400
Received: from ithilien.qualcomm.com ([129.46.51.59]:36579 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id S264340AbTF3Qen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 12:34:43 -0400
Message-Id: <5.1.0.14.2.20030630094248.0e167838@unixmail.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 30 Jun 2003 09:43:49 -0700
To: Olivier Fauchon <olivier.fauchon@free.fr>, linux-kernel@vger.kernel.org
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: RFCOMM BUG - Modules Refcount - 2.5.73
In-Reply-To: <3F0094FA.3090104@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:52 PM 6/30/2003, Olivier Fauchon wrote:
> I got a nice segfault while using "rfcomm bind" tool from bluz-tools.Here is the trace:
>
> ------------[ cut here ]------------
>kernel BUG at include/linux/module.h:294!
>invalid operand: 0000 [#2]
>CPU:    0
>EIP:    0060:[<e10b3f58>]    Not tainted
>EFLAGS: 00010246
>EIP is at rfcomm_sock_alloc+0xe8/0x110 [rfcomm]
>eax: 00000000   ebx: c6d371c0   ecx: c9e5c680   edx: c6d371c0
>esi: 000000d0   edi: ffffff9f   ebp: d8533f00   esp: d8533ee8
>ds: 007b   es: 007b   ss: 0068
>Process rfcomm (pid: 30528, threadinfo=d8532000 task=c24be140)
>Stack: e10b94c0 00000003 00000008 000000d0 fffffff4 ffffffa3 d8533f18 e10b3fca
>       c9e5c680 00000003 000000d0 00000003 d8533f30 e109a0c3 c9e5c680 00000003
>       0000001f c9e5c680 d8533f4c c02d6167 c9e5c680 00000003 00000000 00000001
>Call Trace:
> [<e10b94c0>] +0x0/0x140 [rfcomm]
> [<e10b3fca>] rfcomm_sock_create+0x4a/0x70 [rfcomm]
> [<e109a0c3>] bt_sock_create+0x53/0xa0 [bluetooth]
> [<c02d6167>] sock_create+0xa7/0x190
> [<c02d6279>] sys_socket+0x29/0x60
> [<c02d7205>] sys_socketcall+0x85/0x270
> [<c0140737>] sys_munmap+0x57/0x80
> [<c01090f3>] syscall_call+0x7/0xb
>
>Code: 0f 0b 26 01 51 6c 0b e1 e9 72 ff ff ff 0f 0b cb 01 68 6c 0b

I already have this one in my TODO list :).

Max

