Return-Path: <linux-kernel-owner+ralf=40uni-koblenz.de@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S317131AbSFBFTs>; Sun, 2 Jun 2002 01:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S317132AbSFBFTr>; Sun, 2 Jun 2002 01:19:47 -0400
Received: from norma.kjist.ac.kr ([203.237.41.18]:59522 "EHLO norma.kjist.ac.kr") by vger.kernel.org with ESMTP id <S317131AbSFBFTq>; Sun, 2 Jun 2002 01:19:46 -0400
Message-ID: <3CF9AB50.2000403@nospam.com>
Date: Sun, 02 Jun 2002 14:21:20 +0900
From: Hugh <hugh@nospam.com>
User-Agent: Mozilla/5.0 (X11; U; Linux alpha; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: ko, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Stack error with 2.4.19-pre9aa2 and with 2.4.19-pre8+ in general on a dual Athlon
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been getting memory errors since 2.4.19-pre8+ independently
from -ac or -aa with no message in /var/log/messages so far.

ASUS motherboard K7M266-D with two Athlon MP 1900+ running at 1.6GHz.
When the error happens, it happens when I run latex with a big
manuscript of 1000 pages.

Now with 2.4.19-pre9aa2, I got a message in /var/log/messages as
follows:

Jun  2 13:53:41 bellini kernel: invalid operand: 0000
Jun  2 13:53:41 bellini kernel: CPU:    0
Jun  2 13:53:41 bellini kernel: EIP:    0010:[do_signal+8/614]    Not
tainted
Jun  2 13:53:41 bellini kernel: EFLAGS: 00010212
Jun  2 13:53:41 bellini kernel: eax: 49a9dfc4   ebx: 49a9c000   ecx:
00000000  \
 edx: 00000000
Jun  2 13:53:41 bellini kernel: esi: 00000004   edi: 40115db0   ebp:
3ffff16c  \
 esp: 49a9df30
Jun  2 13:53:41 bellini kernel: ds: 0018   es: 0018   ss: 0018
Jun  2 13:53:41 bellini kernel: Process latex (pid: 3690,
stackpage=49a9d000)
Jun  2 13:53:41 bellini kernel: Stack: 40115db0 3ffff16c 0000000b
00000000 0003\
0001 06834e10 bff52000 bff52000
Jun  2 13:53:41 bellini kernel:        4033384e 45f53b40 bff52000
4048ef6c 4050\
1910 00000000 00000001 00000001
Jun  2 13:53:41 bellini kernel:        0000012b 00085000 404ed080
00000000 4012\
3a25 00000001 00000000 49a9c000
Jun  2 13:53:41 bellini kernel: Call Trace: [do_page_fault+0/1490]
[net_rx_acti\
on+366/624] [update_process_times+37/48]
[smp_apic_timer_interrupt+239/272] [er\
ror_code+52/60]
Jun  2 13:53:41 bellini kernel:    [signal_return+20/24]
Jun  2 13:53:41 bellini kernel:
Jun  2 13:53:41 bellini kernel: Code: 56 53 89 c5 89 54 24 14 8b 45 2c
83 e0 03\
 83 f8 03 74 0a b8
Jun  2 13:53:41 bellini kernel:  invalid operand: 0000
Jun  2 13:53:41 bellini kernel: CPU:    0
Jun  2 13:53:41 bellini kernel: EIP:    0010:[do_signal+8/614]    Not
tainted
Jun  2 13:53:41 bellini kernel: EFLAGS: 00010206
Jun  2 13:53:41 bellini kernel: eax: 46619fc4   ebx: 46619fb0   ecx:
404e5800  \
 edx: 46619fb0
Jun  2 13:53:41 bellini kernel: esi: 080745e8   edi: 46619fc0   ebp:
46619fc4  \
 esp: 46619f0c
Jun  2 13:53:41 bellini kernel: ds: 0018   es: 0018   ss: 0018
Jun  2 13:53:41 bellini kernel: Process ksh (pid: 3212, stackpage=46619000)
Jun  2 13:53:41 bellini kernel: Stack: 46619fc0 46619fc4 46618000
00000007 4011\
5db0 3ffff99c 45860a40 00000001
Jun  2 13:53:41 bellini kernel:        156a176c 44b9a300 46618000
49a9e000 49a9\
e000 00030002 40107298 49a9c5c0
Jun  2 13:53:41 bellini kernel:        156a176c 44b9a300 46618000
49a9e000 49a9\
e000 00030002 40107298 49a9c5c0
Jun  2 13:53:41 bellini kernel:        466183c0 49a9c000 49a9c000
00000060 49a9\
de30 404e5800 49a9c380 40117605
Jun  2 13:53:41 bellini kernel: Call Trace: [do_page_fault+0/1490]
[copy_thread\
+136/160] [schedule+805/912] [sys_rt_sigsuspend+259/288] [system_call+51/56]
Jun  2 13:53:41 bellini kernel:
Jun  2 13:53:41 bellini kernel: Code: 56 53 89 c5 89 54 24 14 8b 45 2c
83 e0 03\
 83 f8 03 74 0a b8
Jun  2 13:53:41 bellini kernel:  invalid operand: 0000
Jun  2 13:53:41 bellini kernel: CPU:    0
Jun  2 13:53:41 bellini kernel: EIP:    0010:[do_signal+8/614]    Not
tainted
Jun  2 13:53:41 bellini kernel: EFLAGS: 00010212
Jun  2 13:53:41 bellini kernel: eax: 48693fc4   ebx: 48692000   ecx:
45de7fc0  \
 edx: 00000000
Jun  2 13:53:41 bellini kernel: esi: 3ffff5cc   edi: 00000000   ebp:
3ffff74c  \
 esp: 48693f30
Jun  2 13:53:41 bellini kernel: ds: 0018   es: 0018   ss: 0018
Jun  2 13:53:41 bellini kernel: Process in.telnetd (pid: 3210,
stackpage=486930\
00)
Jun  2 13:53:41 bellini kernel: Stack: 00000000 3ffff74c 4467d840
00000008 4014\
e4cd 48693f6c 00000004 00000001
Jun  2 13:53:41 bellini kernel:        45de7fd8 00000000 00000104
48692000 0000\
0206 00000004 00000001 45de7fd8
Jun  2 13:53:41 bellini kernel:        45de7fc0 4014e51a 45de7fc0
4014e98f 45de\
7fc0 00000004 48692000 3ffff5cc
Jun  2 13:53:41 bellini kernel: Call Trace: [do_select+493/528]
[select_bits_fr\
ee+10/16] [sys_select+1135/1152] [signal_return+20/24]
Jun  2 13:53:41 bellini kernel:
Jun  2 13:53:41 bellini kernel: Code: 56 53 89 c5 89 54 24 14 8b 45 2c
83 e0 03\
 83 f8 03 74 0a b8
Jun  2 13:53:41 bellini kernel:  invalid operand: 0000
Jun  2 13:53:41 bellini kernel: CPU:    0
Jun  2 13:53:41 bellini kernel: EIP:    0010:[do_signal+8/614]    Not
tainted
Jun  2 13:53:41 bellini kernel: EFLAGS: 00010212
Jun  2 13:53:41 bellini kernel: eax: 45cc3fc4   ebx: 45cc2000   ecx:
bfecdc80  \
 edx: 00000000
Jun  2 13:53:41 bellini kernel: esi: 00000000   edi: 00000000   ebp:
3ffffd0c  \
 esp: 45cc3f30
Jun  2 13:53:41 bellini kernel: ds: 0018   es: 0018   ss: 0018
Jun  2 13:53:41 bellini kernel: Process inetd (pid: 1183,
stackpage=45cc3000)
Jun  2 13:53:41 bellini kernel: Stack: 00000000 3ffffd0c 45c95d40
00008000 4014\
e4cd 45cc3f6c 00000004 00000001
Jun  2 13:53:41 bellini kernel:        bfecdc98 00000000 00000000
45cc2000 0000\
0282 00000004 00000001 bfecdc98
Jun  2 13:53:41 bellini kernel:        bfecdc80 4014e51a bfecdc80
4014e98f bfec\
dc80 00000004 45cc2000 00000000
Jun  2 13:53:41 bellini kernel: Call Trace: [do_select+493/528]
[select_bits_fr\
ee+10/16] [sys_select+1135/1152] [signal_return+20/24]
Jun  2 13:53:41 bellini kernel:
Jun  2 13:53:41 bellini kernel: Code: 56 53 89 c5 89 54 24 14 8b 45 2c
83 e0 03\
 83 f8 03 74 0a b8
================================================================

Regards,

Hugh

