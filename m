Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276719AbRJBVzC>; Tue, 2 Oct 2001 17:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276720AbRJBVyt>; Tue, 2 Oct 2001 17:54:49 -0400
Received: from wolf.ericsson.net.nz ([203.97.68.250]:50324 "EHLO
	wolf.ericsson.net.nz") by vger.kernel.org with ESMTP
	id <S276719AbRJBVyf>; Tue, 2 Oct 2001 17:54:35 -0400
Date: Wed, 3 Oct 2001 09:55:00 +1200 (NZST)
From: Mark Henson <kern@wolf.ericsson.net.nz>
To: <linux-kernel@vger.kernel.org>
Subject: page_alloc problem...
Message-ID: <Pine.LNX.4.33.0110030945050.27543-100000@wolf.ericsson.net.nz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have had three page_alloc report errors on a machine that is running as
an email and gateway server.  Max uptime last night was 10 days...

The machine is a Duron 850 running 2.4.2-2 Redhat, I have 3 other machines
runnning similar hardware, (Duron 700) one on 2.4.3 built from a tar ball
RH 6.2 and the other on RH 2.4.2-2 as well.

Can anyone help me identify if this is a hadrware fault - ie faulty
hardware or if this is a problem with the specific hw design - Soltek MB
or if this is a known issue and I need to upgrade to a recent 2.4.9 or
similar kernel?

thanks for your help

cheers
Mark



Oct  2 13:51:00 jgate kernel: kernel BUG at page_alloc.c:84!
Oct  2 13:51:00 jgate kernel: invalid operand: 0000
Oct  2 13:51:00 jgate kernel: CPU:    0
Oct  2 13:51:00 jgate kernel: EIP:    0010:[__free_pages_ok+75/848]
Oct  2 13:51:00 jgate kernel: EIP:    0010:[<c012d07b>]
Oct  2 13:51:00 jgate kernel: EFLAGS: 00010286
Oct  2 13:51:00 jgate kernel: eax: 0000001f   ebx: c7e4acc8   ecx:
fffffff5   edx: 00000000
Oct  2 13:51:00 jgate kernel: esi: 00000000   edi: c1000164   ebp:
00000000   esp: ccc8de28
Oct  2 13:51:00 jgate kernel: ds: 0018   es: 0018   ss: 0018
Oct  2 13:51:00 jgate kernel: Process crond (pid: 20404,
stackpage=ccc8d000)
Oct  2 13:51:00 jgate kernel: Stack: c020ea7b c020ec89 00000054 c1044010
c7e4acc8 00003000 003fd000 c0124b02
Oct  2 13:51:00 jgate kernel:        c1000164 00003000 003fd000 cc817ffc
c0121ed9 00000003 00002000 00000000
Oct  2 13:51:00 jgate kernel:        00400000 c80fdbfc 00000000 c0000000
c80fdbfc ccc8de8c ffffffff c024a3e0
Oct  2 13:51:00 jgate kernel: Call Trace: [error_table+26787/46744]
[error_table+27313/46744] [__set_page_dirty+50/64]
[zap_page_range+457/656] [llc_oui+3940/4644] [send_signal+45/240]
[exit_mmap+184/288]
Oct  2 13:51:00 jgate kernel: Call Trace: [<c020ea7b>] [<c020ec89>]
[<c0124b02>] [<c0121ed9>] [<c024a3e0>] [<c011dacd>] [<c0124698>]
Oct  2 13:51:00 jgate kernel:        [mmput+38/80] [do_exit+185/560]
[dequeue_signal+109/176] [do_signal+553/672] [pipe_read+202/608]
[sys_read+194/208] [sys_llseek+201/224] [do_page_fault+0/1104]
Oct  2 13:51:00 jgate kernel:        [<c0114b86>] [<c01188d9>]
[<c011d82d>] [<c0108eb9>] [<c013ce1a>] [<c01339d2>] [<c01338f9>]
[<c0112f30>]
Oct  2 13:51:00 jgate kernel:        [signal_return+20/24]
Oct  2 13:51:00 jgate kernel:        [<c0109064>]
Oct  2 13:51:00 jgate kernel:
Oct  2 13:51:00 jgate kernel: Code: 0f 0b 83 c4 0c 8b 0d ac 0b 2c c0 89 f8
29 c8 69 c0 f1 f0 f0


Oct  3 04:03:01 jgate kernel: kernel BUG at page_alloc.c:84!
Oct  3 04:03:01 jgate kernel: invalid operand: 0000
Oct  3 04:03:01 jgate kernel: CPU:    0
Oct  3 04:03:01 jgate kernel: EIP:    0010:[__free_pages_ok+75/848]
Oct  3 04:03:01 jgate kernel: EIP:    0010:[<c012d07b>]
Oct  3 04:03:01 jgate kernel: EFLAGS: 00010286
Oct  3 04:03:01 jgate kernel: eax: 0000001f   ebx: c7e4acc8   ecx:
fffffffe   edx: 00000000
Oct  3 04:03:01 jgate kernel: esi: 00000000   edi: c1000164   ebp:
00000000   esp: c147bf38
Oct  3 04:03:01 jgate kernel: ds: 0018   es: 0018   ss: 0018
Oct  3 04:03:01 jgate kernel: Process kswapd (pid: 4, stackpage=c147b000)
Oct  3 04:03:01 jgate kernel: Stack: c020ea7b c020ec89 00000054 c9819800
000001d3 c012c88e 00000000 c1000164
Oct  3 04:03:01 jgate kernel:        c100018c c1000164 00000000 00000000
c012c375 00000035 00000000 00000004
Oct  3 04:03:01 jgate kernel:        00000000 00000021 00000000 00000056
00000000 00000028 00000004 000001d3
Oct  3 04:03:02 jgate kernel: Call Trace: [error_table+26787/46744]
[error_table+27313/46744] [free_shortage+30/144] [page_launder+1541/2432]
[free_shortage+30/144] [do_try_to_free_pages+53/128] [kswapd+123/288]
Oct  3 04:03:02 jgate kernel: Call Trace: [<c020ea7b>] [<c020ec89>]
[<c012c88e>] [<c012c375>] [<c012c88e>] [<c012ca85>] [<c012cb4b>]
Oct  3 04:03:02 jgate kernel:        [empty_bad_page+0/4096]
[empty_bad_page+0/4096] [kernel_thread+38/48] [kswapd+0/288]
Oct  3 04:03:02 jgate kernel:        [<c0105000>] [<c0105000>]
[<c0107596>] [<c012cad0>]
Oct  3 04:03:02 jgate kernel:
Oct  3 04:03:02 jgate kernel: Code: 0f 0b 83 c4 0c 8b 0d ac 0b 2c c0 89 f8
29 c8 69 c0 f1 f0 f0
Oct  3 04:03:03 jgate kernel: kernel BUG at exit.c:465!
Oct  3 04:03:03 jgate kernel: invalid operand: 0000
Oct  3 04:03:03 jgate kernel: CPU:    0
Oct  3 04:03:03 jgate kernel: EIP:    0010:[do_exit+541/560]
Oct  3 04:03:03 jgate kernel: EIP:    0010:[<c0118a3d>]
Oct  3 04:03:03 jgate kernel: EFLAGS: 00010282
Oct  3 04:03:03 jgate kernel: eax: 0000001a   ebx: 00000000   ecx:
fffffffe   edx: 00000000
Oct  3 08:55:20 jgate syslogd 1.4-0: restart.


