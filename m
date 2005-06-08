Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262137AbVFHHyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262137AbVFHHyq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 03:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbVFHHyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 03:54:45 -0400
Received: from web33315.mail.mud.yahoo.com ([68.142.206.130]:24473 "HELO
	web33315.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S262137AbVFHHyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 03:54:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=m0Ast8cAwESfq7yla+FFpu2sUdp9U8z09I6rA/vULHjJih42VR3tVQM8tsb5w1Y7N/nUzpK57tkIKynlwppfS8LF/xbD31vmvdwRtb8NROvZEcuoZSXdZWpPYDgTY53j8U/AaMTBO9VQ6VvtDr5OxHIBuNIvKe/FQ3e2CZ/nUwA=  ;
Message-ID: <20050608075441.97875.qmail@web33315.mail.mud.yahoo.com>
Date: Wed, 8 Jun 2005 00:54:40 -0700 (PDT)
From: li nux <lnxluv@yahoo.com>
Subject: oops on using io_submit
To: linux <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am getting kernel oops on using io_submit in my
application, trying to read 500Mb files.
sometimes the system freezes.
any idea why this is happening ?
I am using sles9.

uname -a: Linux myhost 2.6.5-7.172-bigsmp #1 SMP Tue
May 10 17:15:56 UTC 2005 i686 i686 i386 GNU/Linux

Jun  8 11:37:15 myhost kernel: Unable to handle kernel
NULL pointer dereference at virtual address 00000020
Jun  8 11:37:15 myhost kernel:  printing eip:
Jun  8 11:37:15 myhost kernel: c019f1ae
Jun  8 11:37:15 myhost kernel: *pde = 35935001
Jun  8 11:37:15 myhost kernel: Oops: 0002 [#2]
Jun  8 11:37:15 myhost kernel: SMP
Jun  8 11:37:15 myhost kernel: CPU:    2
Jun  8 11:37:15 myhost kernel: EIP:   
0060:[<c019f1ae>]    Tainted: G   U
Jun  8 11:37:15 myhost kernel: EFLAGS: 00010096  
(2.6.5-7.172-bigsmp
SLES9_SP2_BRANCH-200505101715560000)
Jun  8 11:37:15 myhost kernel: EIP is at
aio_put_req+0xe/0x60
Jun  8 11:37:15 myhost kernel: eax: f1a62200   ebx:
00000000   ecx: f2cd5f2c   edx: f1a62200
Jun  8 11:37:15 myhost kernel: esi: f1a62200   edi:
f2cd5f70   ebp: f7582d80   esp: f2cd5f3c
Jun  8 11:37:15 myhost kernel: ds: 007b   es: 007b  
ss: 0068
Jun  8 11:37:15 myhost kernel: Process runaio (pid:
23453, threadinfo=f2cd4000 task=f772f320)
Jun  8 11:37:15 myhost kernel: Stack: 00000000
f1a62200 c019f3b7 00000000 0814e6fc 0814e6fc f7582d80
00000000
Jun  8 11:37:15 myhost kernel:        00000000
c019f4f5 f2cd4000 00000000 fffffff2 0814e6fc 00000000
00000000
Jun  8 11:37:15 myhost kernel:        00000000
00000001 00000004 0814e800 00000000 00002000 00000000
001ec000
Jun  8 11:37:15 myhost kernel: Call Trace:
Jun  8 11:37:15 myhost kernel:  [<c019f3b7>]
io_submit_one+0x1b7/0x210
Jun  8 11:37:15 myhost kernel:  [<c019f4f5>]
sys_io_submit+0xe5/0x150
Jun  8 11:37:15 myhost kernel:  [<c01091eb>]
syscall_call+0x7/0xb
Jun  8 11:37:15 myhost kernel:
Jun  8 11:37:15 myhost kernel: Code: f0 fe 4b 20 0f 88
24 0b 00 00 89 c2 89 d8 e8 ff ec ff ff 89
Jun  8 11:37:15 myhost kernel:  <7>exit_aio:ioctx
still alive: 2 1 0


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
