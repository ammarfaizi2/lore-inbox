Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262117AbSIYWDJ>; Wed, 25 Sep 2002 18:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262125AbSIYWDJ>; Wed, 25 Sep 2002 18:03:09 -0400
Received: from jalon.able.es ([212.97.163.2]:21979 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S262117AbSIYWDI>;
	Wed, 25 Sep 2002 18:03:08 -0400
Date: Thu, 26 Sep 2002 00:04:47 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [ANNOUNCE] [patch] kksymoops, in-kernel symbolic oopser, 2.5.38-B0
Message-ID: <20020925220447.GA1573@werewolf.able.es>
References: <Pine.LNX.4.44.0209252155210.18747-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.44.0209252155210.18747-100000@localhost.localdomain>; from mingo@elte.hu on Wed, Sep 25, 2002 at 21:56:22 +0200
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.09.25 Ingo Molnar wrote:
>
>okay, here is the new oops output:
>

Sorry to be picky, but...

>------------[ cut here ]------------
>kernel BUG at time.c:99!
>invalid operand: 0000
>CPU:    1
>EIP:    0060:[<c011bd14>]    Not tainted
>EFLAGS: 00010246
>EIP is at sys_gettimeofday+0x84/0x90
>eax: 0000004e   ebx: cef9e000   ecx: 00000000   edx: 00000068
>esi: 00000000   edi: 00000000   ebp: bffffad8   esp: cef9ffa0
>ds: 0068   es: 0068   ss: 0068
>Process gettimeofday (pid: 549, threadinfo=cef9e000 task=cf84d860)
>Stack: 4001695c bffff414 40156154 00000004 c0112a40 cef9e000 400168e4 bffffb44
>       c0107973 00000000 00000000 40156154 400168e4 bffffb44 bffffad8 0000004e
>       0000002b 0000002b 0000004e 400cecc1 00000023 00000246 bffffacc 0000002b
>Call Trace: [<c0112a40>] do_page_fault+0x0/0x4a2
>[<c0107973>] syscall_call+0x7/0xb
>

...wouldn't this look much nicer with some '\n' and a couple space for indent ?

Stack:
  4001695c bffff414 40156154 00000004 c0112a40 cef9e000 400168e4 bffffb44
  c0107973 00000000 00000000 40156154 400168e4 bffffb44 bffffad8 0000004e
  0000002b 0000002b 0000004e 400cecc1 00000023 00000246 bffffacc 0000002b
Call Trace:
  [<c0112a40>] do_page_fault+0x0/0x4a2
  [<c0107973>] syscall_call+0x7/0xb


-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.0 (Cooker) for i586
Linux 2.4.20-pre7-jam0 (gcc 3.2 (Mandrake Linux 9.0 3.2-1mdk))
